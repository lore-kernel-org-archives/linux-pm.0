From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Thu, 5 Dec 2013 18:23:42 +0000
Message-ID: <20131205182342.GR29200@e106331-lin.cambridge.arm.com>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-2-git-send-email-andrew@lunn.ch>
 <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
 <20131204152726.GC8062@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20131204152726.GC8062@lunn.ch>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 04, 2013 at 03:27:26PM +0000, Andrew Lunn wrote:

[...]
  
> > > +
> > > +	cpu_dev = get_cpu_device(0);
> > > +
> > > +	priv.cpu_clk = devm_clk_get(cpu_dev, "cpu_clk");
> > > +	if (IS_ERR(priv.cpu_clk)) {
> > > +		err = PTR_ERR(priv.cpu_clk);
> > > +		goto out;
> > > +	}
> > 
> > I think it would be better to describe the clocks as being fed to the
> > PMU than directly to the CPU -- the PMU selects the appropriate clock
> > and feeds it to the CPU.
> 
> The wording in the data sheet is not very clear:
> 
>     The PMU initiates new clock ratio values for the CPU subsystem
>     clocks generation unit.
> 
> So to me, the PMU is not the clock consumer, it just controls the
> clock generation unit. There is also a block diagram which shows the
> "CPU Subsystem ClockGen" as being external to the PMU.

Hmm. That's somewhat arguable.

>From a block diagram I've found, the situation seems more like the
ClockGen takes two clocks as input, and feeds the appropriate clock to
the CPU. Logically, the CPU itself is a consumer of one clock.

The ClockGen unit is controlled by a clock manager. The clock manager
appears to be a component of the PMU itself, but I may have
misunderstood. If that is the case, and the CPU Subsytem ClockGen is not
controlled by anything else, then I don't see the problem with grouping
that together logically with the clock manager (and therefore the PMU).
That would imply describing the clock inputs on the PMU is fine.

Have I missed something?

One thing I'm worried about is adding lots of SoC-specific variations on
data to generic nodes rather than doing that in a uniform fashion. I
believe describing the clocks in the way you propose clashes with the
cpufreq-cpu0 way of doing things (whereby the CPU has one clock input).

If the ClockGen were modelled as a mux that allows switching between two
rates, then that would make the description more uniform.

>  
> > Also, the clocks could be named better with respect to their logical
> > function. One is the high-frequency default, and the other is a
> > low-frequency option. They're both able to feed the CPU, and the fact
> > that one also feeds the DDR isn't relevant to the CPU.
> 
> The data sheet uses the terms Turbo Speed and Slow Speed modes. So i
> could call them turbo and slow? However, the current names follow the
> kirkwood cpufreq driver. It also can swap between a fast clock and the
> DDR clock. So i thought keeping the drivers similar would help with
> the maintenance burden. 

I think given the above, the changes I'm asking for would already
involve sufficient changes to make this concern irrelevant. However, I
don't want to force an unmaintainable change.

Mark.
