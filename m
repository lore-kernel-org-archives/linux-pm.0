From: Jean Delvare <jdelvare@suse.de>
Subject: Re: cpuidle governors
Date: Fri, 22 Nov 2013 19:14:44 +0100
Message-ID: <1385144084.4840.9.camel@chaos.site>
References: <1383831870.4370.382.camel@chaos.site>
	 <527B9BA2.4060100@linaro.org> <1385106338.4373.11.camel@chaos.site>
	 <528F7DB9.6020204@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56183 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935Ab3KVSOs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Nov 2013 13:14:48 -0500
In-Reply-To: <528F7DB9.6020204@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

Le Friday 22 November 2013 =C3=A0 16:52 +0100, Rafael J. Wysocki a =C3=A9=
crit :
> On 11/22/2013 8:45 AM, Jean Delvare wrote:
> > * That a kernel built without NO_HZ still gets cpuidle governor "me=
nu".
> > This contradicts your statement above.
> > * That a NO_HZ kernel booted with nohz=3Doff behaves differently th=
an a
> > kernel built without NO_HZ with regards to cpuidle. Both use the "m=
enu"
> > governor by default (while I understand they should rather not), bu=
t in
> > the latter case deep C states are reached while in the former they =
never
> > are. This smells like a second bug.
> >
> > I would appreciate if both bugs could get fixed.
>=20
> Yes, it looks like we have two separate bugs there.
>=20
> >   I can fill out bugzilla entries if it helps.
>=20
> Please do, that helps a lot.

Done:

Bug 65531 - Cpuidle governor menu selected despite NO_HZ not being enab=
led
https://bugzilla.kernel.org/show_bug.cgi?id=3D65531

Bug 65541 - Booting with nohz=3Doff breaks the menu cpuidle governor
https://bugzilla.kernel.org/show_bug.cgi?id=3D65541

--=20
Jean Delvare
Suse L3 Support

