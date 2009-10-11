From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH -v1] MIPS: add IRQF_TIMER flag for Timer
	Interrupts
Date: Mon, 12 Oct 2009 01:59:39 +0900 (JST)
Message-ID: <20091012.015939.165860325.anemo__10066.7169005193$1255371391$gmane$org@mba.ocn.ne.jp>
References: <1255103450-12537-1-git-send-email-wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1255103450-12537-1-git-send-email-wuzhangjin@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: wuzhangjin@gmail.com
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, linux-pm@lists.linux-foundation.org, yuasa@linux-mips.org
List-Id: linux-pm@vger.kernel.org

On Fri,  9 Oct 2009 23:50:50 +0800, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> This patch add IRQF_TIMER flag for all Timer interrupts in linux-MIPS,
> which will help to not disable the Timer IRQ when suspending to ensure
> resuming normally(d6c585a4342a2ff627a29f9aea77c5ed4cd76023) and not
> thread them when enabled PREEMPT_RT.
> 
> NOTE: Perhaps there are also some board-specific Timer interrupts
> missing here!
> 
> (This -v1 version Incorporated the feedback from Atsushi Nemoto
>  <anemo@mba.ocn.ne.jp>.)
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/jazz/irq.c                |    2 +-
>  arch/mips/kernel/cevt-bcm1480.c     |    2 +-
>  arch/mips/kernel/cevt-ds1287.c      |    2 +-
>  arch/mips/kernel/cevt-gt641xx.c     |    2 +-
>  arch/mips/kernel/cevt-r4k.c         |    2 +-
>  arch/mips/kernel/cevt-sb1250.c      |    2 +-
>  arch/mips/kernel/cevt-txx9.c        |    2 +-
>  arch/mips/kernel/i8253.c            |    2 +-
>  arch/mips/nxp/pnx8550/common/int.c  |    2 +-
>  arch/mips/nxp/pnx8550/common/time.c |    4 ++--
>  arch/mips/sgi-ip27/ip27-timer.c     |    2 +-
>  arch/mips/sni/time.c                |    2 +-
>  12 files changed, 13 insertions(+), 13 deletions(-)

Thank you.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
