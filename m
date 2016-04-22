From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/8] cpufreq: shmobile: Use generic platdev driver
Date: Fri, 22 Apr 2016 08:51:42 +0530
Message-ID: <20160422032142.GN29799@vireshk-i7>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <ab29df38f70453e67089e3f3dbb9085336eef1c2.1461228081.git.viresh.kumar@linaro.org>
 <CAMuHMdUnzgr==S86Wiz0fGk2gSWW2=j+maiq3=3x9Ozy7AoOZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUnzgr==S86Wiz0fGk2gSWW2=j+maiq3=3x9Ozy7AoOZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-renesas-soc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21-04-16, 15:04, Geert Uytterhoeven wrote:
> Hi Viresh,
> 
> On Thu, Apr 21, 2016 at 10:43 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -29,6 +29,18 @@ static const struct of_device_id machines[] = {
> >         { .compatible = "samsung,exynos5800", },
> >  #endif
> >
> 
> I think an #ifdef CONFIG_ARCH_RENESAS block wouldn't hurt, likewise
> for the other SoCs.
> Soon you'll have this file filled with lots of compatible values for random\
> SoCs...

This is going to be done once per boot and this shouldn't hurt. And for new
platforms we may do things differently as they are going to use opp-v2 bindings.

And, so I am not really in favor of ifdef hackery :)

-- 
viresh
