From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 10/10] arch_topology: Start Energy Aware Scheduling
Date: Tue, 19 Jun 2018 11:25:03 +0100
Message-ID: <20180619102502.GU17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-11-quentin.perret@arm.com>
 <20180619091841.GD9208@codeaurora.org>
 <20180619094002.GR17720@e108498-lin.cambridge.arm.com>
 <20180619094714.GA13617@localhost.localdomain>
 <20180619100224.GT17720@e108498-lin.cambridge.arm.com>
 <20180619101901.GC13617@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619101901.GC13617@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>, peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 Jun 2018 at 12:19:01 (+0200), Juri Lelli wrote:
> On 19/06/18 11:02, Quentin Perret wrote:
> > On Tuesday 19 Jun 2018 at 11:47:14 (+0200), Juri Lelli wrote:
> > > On 19/06/18 10:40, Quentin Perret wrote:
> > > > Hi Pavan,
> > > > 
> > > > On Tuesday 19 Jun 2018 at 14:48:41 (+0530), Pavan Kondeti wrote:
> > > 
> > > [...]
> > > 
> > > > > There seems to be a sysfs interface exposed by this driver to change cpu_scale.
> > > > > Should we worry about it? I don't know what is the usecase for changing the
> > > > > cpu_scale from user space.
> > > > 
> > > > This is something I've been wondering as well. TBH, I'm not sure what to
> > > > do in this case. And I'm not sure to know what is the use-case either.
> > > > Debugging purpose I assume ?
> > > > 
> > > > Juri, did you have a specific use-case for this feature when the
> > > > arch_topology driver was first introduced ? Or was it just to align
> > > > with the existing arm/arm64 code ?
> > > 
> > > It was requested (IIRC) because DT might have bogus values and not be
> > > easily modifiable. So, this is another way to get things right for your
> > > platform at runtime.
> > 
> > Right, but that also allows you to set different capacities to CPUs
> > inside the same freq domain, which isn't supported by the EM framework,
> > at least for now. So I would prefer to assume that your values in DT must
> > to be correct to use EAS, and leave the code as-is for now.
> 
> It's actually built on the (current) assumption that siblings share
> capacity [1], so it seems to align with what EM requires.
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/base/arch_topology.c#L71

But there is not hard guarantee that the core_sibling mask and the
frequency domains are aligned :-(

Hikey 620 is an example where they might be misaligned (I think)
