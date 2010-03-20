From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Regression,
 post-2.6.34-rc1][PATCH] x86 / perf: Fix suspend to RAM on HP nx6325
Date: Sat, 20 Mar 2010 18:36:49 +0100
Message-ID: <1269106609.9440.529.camel__46087.4667544433$1269106695$gmane$org@laptop>
References: <201003201507.15358.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003201507.15358.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2010-03-20 at 15:07 +0100, Rafael J. Wysocki wrote:
> Hi Peter,
> 
> Your commit 3f6da3905398826d85731247e7fbcf53400c18bd
> (perf: Rework and fix the arch CPU-hotplug hooks) unfortunately broke suspend
> to RAM (probably hibernation too, but I haven't checked) on my HP nx6325.
> I also expect more (if not all) AMD-based boxes to be broken by it.
> 
> The machine simply hangs solid while trying to disable CPU1 during suspend.
> 
> The patch below fixes it, although I'm not exactly sure why calling
> amd_pmu_cpu_offline() during suspend causes the hang to happen.  If there's a
> better way to fix this, please let me know.

Hrmm, I'll have a poke at my AMD once I'm back home again, but does
something like the below cure things for you?

---
 arch/x86/kernel/cpu/perf_event_amd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_amd.c b/arch/x86/kernel/cpu/perf_event_amd.c
index 358a8e3..0189af4 100644
--- a/arch/x86/kernel/cpu/perf_event_amd.c
+++ b/arch/x86/kernel/cpu/perf_event_amd.c
@@ -345,6 +345,8 @@ static void amd_pmu_cpu_offline(int cpu)
 		return;
 
 	cpuhw = &per_cpu(cpu_hw_events, cpu);
+	if (!cpuhw)
+		return;
 
 	raw_spin_lock(&amd_nb_lock);
 
