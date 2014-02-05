From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v7 2/3] trivial: PM / Hibernate: clean up checkpatch in
 hibernate.c
Date: Tue, 04 Feb 2014 16:06:42 -0800
Message-ID: <20140205000642.6803.8182@capellas-linux>
References: <1391546631-7715-1-git-send-email-sebastian.capella@linaro.org>
 <20140204223733.30015.23993@capellas-linux>
 <20140204232222.31169.83206@capellas-linux>
 <1593382.PUxxx0NMeh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1593382.PUxxx0NMeh@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Quoting Rafael J. Wysocki (2014-02-04 16:03:29)
> On Tuesday, February 04, 2014 03:22:22 PM Sebastian Capella wrote:
> > Quoting Sebastian Capella (2014-02-04 14:37:33)
> > > Quoting Rafael J. Wysocki (2014-02-04 13:36:29)
> > > > >  static int __init resumedelay_setup(char *str)
> > > > >  {
> > > > > -     resume_delay =3D simple_strtoul(str, NULL, 0);
> > > > > +     int ret =3D kstrtoint(str, 0, &resume_delay);
> > > > > +     /* mask must_check warn; on failure, leaves resume_delay un=
changed */
> > > > > +     (void)ret;
> > =

> > One unintended consequence of this change is that it'll now accept a
> > negative integer parameter.
> =

> Well, what about using kstrtouint(), then?
I was thinking of doing something like:

	int delay, res;
	res =3D kstrtoint(str, 0, &delay);
	if (!res && delay >=3D 0)
		resume_delay =3D delay;
	return 1;

> Well, kstrtoint() is used in some security-sensitive places AFAICS, so it
> really is better to check its return value in general.  The __must_check
> reminds people about that.

Thanks!

Sebastian

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
