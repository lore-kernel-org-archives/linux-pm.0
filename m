From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Help needed: Resume problems in 2.6.32-rc,
 perhaps related to preempt_count leakage in keventd
Date: Mon, 9 Nov 2009 07:57:35 -0800 (PST)
Message-ID: <alpine.LFD.2.01.0911090733150.31845__35436.7520114922$1257782352$gmane$org@localhost.localdomain>
References: <200911091250.31626.rjw@sisk.pl> <20091109120217.GB18399@elte.hu>
	<200911091324.37955.rjw@sisk.pl> <20091109124937.GA21114@elte.hu>
	<alpine.LFD.2.00.0911091452300.2725@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0911091452300.2725@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 9 Nov 2009, Thomas Gleixner wrote:
> 
> I think it _IS_ releated because the worker_thread is CPU affine and
> the debug_smp_processor_id() check does:

Hmm. We do know CPU affinity is destroyed by CPU hotplug. People have 
complained about that before (for user-space processes that get moved 
around due to hot-unplug/plug).

And the suspend/resume process does CPU hotplug to take down all but one 
CPU. The workqueues should act on those events already, but maybe there's 
a bug somewhere. None of that is new to 32-rc, though - is it?

And workqueue_cpu_callback() seems buggy. It loops over the 'workqueues' 
list with no protection. Yes, we do 'stop_machine' for CPU hotplug events, 
but only for the very internal one (CPU_DYING) will the CPU notifiers be 
called with the machine stopped).

Hmm. I don't see any changes in kernel/cpu.c or kernel/workqueue.c that 
look at all relevant. But scheduler changes could certainly matter.

			Linus
