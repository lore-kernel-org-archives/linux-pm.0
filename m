From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [Resend RFC PATCH 4/5] cpuidle/ppc: CPU goes tickless if there are
 no arch-specific constraints
Date: Fri, 26 Jul 2013 10:49:32 +0530
Message-ID: <20130726051858.17167.72800.stgit@preeti>
References: <20130726050915.17167.16298.stgit@preeti>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20130726050915.17167.16298.stgit@preeti>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: benh@kernel.crashing.org, paul.gortmaker@windriver.com, paulus@samba.org, shangw@linux.vnet.ibm.com, galak@kernel.crashing.org, fweisbec@gmail.com, paulmck@linux.vnet.ibm.com, michael@ellerman.id.au, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, rjw@sisk.pl, john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com, geoff@infradead.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

In the current design of timer offload framework, the broadcast cpu should
*not* go into tickless idle so as to avoid missed wakeups on CPUs in deep idle states.

Since we prevent the CPUs entering deep idle states from programming the
decrementer of the broadcast cpu for their respective next local events for
reasons mentioned in PATCH[3/5], the broadcast CPU checks if there are any
CPUs to be woken up during each of its timer interrupt, which is programmed
to its local events.

With tickless idle, the broadcast CPU might not have a timer interrupt
pending till after many ticks, which can result in missed wakeups on CPUs
in deep idle states. By disabling tickless idle, worst case, the tick_sched
hrtimer will trigger a timer interrupt every period.

However the current setup of tickless idle does not let us make the choice
of tickless on individual cpus. NOHZ_MODE_INACTIVE which disables tickless idle,
is a system wide setting. Hence resort to an arch specific call to check if a cpu
can go into tickless idle.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/time.c |    5 +++++
 kernel/time/tick-sched.c   |    7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7e858e1..916c32f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -864,6 +864,11 @@ static void decrementer_timer_broadcast(const struct cpumask *mask)
 	arch_send_tick_broadcast(mask);
 }
 
+int arch_can_stop_idle_tick(int cpu)
+{
+	return cpu != bc_cpu;
+}
+
 static void register_decrementer_clockevent(int cpu)
 {
 	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6960172..e9ffa84 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -700,8 +700,15 @@ static void tick_nohz_full_stop_tick(struct tick_sched *ts)
 #endif
 }
 
+int __weak arch_can_stop_idle_tick(int cpu)
+{
+	return 1;
+}
+
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
+	if (!arch_can_stop_idle_tick(cpu))
+		return false;
 	/*
 	 * If this cpu is offline and it is the one which updates
 	 * jiffies, then give up the assignment and let it be taken by
