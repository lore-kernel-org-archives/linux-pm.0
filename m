From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression,
	post-2.6.34-rc1][PATCH] x86 / perf: Fix suspend to RAM on HP nx6325
Date: Sun, 21 Mar 2010 21:51:51 +0100
Message-ID: <201003212151.51383.rjw__21609.3370611363$1269204593$gmane$org@sisk.pl>
References: <201003201507.15358.rjw@sisk.pl> <201003202148.01312.rjw@sisk.pl>
	<alpine.LFD.2.00.1003211029480.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1003211029480.18017@i5.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 21 March 2010, Linus Torvalds wrote:
> 
> On Sat, 20 Mar 2010, Rafael J. Wysocki wrote:
> >
> > The appended patch fixes the breakage for me too.
> 
> Please don't use a 'goto' for something like this.
> 
> >  	raw_spin_lock(&amd_nb_lock);
> >  
> > +	if (!cpuhw->amd_nb)
> > +		goto unlock;
> > +
> >  	if (--cpuhw->amd_nb->refcnt == 0)
> >  		kfree(cpuhw->amd_nb);
> >  
> >  	cpuhw->amd_nb = NULL;
> >  
> > + unlock:
> >  	raw_spin_unlock(&amd_nb_lock);
> >  }
> 
> Just do
> 
> 	raw_spin_lock(&amd_nb_lock);
> 	if (cpuhw->amd_nb) {
> 		if (!--cpuhw->amd_nb->refcnt)
> 			kfree(cpuhw->amd_nb);
> 		cpuhw->amd_nb = NULL;
> 	}
> 	raw_spin_unlock(&amd_nb_lock);
> 
> instead. Much more readable.
> 
> Let's keep 'goto' for cases where we have error returns that we don't want 
> to nest, not trivial stuff like this.

OK

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: x86 / perf: Fix suspend to RAM on HP nx6325

Commit 3f6da3905398826d85731247e7fbcf53400c18bd
(perf: Rework and fix the arch CPU-hotplug hooks) broke suspend to
RAM on my HP nx6325 (and most likely on other AMD-based boxes too)
by allowing amd_pmu_cpu_offline() to be executed for CPUs that are
going offline as part of the suspend process.  The problem is that
cpuhw->amd_nb may be NULL already, so the function should make sure
it's not NULL before accessing the object pointed to by it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/cpu/perf_event_amd.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/x86/kernel/cpu/perf_event_amd.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/perf_event_amd.c
+++ linux-2.6/arch/x86/kernel/cpu/perf_event_amd.c
@@ -348,10 +348,12 @@ static void amd_pmu_cpu_offline(int cpu)
 
 	raw_spin_lock(&amd_nb_lock);
 
-	if (--cpuhw->amd_nb->refcnt == 0)
-		kfree(cpuhw->amd_nb);
+	if (cpuhw->amd_nb) {
+		if (--cpuhw->amd_nb->refcnt == 0)
+			kfree(cpuhw->amd_nb);
 
-	cpuhw->amd_nb = NULL;
+		cpuhw->amd_nb = NULL;
+	}
 
 	raw_spin_unlock(&amd_nb_lock);
 }
