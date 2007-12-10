From: Ingo Molnar <mingo@elte.hu>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Mon, 10 Dec 2007 10:10:52 +0100
Message-ID: <20071210091052.GA14487@elte.hu>
References: <20071207151150.GB24254@elte.hu> <20071207175134.GA18916@elte.hu>
	<475A5188.6070809@gmail.com> <20071208083939.GD30997@elte.hu>
	<475A629C.7010408@gmail.com> <20071208152447.GA30270@elte.hu>
	<475B24F4.3090904@gmail.com> <20071209074647.GE22981@elte.hu>
	<20071210081952.GA7215@in.ibm.com> <475CFF01.2090502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <475CFF01.2090502@gmail.com>
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


> > softlockup: remove get_online_cpus() which doesn't help here.
> > 
> > The get_online_cpus() protection seems to be bogus in 
> > kernel/softlockup.c as cpu cached in check_cpu can go offline once 
> > we do a put_online_cpus().
> > 
> > This can also cause deadlock during a cpu offline as follows:

i'm wondering, what's the proper CPU-hotplug safe sequence here then? 
I'm picking a CPU number from cpu_online_map, and that CPU could go away 
while i'm still using it, right? What's saving us here?

	Ingo
