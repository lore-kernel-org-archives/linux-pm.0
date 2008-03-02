From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Too many timer interrupts in NO_HZ
Date: Sun, 2 Mar 2008 11:57:09 -0800
Message-ID: <20080302115709.30403490__26522.1539921642$1204488186$gmane$org@laptopd505.fenrus.org>
References: <20080302194812.GD10028@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080302194812.GD10028@dirshya.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: svaidy@linux.vnet.ibm.com
Cc: Chanda Sethia <chanda.sethia@in.ibm.com>, Ingo@smtp1.linux-foundation.org, suresh.b.siddha@intel.com, Linux Kernel <linux-kernel@vger.kernel.org>, tglx@linutronix.de, discuss@LessWatts.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 Mar 2008 01:18:13 +0530
Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:

> Hi,
> 
> I am trying to play around with the tickless kernel and
> sched_mc_power_savings tunables to increase the idle duration of the
> CPU in an SMP server.  sched_mc_power_savings provides good
> consolidation of long running jobs when the system is lightly loaded.
> However I am interested to see CPU idle times for couple minutes on
> atleast few CPUs in an completely idle SMP system.
> 
> I have posted related instrumentation results at
> http://lkml.org/lkml/2008/1/8/243
> 
> The experimental setup is identical.  Just that I have tried to
> collect more data and also bias the wakeup logic.
> 
> The kernel is 2.6.25-rc3 with NO_HZ, SCHED_MC, HIGH_RES_TIMERS, and
> HPET turned on.
> 
> I have tried to collect interesting data from tick-sched.c, sched.c
> and softirq.c.
> 
> As suggested by Ingo in the previous thread, I have hacked the sched.c
> try_to_wake_up logic so that I can force all wake-ups to happen on
> CPU0.  This is just and experiment, in reality we will have to
> carefully choose a domain and CPU to bias all wakeups on an idle
> system.


please show us powertop -d output; that way we can at least see sort of what
is going on...
