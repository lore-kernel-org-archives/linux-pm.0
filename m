From: Sebastian Capella <sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/2] PM / Hibernate: use name_to_dev_t to parse resume
Date: Mon, 26 Aug 2013 10:10:59 -0700
Message-ID: <CADHgK6tN43dttaB9mJ8mCiORUf61APXv2SmBUD2wR1AVFL0L6A@mail.gmail.com>
References: <1377114413-8521-1-git-send-email-sebastian.capella@linaro.org>
 <1377114413-8521-2-git-send-email-sebastian.capella@linaro.org>
 <20130825153811.GA4795@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2083793441185267502=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20130825153811.GA4795-tWAi6jLit6GreWDznjuHag@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
 <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
 <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============2083793441185267502==
Content-Type: multipart/alternative; boundary=001a11c1ce681b893104e4dcd7cc

--001a11c1ce681b893104e4dcd7cc
Content-Type: text/plain; charset=ISO-8859-1

Thanks Pavel!  I'll add the check for NULL.

name_to_dev_t expects a non-const name, but the buffer passed in is const.
I also am removing the '\n' if found at the end of the string which would
violate the const.

Thanks!

Sebastian


On 25 August 2013 08:38, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> Hi!
>
> > Use the name_to_dev_t call to parse the device name echo'd to
> > to /sys/power/resume.  This imitates the method used in hibernate.c
> > in software_resume, and allows the resume partition to be specified
> > using other equivalent device formats as well.  By allowing
> > /sys/debug/resume to accept the same syntax as the resume=device
> > parameter, we can parse the resume=device in the init script and
> > use the resume device directly from the kernel command line.
> >
> > Signed-off-by: Sebastian Capella <sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  kernel/power/hibernate.c |   14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index b26f5f1..51d4c29 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -971,15 +971,19 @@ static ssize_t resume_show(struct kobject *kobj,
> struct kobj_attribute *attr,
> >  static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute
> *attr,
> >                           const char *buf, size_t n)
> >  {
> > -     unsigned int maj, min;
> >       dev_t res;
> >       int ret = -EINVAL;
> > +     int len = n;
> > +     char *devcpy;
> >
> > -     if (sscanf(buf, "%u:%u", &maj, &min) != 2)
> > -             goto out;
> > +     if (buf[len-1] == '\n')
> > +             len--;
> > +
> > +     devcpy = kstrndup(buf, len, GFP_KERNEL);
> > +     res = name_to_dev_t(devcpy);
> > +     kfree(devcpy);
>
> Is the allocation actually neccessary? At the very least this should
> test for NULL...
>
> Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>

--001a11c1ce681b893104e4dcd7cc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Pavel! =A0I&#39;ll add the check for NULL.<div><div=
><br></div><div>name_to_dev_t expects a non-const name, but the buffer pass=
ed in is const.</div><div>I also am removing the &#39;\n&#39; if found at t=
he end of the string which would violate the const.</div>
<div><br></div><div>Thanks!</div><div><br></div><div>Sebastian=A0</div></di=
v></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On 25=
 August 2013 08:38, Pavel Machek <span dir=3D"ltr">&lt;<a href=3D"mailto:pa=
vel-+ZI9xUNit7I@public.gmane.org" target=3D"_blank">pavel-+ZI9xUNit7I@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi!<br>
<div><div class=3D"h5"><br>
&gt; Use the name_to_dev_t call to parse the device name echo&#39;d to<br>
&gt; to /sys/power/resume. =A0This imitates the method used in hibernate.c<=
br>
&gt; in software_resume, and allows the resume partition to be specified<br=
>
&gt; using other equivalent device formats as well. =A0By allowing<br>
&gt; /sys/debug/resume to accept the same syntax as the resume=3Ddevice<br>
&gt; parameter, we can parse the resume=3Ddevice in the init script and<br>
&gt; use the resume device directly from the kernel command line.<br>
&gt;<br>
&gt; Signed-off-by: Sebastian Capella &lt;<a href=3D"mailto:sebastian.capel=
la-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0kernel/power/hibernate.c | =A0 14 +++++++++-----<br>
&gt; =A01 file changed, 9 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c<br>
&gt; index b26f5f1..51d4c29 100644<br>
&gt; --- a/kernel/power/hibernate.c<br>
&gt; +++ b/kernel/power/hibernate.c<br>
&gt; @@ -971,15 +971,19 @@ static ssize_t resume_show(struct kobject *kobj,=
 struct kobj_attribute *attr,<br>
&gt; =A0static ssize_t resume_store(struct kobject *kobj, struct kobj_attri=
bute *attr,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, s=
ize_t n)<br>
&gt; =A0{<br>
&gt; - =A0 =A0 unsigned int maj, min;<br>
&gt; =A0 =A0 =A0 dev_t res;<br>
&gt; =A0 =A0 =A0 int ret =3D -EINVAL;<br>
&gt; + =A0 =A0 int len =3D n;<br>
&gt; + =A0 =A0 char *devcpy;<br>
&gt;<br>
&gt; - =A0 =A0 if (sscanf(buf, &quot;%u:%u&quot;, &amp;maj, &amp;min) !=3D =
2)<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
&gt; + =A0 =A0 if (buf[len-1] =3D=3D &#39;\n&#39;)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 len--;<br>
&gt; +<br>
&gt; + =A0 =A0 devcpy =3D kstrndup(buf, len, GFP_KERNEL);<br>
&gt; + =A0 =A0 res =3D name_to_dev_t(devcpy);<br>
&gt; + =A0 =A0 kfree(devcpy);<br>
<br>
</div></div>Is the allocation actually neccessary? At the very least this s=
hould<br>
test for NULL...<br>
<span class=3D"HOEnZb"><font color=3D"#888888">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Pavel<br>
--<br>
(english) <a href=3D"http://www.livejournal.com/~pavelmachek" target=3D"_bl=
ank">http://www.livejournal.com/~pavelmachek</a><br>
(cesky, pictures) <a href=3D"http://atrey.karlin.mff.cuni.cz/~pavel/picture=
/horses/blog.html" target=3D"_blank">http://atrey.karlin.mff.cuni.cz/~pavel=
/picture/horses/blog.html</a><br>
</font></span></blockquote></div><br></div>

--001a11c1ce681b893104e4dcd7cc--


--===============2083793441185267502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============2083793441185267502==--
