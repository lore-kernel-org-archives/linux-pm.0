From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: try to resume policies which failed on last resume
Date: Mon, 06 Jan 2014 12:14:13 +0100
Message-ID: <2207601.6Y4Zru5qMP@vostro.rjw.lan>
References: <f9d7b0d5424e4443597d2ed39bec3fedd2b10d1e.1387848958.git.viresh.kumar@linaro.org> <CAKohpo=KgHqz0KYv7h0EYP3=8h7T3ZfPpFTMS6qVoEb6dXGnSQ@mail.gmail.com> <87a9f92xnn.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87a9f92xnn.fsf@nemi.mork.no>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, January 06, 2014 11:49:00 AM Bj=C3=B8rn Mork wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
>=20
> > On 6 January 2014 14:31, Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
> >> That's correct.  I have not observed this on suspend to RAM.  But =
then
> >> again I haven't rigged any way to log that, so I don't think it's
> >> conclusive..
> >>
> >> The point I tried to make is that it isn't related to any hibernat=
ion
> >> *failures*.  The warning appears even if the add_dev() is successf=
ul,
> >> and it also appears if I touch only the *boot* cpu cpufreq attribu=
tes.
> >
> > Okay.. But your log below is for add_dev() failure case.
>=20
> Any suggestion on how to capure warnings issued between freeze and th=
aw
> is appreciated :-)

You can try to add no_console_suspend to the kernel's command line.

Thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
