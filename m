From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/6] Suspend: Fix comment in main.c
Date: Tue, 27 Nov 2007 00:31:21 +0100
Message-ID: <200711270031.22305.rjw__14515.3768048205$1196119840$gmane$org@sisk.pl>
References: <200711270025.08128.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711270025.08128.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Fix a comment in kernel/power/main.c so that it doesn't contain lines
longer that 80 characters.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -242,8 +242,8 @@ static int suspend_enter(suspend_state_t
 }
 
 /**
- *	suspend_devices_and_enter - suspend devices and enter the desired system sleep
- *			  state.
+ *	suspend_devices_and_enter - suspend devices and enter the desired system
+ *				    sleep state.
  *	@state:		  state to enter
  */
 int suspend_devices_and_enter(suspend_state_t state)
