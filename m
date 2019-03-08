From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Date: Fri, 8 Mar 2019 14:43:01 +0100
Message-ID: <CAPDyKFrvcTb0FDf5tcvdenDNSS_o6RX+Uxb9c5XprHQUnW8waQ@mail.gmail.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com> <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
 <20190306181519.GA3355@e107981-ln.cambridge.arm.com> <CAPDyKFrbu4rFyohv+YJkG7O03_r3+3gn1vib_FJUW0t-4REgTw@mail.gmail.com>
 <20190308114943.GA27731@e107981-ln.cambridge.arm.com> <CAPDyKFry_ZQXA-bj6gA8npdqkMmg8AUOZ+Kr4mnOaS8=xZ+MwA@mail.gmail.com>
 <20190308131723.GA30600@e107981-ln.cambridge.arm.com> <CAPDyKFpf_SHO46x-7tYU3ouWbjQ9+r_wr6qx9q3ofZoDAtEqfA@mail.gmail.com>
 <20190308133132.GB30600@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308133132.GB30600@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 8 Mar 2019 at 14:31, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Mar 08, 2019 at 02:23:26PM +0100, Ulf Hansson wrote:
> > On Fri, 8 Mar 2019 at 14:17, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Fri, Mar 08, 2019 at 02:07:51PM +0100, Ulf Hansson wrote:
> > > > On Fri, 8 Mar 2019 at 12:49, Lorenzo Pieralisi
> > > > <lorenzo.pieralisi@arm.com> wrote:
> > > > >
> > > > > On Fri, Mar 08, 2019 at 11:36:49AM +0100, Ulf Hansson wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > Instead, my suggestion is according to what I propose in patch 4 and
> > > > > > $subject patch, which means minor adjustments to be able to pass the
> > > > > > struct cpuidle_driver * to the init functions. This, I need it for
> > > > > > next steps, but already at this point it improves things as it avoids
> > > > > > some of the OF parsing, and that's good, isn't it?
> > > > >
> > > > > I will take the patches Mark ACKed and send them for v5.2 as
> > > > > early as it gets in v5.1-rc* cycle.
> > > >
> > > > Actually, may I suggest we funnel these through Rafael's tree, unless
> > > > you are expecting other PSCI changes for v.5.2, which could cause
> > > > conflicts?
> > > >
> > > > The reason is, other PM core changes, to genpd for example, needs to
> > > > go via Rafael's tree. Those would then potentially block us for
> > > > applying any other changes to your tree (arm-soc?) for PSCI (as there
> > > > is dependency) until v5.3.
> > > >
> > > > How about if you provides your explicit acks for those PSCI changes
> > > > your are happy with, then Rafael can pick them?
> > >
> > > It is fine we can do that, I would have not sent the patches Mark
> > > has ACKed to arm-soc till -{rc2/rc3} anyway.
> >
> > Great!
> >
> > May I suggest you just reply to the cover-letter and provide the acks
> > to the relevant patches, then I can then collect the received acks
> > tags and re-post them to Rafael once rc1 is out.
>
> Mark ACKed the patches that we consider ready for upstream, tag them
> and send them out at -rc1 there is nothing left to do on those.

Right, I add your acks to them as well then.

Thanks!

Kind regards
Uffe
