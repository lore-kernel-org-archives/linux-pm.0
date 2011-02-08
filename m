From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH] Remove CONFIG_PM altogether,
 enable power management all the time
Date: Tue, 8 Feb 2011 15:35:29 -0800
Message-ID: <4D51D341.3040209__48141.185710165$1297208283$gmane$org@am.sony.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201102072046.48763.rjw@sisk.pl>
	<20110207201803.GU10564@opensource.wolfsonmicro.com>
	<201102072215.59921.rjw@sisk.pl> <20110208122159.GA8284@elte.hu>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110208122159.GA8284@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-embedded@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 02/08/11 04:21, Ingo Molnar wrote:

< snip >

> Also, i've Cc:-ed Linus, to check whether the idea to make power management a 
> permanent, core portion of Linux has any obvious downsides we missed.
> 
> Rafael, could you do a defconfig-ish x86 build with and without CONFIG_PM, and post 
> the 'size vmlinux' comparison - so that we can see the size difference? We make some 
> things CONFIG_EXPERT configurable just to enable folks who *really* want to cut down 
> on kernel size to configure it out.

For 2.6.38-rc4, x86_64, CONFIG_NR_CPUS=4:

size vmlinux
   text     data       bss       dec      hex  filename

6553910  3555020   9994240  20103170  132c002  vmlinux    with    CONFIG_PM
6512652  3553116   9994240  20060008  1321768  vmlinux    without CONFIG_PM

  41258     1904         0     43162                      delta


That is big enough for me to care.

Turning on CONFIG_PM also forces a few other options on:

 295a296
 > CONFIG_XEN_SAVE_RESTORE=y
 422c423,431
 < # CONFIG_PM is not set
 ---
 > CONFIG_PM=y
 > # CONFIG_PM_DEBUG is not set
 > CONFIG_PM_SLEEP_SMP=y
 > CONFIG_PM_SLEEP=y
 > # CONFIG_SUSPEND is not set
 > # CONFIG_HIBERNATION is not set
 > # CONFIG_PM_RUNTIME is not set
 > CONFIG_PM_OPS=y
 > # CONFIG_ACPI is not set
 451,454c460
 < CONFIG_CPU_IDLE=y
 < CONFIG_CPU_IDLE_GOV_LADDER=y
 < CONFIG_CPU_IDLE_GOV_MENU=y
 < # CONFIG_INTEL_IDLE is not set
 ---
 > # CONFIG_CPU_IDLE is not set

> 
> Note that those usecases, even if they want a super-small kernel, might not care 
> about PM at all while they care about size: small boot kernels in ROMs, or simple 
> devices where CPU-idling implies deep low power mode, etc.
> 
> So the vmlinux size comparisons would be needed really. If it's 5k nobody will care. 
> If it's 50k-100k that's borderline. In the other side of the scale we have the 1500+
> #ifdef CONFIG_PM lines strewn around the kernel source, and the frequent !PM build
> breakages.
> 
> 	Ingo

-Frank
