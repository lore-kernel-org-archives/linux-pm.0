From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 07/10] ARM: dts: gemini: Remove "cooling-{min|max}-level"
 for gpio-fan node
Date: Tue, 20 Mar 2018 04:10:19 +0100
Message-ID: <CACRpkdaQtPOJCcXoVB0UufLDNhkkh4__XTT2sapAKWDu9jw73g@mail.gmail.com>
References: <cover.1518166039.git.viresh.kumar@linaro.org> <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 9, 2018 at 9:58 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> gpio-fan cooling device is found by referring to the
> "gpio-fan,speed-map" instead.
>
> Remove the unused properties from the gpio-fan node.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I can queue it next week (different machine hosting the git tree)
but it is also OK if the ARM SoC maintainers want to pick it
directly for the ARM SoC DTS branch.

Yours,
Linus Walleij
