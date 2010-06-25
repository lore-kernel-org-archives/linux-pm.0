From: Dave Jones <davej@redhat.com>
Subject: RFC: Don't enable both cpuidle governors when NO_HZ is
	enabled.
Date: Thu, 24 Jun 2010 23:52:54 -0400
Message-ID: <20100625035254.GA25695@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Does this patch make sense ?

I noticed we setup both governors during boot..

 kernel: [    3.387035] cpuidle: using governor ladder
 kernel: [    3.391541] cpuidle: using governor menu

which seems wasteful.

With this patch, we configure either ladder, or menu, depending on
whether NO_HZ is set.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.34.noarch/drivers/cpuidle/Kconfig~	2010-06-24 23:48:08.000000000 -0400
+++ linux-2.6.34.noarch/drivers/cpuidle/Kconfig	2010-06-24 23:48:13.000000000 -0400
@@ -11,7 +11,7 @@ config CPU_IDLE
 
 config CPU_IDLE_GOV_LADDER
 	bool
-	depends on CPU_IDLE
+	depends on CPU_IDLE && !NO_HZ
 	default y
 
 config CPU_IDLE_GOV_MENU
