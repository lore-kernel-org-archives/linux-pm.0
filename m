From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/10] cpufreq: Cleanup header files included in core
Date: Sat, 03 Aug 2013 23:42:30 +0200
Message-ID: <2013377.ZVFroF3AQ6@vostro.rjw.lan>
References: <cover.1375530162.git.viresh.kumar@linaro.org> <fe67f3269a07123b025468214e692af573b07364.1375530162.git.viresh.kumar@linaro.org> <CAKohponCtLRi1UJCN0z2hRVH=o326mtS2nUEvoi8Rf5H==vATw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponCtLRi1UJCN0z2hRVH=o326mtS2nUEvoi8Rf5H==vATw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, l.majewski@samsung.com
List-Id: linux-pm@vger.kernel.org

On Saturday, August 03, 2013 10:45:04 PM Viresh Kumar wrote:
> On 3 August 2013 17:19, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > This patch intends to cleanup following issues in the header files included in
> > cpufreq core layers:
> > - Include headers in ascending order, so that we don't add same multiple times
> >   by mistake.
> > - <asm/> must be included after <linux/>, so that they override whatever they
> >   need.
> > - Remove unnecessary header files
> > - Don't include files already included by cpufreq.h or cpufreq_governor.h
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Fixup due to compilation warning reported by Fengguang's kbuild system:
> [Latest stuff pushed in my cpufreq-next branch]
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 70399ea..ccaf025 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -19,6 +19,7 @@
> 
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/kernel_stat.h>

Can you please repost the complete patch with this folded in?

Rafael

