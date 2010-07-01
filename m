From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] PM / Hibernate: Fix snapshot error code path
Date: Thu, 1 Jul 2010 23:59:24 +0200
Message-ID: <201007012359.25051.rjw__2619.35692183233$1278021785$gmane$org@sisk.pl>
References: <201007012356.44690.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007012356.44690.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There is an inconsistency between hibernation_platform_enter()
and hibernation_snapshot(), because the latter calls
hibernation_ops->end() after failing hibernation_ops->begin(), while
the former doesn't do that.  Make hibernation_snapshot() behave in
the same way as hibernation_platform_enter() in that respect.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/hibernate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/power/hibernate.c
===================================================================
--- linux-2.6.orig/kernel/power/hibernate.c
+++ linux-2.6/kernel/power/hibernate.c
@@ -330,7 +330,7 @@ int hibernation_snapshot(int platform_mo
 
 	error = platform_begin(platform_mode);
 	if (error)
-		return error;
+		goto Close;
 
 	/* Preallocate image memory before shutting down devices. */
 	error = hibernate_preallocate_memory();
