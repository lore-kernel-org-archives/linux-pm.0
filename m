From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Fri, 4 Nov 2016 09:58:30 +0100
Message-ID: <20161104085830.GA4089@amd>
References: <20161104083849.GA32688@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161104083849.GA32688@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2016-11-04 09:38:49, Pavel Machek wrote:
> Hi!
>=20
> I'm debugging overheats on v4.9-rc1... which did not seem to happen in
> v4.8-rc1. I'm running basically "nice make -j 3" on kernel... cpus are
> fully loaded.=20
>=20
> %Cpu(s):  7.5 us, 18.5 sy, 72.6 ni,  0.0 id,  0.0 wa,  0.0 hi,  1.5
> si,  0.0 st
> KiB Mem:   3087096 total,  2993076 used,    94020 free,    52900
> buffers
> KiB Swap:  1681428 total,    60900 used,  1620528 free.  1183664
> cached Mem
>=20
> Still, cpus don't stay on maximum frequency on v4.8-rc1. (I suspect
> that may be why machine does not overheat).

What is worse, they go to low frequency even with "performance"
governor on v4.8-rc1?!

pavel@duo:/sys/devices/system/cpu/cpu0/cpufreq$ sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq ; sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq  ; sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq ; sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq  ; sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq  ; sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq
1000000
1000000
1000000
1000000
1833000
1833000
1000000
1000000
1833000
1833000
1000000
1000000
pavel@duo:/sys/devices/system/cpu/cpu0/cpufreq$ grep -i
=2E /sys/devices/system/cpu/cpu0/cpufreq/*
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
/sys/devices/system/cpu/cpu0/cpufreq/bios_limit:1000000
grep: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:
Permission denied
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:1833000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:1000000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:10000
/sys/devices/system/cpu/cpu0/cpufreq/freqdomain_cpus:0 1
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:1833000
1333000 1000000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:conservati=
ve
powersave schedutil ondemand performance
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:1000000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:1000000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>
grep: /sys/devices/system/cpu/cpu0/cpufreq/stats: Is a directory
pavel@duo:/sys/devices/system/cpu/cpu0/cpufreq$

Let me try v4.9-rc2... that works ok (cpus at the high frequency
during the kernel build). Unfortunately that sends my cpus to 99C
temperature range (and eventually forces emergency shutdown).

v4.9-rc2, current policy changes without me touching it. Notice the
1.47GHz below? I did not do that, it oscilates itself. Is that thermal
protection?=20

analyzing CPU 1:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 1
  CPUs which need to have their frequency coordinated by software: 1
  maximum transition latency: 10.0 us.
  hardware limits: 1000 MHz - 1.83 GHz
  available frequency steps: 1.83 GHz, 1.33 GHz, 1000 MHz
  available cpufreq governors: conservative, powersave, ondemand, performan=
ce, schedutil
  current policy: frequency should be within 1000 MHz and 1.47 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.33 GHz.
  cpufreq stats: 1.83 GHz:38.24%, 1.33 GHz:34.83%, 1000 MHz:26.94%  (9929)

dmesg is full of

[  716.196096] thinkpad_acpi: THERMAL EMERGENCY: a sensor reports
something is extremely hot!
[  716.198181] thinkpad_acpi: temperatures (Celsius): 97 52 N/A 87 37
N/A 37 N/A 53 62 N/A N/A N/A N/A N/A N/A

but no information about thermal throttling...

Any ideas?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgcTbYACgkQMOfwapXb+vKB3wCglDJN6Q2j5o8svPd9tAkuZbZA
+eoAn2cCMK9B73sSZCi2ZtFvBxtgcge5
=Z0hq
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
