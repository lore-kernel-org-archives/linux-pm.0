From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v11 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Thu, 24 May 2018 10:37:57 +0100
Message-ID: <20180524093757.GB24846@e107155-lin>
References: <1527079139-3558-1-git-send-email-ilialin@codeaurora.org>
 <1527079139-3558-2-git-send-email-ilialin@codeaurora.org>
 <1ec7645d-72b6-5a1a-48c3-831a3c484a0e@arm.com>
 <20180524043443.adivshl2un53n6hm@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180524043443.adivshl2un53n6hm@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ilia Lin <ilialin@codeaurora.org>, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 24, 2018 at 10:04:43AM +0530, Viresh Kumar wrote:
> On 23-05-18, 14:25, Sudeep Holla wrote:
> > On 23/05/18 13:38, Ilia Lin wrote:
> > > +config ARM_QCOM_CPUFREQ_KRYO
> > > +	bool "Qualcomm Kryo based CPUFreq"
> > > +	depends on QCOM_QFPROM
> > > +	depends on QCOM_SMEM
> > > +	select PM_OPP
> > > +	help
> > > +	  This adds the CPUFreq driver for Qualcomm Kryo SoC based boards.
> > > +
> > > +	  If in doubt, say N.
> > > +
> > 
> > Sorry but just noticed now, any reason why this can't be module. I can't
> > imagine any.
> 
> Actually I asked him to do that as cpufreq-dt itself can be compiled
> in as module and this driver wasn't doing much and isn't big enough
> (size wise) as well.
> 

Initially I guessed that to be the reason, but not prevents this to be a
module. But you are right, the gain is not much as this driver is quite
small on it's own.

--
Regards,
Sudeep
