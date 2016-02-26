From: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH v3 5/5] cpufreq: qoriq: Don't look at clock
 implementation details
Date: Fri, 26 Feb 2016 15:46:06 -0600
Message-ID: <1456523166.5360.49.camel@buserror.net>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
	 <3374654.Hks5DeSGVV@vostro.rjw.lan>
	 <1443215827.32298.130.camel@freescale.com>
	 <2148611.GEpYdTfpoR@vostro.rjw.lan>
	 <CADRPPNRiU-9b5J_9+0ofk6huLCn4LPm1s_2yd=Py0eBBi9GGXg@mail.gmail.com>
	 <1456510574.5360.48.camel@buserror.net>
	 <CADRPPNQtsMo0D7KbQtYTktLWJPiTg2bqKvuhNtcC02TSrw1GUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CADRPPNQtsMo0D7KbQtYTktLWJPiTg2bqKvuhNtcC02TSrw1GUg@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2016-02-26 at 15:01 -0600, Li Yang wrote:
> On Fri, Feb 26, 2016 at 12:16 PM, Scott Wood <oss@buserror.net> wrote:
> > On Fri, 2016-02-26 at 12:14 -0600, Li Yang wrote:
> > > On Fri, Sep 25, 2015 at 4:50 PM, Rafael J. Wysocki <rjw@rjwysocki.net>
> > > wrote:
> > > > On Friday, September 25, 2015 04:17:07 PM Scott Wood wrote:
> > > > > On Fri, 2015-09-25 at 23:42 +0200, Rafael J. Wysocki wrote:
> > > > > > On Tuesday, September 22, 2015 12:46:54 PM Viresh Kumar wrote:
> > > > > > > On 19-09-15, 23:29, Scott Wood wrote:
> > > > > > > > Get the CPU clock's potential parent clocks from the clock
> > > > > > > > interface
> > > > > > > > itself, rather than manually parsing the clocks property to
> > > > > > > > find a
> > > > > > > > phandle, looking at the clock-names property of that, and
> > > > > > > > assuming
> > > > > > > > that
> > > > > > > > those are valid parent clocks for the cpu clock.
> > > > > > > > 
> > > > > > > > This is necessary now that the clocks are generated based on
> > > > > > > > the
> > > > > > > > clock
> > > > > > > > driver's knowledge of the chip rather than a fragile device
> > > > > > > > -tree
> > > > > > > > description of the mux options.
> > > > > > > > 
> > > > > > > > We can now rely on the clock driver to ensure that the mux
> > > > > > > > only
> > > > > > > > exposes
> > > > > > > > options that are valid.  The cpufreq driver was currently
> > > > > > > > being
> > > > > > > > overly
> > > > > > > > conservative in some cases -- for example, the "min_cpufreq =
> > > > > > > > get_bus_freq()" restriction only applies to chips with erratum
> > > > > > > > A-004510, and whether the freq_mask used on p5020 is needed
> > > > > > > > depends on
> > > > > > > > the actual frequencies of the PLLs (FWIW, p5040 has a similar
> > > > > > > > limitation but its .freq_mask was zero) -- and the frequency
> > > > > > > > mask
> > > > > > > > mechanism made assumptions about particular parent clock
> > > > > > > > indices
> > > > > > > > that
> > > > > > > > are no longer valid.
> > > > > > > > 
> > > > > > > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > > > > > > > ---
> > > > > > > > v3: was patch 1/5 and patch 4/5, plus blacklist e6500 and
> > > > > > > > changes
> > > > > > > > to clk api usage
> > > > > > > > 
> > > > > > > >  drivers/cpufreq/qoriq-cpufreq.c | 137 ++++++++++++-----------
> > > > > > > > ----
> > > > > > > > ------
> > > > > > > > -------
> > > > > > > >  1 file changed, 40 insertions(+), 97 deletions(-)
> > > > > > > 
> > > > > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > > 
> > > > > > I'm wondering who's supposed to be merging this set?
> > > > > 
> > > > > As I noted in the cover letter, I'm looking for acks so that I can
> > > > > apply
> > > > > these to a topic branch which can be pulled through the PPC and ARM
> > > > > trees,
> > > > > each of which will have patches that depend on it.
> > > > 
> > > > OK, so no objections from the cpufreq side and you have the ACK from
> > > > Viresh.
> > > 
> > > Hi Scott,
> > > 
> > > Did you drop this patch later?  I can not find it in 4.5-rc still.
> > 
> > I was asked to get an ack from Russell King patch 4/5, which this patch
> > requires.  Despite repeated pings, I could not get a reply from Russell
> > King.
> 
> This patch?   I think you should try to get ACK from clock maintainers
> instead of Russell.

A clock maintainer was who asked me to get an ACK from Russell.

-Scott

