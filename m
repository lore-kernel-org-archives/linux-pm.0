From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Date: Fri, 8 Mar 2019 11:49:43 +0000
Message-ID: <20190308114943.GA27731@e107981-ln.cambridge.arm.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com>
 <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
 <20190306181519.GA3355@e107981-ln.cambridge.arm.com>
 <CAPDyKFrbu4rFyohv+YJkG7O03_r3+3gn1vib_FJUW0t-4REgTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrbu4rFyohv+YJkG7O03_r3+3gn1vib_FJUW0t-4REgTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 08, 2019 at 11:36:49AM +0100, Ulf Hansson wrote:

[...]

> Instead, my suggestion is according to what I propose in patch 4 and
> $subject patch, which means minor adjustments to be able to pass the
> struct cpuidle_driver * to the init functions. This, I need it for
> next steps, but already at this point it improves things as it avoids
> some of the OF parsing, and that's good, isn't it?

I will take the patches Mark ACKed and send them for v5.2 as
early as it gets in v5.1-rc* cycle.

For this one maybe you can post the changes on top and see what's
the best way forward ?

I agree that duplicating idle state parsing code across back-ends
is silly - we just want to keep PSCI and kernel data structure
decoupled.

Post the code on top and we will find a way forward, OK ?

Thanks,
Lorenzo
