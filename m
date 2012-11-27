From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Longhaul: Disable driver by default
Date: Wed, 28 Nov 2012 00:44:54 +0100
Message-ID: <1451067.pE2ohDYtjy@vostro.rjw.lan>
References: <1354054435-2459-1-git-send-email-rafalbilski@interia.pl> <1997813.IluQxocScm@vostro.rjw.lan> <50B54ED9.3090704@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34721 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab2K0XkK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Nov 2012 18:40:10 -0500
In-Reply-To: <50B54ED9.3090704@interia.pl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?B?UmFmYcWC?= Bilski <rafalbilski@interia.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Dave Jones <davej@redhat.com>

On Tuesday, November 27, 2012 11:38:01 PM Rafa=C5=82 Bilski wrote:
>=20
> > On Tuesday, November 27, 2012 10:13:55 PM Rafal Bilski wrote:
> >> This is only solution I can think of. User decides if he wants thi=
s
> >> driver on his machine. I don't have enough knowledge and time to f=
ind
> >> the reason why same code works on some machines and doesn't on oth=
ers
> >> which use same, or very similar,  chipset and processor.
> > I always have problems with patches like this one, because they are=
 pretty much
> > guaranteed to make someone complain.
> >
> > Is there any way to blacklist the affected machine you have?
> >
> > Rafael
> No. Also problem seems to be larger than one machine. Also weirder.
> One user claims his processor can't run below some frequency even
> if it should be perfectly capable of doing so. System in question
> freezes straight away. In past on good system I could change
> frequency at least a couple of times without any protection. Just by
> a chance. I tried to investigate "weird CPU 0 not listed by the BIOS"
> message, but I have nothing. Also I seem to have far less time for
> anything than in the past.

OK, I'll take the patch, then, but I won't include it in my first v3.8 =
pull
request.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
