From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Mon, 20 Apr 2015 20:31:50 +0200
Message-ID: <1429554710.14597.41.camel@x220>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
	 <1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
	 <20150420141719.GF27115@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150420141719.GF27115@jcartwri.amer.corp.natinst.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Cc: "pi-cheng.chen" <pi-cheng.chen@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, fan.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, linux-mediatek@lists.infradead.org, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-04-20 at 09:17 -0500, Josh Cartwright wrote:
> On Mon, Apr 20, 2015 at 05:27:26PM +0800, pi-cheng.chen wrote:
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
>   
> > +config ARM_MT8173_CPUFREQ
> > +	bool "Mediatek MT8173 CPUFreq support"
> > +	depends on ARCH_MEDIATEK && REGULATOR
> 
> I think you want to 'select REGULATOR' here; because REGULATOR isn't
> a user-visible option.

REGULATOR is user visible, at least in next-20150420.

> > +	help
> > +	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.

Thanks,


Paul Bolle
