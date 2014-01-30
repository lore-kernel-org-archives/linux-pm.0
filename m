From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v4 1/2] mm: add kstrimdup function
Date: Wed, 29 Jan 2014 19:41:37 -0800
Message-ID: <20140130034137.2769.50210@capellas-linux>
References: <1391039304-3172-1-git-send-email-sebastian.capella@linaro.org>
 <1391039304-3172-2-git-send-email-sebastian.capella@linaro.org>
 <alpine.LRH.2.02.1401291956510.8304@file01.intranet.prod.int.rdu2.redhat.com>
 <1391045068.2422.30.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1391045068.2422.30.camel@joe-AO722>
Sender: owner-linux-mm@kvack.org
To: Joe Perches <joe@perches.com>, Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

Quoting Joe Perches (2014-01-29 17:24:28)
> Why not minimize the malloc length too?
> =

> maybe something like:
> =

> char *kstrimdup(const char *s, gfp_t gfp)
> {
>         char *buf;
>         const char *begin =3D skip_spaces(s);
>         size_t len =3D strlen(begin);
> =

>         while (len && isspace(begin[len - 1]))
>                 len--;
> =

>         buf =3D kmalloc_track_caller(len + 1, gfp);
>         if (!buf)
>                 return NULL;
> =

>         memcpy(buf, begin, len);
>         buf[len] =3D 0;
> =

>         return buf;
> }

I figured it would be mostly for small trimming, but it seems like
it could be and advantage and used more generally this way.

I have a couple of small changes to return NULL in empty string/all ws
cases and fix a buffer underrun.

How does this look?

Thanks,

Sebastian


char *kstrimdup(const char *s, gfp_t gfp)
{                                                                          =
      =

        char *buf;                                                         =
      =

        const char *begin =3D skip_spaces(s);                              =
        =

        size_t len =3D strlen(begin);                                      =
        =


        if (len =3D=3D 0)                                                  =
          =

                return NULL;                                               =
      =

                                                                           =
      =

        while (len > 1 && isspace(begin[len - 1]))                         =
      =

                len--;                                                     =
      =

                                                                           =
      =

        buf =3D kmalloc_track_caller(len + 1, gfp);                        =
        =

        if (!buf)                                                          =
      =

                return NULL;                                               =
      =

                                                                           =
      =

        memcpy(buf, begin, len);                                           =
      =

        buf[len] =3D '\0';                                                 =
           =

                                                                           =
      =

        return buf;                                                        =
      =

}        =




--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
