From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 1/4] power: supply: core: Introduce one property to
 present the battery internal resistance
Date: Fri, 28 Sep 2018 09:29:14 +0200
Message-ID: <CACRpkdYLgT3eRRx6VFa3hMEd11JF1CeANgo9hrgkTD-wn2F1zQ@mail.gmail.com>
References: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 27, 2018 at 9:27 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> The internal resistance of a battery is not a constant in its life cycle,
> this varies over the age of the battery or temperature and so on. But we
> just want use one constant battery internal resistance to estimate the
> battery capacity. Thus this patch introduces one property to present
> the battery factory internal resistance for battery information.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v2:
>  - Rename the property.
>  - Improve the commit message.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
