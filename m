From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Mon, 26 May 2014 14:52:47 -0700
Message-ID: <2827f20b-b489-4eb0-8ec9-9db957e28788@BL2FFO11FD008.protection.gbl>
References: <20140521073457.GD31687@pengutronix.de>
 <9956925.Qsz2bH3rDg@vostro.rjw.lan>
 <CAKohpomam0qKdkMMMRDOfWN9QnZ3DzCviV=RuZ5f_7JbmYNDNw@mail.gmail.com>
 <9956935.0oj56vcaUh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9956935.0oj56vcaUh@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2014-05-26 at 01:47PM +0200, Rafael J. Wysocki wrote:
> On Monday, May 26, 2014 04:37:13 PM Viresh Kumar wrote:
> > On 26 May 2014 16:52, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > I agree as far as the 64-bit thing goes, but is switching to Hz r=
eally
> > > necessary?
> >=20
> > Don't really know that.. It seems that there will always be problem=
s with
> > close enough frequencies whenever rounding is done.
>=20
> Well, rounding errors are a problem, but question is if that is enoug=
h of
> a problem to justify expanding the storage size twice.  Also, that'd =
be
> a performance hit on 32-bit systems.
>=20
> > More can be elaborated by Soren.
>=20
> OK

I'd say it's probably not worth switching. As you and I said, rounding
issues are likely to happen no matter what. In this particular case,
switching would not remove the need for the patch I proposed to allow
for rounding errors. The error margin could be reduced, but that's it.
I think it would be nice if CCF, OPP and cpufreq would use the same
resolution and types, since it would remove the need for all these
conversions that are going on in cpufreq drivers, but looking at the
wide usage of cpufreq and the potential drawbacks Rafael pointed at:
nice-to-have is probably not enough of a justification.

	S=C3=B6ren

