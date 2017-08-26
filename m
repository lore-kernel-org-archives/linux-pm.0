From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [Bug] ARM: cpuidle: possible memleak
Date: Sat, 26 Aug 2017 13:46:20 +0200 (CEST)
Message-ID: <299133306.50715.1503747980116@email.1und1.de>
References: <1980049531.494543.1502543973258@email.1und1.de>
 <20170813035040.GA13637@leoy-linaro>
 <37728512.316309.1502619006183@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <37728512.316309.1502619006183@email.1und1.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Leo Yan <leo.yan@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 13. August 2017 um 12:10 geschrieben:
> 
> 
> Hi Leo,
> 
> > Leo Yan <leo.yan@linaro.org> hat am 13. August 2017 um 05:50 geschrieben:
> > 
> > 
> > Hi Stefan,
> > 
> > On Sat, Aug 12, 2017 at 03:19:33PM +0200, Stefan Wahren wrote:
> > > Hi,
> > > 
> > > if i additionally enable kmemleak (on top of multi_v7_defconfig) on RPi 3 (4 cores) with 4.13-rc4, i get the following output from kmemleak:
> > > 
> > > unreferenced object 0xede0dc00 (size 1024):
> > >   comm "swapper/0", pid 1, jiffies 4294937431 (age 744.510s)
> > >   hex dump (first 32 bytes):
> > >     94 9e 0b c1 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >     57 46 49 00 00 00 00 00 00 00 00 00 00 00 00 00  WFI.............
> > >   backtrace:
> > >     [<c1295f04>] arm_idle_init+0x44/0x1ac
> > >     [<c0301e6c>] do_one_initcall+0x3c/0x16c
> > >     [<c1200d70>] kernel_init_freeable+0x110/0x1d0
> > >     [<c0cb3624>] kernel_init+0x8/0x114
> > >     [<c0307a98>] ret_from_fork+0x14/0x3c
> > >     [<ffffffff>] 0xffffffff
> > > 
> > > If i revert the last commit in cpuidle-arm d50a7d8acd78 ("ARM: cpuidle: Support asymmetric idle definition") then kmemleak stays calm.
> > 
> > I cannot reproduce the error at my side, I also tried to disable idle
> > states but cannot trigger the failure. So first thing is to know the
> > reason for registeration failure and finally introduce the memory
> > leaking. Could you point out the dts you are using for idle states
> > binding?
> 
> thanks for you quick response. Sorry, i forgot to mention that arch/arm64/boot/dts/broadcom/bcm2837.dtsi doesn't contain any idle states. So the error path of dt_init_idle_driver() is expected. If i get it right, the clean up loop after out_fail only handles registered drivers (better label name or a comment would be helpful). So combined with your fix the following fixes the memleak for me (didn't test the clean up loop):
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 7080c38..827ab25 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -104,12 +104,14 @@ static int __init arm_idle_init(void)
>  		ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
>  		if (ret <= 0) {
>  			ret = ret ? : -ENODEV;
> +			kfree(drv);
>  			goto out_fail;
>  		}
>  
>  		ret = cpuidle_register_driver(drv);
>  		if (ret) {
>  			pr_err("Failed to register cpuidle driver\n");
> +			kfree(drv);
>  			goto out_fail;
>  		}
>  
> @@ -152,11 +154,13 @@ static int __init arm_idle_init(void)
>  out_fail:
>  	while (--cpu >= 0) {
>  		dev = per_cpu(cpuidle_devices, cpu);
> -		cpuidle_unregister_device(dev);
> -		kfree(dev);
> -		drv = cpuidle_get_driver();
> +		drv = cpuidle_get_cpu_driver(dev);
> +
>  		cpuidle_unregister_driver(drv);
>  		kfree(drv);
> +
> +		cpuidle_unregister_device(dev);
> +		kfree(dev);
>  	}
>  
>  	return ret;

should i split this patch (fix for "my" memleak and cleanup fix)?
