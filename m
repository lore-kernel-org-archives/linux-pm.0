From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/2] thermal: mediatek: Add cpu power cooling model
Date: Wed, 28 Oct 2015 21:14:49 +0530
Message-ID: <20151028154449.GH3716@ubuntu>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On 22-10-15, 20:02, Dawei Chien wrote:
> Use Intelligent Power Allocation (IPA) technical to add static/dynamic power model for binding CPU thermal zone.
> The power allocator governor allocates power budget to control CPU temperature.
> 
> Power Allocator governor is able to keep SOC temperature within a defined temperature range to avoid SOC overheat and keep it's performance. mt8173-cpufreq.c need to register its' own power model with power allocator thermal governor, so that power allocator governor can allocates suitable power budget to control CPU temperature.
> 
> PATCH1 is base on
> https://patchwork.kernel.org/patch/7034601/
> 
> PATCH2 is base on Sascha's thermal driver V9
> https://patchwork.kernel.org/patch/7249821/
> https://patchwork.kernel.org/patch/7249861/
> https://patchwork.kernel.org/patch/7249891/
> 
> Change since V1:
> include mt8171.h and sort header file for mt8173.dtsi
> 
> Change since V2:
> Move dynamic/static power model in device tree
> 
> Dawei.Chien (2):
>   thermal: mediatek: Add cpu power cooling model.
>   arm64: dts: mt8173: Add thermal zone node for mt8173.

Sorry for being extremely late in reviewing this stuff. You are
already on v3 and I haven't reviewed it once. Mostly due to bad timing
of my holidays and other work pressure.

Now, there are few things that I feel are not properly addressed here,
and I may be wrong:
- Where are the bindings for static-power-points and
  dynamic-power-coefficient. Sorry I failed to see them in this or
  other series you mentioned.
- Even then, why should we be adding another table into DT for
  voltage/power ? And not reuse and extend the opp-v2 stuff which is
  already mainlined now.
- There are few issues with the code as well, but I want to see where
  the bindings should go first. And then only discuss the code
  further.

-- 
viresh
