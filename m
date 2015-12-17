From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 0/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
Date: Thu, 17 Dec 2015 07:22:31 +0530
Message-ID: <20151217015231.GC3496@ubuntu>
References: <1450272556-29770-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450272556-29770-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

On 16-12-15, 21:29, Dawei Chien wrote:
> Use Intelligent Power Allocation (IPA) technical to add dynamic power model
> for binding CPU thermal zone. The power allocator governor allocates power
> budget to control CPU temperature.
> 
> Power Allocator governor is able to keep SOC temperature within a defined
> temperature range to avoid SOC overheat and keep it's performance.
> mt8173-cpufreq.c need to register its' own power model with power allocator
> thermal governor, so that power allocator governor can allocates suitable
> power budget to control CPU temperature.
> 
> Binding document is refer to this patchset
> https://lkml.org/lkml/2015/11/30/239
> 
> Change since V5:
> 1. Remove thermal sensor ID from phandles

Though you should have included this in the new version, but still

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
