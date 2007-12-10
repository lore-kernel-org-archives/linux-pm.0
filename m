From: Ingo Molnar <mingo@elte.hu>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Mon, 10 Dec 2007 10:29:48 +0100
Message-ID: <20071210092948.GA18184__6851.67472479424$1197279204$gmane$org@elte.hu>
References: <47595A0A.5000502@gmail.com> <20071207151150.GB24254@elte.hu>
	<20071207175134.GA18916@elte.hu> <475A5188.6070809@gmail.com>
	<20071208083939.GD30997@elte.hu> <475A629C.7010408@gmail.com>
	<20071208152447.GA30270@elte.hu> <475B24F4.3090904@gmail.com>
	<20071209074647.GE22981@elte.hu> <20071210081952.GA7215@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071210081952.GA7215@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> Further more this can cause a deadlock since we're calling 
> get_online_cpus() from the watchdog thread's context, which is going 
> to be kthread_stop'ed from a cpu-hotplug context. This is what I think 
> was happening in the case reported by Jiri.
> 
> Please find the patch below.

thanks, and i've updated sched-devel.git.

	Ingo
