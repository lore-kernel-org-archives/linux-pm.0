From: Rik van Riel <riel@redhat.com>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Wed, 02 Mar 2016 12:10:54 -0500
Message-ID: <1456938654.17839.9.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <87si087tsr.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-x7uYuVH1XGo5BclAENQ3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52236 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802AbcCBRK5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Mar 2016 12:10:57 -0500
In-Reply-To: <87si087tsr.fsf@iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--=-x7uYuVH1XGo5BclAENQ3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-03-02 at 18:01 +0200, Arto Jantunen wrote:
> Len Brown <lenb@kernel.org> writes:
>=20
> > > Since this is about cpuidle, I'll also mention that this hardware
> > > requires idle=3Dnomwait on the command line, otherwise the kernel
> > > will not
> > > boot.
> >=20
> > Arto,
> >=20
> > A boot failure is even more disruptive than bad P-state and C-state=20
> > choices!
> > Please tell us more about it.
> >=20
> > What c-states are used when you use "idle=3Dnomwait"?
> > you can see them this way:
> >=20
> > grep . /sys/devices/system/cpu/cpu0/cpuidle/*/*
>=20
> /sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL
> IDLE
> /sys/devices/system/cpu/cpu0/cpuidle/state0/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
> /sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
> /sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/time:1405175
> /sys/devices/system/cpu/cpu0/cpuidle/state0/usage:135

It looks like the system spent some time in idle
poll, but not that much.

> /sys/devices/system/cpu/cpu0/cpuidle/state1/desc:ACPI HLT
> /sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency:1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
> /sys/devices/system/cpu/cpu0/cpuidle/state1/time:69898878
> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage:25539

This looks reasonable, with an exit latency of 1 us,
and a lot of idle time spent here.

> /sys/devices/system/cpu/cpu0/cpuidle/state2/desc:ACPI IOPORT 0x1816
> /sys/devices/system/cpu/cpu0/cpuidle/state2/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state2/latency:151
> /sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2
> /sys/devices/system/cpu/cpu0/cpuidle/state2/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state2/residency:302
> /sys/devices/system/cpu/cpu0/cpuidle/state2/time:28132
> /sys/devices/system/cpu/cpu0/cpuidle/state2/usage:10724

The exit latency for your C2 and C3 states look excessive,
with 151 and 1034 microseconds, respectively.

I believe there are supposed to be some lower latency
idle states in there. The skl_cstates table in
drivers/idle/intel_idle.c suggests you should be seeing
states with exit latencies of 2, 10, 70, 85, and 124
us before getting to that C2 state you see above.

As you can see from the "time" stats, your CPU spends
most of its time in HLT or polling, and very little time
in these deeper, much much slower idle states.

Having the mwait based idle states working would probably
get the CPU to spend a lot less time in HLT, and more time
in "proper" idle states.

> /sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI IOPORT 0x1819
> /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:1034
> /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3
> /sys/devices/system/cpu/cpu0/cpuidle/state3/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:2068
> /sys/devices/system/cpu/cpu0/cpuidle/state3/time:14169
> /sys/devices/system/cpu/cpu0/cpuidle/state3/usage:3375



> > Please boot with intel_idle.max_cstate=3D0
> >=20
> > If that also boots, please again show the available c-states via
> > the grep above.
>=20
> It does, here:
>=20
> /sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL
> IDLE
> /sys/devices/system/cpu/cpu0/cpuidle/state0/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
> /sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
> /sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state0/time:30951
> /sys/devices/system/cpu/cpu0/cpuidle/state0/usage:132
> /sys/devices/system/cpu/cpu0/cpuidle/state1/desc:ACPI FFH INTEL MWAIT
> 0x0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/latency:1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1
> /sys/devices/system/cpu/cpu0/cpuidle/state1/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
> /sys/devices/system/cpu/cpu0/cpuidle/state1/time:4231850
> /sys/devices/system/cpu/cpu0/cpuidle/state1/usage:14709
> /sys/devices/system/cpu/cpu0/cpuidle/state2/desc:ACPI FFH INTEL MWAIT
> 0x33
> /sys/devices/system/cpu/cpu0/cpuidle/state2/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state2/latency:151
> /sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2
> /sys/devices/system/cpu/cpu0/cpuidle/state2/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state2/residency:302
> /sys/devices/system/cpu/cpu0/cpuidle/state2/time:6524492
> /sys/devices/system/cpu/cpu0/cpuidle/state2/usage:4621
> /sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI FFH INTEL MWAIT
> 0x60
> /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:1034
> /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3
> /sys/devices/system/cpu/cpu0/cpuidle/state3/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:2068
> /sys/devices/system/cpu/cpu0/cpuidle/state3/time:52217106
> /sys/devices/system/cpu/cpu0/cpuidle/state3/usage:3364
>=20
> > Does it happen if you use default cmdline,
> > but edit intel_idle.c to comment out c8 and c9 support?
>=20
> That also boots, ts.out attached (as is the patch to do this, to make
> sure there is no miscommunication). With this change the original bug
> disappears as well.
>=20
--=20
--=C2=A0
All rights reversed

--=-x7uYuVH1XGo5BclAENQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAABAgAGBQJW1x6eAAoJEM553pKExN6Dwr8H/R1THlC26QNXQSzq4vTLub0/
Tj2oSmjN6iqNxz6jZ2s3xR7HhwJXxMLZooSdgeIwKat6rEe7KHl+S81m6jFhDMSh
zefU45HYmfk2NSWH7bS4Su4iJX459YnY2fSFvSh9TO+v2scjBNfX2ccphKkvLDHm
VlAp+w/Vu0Y8SFCi8QpuC3dpZkt1o1mJFTsRvD7EiGyQJS9iZ83bHcsPn5N4L2V9
gm7vXJuB+hQnnyOUPjnefvjLUo2JSBNxcjqXggpwoZACWa8+ZXTtJaKXiL/GfGpu
uQbPSeqWpDKLlpVMBLsBRlh9JuqSHV5wVLvnyvUF+QNFmk11BMXeAjp7o2p1ufw=
=fsQY
-----END PGP SIGNATURE-----

--=-x7uYuVH1XGo5BclAENQ3--

