From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] MIPS: add IRQF_TIMER flag for Timer
	Interrupts
Date: Thu, 8 Oct 2009 17:13:00 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910081712390.9428__14735.2257081822$1255014956$gmane$org@localhost.localdomain>
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
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, pm list <linux-pm@lists.linux-foundation.org>, Yoichi Yuasa <yuasa@linux-mips.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 8 Oct 2009, Wu Zhangjin wrote:

> This patch add IRQF_TIMER flag for all Timer interrupts in linux-MIPS,
> which will help to not disable the Timer IRQ when suspending to ensure
> resuming normally(d6c585a4342a2ff627a29f9aea77c5ed4cd76023) and not
> thread them when enabled PREEMPT_RT.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
