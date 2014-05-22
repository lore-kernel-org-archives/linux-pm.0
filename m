From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: EXYNOS: Use wfi macro in platform_do_lowpower
Date: Thu, 22 May 2014 13:55:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1405221353030.17310@knanqh.ubzr>
References: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org> <537DE530.3050205@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <537DE530.3050205@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Leela Krishna Amudala <leela.krishna@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, 22 May 2014, Daniel Lezcano wrote:

> On 05/22/2014 09:57 AM, Leela Krishna Amudala wrote:
> > This patch is originally based on commit b3377d186572 ("ARM: 7064/1:
> > vexpress: Use wfi macro in platform_do_lowpower.")
> >
> > Current Exynos CPU hotplug code includes a hardcoded WFI
> > instruction, in ARM encoding.  When the kernel is compiled in Thumb-2
> > mode, this is invalid and causes the machine to hang hard when a CPU
> > is offlined.
> >
> > Use wfi macro instead of the hardcoded WFI instruction.
> 
> Is it possible to change it for cpu_do_idle() ?

Please let's not encourage every wfi() to be turned into cpu_do_idle().  
They are not always equivalent.  And semantically they are not.


Nicolas
