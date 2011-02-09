From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Remove CONFIG_PM altogether,
 enable power management all the time
Date: Wed, 9 Feb 2011 11:41:38 +0000
Message-ID: <20110209114137.GA10163__20291.8304283687$1297251851$gmane$org@opensource.wolfsonmicro.com>
References: <4D51D341.3040209@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4D51D341.3040209@am.sony.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frank Rowand <frank.rowand@am.sony.com>
Cc: Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-embedded@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 08, 2011 at 03:35:29PM -0800, Frank Rowand wrote:

> For 2.6.38-rc4, x86_64, CONFIG_NR_CPUS=4:

> size vmlinux
>    text     data       bss       dec      hex  filename
> 
> 6553910  3555020   9994240  20103170  132c002  vmlinux    with    CONFIG_PM
> 6512652  3553116   9994240  20060008  1321768  vmlinux    without CONFIG_PM
> 
>   41258     1904         0     43162                      delta

> That is big enough for me to care.

Hrm, that's pretty surprising.  It'd be interesting to know how much of
that is due to the PM core itself and how much of that is from drivers.
For the drivers CONFIG_PM isn't really the option they should be using
in the first place - they mostly want some combination of PM_SLEEP and
PM_RUNTIME for the specific functionality.  I'm running some checks now.

>  > CONFIG_PM_SLEEP=y

Raphael's patch will make this a user visible option in place of raw
CONFIG_PM by default so you'd be able to turn that off.
