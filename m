From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] MIPS: add IRQF_TIMER flag for Timer
	Interrupts
Date: Sat, 10 Oct 2009 00:17:54 +0900 (JST)
Message-ID: <20091010.001754.229727131.anemo__9473.20887721634$1255371127$gmane$org@mba.ocn.ne.jp>
References: <1255007874-19574-1-git-send-email-wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1255007874-19574-1-git-send-email-wuzhangjin@gmail.com>
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
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, yuasa@linux-mips.org
List-Id: linux-pm@vger.kernel.org

On Thu,  8 Oct 2009 21:17:54 +0800, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> This patch add IRQF_TIMER flag for all Timer interrupts in linux-MIPS,
> which will help to not disable the Timer IRQ when suspending to ensure
> resuming normally(d6c585a4342a2ff627a29f9aea77c5ed4cd76023) and not
> thread them when enabled PREEMPT_RT.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/jazz/irq.c                |    2 +-
>  arch/mips/kernel/cevt-gt641xx.c     |    2 +-
>  arch/mips/kernel/cevt-r4k.c         |    2 +-
>  arch/mips/kernel/i8253.c            |    2 +-
>  arch/mips/nxp/pnx8550/common/time.c |    2 +-
>  arch/mips/sgi-ip27/ip27-timer.c     |    2 +-
>  arch/mips/sni/time.c                |    2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

Maybe cevt-bcm1480.c, cevt-ds1287.c, cevt-sb1250.c, cevt-txx9.c and
i8253.c need same fix?

---
Atsushi Nemoto
