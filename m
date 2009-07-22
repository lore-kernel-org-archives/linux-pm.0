From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [suspend] pci_raw_set_power_state:
	replace	msleep by udelay in resuming procedure
Date: Wed, 22 Jul 2009 09:10:39 +0200
Message-ID: <20090722071039.GD29955__13714.1811931089$1248246714$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0907161259510.2952-100000@iolanthe.rowland.org>
	<1247796643.19112.77.camel@falcon> <200907170433.42366.rjw@sisk.pl>
	<1248229436.12360.27.camel@falcon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1248229436.12360.27.camel@falcon>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: len.brown@intel.com, yanh@lemote.com, linux-kernel@vger.kernel.org, zhangfx@lemote.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> > Perhaps it's necessary to annotate your timer interrupts appropriately so that
> > they are not disabled during suspend?
> 
> Thanks very much, The IRQF_TIMER flag works for me, so the replacement
> of msleep by udelay is not needed.
> 
> [This source code is not ready to upstream, herein, just a prompt to the
> other guys who will meet the same problem.]

Unlike the other patch, this one actually looks ok.

> Adding IRQF_TIMER to the interupt flags when requesting the mfgpt timer
> interrupts solves the problem.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/loongson/common/cs5536/cs5536_mfgpt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
> b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
> index 1a518ec..5b8fa9f 100644
> --- a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
> +++ b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
> @@ -133,7 +133,7 @@ static irqreturn_t timer_interrupt(int irq, void
> *dev_id)
>  
>  static struct irqaction irq5 = {
>  	.handler = timer_interrupt,
> -	.flags = IRQF_DISABLED | IRQF_NOBALANCING,
> +	.flags = IRQF_TIMER | IRQF_DISABLED | IRQF_NOBALANCING,
>  	.name = "timer"
>  };


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
