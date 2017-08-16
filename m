From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: dt-platdev: Automatically create cpufreq
 device with OPP v2
Date: Wed, 16 Aug 2017 16:53:22 +0530
Message-ID: <20170816112322.GC24299@vireshk-i7>
References: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
 <CAGb2v65arhOb3-zLuHj3MM38vT8OJHXoi=k3RG+F4Lou0N3VTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v65arhOb3-zLuHj3MM38vT8OJHXoi=k3RG+F4Lou0N3VTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Wei Xu <xuwei5@hisilicon.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, jun.nie@linaro.org, Baoyou Xie <baoyou.xie@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16-08-17, 16:49, Chen-Yu Tsai wrote:
> On Wed, Aug 16, 2017 at 1:37 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > The initial idea of creating the cpufreq-dt-platdev.c file was to keep a
> > list of platforms that use the "operating-points" (V1) bindings and
> > create cpufreq device for them only, as we weren't sure which platforms
> > would want the device to get created automatically as some had their own
> > cpufreq drivers as well, or wanted to initialize cpufreq after doing
> > some stuff from platform code.
> >
> > But that wasn't the case with platforms using "operating-points-v2"
> > property. We wanted the device to get created automatically without the
> > need of adding them to the whitelist. Though, we will still have some
> > exceptions where we don't want to create the device automatically.
> >
> > Rename the earlier platform list as *whitelist* and create a new
> > *blacklist* as well.
> >
> > The cpufreq-dt device will get created if:
> > - The platform is there in the whitelist OR
> > - The platform has "operating-points-v2" property in CPU0's DT node and
> >   isn't part of the blacklist .
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Does this mean "cpufreq: dt: Add support for some new Allwinner SoCs",
> or any other patch adding new SoCs to the list, isn't needed anymore?

For SoCs using OPP-v2, yeah, we don't need any more patches in future.

-- 
viresh
