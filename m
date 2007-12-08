From: Ingo Molnar <mingo@elte.hu>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Sat, 8 Dec 2007 09:39:39 +0100
Message-ID: <20071208083939.GD30997__18644.5205974907$1197103280$gmane$org@elte.hu>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<47595A0A.5000502@gmail.com> <20071207151150.GB24254@elte.hu>
	<20071207175134.GA18916@elte.hu> <475A5188.6070809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <475A5188.6070809@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Jiri Slaby <jirislaby@gmail.com> wrote:

> Unfortunately no change here.

could you try to revert this change:

-int softlockup_thresh = 10;
+int softlockup_thresh = 60;

i.e. change the value of softlockup_thresh back to 10. You should be 
able to tweak this runtime as well, without patching the kernel:

  echo 10 > /proc/sys/kernel/softlockup_thresh

	Ingo
