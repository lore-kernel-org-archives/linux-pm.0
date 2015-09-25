From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 5/5] cpufreq: qoriq: Don't look at clock implementation details
Date: Fri, 25 Sep 2015 23:50:02 +0200
Message-ID: <2148611.GEpYdTfpoR@vostro.rjw.lan>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com> <3374654.Hks5DeSGVV@vostro.rjw.lan> <1443215827.32298.130.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1443215827.32298.130.camel@freescale.com>
Sender: linux-clk-owner@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: linux-pm@vger.kernel.org

On Friday, September 25, 2015 04:17:07 PM Scott Wood wrote:
> On Fri, 2015-09-25 at 23:42 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, September 22, 2015 12:46:54 PM Viresh Kumar wrote:
> > > On 19-09-15, 23:29, Scott Wood wrote:
> > > > Get the CPU clock's potential parent clocks from the clock interface
> > > > itself, rather than manually parsing the clocks property to find a
> > > > phandle, looking at the clock-names property of that, and assuming that
> > > > those are valid parent clocks for the cpu clock.
> > > > 
> > > > This is necessary now that the clocks are generated based on the clock
> > > > driver's knowledge of the chip rather than a fragile device-tree
> > > > description of the mux options.
> > > > 
> > > > We can now rely on the clock driver to ensure that the mux only exposes
> > > > options that are valid.  The cpufreq driver was currently being overly
> > > > conservative in some cases -- for example, the "min_cpufreq =
> > > > get_bus_freq()" restriction only applies to chips with erratum
> > > > A-004510, and whether the freq_mask used on p5020 is needed depends on
> > > > the actual frequencies of the PLLs (FWIW, p5040 has a similar
> > > > limitation but its .freq_mask was zero) -- and the frequency mask
> > > > mechanism made assumptions about particular parent clock indices that
> > > > are no longer valid.
> > > > 
> > > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > > > ---
> > > > v3: was patch 1/5 and patch 4/5, plus blacklist e6500 and changes
> > > > to clk api usage
> > > > 
> > > >  drivers/cpufreq/qoriq-cpufreq.c | 137 ++++++++++++---------------------
> > > > -------
> > > >  1 file changed, 40 insertions(+), 97 deletions(-)
> > > 
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > I'm wondering who's supposed to be merging this set?
> 
> As I noted in the cover letter, I'm looking for acks so that I can apply 
> these to a topic branch which can be pulled through the PPC and ARM trees, 
> each of which will have patches that depend on it.

OK, so no objections from the cpufreq side and you have the ACK from Viresh.

Thanks,
Rafael

