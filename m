From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Wed, 6 Jun 2018 16:29:51 +0100
Message-ID: <20180606152950.GH10870@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <b47cb1f1-6ca1-7674-903f-724be43a57a0@arm.com>
 <20180606143739.GF10870@e108498-lin.cambridge.arm.com>
 <20180606152000.GB15894@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606152000.GB15894@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 06 Jun 2018 at 17:20:00 (+0200), Juri Lelli wrote:
> > > This brings me to another question. Let's say there are multiple users of
> > > the Energy Model in the system. Shouldn't the units of frequency and power
> > > not standardized, maybe Mhz and mW?
> > > The task scheduler doesn't care since it is only interested in power diffs
> > > but other user might do.
> > 
> > So the good thing about specifying units is that we can probably assume
> > ranges on the values. If the power is in mW, assuming that we're talking
> > about a single CPU, it'll probably fit in 16 bits. 65W/core should be
> > a reasonable upper-bound ?
> > But there are also vendors who might not be happy with disclosing absolute
> > values ... These are sometimes considered sensitive and only relative
> > numbers are discussed publicly. Now, you can also argue that we already
> > have units specified in IPA for ex, and that it doesn't really matter if
> > a driver "lies" about the real value, as long as the ratios are correct.
> > And I guess that anyone can do measurement on the hardware and get those
> > values anyway. So specifying a unit (mW) for the power is probably a
> > good idea.
> 
> Mmm, I remember we fought quite a bit while getting capacity-dmpis-mhz
> binding accepted, and one of the musts was that the values were going to
> be normalized. So, normalized power values again maybe?

Hmmm, that's a very good point ... There should be no problems on the
scheduler side -- we're only interested in correct ratios. But I'm not
sure on the thermal side ... I will double check that.

Javi, Viresh, Eduardo: any thoughts about this ?

Thanks !
Quentin
