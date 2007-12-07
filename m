From: Jiri Slaby <jirislaby@gmail.com>
Subject: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Fri, 07 Dec 2007 15:34:50 +0100
Message-ID: <47595A0A.5000502@gmail.com>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071204211701.994dfce6.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 12/05/2007 06:17 AM, Andrew Morton wrote:
>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc4/2.6.24-rc4-mm1/

>  git-sched.patch

breaks suspend here since -rc3-mm2. More precisely, this one:
softlockup: automatically detect hung TASK_UNINTERRUPTIBLE tasks

2.6.24-rc4-mm1 minus this one works just fine. Otherwise disks stop, graphics
stops and then it hangs not powering down.

Core 2 Duo, SMP kernel, voluntary preempt, 250 HZ, SLUB, 64 bit.

Ideas?
