From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Thu, 31 Mar 2016 08:10:25 -0700
Message-ID: <003001d18b5f$748d3420$5da79c60$@net>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>	<CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>	<4187911.uaFVupaTVL@vostro.rjw.lan>	<CADDKRnCr0riAu4pjYRkuguoCoAjWxFoc+pU1NBymPr+3JnVanQ@mail.gmail.com>	<CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>	<1459352017.13525.45.camel@intel.com>	<CADDKRnA5x9dK=6KZWijiP_ihrUA9Afpmqw8TSzYn9oaBeaOfKw@mail.gmail.com>	<002401d18ab5$0bf84a30$23e8de90$@net>	<1459364336.13525.69.camel@linux.intel.com>	<CAJZ5v0gDNYRNaLKFCnPRomOhavLPD=zgp1oJdRv6OtHLb031Bw@mail.gmail.com>	<1459369587.13525.75.camel@linux.intel.com> <CADDKRnCfaG35EXp_thOqfG=6sjov7f1q521LSGL8oFqRfCqSaw@mail.gmail.com> <002701d18b5b$22ea72d0$68bf5870$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta5.telus.net ([209.171.16.78]:49542 "EHLO cmta5.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757047AbcCaPKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 11:10:41 -0400
In-Reply-To: <002701d18b5b$22ea72d0$68bf5870$@net>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

On 2016.03.31 07:40 Doug Smythies wrote:
> On 2016.03.31 02:24 J=C3=B6rg Otte wrote:

>>
>> jojo@fichte:/sys/devices/system/cpu/cpufreq/policy0$ cat scaling_gov=
ernor
>> powersave
>>=20
>> turbostat -i 1 --msr=3D0x199
>> CPUID(7): No-SGX

=2E.. [cut]...

> Very Interesting.
>
> I would still like to get a trace sample to post process.
> Copied from a previous e-mail:
>
> On an otherwise idle system, do:
>
> # perf record -a --event=3Dpower:pstate_sample sleep 300
>
> If pressed for time, your sleep time can be less than 5 minutes,
> but try to get at least 100 seconds.
>
> The resulting perf.data file will be too big to include as an
> on-list attachment, but send it (or them) to me off-list for
> post processing, and I'll report back.

Never mind. I had not seen some of the e-mails, in particular
the one where Rafael had figured out the issue.

=2E.. Doug


