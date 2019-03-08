From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Date: Fri, 8 Mar 2019 14:07:51 +0100
Message-ID: <CAPDyKFry_ZQXA-bj6gA8npdqkMmg8AUOZ+Kr4mnOaS8=xZ+MwA@mail.gmail.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com> <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
 <20190306181519.GA3355@e107981-ln.cambridge.arm.com> <CAPDyKFrbu4rFyohv+YJkG7O03_r3+3gn1vib_FJUW0t-4REgTw@mail.gmail.com>
 <20190308114943.GA27731@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308114943.GA27731@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 8 Mar 2019 at 12:49, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Mar 08, 2019 at 11:36:49AM +0100, Ulf Hansson wrote:
>
> [...]
>
> > Instead, my suggestion is according to what I propose in patch 4 and
> > $subject patch, which means minor adjustments to be able to pass the
> > struct cpuidle_driver * to the init functions. This, I need it for
> > next steps, but already at this point it improves things as it avoids
> > some of the OF parsing, and that's good, isn't it?
>
> I will take the patches Mark ACKed and send them for v5.2 as
> early as it gets in v5.1-rc* cycle.

Actually, may I suggest we funnel these through Rafael's tree, unless
you are expecting other PSCI changes for v.5.2, which could cause
conflicts?

The reason is, other PM core changes, to genpd for example, needs to
go via Rafael's tree. Those would then potentially block us for
applying any other changes to your tree (arm-soc?) for PSCI (as there
is dependency) until v5.3.

How about if you provides your explicit acks for those PSCI changes
your are happy with, then Rafael can pick them?

>
> For this one maybe you can post the changes on top and see what's
> the best way forward ?
>
> I agree that duplicating idle state parsing code across back-ends
> is silly - we just want to keep PSCI and kernel data structure
> decoupled.

Right. Let's continue this discussion later on and move forward here.
Make sense.

>
> Post the code on top and we will find a way forward, OK ?

Sure, let me do that.

Thanks and kind regards
Uffe
