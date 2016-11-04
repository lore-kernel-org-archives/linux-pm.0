From: Pavel Machek <pavel@ucw.cz>
Subject: v4.8-rc1: thinkpad x60: running at low frequency even during kernel
 build
Date: Fri, 4 Nov 2016 09:38:49 +0100
Message-ID: <20161104083849.GA32688@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57500 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760644AbcKDIix (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2016 04:38:53 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm debugging overheats on v4.9-rc1... which did not seem to happen in
v4.8-rc1. I'm running basically "nice make -j 3" on kernel... cpus are
fully loaded.=20

%Cpu(s):  7.5 us, 18.5 sy, 72.6 ni,  0.0 id,  0.0 wa,  0.0 hi,  1.5
si,  0.0 st
KiB Mem:   3087096 total,  2993076 used,    94020 free,    52900
buffers
KiB Swap:  1681428 total,    60900 used,  1620528 free.  1183664
cached Mem

Still, cpus don't stay on maximum frequency on v4.8-rc1. (I suspect
that may be why machine does not overheat).

pavel@duo:/data/l/linux$ sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq ; sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq  ; sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq ; sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq  ; sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq  ; sudo cat
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq
1833000
1833000
1000000
1000000
1000000
1000000
1833000
1833000
1833000
1833000
1000000
1000000
pavel@duo:/data/l/linux

pavel@duo:/data/l/linux$ grep -i
=2E /sys/devices/system/cpu/cpu0/cpufreq/*
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
/sys/devices/system/cpu/cpu0/cpufreq/bios_limit:1833000
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
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1833000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:ondemand
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:1833000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:1000000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>
grep: /sys/devices/system/cpu/cpu0/cpufreq/stats: Is a directory

Is that expected behaviour? Any ideas?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgcSRkACgkQMOfwapXb+vLO7ACfQENb6t5dCX+sfWtwZT/eAbj0
ERwAni6JMgNXnzoqWVClUa2NDpYpYq5Y
=m1jF
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
