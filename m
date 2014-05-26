From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Mon, 26 May 2014 13:22:32 +0200
Message-ID: <9956925.Qsz2bH3rDg@vostro.rjw.lan>
References: <20140521073457.GD31687@pengutronix.de> <00f65d1c-a375-40e7-b30a-cd8cb3ca87fc@BN1BFFO11FD020.protection.gbl> <CAKohpomb+h6ZNDgJ8AwJ_J9DjMB7AP_v-cp8coG3CACo5Wt4vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64855 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751716AbaEZLF3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 07:05:29 -0400
In-Reply-To: <CAKohpomb+h6ZNDgJ8AwJ_J9DjMB7AP_v-cp8coG3CACo5Wt4vQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Mike Turquette <mturquette@linaro.org>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Monday, May 26, 2014 11:59:09 AM Viresh Kumar wrote:
> On 23 May 2014 21:44, S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.co=
m> wrote:
> > Viresh: Could you imagine something similar for cpufreq? You sugges=
ted
> > migrating to Hz resolution. I guess that would ideally mean to foll=
ow
> > the CCF to a 64-bit type for frequencies and increasing the resolut=
ion.
> > I have a messy patch migrating cpufreq and OPP to Hz and unsigned l=
ong
> > that works on Zynq. But cpufreq has so many users that it would bec=
ome
> > quite an undertaking.
> > And we'd need some new/amended OPP DT binding.
>=20
> If we are going to migrate to Hz from KHz, I think we must consider t=
he
> 64 bit stuff right now, otherwise it will bite us later.
>=20
> @Rafael: What do you think?

I agree as far as the 64-bit thing goes, but is switching to Hz really
necessary?

Rafael

