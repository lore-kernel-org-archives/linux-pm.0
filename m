From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management
 framework
Date: Tue, 11 Sep 2018 15:31:51 +0200
Message-ID: <20180911133151.GA29426@andrea>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-4-quentin.perret@arm.com>
 <20180829100435.GP2960@e110439-lin>
 <20180829132811.iacfltcos6kfgp7e@queper01-lin>
 <20180911093456.GA27352@andrea>
 <20180911123248.mjcaxrycfdelypo2@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911123248.mjcaxrycfdelypo2@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 11, 2018 at 01:32:50PM +0100, Quentin Perret wrote:
> Hi Andrea,
> 
> On Tuesday 11 Sep 2018 at 11:34:56 (+0200), Andrea Parri wrote:
> > FYI, the directory "tools/memory-model/" provides an "automated
> > memory-barriers.txt": in short, you encode your "memory ordering
> > questions" into "litmus tests" to be passed to the tool/simulator;
> > the tool will then answer with "Yes/No" (plus other information).
> > 
> > Some preparation is required to set up and learn how to use the
> > LKMM tools, but once there, I expect them to be more "efficient"
> > than reading memory-barriers.txt... ;-)
> 
> Thanks for pointing this out, I'll have a look.
> 
> > Please don't hesitate
> > to contact me/the LKMM maintainers if you need help with this.
> 
> And thanks for that too.
> 
> > You'd need some info in order to write down a _well-formed litmus
> > test, e.g., matching barrier/synchronization and interested memory
> > accesses on the reader side (IAC, the replacement "store-release
> > -> store-once+smp_wmb" discussed above is suspicious...).
> 
> Regarding the disccusion above, I was actually planning on removing the
> smp_wmb entirely and rely on WRITE_ONCE + mutex_{un}lock here. Do you
> see something obviously wrong with that ?

As said in IRC: nothing I can currently see.


> 
> I guess the LKMM tools should give me the yes/no answer I want, but if
> that's a no, I'd also like to understand why ... :-)

That answer would be a little bit more involved ... ;-)  The file
Documentation/explanation.txt within the above mentioned directory
could be a good starting point; skimming through litmus-tests/ and
Documentation/recipes.txt could also provide some hints.

  Andrea


> 
> Thanks,
> Quentin
