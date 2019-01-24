From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [BUG] cpufreq/armada-37xx: Parent clock issues after boot
Date: Thu, 24 Jan 2019 11:39:43 +0100
Message-ID: <87bm46jq4w.fsf@FE-laptop>
References: <20190124103052.dvkg43uwieejoupo@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190124103052.dvkg43uwieejoupo@vireshk-i7> (Viresh Kumar's
 message of "Thu, 24 Jan 2019 16:00:52 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, rjw@rjwysocki.net, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,
 
 On jeu., janv. 24 2019, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Hi Gregory,
>
> Ilias has an espressobin board and he reported performance regression
> while playing with cpufreq governors.
>
> I have tried to track it down in the last couple of days with Ilias
> testing the kernel with my suggestions. We strongly believe that there
> is something wrong with parent clock selection in the clk driver.
>
> Simple way to reproduce the issue:
>
> - configure kernel with performance and powersave governors, make
>   performance governor default and boot the kernel.
>
> - Run "sysbench --test=cpu run" and note down performance numbers.
> - Do following to force a freq change by kernel:
>   echo powersave > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
>   echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
>
> - Run sysbench again and you will see 20% drop in performance.
>
> The problem happens as soon as the kernel changes the frequency for
> the very first time. Probably because that's when we change the
> clk-parent for the very first time.
>
> Few more things I noticed:
>
> - During boot when the kernel adds the CPU clk to clk-framework, we
>   read the registers from the non-DVFS set as DVFS wasn't enabled yet.
>   So both parent and clock rate are read from there.
>
> - But cpufreq starts working with the other set of registers which are
>   available only after DVFS is enabled.
>
> - We call clk_get_parent() followed by clk_set_parent() in
>   armada37xx_cpufreq_dvfs_setup(). I am not sure what you wanted to do
>   here as these two statements may not have any affect as you pass the
>   return value of clk_get_parent() to clk_set_parent(). Because the
>   clk framework will match the new parent with cached value of old
>   one, it wouldn't change anything at all at hardware level. Over
>   that, this all is done before enabling DVFS specific bits, which
>   will make us play with non-DVFS registers and we don't want that,
>   isn't it ?
>
> - We checked the divider values right from the registers before moving
>   to powersave and after moving back to performance. We are at
>   load_level 0, which means parent clock gets passed as is. So the
>   divider should be fine, only thing left is parent clock.
>
> I am attaching two files here, one of them is the debug patch I wrote
> to test this and the second one shows those debug prints during
> different phase of testing.
>
> Thanks in advance for helping out.

Thanks for your very detailed bug report and for your first
investigations. I will have a look on it very soon.

Gregory

>
> -- 
> viresh
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
