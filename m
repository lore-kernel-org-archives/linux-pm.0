From: Jean Delvare <jdelvare@suse.de>
Subject: Re: cpuidle governors
Date: Fri, 22 Nov 2013 08:45:38 +0100
Message-ID: <1385106338.4373.11.camel@chaos.site>
References: <1383831870.4370.382.camel@chaos.site>
	 <527B9BA2.4060100@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55888 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216Ab3KVHpo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Nov 2013 02:45:44 -0500
In-Reply-To: <527B9BA2.4060100@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Hi Daniel,

Thanks for your fast reply and sorry for my slow one :(

Le Thursday 07 November 2013 =C3=A0 14:54 +0100, Daniel Lezcano a =C3=A9=
crit :
> On 11/07/2013 02:44 PM, Jean Delvare wrote:
> > Hi all,
> >
> > I had to work on cpuidle recently and there are two things which ca=
used
> > me trouble and I'd like to discuss.
> >
> > 1* Is there no documentation about how the available governors (men=
u and
> > ladder) work? I found good documentation of the general architectur=
e and
> > API in Documentation/cpuidle, but I am missing a description of the
> > internal logic of each available governor (just like
> > Documentation/cpu-freq/governors.txt for cpufreq.)
>=20
> IMO, the code review and the header description in the menu.c file is=
=20
> the best way to understand how the governor works.

OK, I'll look at the code then. But I still believe this should be
documented for clarity.

> For very specific=20
> questions, try asking in the mailing list.

I'm doing that right now ;)

> > Also, the
> > documentation says that "the kernel picks the best governor based o=
n
> > governor ratings" but that's pretty vague. An explanation of how th=
e
> > governors are rated would be good to have. Could this be added?
>=20
> Yeah, actually they are rated but depending on the system configurati=
on=20
> one fit better than the other one. Tickless system =3D> menu governor=
,=20
> Periodic system =3D> ladder governor. Using a tickless system with th=
e=20
> ladder governor is less efficient from a power saving POV.

My original issue is somewhat related to this. One customer reported to
us that booting with nohz=3Doff breaks cpuidle. My own testing revealed=
:

* That a kernel built without NO_HZ still gets cpuidle governor "menu".
This contradicts your statement above.
* That a NO_HZ kernel booted with nohz=3Doff behaves differently than a
kernel built without NO_HZ with regards to cpuidle. Both use the "menu"
governor by default (while I understand they should rather not), but in
the latter case deep C states are reached while in the former they neve=
r
are. This smells like a second bug.

I would appreciate if both bugs could get fixed. I can fill out bugzill=
a
entries if it helps.

Thanks,
--=20
Jean Delvare
Suse L3 Support

