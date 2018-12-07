From: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v2 6/7] ARM: dts: qcom: msm8974: add gpio-ranges
Date: Fri, 7 Dec 2018 06:41:17 -0500
Message-ID: <20181207114117.GA30737@basecamp>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-7-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101001149.13453-7-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca, sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 31, 2018 at 08:11:48PM -0400, Brian Masney wrote:
> This adds the gpio-ranges property to pm8941_gpios so that the GPIO
> pins are initialized by the GPIO framework and not pinctrl. This fixes
> a circular dependency so GPIO hogging can be used on this board.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Hi Andy,

All of the dependencies for USB have been merged into their respective
trees. Patches 6 and 7 in this series are the only two that are
outstanding for your consideration.

I know that I'm still waiting for a review from Dmitry regarding the new
vibrator driver [1] and we're nearing the end of the development cycle.
In case he runs into an issue with that driver, I verified that I can use
git am to apply patches 6 and 7 in this series for USB, and the patch
for WiFi [2] without the bindings for the vibrator. I'm hoping to get as
much of this merged into this kernel development cycle as possible.

[1] https://lore.kernel.org/lkml/20181025012937.2154-1-masneyb@onstation.org/
[2] https://lore.kernel.org/lkml/20181104215034.3677-1-masneyb@onstation.org/

Thanks,

Brian
