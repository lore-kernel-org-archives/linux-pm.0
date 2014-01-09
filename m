From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH V3 Resend] cpufreq: create cpufreq_generic_get() routine
Date: Thu, 9 Jan 2014 00:38:35 -0800
Message-ID: <CAOesGMgfFVoVJpOMXWtzVWj_F4pD-L9Osyv4u6=c8RUWOoLHFw@mail.gmail.com>
References: <d9239e0a5df99392647ff8343673342f89d09476.1389059568.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <d9239e0a5df99392647ff8343673342f89d09476.1389059568.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Mon, Jan 6, 2014 at 5:54 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> CPUFreq drivers that use clock frameworks interface,i.e. clk_get_rate(), to get
> CPUs clk rate, has similar sort of code used for most of them.
>
> This patch adds a generic ->get() which will do the same thing for them. All
> those drivers are required to now is to set .get to cpufreq_generic_get() and
> set their clk pointer in policy->clk during ->init().
>
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Rafael,
>
> V2->V3: As asked by you earlier, I have merged all 23 patches here as they had
> common log and were touching separate drivers. This is already acked by many
> people.  Please see if looks okay for 3.14.

This patch breaks a bunch of ARM boards. In particular, the following
defconfigs no longer build:

          assabet_defconfig
          badge4_defconfig
          cerfcube_defconfig
          collie_defconfig
          h3600_defconfig
          hackkit_defconfig
          jornada720_defconfig
          lart_defconfig
          neponset_defconfig
          pleb_defconfig
          shannon_defconfig
          simpad_defconfig

Error is:

drivers/built-in.o: In function `cpufreq_generic_get':
drivers/cpufreq/cpufreq.c:189: undefined reference to `clk_get_rate'

Seems like this needs to be guarded by HAVE_CLK?


-Olof
