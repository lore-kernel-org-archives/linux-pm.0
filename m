From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv2 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
Date: Fri, 28 Nov 2014 19:13:02 +0530
Message-ID: <CAKohpokh9oGTOrGB3L=qD2o+nSLJCyBLrpGu4DHiFPU-ByRLpg@mail.gmail.com>
References: <1417097577-3548-1-git-send-email-edubezval@gmail.com>
	<CAKohponu_PRrqsuMdCJDznhiO_-=iCaYPhCCad8F4WS3rNxo5A@mail.gmail.com>
	<20141128111824.533c4641@jawa>
	<20141128131425.GA23622@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141128131425.GA23622@developer>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@majess.pl>, Linux PM <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, LKML <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28 November 2014 at 18:44, Eduardo Valentin <edubezval@gmail.com> wrote:
> Well, I wouldn't say unfortunately, but fortunately! :-)

+1 :)

> However, I would prefer, at least to what comes to deferring, to update
> the drivers altogether with the inclusion of the check in cpu cooling.
> This way the change in behavior is atomic, in terms of commit changes.
>
> Viresh, if you don't mind, I will merge your patch 04/26 into this one.

Sure, go ahead.
