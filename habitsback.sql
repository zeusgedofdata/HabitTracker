PGDMP     :    3    
    
        x           Habits    12.2    12.2 %    /           0    0    ENCODING    ENCODING        SET client_encoding = 'BIG5';
                      false            0           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            1           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            2           1262    24765    Habits    DATABASE     �   CREATE DATABASE "Habits" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE "Habits";
                postgres    false            �            1259    24790    activity    TABLE     �   CREATE TABLE public.activity (
    id integer NOT NULL,
    name character varying NOT NULL,
    distance double precision,
    duration time without time zone,
    date date,
    note character varying,
    category_fk integer NOT NULL
);
    DROP TABLE public.activity;
       public         heap    postgres    false            �            1259    24788    activity_id_seq    SEQUENCE     �   CREATE SEQUENCE public.activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.activity_id_seq;
       public          postgres    false    207            3           0    0    activity_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.activity_id_seq OWNED BY public.activity.id;
          public          postgres    false    206            �            1259    24779    category    TABLE     �   CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying NOT NULL,
    weekly_goal integer,
    metacat_fk integer NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    24777    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          postgres    false    205            4           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    204            �            1259    32959    fit_activity    TABLE     �   CREATE TABLE public.fit_activity (
    id integer NOT NULL,
    calories real,
    heart_rate integer,
    duration time without time zone,
    distance real,
    activity_fk integer NOT NULL,
    pace time without time zone
);
     DROP TABLE public.fit_activity;
       public         heap    postgres    false            �            1259    32957    fit_activity_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fit_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.fit_activity_id_seq;
       public          postgres    false    209            5           0    0    fit_activity_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.fit_activity_id_seq OWNED BY public.fit_activity.id;
          public          postgres    false    208            �            1259    24768    meta_category    TABLE     }   CREATE TABLE public.meta_category (
    id integer NOT NULL,
    name character varying NOT NULL,
    weekly_goal integer
);
 !   DROP TABLE public.meta_category;
       public         heap    postgres    false            �            1259    24766    meta_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.meta_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.meta_category_id_seq;
       public          postgres    false    203            6           0    0    meta_category_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.meta_category_id_seq OWNED BY public.meta_category.id;
          public          postgres    false    202            �
           2604    24793    activity id    DEFAULT     j   ALTER TABLE ONLY public.activity ALTER COLUMN id SET DEFAULT nextval('public.activity_id_seq'::regclass);
 :   ALTER TABLE public.activity ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    207    207            �
           2604    24782    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            �
           2604    32962    fit_activity id    DEFAULT     r   ALTER TABLE ONLY public.fit_activity ALTER COLUMN id SET DEFAULT nextval('public.fit_activity_id_seq'::regclass);
 >   ALTER TABLE public.fit_activity ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    208    209            �
           2604    24771    meta_category id    DEFAULT     t   ALTER TABLE ONLY public.meta_category ALTER COLUMN id SET DEFAULT nextval('public.meta_category_id_seq'::regclass);
 ?   ALTER TABLE public.meta_category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            *          0    24790    activity 
   TABLE DATA           Y   COPY public.activity (id, name, distance, duration, date, note, category_fk) FROM stdin;
    public          postgres    false    207   )       (          0    24779    category 
   TABLE DATA           E   COPY public.category (id, name, weekly_goal, metacat_fk) FROM stdin;
    public          postgres    false    205   �2       ,          0    32959    fit_activity 
   TABLE DATA           g   COPY public.fit_activity (id, calories, heart_rate, duration, distance, activity_fk, pace) FROM stdin;
    public          postgres    false    209   n3       &          0    24768    meta_category 
   TABLE DATA           >   COPY public.meta_category (id, name, weekly_goal) FROM stdin;
    public          postgres    false    203   �7       7           0    0    activity_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.activity_id_seq', 1571, true);
          public          postgres    false    206            8           0    0    category_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.category_id_seq', 9, true);
          public          postgres    false    204            9           0    0    fit_activity_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.fit_activity_id_seq', 245, true);
          public          postgres    false    208            :           0    0    meta_category_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.meta_category_id_seq', 7, true);
          public          postgres    false    202            �
           2606    24798    activity activity_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.activity DROP CONSTRAINT activity_pk;
       public            postgres    false    207            �
           2606    73921    activity activity_un 
   CONSTRAINT     O   ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_un UNIQUE (name);
 >   ALTER TABLE ONLY public.activity DROP CONSTRAINT activity_un;
       public            postgres    false    207            �
           2606    24787    category category_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pk;
       public            postgres    false    205            �
           2606    32972    fit_activity fit_activity_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fit_activity
    ADD CONSTRAINT fit_activity_pk PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.fit_activity DROP CONSTRAINT fit_activity_pk;
       public            postgres    false    209            �
           2606    73923    fit_activity fit_activity_un 
   CONSTRAINT     ^   ALTER TABLE ONLY public.fit_activity
    ADD CONSTRAINT fit_activity_un UNIQUE (activity_fk);
 F   ALTER TABLE ONLY public.fit_activity DROP CONSTRAINT fit_activity_un;
       public            postgres    false    209            �
           2606    24773    meta_category meta_category_pk 
   CONSTRAINT     \   ALTER TABLE ONLY public.meta_category
    ADD CONSTRAINT meta_category_pk PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.meta_category DROP CONSTRAINT meta_category_pk;
       public            postgres    false    203            �
           2606    24799    activity activity_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_fk FOREIGN KEY (category_fk) REFERENCES public.category(id);
 >   ALTER TABLE ONLY public.activity DROP CONSTRAINT activity_fk;
       public          postgres    false    205    2715    207            �
           2606    24804    category category_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_fk FOREIGN KEY (metacat_fk) REFERENCES public.meta_category(id);
 >   ALTER TABLE ONLY public.category DROP CONSTRAINT category_fk;
       public          postgres    false    203    2713    205            �
           2606    32963    fit_activity fit_activity_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.fit_activity
    ADD CONSTRAINT fit_activity_fk FOREIGN KEY (activity_fk) REFERENCES public.activity(id);
 F   ALTER TABLE ONLY public.fit_activity DROP CONSTRAINT fit_activity_fk;
       public          postgres    false    2717    207    209            *   �	  x���ۊ7��{�b^`�J�>\B ;!	�@n���^b��NB�>]�j��Խ��e�/��R>�Qw><��O�.O�o��N?ߞ.'�NZ�������{�����ޙ;2�+��_��\���\O4����H?��?n���/ϬU��Խ��մ䐖\���������u�ĺ��C����,kV@N��Uj��x}L�Z#�֑֔S���������
Z=o���S���w�Ǐ�^���7�O�}3�S�T�Y�u�US�����������Gްۦ4Pi�n����w�����&������O����4���Y7vo.�/���msEHPH]�f��l�|�]��5
��Q�*��ԇf��W�s��J���/H�~������K�+/�0K����4�,�v/�b�X��W�C���X���6��H�#���Q�g����v̦Mv���аL�v��Q�չ]��E��z��Z1�F�T/+�U�|ܮ�I�t�v�����bV�ຕ7�>�����[y��T��E�lp�����|��	^c#�X�.��^���82��o����8��k`�5��#֏��������	g�O8V���~�c�_0��Nư�����_�B�}:��Bï��W�&��-�� �
d��B:@0�t�> $�����A&h�����q���t����|��]M^���<$s~S.�Φ��$�H�!��8{��݌�{ ������,C��K�D�J�9H�͋�#!Af���K�_4X:�8t&^��J��S��
�'6�E����Up:N��L�)Jߒ�!6k��ؒ��受�W1~=�R}�G/u�l,UK>4�c�ћ�-�ONS�M�I�19V�|�����g��mv4�"�6 �o��y�C�/zС�9����d�n�ӟu���e�I�w���o�&�'�gtQ�mJx:�����뺺d�iMϝ�J�ܗ#�D�xVK��z�?Y[qPA�L�"-vQA2m�d"v���U�̙�9;S�:��_Z��s��
:`$y�L;5�+�c�I�<],�7��F�8�[�=��$��X;��-H�Y�=d�@e��p�9pxMi��Ar3�i��x����F꩘7dw �RIn1�$B�EŰ�L�:��Y��H\�����|�)�<T:�.|f^���������g��Y�lf�5v	�ɃI��7η(�J�P�LW��RN��}� �!D�L�fQ\'D��$��1Z�m�� �  b��f)�aI0�jr�p��Ĺ!�D�kT{���H�I�{	`�k��+ xL��N�V�D��N���c"L��`�G�D;6��/��/�W�_p����Em��T�C|L���h�q�xa49�J��>��!S�8R1���Î9��t�KA�49�=�R#�FR�T�� �PC�6��_�"�����vF��%��(g
OF��dȪ�OH'@dU|]� �
9|���"��x~J@���]�	�xÎ9���;�7�/�����0Ǟ�|j�~�g����»N��ʎ�T�������4�\�a0�<������, ���ܺ�8оV�>-[G\)�`cuv$Ҳ2�����9�l��
(CҒ!	v�����r�
 �R�M�Jm*��������**�Mqy��|�08�d��b���/�:@ʓ��!��k���g���#���]x�U�ɑ�q�$��}~�sۚ��H�R�'�5�X�$������� I�����	�N��o��I�М�2���ny���i}�[��ͥ����z�\/J�IRpީ���8F�v,�u�ʁ�t∶!�!���؀|x�71��o�n��IA�L��`��q��.0���:����&�ʩ��7����h�"�iYU��L�#��=�����,�`H�Iix�H�� �Zl�e:����fL��w��sكTH�������3y'�a,$jS�=��mƝ�})k
����B��Ј���H�N��TH K���� $��C��7֌D�>l��U$�Yp��oW�&��
)v)�o�iU����h�7l@�5
�v͊v��e��څJ����v@`��T`�O������S�#;i��� �:`�)oq}{�B<�#n�#U&uR���|7$��7kDJ���GlO6 �PN��W�|p$�j���'X�;#a�B��#`TE��ni�莅~g��N�p<T���gT�p|
q��X{���6���c �^GѱE��XH�LҐ��T�����F�="$(j����t&�+�	���Qb�%����?��		M������]���þ��{�r�:�$�V�M�#H��T�$(�k���gZ�5�c����yY�
0$H�N��-Av(��7�"��Uo`"���~� ���\��I`�H��r�	�i�j#�L���>�n�`P9�H�<�͟B_�dڢ}u�H.t���`#˩�. v��P��:��/��p�p��wwww�g��      (   s   x�=�K�0����=R�������q��r{ԇX��F�bM�:a�#P�$&�c#�����~F����[��\8��5;���%9���f~=�X��÷$���cvL'"�?'      ,   '  x�}VK��:\ˇQ�G�Y���1�-S��ы&+��$�"6�cZF�A��&��e]��%��CԿ�1���mE������ms,�$�������m���SDL_��m��m���3Ŗ�!���l�B{2��D���իmyp�ܡ�N.���m�(�A3�/�yO�?D�4=V������m�h�:'�s���%J� Vc�N����_��"�b*���{~���6�	⚉����I��q�j�&h��[_M�hč�T#9�pN̶/1 .��hy�Ie�T�H~�ei�n<�%V)bՖ��ϾJY"4�w|��[�%r� �-�{.��D/|DiDG&S����n���m_���%���(n�a��W������P�MY˾��Q[{C�p���v�L��Z�jes�ok�A�Aw贇皱��j�0�8!&�)u�j�hnO@��%��,�km�YÎL��aUq9=��Hch9���a��J���^��8K��?(�8�)�7���k7�΍��.��L9�4Rsi|�O:}���3��XB5�p���+�gRDg�l������q�s�Q��N�� �:9�j��8��i��{rtlĹ��q4�F�{
�wZ�團����_�n:}��7�k劤�\���:�ܞ��5���I��\w�p�o�ȊV��"��4+~8�h�-�f}�Nj�B�LY�
n6L~�J�@3����8���Ĭ҄Bj��#��C���Y�{�[	E�e%�q8`�;E���x0&�1�a��@C�#֣�Zܒ�(�����7V��y:��b� ��0����e?�J��Ńx�4ٞ���E=W`���.��ώ���r؍��^��n��Ha��f����+��e��=��p���g�$7�cW����d�O4)*���AG�M�i��-��h�^^�6�'c���3���WK1��0�9�aq�{�I"+��0�\��7�(
�Ð>��ٵ���o���U����{�6��=�'�q|Dѿ��r���W�F21��[���m�'��-�������߼��1���      &   I   x�3�L�H-J�,N�4�2��MM�,I,����4�2�LM)M��̸L8�3�R�9c��L9��R�e� ^� 7�D     