From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v7 2/3] trivial: PM / Hibernate: clean up checkpatch in
 hibernate.c
Date: Tue, 04 Feb 2014 16:24:13 -0800
Message-ID: <20140205002413.7648.33035@capellas-linux>
References: <1391546631-7715-1-git-send-email-sebastian.capella@linaro.org>
 <1593382.PUxxx0NMeh@vostro.rjw.lan> <20140205000642.6803.8182@capellas-linux>
 <2342041.V7doIJk0XQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <2342041.V7doIJk0XQ@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Quoting Rafael J. Wysocki (2014-02-04 16:28:13)
> On Tuesday, February 04, 2014 04:06:42 PM Sebastian Capella wrote:
> > Quoting Rafael J. Wysocki (2014-02-04 16:03:29)
> > > On Tuesday, February 04, 2014 03:22:22 PM Sebastian Capella wrote:
> > > > Quoting Sebastian Capella (2014-02-04 14:37:33)
> > > > > Quoting Rafael J. Wysocki (2014-02-04 13:36:29)
> > > > > > >  static int __init resumedelay_setup(char *str)
> > > > > > >  {
> > > > > > > -     resume_delay =3D simple_strtoul(str, NULL, 0);
> > > > > > > +     int ret =3D kstrtoint(str, 0, &resume_delay);
> > > > > > > +     /* mask must_check warn; on failure, leaves resume_dela=
y unchanged */
> > > > > > > +     (void)ret;
> > > > =

> > > > One unintended consequence of this change is that it'll now accept a
> > > > negative integer parameter.
> > > =

> > > Well, what about using kstrtouint(), then?
> > I was thinking of doing something like:
> > =

> >       int delay, res;
> >       res =3D kstrtoint(str, 0, &delay);
> >       if (!res && delay >=3D 0)
> >               resume_delay =3D delay;
> >       return 1;
> =

> It uses simple_strtoul() for a reason.  You can change the type of resume=
_delay
> to match, but the basic question is:
> =

> Why exactly do you want to change that thing?

This entire patch is a result of a single checkpatch warning from a printk
that I indented.

I was hoping to be helpful by removing all of the warnings from this
file, since I was going to have a separate cleanup patch for the printk.

I can see this is not a good direction.

Would it be better also to leave the file's printks as they were and drop
the cleanup patch completely?

Thanks,

Sebastian


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
