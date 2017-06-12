From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: cpuidle: Support asymmetric idle definition
Date: Mon, 12 Jun 2017 21:17:45 +0200
Message-ID: <20170612191745.GF2261@mai>
References: <20170612155441.GE2261@mai>
 <1497282910-19085-1-git-send-email-daniel.lezcano@linaro.org>
 <1497282910-19085-2-git-send-email-daniel.lezcano@linaro.org>
 <2056969.dMlCPX6XND@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2056969.dMlCPX6XND@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Leo Yan <leo.yan@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 12, 2017 at 08:49:39PM +0200, Rafael J. Wysocki wrote:
> On Monday, June 12, 2017 05:55:10 PM Daniel Lezcano wrote:
> > Some hardware have clusters with different idle states. The current code does
> > not support this and fails as it expects all the idle states to be identical.
> > 
> > Because of this, the Mediatek mtk8173 had to create the same idle state for a
> > big.Little system and now the Hisilicon 960 is facing the same situation.
> > 
> > Solve this by simply assuming the multiple driver will be needed for all the
> > platforms using the ARM generic cpuidle driver which makes sense because of the
> > different topologies we can support with a single kernel for ARM32 or ARM64.
> > 
> > Every CPU has its own driver, so every single CPU can specify in the DT the
> > idle states.
> > 
> > This simple approach allows to support the future dynamIQ system, current SMP
> > and HMP.
> > 
> > Tested on:
> >  - 96boards: Hikey 620
> >  - 96boards: Hikey 960
> >  - 96boards: dragonboard410c
> >  - Mediatek 8173
> > 
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Tested-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> There seems to have been quite some discussion regarding this one and I'm not
> sure about the resolution of it.
> 
> I'd feel more comfortable with an ACK or Reviewed-by from Sudeep or Lorenzo here.

I understand.

Sudeep it is ok with the patch [1] without an explicit acked-by.

  -- Daniel

[1] https://www.spinics.net/lists/kernel/msg2525980.html
