From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Longhaul: Disable driver by default
Date: Sat, 15 Dec 2012 01:06:02 +0100
Message-ID: <4105674.oPYtRh9f8m@vostro.rjw.lan>
References: <1354054435-2459-1-git-send-email-rafalbilski@interia.pl> <50B54ED9.3090704@interia.pl> <1451067.pE2ohDYtjy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34243 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945960Ab2LOAAz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Dec 2012 19:00:55 -0500
In-Reply-To: <1451067.pE2ohDYtjy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?B?UmFmYcWC?= Bilski <rafalbilski@interia.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Dave Jones <davej@redhat.com>

On Wednesday, November 28, 2012 12:44:54 AM Rafael J. Wysocki wrote:
> On Tuesday, November 27, 2012 11:38:01 PM Rafa=C5=82 Bilski wrote:
> >=20
> > > On Tuesday, November 27, 2012 10:13:55 PM Rafal Bilski wrote:
> > >> This is only solution I can think of. User decides if he wants t=
his
> > >> driver on his machine. I don't have enough knowledge and time to=
 find
> > >> the reason why same code works on some machines and doesn't on o=
thers
> > >> which use same, or very similar,  chipset and processor.
> > > I always have problems with patches like this one, because they a=
re pretty much
> > > guaranteed to make someone complain.
> > >
> > > Is there any way to blacklist the affected machine you have?
> > >
> > > Rafael
> > No. Also problem seems to be larger than one machine. Also weirder.
> > One user claims his processor can't run below some frequency even
> > if it should be perfectly capable of doing so. System in question
> > freezes straight away. In past on good system I could change
> > frequency at least a couple of times without any protection. Just b=
y
> > a chance. I tried to investigate "weird CPU 0 not listed by the BIO=
S"
> > message, but I have nothing. Also I seem to have far less time for
> > anything than in the past.
>=20
> OK, I'll take the patch, then, but I won't include it in my first v3.=
8 pull
> request.

I'm queuing it up for submission as v3.8 material later in the cycle.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
