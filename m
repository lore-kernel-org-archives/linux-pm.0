From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.22-rcX Transmeta/APM regression
Date: Sat, 30 Jun 2007 11:26:40 +0200
Message-ID: <200706301126.41179.ak@suse.de>
References: <20070630030343.31711.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070630030343.31711.qmail@science.horizon.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux@horizon.com
Cc: bk@suse.de, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, michal.k.k.piotrowski@gmail.com, hpa@zytor.com
List-Id: linux-pm@vger.kernel.org

On Saturday 30 June 2007 05:03, linux@horizon.com wrote:

> Anyway, the patch which introduces the problem is the aptly named 3ebad:
> 3ebad59056: [PATCH] x86: Save and restore the fixed-range MTRRs of the BSP
> when suspending
>
> 2.6.22-rc6 plus that one commit reverted successfully does APM suspend
> (and resume) for me.

Mr.Linux, Does that patch fix it? 

-Andi

i386: Check if CPU has MTRRs before trying to save them

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/cpu/mtrr/main.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/mtrr/main.c
+++ linux/arch/i386/kernel/cpu/mtrr/main.c
@@ -734,8 +734,11 @@ void mtrr_ap_init(void)
  */
 void mtrr_save_state(void)
 {
-	int cpu = get_cpu();
+	int cpu;
 
+	if (!cpu_has_mtrr)
+		return;
+	cpu  = get_cpu();
 	if (cpu == 0)
 		mtrr_save_fixed_ranges(NULL);
 	else
