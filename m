From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Thu, 31 Mar 2016 11:23:33 +0200
Message-ID: <CADDKRnCfaG35EXp_thOqfG=6sjov7f1q521LSGL8oFqRfCqSaw@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>
	<4187911.uaFVupaTVL@vostro.rjw.lan>
	<CADDKRnCr0riAu4pjYRkuguoCoAjWxFoc+pU1NBymPr+3JnVanQ@mail.gmail.com>
	<CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>
	<1459352017.13525.45.camel@intel.com>
	<CADDKRnA5x9dK=6KZWijiP_ihrUA9Afpmqw8TSzYn9oaBeaOfKw@mail.gmail.com>
	<002401d18ab5$0bf84a30$23e8de90$@net>
	<1459364336.13525.69.camel@linux.intel.com>
	<CAJZ5v0gDNYRNaLKFCnPRomOhavLPD=zgp1oJdRv6OtHLb031Bw@mail.gmail.com>
	<1459369587.13525.75.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459369587.13525.75.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

2016-03-30 22:26 GMT+02:00 Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com>:
> On Wed, 2016-03-30 at 22:12 +0200, Rafael J. Wysocki wrote:
>> On Wed, Mar 30, 2016 at 8:58 PM, Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com> wrote:
>> >
>> > On Wed, 2016-03-30 at 11:50 -0700, Doug Smythies wrote:
>> > >
>> > > On 2016.03.30 08:52 J=C3=B6rg Otte wrote:
>> > > >
>> > > >
>> > > > 2016-03-30 17:33 GMT+02:00 Pandruvada, Srinivas
>> > > > <srinivas.pandruvad
>> > > > a@intel.com>:
>> > > > >
>> > > > >
>> > > > > On Wed, 2016-03-30 at 13:05 +0200, Rafael J. Wysocki wrote:
>> > > > > >
>> > > > > >
>> > > > > > On Wed, Mar 30, 2016 at 12:17 PM, J=C3=B6rg Otte <jrg.otte=
@gmail
>> > > > > > .com
>> > > > > > >
>> > > > > > >
>> > > > >
>> > > > >
>> > > > > >
>> > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > > >
>> > > > > > > >
>> > > > > > > > >
>> > > > > > > > >
>> > > > > > > > > Now in v4.6-rc1 the characteristic has dramatically
>> > > > > > > > > changed.
>> > > > > > > > > If in idle the processor frequency is more or less a
>> > > > > > > > > few
>> > > > > > > > > MHz around 2500Mhz.
>> > > > > > > > > I currently use acpi_cpufreq which works as usual.
>> > > > > > > > > Processor: Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz
>> > > > > > > > > (family: 0x6, model: 0x3c, stepping: 0x3)
>> > > > >
>> > > > >
>> > > > > I want to reproduce this if I can. Can you give us info abou=
t
>> > > > > your
>> > > > > setup (Linux distribution, laptop model etc.)?
>> > > I would like to try to reproduce the issue also.
>> > >
>> > > >
>> > > >
>> > > > Distro: Ubuntu 14.04.4 LTS
>> > > Note that with Ubuntu 14.04, I had issues where my CPU
>> > > would lock at pstate 24 (not always 24, but usually),
>> > > regardless of load.
>> > > However, it was always after an S3 suspend, occurred 100%
>> > > of the time, and was independent of intel_pstate or
>> > > acpi-cpufreq CPU frequency scaling drivers.
>> > >
>> > > Since changing my test server to Ubuntu server edition 16.04
>> > > (development version), I have not had those issues. While I have
>> > > no proof, I have assumed the issue elimination was somehow
>> > > related
>> > > to the change to systemd.
>> > >
>> > > It might be worth observing both what the intel_pstate is asking
>> > > for
>> > > and what the processor is actually doing.
>> > If J=C3=B6rg runs with
>> >
>> > turbostat -i 1 --msr=3D0x199
>> >
>> > We can tell whether if we requested or the same problem you had.
>> > I tried on Ubuntu LTS 14.04 on same Haswell CPU model, I didn't se=
e
>> > this issue.
>> There seems to be something odd about the J=C3=B6rg's setup, or we'd=
 have
>> received more reports about this issue.
>>
>> Question is what that is and what really makes the difference.
>>
> I think, somehow we entered performance mode from powersave by defaul=
t
>
> turbostat -i 1 --msr=3D0x199 will tell us.
>

jojo@fichte:/sys/devices/system/cpu/cpufreq/policy0$ cat scaling_govern=
or
powersave

turbostat -i 1 --msr=3D0x199
CPUID(7): No-SGX
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -      45    1.74    2590    2496  0x00000000
       0      45    1.76    2565    2498  0x00000a00
       1      72    2.84    2548    2496  0x00000800
       2      30    1.11    2661    2496  0x00001a00
       3      33    1.23    2661    2495  0x00001a00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -       9    0.35    2525    2495  0x00000000
       0       1    0.04    2735    2495  0x00000800
       1       1    0.05    2501    2495  0x00000800
       2      17    0.65    2540    2495  0x00001a00
       3      16    0.64    2501    2495  0x00001a00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -      11    0.43    2523    2495  0x00000000
       0       3    0.11    2631    2495  0x00000c00
       1       7    0.27    2524    2495  0x00000800
       2      18    0.72    2527    2495  0x00001a00
       3      15    0.61    2501    2495  0x00001a00

Thanks, J=C3=B6rg
