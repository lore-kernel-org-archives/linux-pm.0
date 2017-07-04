From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: Clocks used by another OS/CPU (was: Re: [RFC PATCH] clk:
 renesas: cpg-mssr: Add interface for critical core clocks)
Date: Tue, 4 Jul 2017 10:31:37 +0300
Message-ID: <20170704073137.GG14819@tbergstrom-lnx.Nvidia.com>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
 <CAL_JsqKGrZeR7z80beY_XEjqd5fEQQwPxusJ1FADoALgNE3fEg@mail.gmail.com>
 <20170630202453.eh6vaehkap3as4np@pengutronix.de>
 <8d86a9aa-1928-6b52-1487-d5fb9dae17f4@gmail.com>
 <20170701181408.yuocymwtj5dgt74d@pengutronix.de>
 <8d255a76-babe-312d-15b3-3474969f2410@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8d255a76-babe-312d-15b3-3474969f2410@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Dirk Behme <dirk.behme@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kevin Hilman <khilman@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 03, 2017 at 10:17:22AM +0100, Sudeep Holla wrote:
> 
> 
> On 01/07/17 19:14, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Sat, Jul 01, 2017 at 07:02:48AM +0200, Dirk Behme wrote:
> 
> [...]
> 
> >>
> >>
> >> The other problem is security related. If, at all, you have to do it the
> >> other way around, then:
> >>
> >> Make Linux a consumer of the other CPU's (trusted/trustzone/whatever
> >> secured) OS clock driver.
> 
> Yes, that's better and is getting common on newer platforms. They have
> separate M-class(or even low A-class e.g. A5/A7) processors to handle
> all the system management.
> 
> The new ARM SCMI specification[0][1] is designed to standardize the
> interface. It covers the clocks in clock protocol.
> 

Yes, however this doesn't exist on older SoCs which still have multiple CPU's

Peter.
