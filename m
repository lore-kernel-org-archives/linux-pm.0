From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] kernel/power/hibernate.c: be sure of 'start' is not bigger than 'stop'
Date: Mon, 21 Apr 2014 22:43:10 +0200
Message-ID: <1597133.Gff7RjtQZQ@vostro.rjw.lan>
References: <53551FCB.3030109@gmail.com> <20140421200930.GA9880@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55810 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754440AbaDUU0w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Apr 2014 16:26:52 -0400
In-Reply-To: <20140421200930.GA9880@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Chen Gang <gang.chen.5i5j@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, len.brown@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Monday, April 21, 2014 10:09:30 PM Pavel Machek wrote:
> On Mon 2014-04-21 21:40:27, Chen Gang wrote:
> > For do_div(), it need 'u64' type, which means the outside must be s=
ure
> > of 'start' is not bigger than 'stop', or it will report warning.
> >=20
> > The related warning (with allmodconfig for unicore32):
> >=20
> >     CC      kernel/power/hibernate.o
> >   kernel/power/hibernate.c: In function =E2=80=98swsusp_show_speed=E2=
=80=99:
> >   kernel/power/hibernate.c:237: warning: comparison of distinct poi=
nter types lacks a cast
> >=20
> > Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>=20
> >  {
> > -	s64 elapsed_centisecs64;
> > +	u64 elapsed_centisecs64;
> >  	int centisecs;
> >  	int k;
> >  	int kps;
> > =20
> >  	elapsed_centisecs64 =3D timeval_to_ns(stop) - timeval_to_ns(start=
);
> > +	if ((s64)elapsed_centisecs64 < 0) {
> > +		printk(KERN_ERR "PM: stop: %llu < start %llu\n",
> > +			timeval_to_ns(stop), timeval_to_ns(start));
> > +		return;
> > +	}
> >  	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
> >  	centisecs =3D elapsed_centisecs64;
> >  	if (centisecs =3D=3D 0)
>=20
> Quite a lot of code to shut up warning in mostly debugging
> function... is there alternative method of shutting it up? Have you
> seen < 0 values in wild?

No, I don't think so.  This is a purely theoretical problem that never
happens in practice, because all of the callers do the right thing.

Rafael=20

