From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v4 7/7] mfd: axp20x: Add supported cells for AXP803
Date: Tue, 16 Oct 2018 12:17:37 +0800
Message-ID: <CAGb2v66aJUYOkZL=b5TfnvLsbLk_mU8AQtR3BSBRM-49rh2yOA@mail.gmail.com>
References: <20181013080848.29894-1-oskari@lemmela.net> <20181013080848.29894-8-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181013080848.29894-8-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: oskari@lemmela.net
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 is compatible with AXP813.
> Adding cells for GPIO, ADC, AC and battery power supplies.

They are not _completely_ compatible. A better way to phrase this would be:

Parts of the AXP803 are compatible with their counterparts on the AXP813.
These include the GPIO, ADC, AC and battery power supplies.

> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
