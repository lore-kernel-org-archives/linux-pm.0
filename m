From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: BUG: using smp_processor_id() in preemptible code:
	s2disk
Date: Mon, 14 Jun 2010 17:09:41 +0300
Message-ID: <20100614140941.GA3581__36955.7351143614$1276527817$gmane$org@swordfish.minsk.epam.com>
References: <20100613203352.GA3577@swordfish>
	<1276461183.2659.4.camel@maxim-laptop>
	<201006140136.18652.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201006140136.18652.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,
Not sure if this simple solution is the correct one.

---

diff --git a/kernel/sched.c b/kernel/sched.c
index f8b8996..cfb262b 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2866,7 +2866,10 @@ unsigned long nr_iowait(void)
 
 unsigned long nr_iowait_cpu(void)
 {
-	struct rq *this = this_rq();
+	int cpu = get_cpu();
+	struct rq *this = cpu_rq(cpu);
+	put_cpu();
+	
 	return atomic_read(&this->nr_iowait);
 }
 
