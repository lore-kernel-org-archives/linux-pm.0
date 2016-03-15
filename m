From: dawei chien <dawei.chien@mediatek.com>
Subject: Re: [PATCH v6 0/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
Date: Tue, 15 Mar 2016 12:53:40 +0800
Message-ID: <1458017620.30412.3.camel@mtksdaap41>
References: <1450272556-29770-1-git-send-email-dawei.chien@mediatek.com>
	 <20151217015231.GC3496@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151217015231.GC3496@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2015-12-17 at 09:52 +0800, Viresh Kumar wrote:
> On 16-12-15, 21:29, Dawei Chien wrote:
> > Use Intelligent Power Allocation (IPA) technical to add dynamic power model
> > for binding CPU thermal zone. The power allocator governor allocates power
> > budget to control CPU temperature.
> >
> > Power Allocator governor is able to keep SOC temperature within a defined
> > temperature range to avoid SOC overheat and keep it's performance.
> > mt8173-cpufreq.c need to register its' own power model with power allocator
> > thermal governor, so that power allocator governor can allocates suitable
> > power budget to control CPU temperature.
> >
> > Binding document is refer to this patchset
> > https://lkml.org/lkml/2015/11/30/239
> >
> > Change since V5:
> > 1. Remove thermal sensor ID from phandles
> 
> Though you should have included this in the new version, but still
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> --
> viresh

Hi Viresh,
Would you please pull this patch to your tree since following patch
already pulled in, thank you.

https://lkml.org/lkml/2015/11/30/239

BR,
Dawei
