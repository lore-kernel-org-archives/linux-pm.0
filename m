From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Thu, 31 Mar 2016 08:06:06 -0700
Message-ID: <1459436766.4569.54.camel@linux.intel.com>
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
	 <CADDKRnCfaG35EXp_thOqfG=6sjov7f1q521LSGL8oFqRfCqSaw@mail.gmail.com>
	 <002701d18b5b$22ea72d0$68bf5870$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <002701d18b5b$22ea72d0$68bf5870$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, =?ISO-8859-1?Q?=27J=F6rg?= Otte' <jrg.otte@gmail.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 2016-03-31 at 07:39 -0700, Doug Smythies wrote:
> On 2016.03.31 02:24 J=C3=B6rg Otte wrote:

Hi J=C3=B6rg,

Can you send me your kernel config file?

Thanks,
Srinivas
>=20
> > jojo@fichte:/sys/devices/system/cpu/cpufreq/policy0$ cat
> > scaling_governor
> > powersave
> >=20
> > turbostat -i 1 --msr=3D0x199
> > CPUID(7): No-SGX
> > =C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0Busy% Bzy_MHz =
TSC_MHz=C2=A0=C2=A0=C2=A0MSR 0x199
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A045=C2=A0=C2=A0=C2=A0=C2=A01.74=C2=A0=C2=A0=C2=A0=C2=A02590=C2=A0=C2=
=A0=C2=A0=C2=A02496=C2=A0=C2=A00x00000000
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A045=C2=A0=C2=A0=C2=A0=C2=A01.76=C2=A0=C2=A0=C2=A0=C2=A02565=C2=A0=C2=
=A0=C2=A0=C2=A02498=C2=A0=C2=A00x00000a00
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A072=C2=A0=C2=A0=C2=A0=C2=A02.84=C2=A0=C2=A0=C2=A0=C2=A02548=C2=A0=C2=
=A0=C2=A0=C2=A02496=C2=A0=C2=A00x00000800
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A030=C2=A0=C2=A0=C2=A0=C2=A01.11=C2=A0=C2=A0=C2=A0=C2=A02661=C2=A0=C2=
=A0=C2=A0=C2=A02496=C2=A0=C2=A00x00001a00
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A033=C2=A0=C2=A0=C2=A0=C2=A01.23=C2=A0=C2=A0=C2=A0=C2=A02661=C2=A0=C2=
=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00001a00
> > =C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0Busy% Bzy_MHz =
TSC_MHz=C2=A0=C2=A0=C2=A0MSR 0x199
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A09=C2=A0=C2=A0=C2=A0=C2=A00.35=C2=A0=C2=A0=C2=A0=C2=A02525=C2=
=A0=C2=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00000000
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A00.04=C2=A0=C2=A0=C2=A0=C2=A02735=C2=
=A0=C2=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00000800
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A00.05=C2=A0=C2=A0=C2=A0=C2=A02501=C2=
=A0=C2=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00000800
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A017=C2=A0=C2=A0=C2=A0=C2=A00.65=C2=A0=C2=A0=C2=A0=C2=A02540=C2=A0=C2=
=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00001a00
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A016=C2=A0=C2=A0=C2=A0=C2=A00.64=C2=A0=C2=A0=C2=A0=C2=A02501=C2=A0=C2=
=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00001a00
> > =C2=A0=C2=A0=C2=A0=C2=A0CPU Avg_MHz=C2=A0=C2=A0=C2=A0Busy% Bzy_MHz =
TSC_MHz=C2=A0=C2=A0=C2=A0MSR 0x199
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A011=C2=A0=C2=A0=C2=A0=C2=A00.43=C2=A0=C2=A0=C2=A0=C2=A02523=C2=A0=C2=
=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00000000
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A00.11=C2=A0=C2=A0=C2=A0=C2=A02631=C2=
=A0=C2=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00000c00
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A07=C2=A0=C2=A0=C2=A0=C2=A00.27=C2=A0=C2=A0=C2=A0=C2=A02524=C2=
=A0=C2=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00000800
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A018=C2=A0=C2=A0=C2=A0=C2=A00.72=C2=A0=C2=A0=C2=A0=C2=A02527=C2=A0=C2=
=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00001a00
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A015=C2=A0=C2=A0=C2=A0=C2=A00.61=C2=A0=C2=A0=C2=A0=C2=A02501=C2=A0=C2=
=A0=C2=A0=C2=A02495=C2=A0=C2=A00x00001a00
>=20
> Very Interesting.
>=20
> I would still like to get a trace sample to post process.
> Copied from a previous e-mail:
>=20
> On an otherwise idle system, do:
>=20
> # perf record -a --event=3Dpower:pstate_sample sleep 300
>=20
> If pressed for time, your sleep time can be less than 5 minutes,
> but try to get at least 100 seconds.
>=20
> The resulting perf.data file will be too big to include as an
> on-list attachment, but send it (or them) to me off-list for
> post processing, and I'll report back.
>=20
> ... Doug
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
