From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v5 1/2] mm: add kstrimdup function
Date: Thu, 30 Jan 2014 13:45:45 -0800
Message-ID: <20140130214545.18296.69349@capellas-linux>
References: <1391116318-17253-1-git-send-email-sebastian.capella@linaro.org>
 <1391116318-17253-2-git-send-email-sebastian.capella@linaro.org>
 <20140130132251.4f662aeddc09d8410dee4490@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140130132251.4f662aeddc09d8410dee4490@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Joe Perches <joe@perches.com>, Mikulas Patocka <mpatocka@redhat.com>, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

Quoting Andrew Morton (2014-01-30 13:22:51)
> On Thu, 30 Jan 2014 13:11:57 -0800 Sebastian Capella <sebastian.capella@l=
inaro.org> wrote:
> > +char *kstrimdup(const char *s, gfp_t gfp)
> > +{
> > +     char *buf;
> > +     char *begin =3D skip_spaces(s);
> > +     size_t len =3D strlen(begin);
> > +
> > +     while (len > 1 && isspace(begin[len - 1]))
> > +             len--;
> =

> That's off-by-one isn't it?  kstrimdup("   ") should return "", not " ".
> =

> > +     buf =3D kmalloc_track_caller(len + 1, gfp);
> > +     if (!buf)
> > +             return NULL;
> > +
> > +     memcpy(buf, begin, len);
> > +     buf[len] =3D '\0';
> > +
> > +     return buf;
> > +}

Hi Andrew,

I think this is a little tricky.

For an empty string, the function relies on skip_spaces to point begin
at the \0'.

Alternately, if we don't have an empty string, we know we have at least 1
non-space, non-null character at begin[0], and there's no need to check it,
so the loop stops at [1].  If there's a space at 1, we just put the '\0'
there.

We could check at [0], but I think its already been checked by skip_spaces.

I'll add a comment above the while for that

Thanks,

Sebastian


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
