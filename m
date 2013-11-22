From: Jean Delvare <jdelvare@suse.de>
Subject: Re: cpuidle governors
Date: Fri, 22 Nov 2013 19:06:51 +0100
Message-ID: <1385143611.4840.7.camel@chaos.site>
References: <1383831870.4370.382.camel@chaos.site>
	 <527B9BA2.4060100@linaro.org> <1385106338.4373.11.camel@chaos.site>
	 <528F7DB9.6020204@intel.com>  <528F82F4.3080005@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55849 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137Ab3KVSG6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Nov 2013 13:06:58 -0500
In-Reply-To: <528F82F4.3080005@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

Hi Daniel,

Le Friday 22 November 2013 =C3=A0 17:14 +0100, Daniel Lezcano a =C3=A9c=
rit :
> On 11/22/2013 04:52 PM, Rafael J. Wysocki wrote:
> > On 11/22/2013 8:45 AM, Jean Delvare wrote:
> >>My own testing revealed:
> >>
> >> * That a kernel built without NO_HZ still gets cpuidle governor "m=
enu".
> >> This contradicts your statement above.
> >> * That a NO_HZ kernel booted with nohz=3Doff behaves differently t=
han a
> >> kernel built without NO_HZ with regards to cpuidle. Both use the "=
menu"
> >> governor by default (while I understand they should rather not), b=
ut in
> >> the latter case deep C states are reached while in the former they=
 never
> >> are. This smells like a second bug.
> >>
> >> I would appreciate if both bugs could get fixed.
> >
> > Yes, it looks like we have two separate bugs there.
>=20
> Actually, the first one is a bug but not the second one.
>=20
> I made some changes to select by default the menu governor with NO_HZ=
=20
> and the ladder governor without NO_HZ and wanted to remove the unneed=
ed=20
> governor from the Kconfig. But we let it as it was to keep the old=20
> behavior. Unfortunately, the governor rating decision will always goe=
s=20
> in favor of the menu governor as it is the best one even if we are *n=
ot*=20
> with NO_HZ. So the only way to prevent is to set in the kernel comman=
d=20
> line the option 'cpuidle_sysfs_switch' and from the userspace set the=
=20
> ladder governor when the system has booted.

That's what I ended up doing, yes, but I don't like it, because 1* it's
not as straightforward as a cpuidle.governor=3Dxxx option and 2* I don'=
t
think I should have to change the governor manually in the first place.

> A fix could be to remove from the configuration the governor which do=
es=20
> not suit the NO_HZ option.

That's not a good idea because nohz=3Doff can be passed on the command
line to reenable the ticking at runtime. So the governor must be decide=
d
at runtime too.

> Another fix would be to play with the rating and change them dependin=
g=20
> on the NO_HZ option.

Yes, I think this is better, because then you can honor nohz=3Doff.

> Concerning the second bug, it is not a bug but totally normal. On a=20
> periodic tick system, (aka NO_HZ=3Dno), the periodic timer duration=20
> prevents to enter a deep idle state. The target residency for the sta=
te,=20
> which is never reached, should be on your system greater than the=20
> periodic tick duration.

Not sure if you read what I wrote properly. The menu governor _does_
work at least to some degree without NO_HZ, even if it is less efficien=
t
than with NO_HZ (no surprise here.) What bothers me is that NO_HZ=3Dy +
nohz=3Doff behaves differently than NO_HZ=3Dn. I believe they should be=
have
the same.

I'll fill bugs for both.

Thanks,
--=20
Jean Delvare
Suse L3 Support

