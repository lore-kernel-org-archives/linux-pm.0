From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] cpufreq: dbx500: Manage cooling device from cpufreq driver
Date: Wed, 15 Mar 2017 14:37:44 +0100
Message-ID: <CACRpkdbj6UH+ZJfCYD1DKQ=3Qa=Aho9M5EWyQG8mRg=GCDEmXA@mail.gmail.com>
References: <99cc71f22d0470cb164b0fa05e07a863265bf922.1489468688.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <99cc71f22d0470cb164b0fa05e07a863265bf922.1489468688.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 14, 2017 at 6:18 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> The best place to register the CPU cooling device is from the cpufreq
> driver as we would know if all the resources are already available or
> not. That's what is done for the cpufreq-dt.c driver as well.
>
> The cpu-cooling driver for dbx500 platform was just (un)registering
> with the thermal framework and that can be handled easily by the cpufreq
> driver as well and in proper sequence as well.
>
> Get rid of the cooling driver and its its users and manage everything
> from the cpufreq driver instead.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Only compile tested.

Works fine. Nice cleanup, thanks!
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
