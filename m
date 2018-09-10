From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management framework
Date: Mon, 10 Sep 2018 12:40:55 +0200
Message-ID: <2400837.WDdV4EAXz7@aspire.rjw.lan>
References: <20180820094420.26590-1-quentin.perret@arm.com> <1866195.ZKEIBQluJJ@aspire.rjw.lan> <20180910103802.l4zhewxgskchflsa@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910103802.l4zhewxgskchflsa@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 10, 2018 12:38:05 PM CEST Quentin Perret wrote:
> On Monday 10 Sep 2018 at 11:44:33 (+0200), Rafael J. Wysocki wrote:
> > A kerneldoc comment would be useful here IMO.
> 
> OK
> 
> > > +struct em_cap_state {
> > > +	unsigned long frequency; /* Kilo-hertz */
> > 
> > I wonder if the "frequency" field here could be changed into something a bit
> > more abstract like "level" or similar?
> > 
> > The reason why is because in some cases we may end up with somewhat artificial
> > values of "frequency" like when the intel_pstate driver is in use (it uses
> > abstract "p-state" values internally and only produces "frequency" numbers for
> > the cpufreq core and the way they are derived from the "p-states" is not always
> > entirely clean).
> > 
> > The "level" could just be frequency on systems where cpufreq drivers operate on
> > frequencies directly or something else on the other systems.
> 
> I see your point (and TBH we start to have same sort of problems on
> Arm) but at this stage I would rather keep this field coherent with
> what CPUFreq manages, that is, KHz. The only reason for that is because
> the thermal subsystem (IPA) will look at this table to apply a max freq
> capping on CPUFreq policies, so things need to be aligned.
> 
> I agree that even if the unit of this field wasn't specified we could
> still build a system that works just fine. However if things are too
> loosely specified, problems are allowed to happen, so they will.

Fair enough.

> Now, if the CPUFreq core is modified to manipulate abstract performance
> levels one day, I'll be happy to change the EM framework the same way :-)

I don't think this is going to happen any time soon, though.
