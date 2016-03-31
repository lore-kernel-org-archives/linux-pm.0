From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Thu, 31 Mar 2016 07:39:30 -0700
Message-ID: <002701d18b5b$22ea72d0$68bf5870$@net>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>	<CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>	<4187911.uaFVupaTVL@vostro.rjw.lan>	<CADDKRnCr0riAu4pjYRkuguoCoAjWxFoc+pU1NBymPr+3JnVanQ@mail.gmail.com>	<CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>	<1459352017.13525.45.camel@intel.com>	<CADDKRnA5x9dK=6KZWijiP_ihrUA9Afpmqw8TSzYn9oaBeaOfKw@mail.gmail.com>	<002401d18ab5$0bf84a30$23e8de90$@net>	<1459364336.13525.69.camel@linux.intel.com>	<CAJZ5v0gDNYRNaLKFCnPRomOhavLPD=zgp1oJdRv6OtHLb031Bw@mail.gmail.com>	<1459369587.13525.75.camel@linux.intel.com> <CADDKRnCfaG35EXp_thOqfG=6sjov7f1q521LSGL8oFqRfCqSaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta7.telus.net ([209.171.16.80]:47056 "EHLO cmta7.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768AbcCaOjg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 10:39:36 -0400
In-Reply-To: <CADDKRnCfaG35EXp_thOqfG=6sjov7f1q521LSGL8oFqRfCqSaw@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>

On 2016.03.31 02:24 J=C3=B6rg Otte wrote:

> jojo@fichte:/sys/devices/system/cpu/cpufreq/policy0$ cat scaling_gove=
rnor
> powersave
>=20
> turbostat -i 1 --msr=3D0x199
> CPUID(7): No-SGX
>     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
>       -      45    1.74    2590    2496  0x00000000
>       0      45    1.76    2565    2498  0x00000a00
>       1      72    2.84    2548    2496  0x00000800
>       2      30    1.11    2661    2496  0x00001a00
>       3      33    1.23    2661    2495  0x00001a00
>     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
>       -       9    0.35    2525    2495  0x00000000
>       0       1    0.04    2735    2495  0x00000800
>       1       1    0.05    2501    2495  0x00000800
>       2      17    0.65    2540    2495  0x00001a00
>       3      16    0.64    2501    2495  0x00001a00
>     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
>       -      11    0.43    2523    2495  0x00000000
>       0       3    0.11    2631    2495  0x00000c00
>       1       7    0.27    2524    2495  0x00000800
>       2      18    0.72    2527    2495  0x00001a00
>       3      15    0.61    2501    2495  0x00001a00

Very Interesting.

I would still like to get a trace sample to post process.
Copied from a previous e-mail:

On an otherwise idle system, do:

# perf record -a --event=3Dpower:pstate_sample sleep 300

If pressed for time, your sleep time can be less than 5 minutes,
but try to get at least 100 seconds.

The resulting perf.data file will be too big to include as an
on-list attachment, but send it (or them) to me off-list for
post processing, and I'll report back.

=2E.. Doug


