From: Len Brown <lenb@kernel.org>
Subject: Re: Need to replace one patch in suspend branch
Date: Thu, 31 Jan 2008 23:22:08 -0500
Message-ID: <200801312322.09211.lenb__20977.6833573871$1201839873$gmane$org@kernel.org>
References: <200801290029.07402.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801290029.07402.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 28 January 2008 18:29, Rafael J. Wysocki wrote:
> Hi Len,
> 
> Would it be possible to replace commit a04ca6718960e842624833a01dbd5f10f38f5af1
> "Suspend: Testing facility (rev. 2)" in the suspend branch with the appended patch?
> 
> Unfortunately, the original commit uses pointers to 'struct kset' which is no
> longer valid after the recently merged driver core changes.

Hi Rafael,
The original suspend branch is now available rooted at 2.6.24
as "suspend-2.6.24".

The latest "suspend" branch is now based on today's linus HEAD.

In the suspend branch, I rewound the series until after the
original patch, patch -R the original, patch -N the new one,
and checked in the the resulting diff (below).

At the expense of the additional trivial patch,
this struck me as a good balance between preserving
the (tested) history, showing what changed,
and minimizing exposure to bisect build breakage.

thanks,
-Len

commit 21779c8de31b1c9e749af676a033109f70156678
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Tue Jan 29 00:29:06 2008 +0100

    suspend: build fix responding to 2.6.25 kset change
    
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 84e1ae6..fc717b8 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -53,7 +53,8 @@ static const char * const pm_tests[__TEST_AFTER_LAST] = {
 	[TEST_FREEZER] = "freezer",
 };
 
-static ssize_t pm_test_show(struct kset *kset, char *buf)
+static ssize_t pm_test_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
 {
 	char *s = buf;
 	int level;
@@ -73,7 +74,8 @@ static ssize_t pm_test_show(struct kset *kset, char *buf)
 	return (s - buf);
 }
 
-static ssize_t pm_test_store(struct kset *kset, const char *buf, size_t n)
+static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t n)
 {
 	const char * const *s;
 	int level;
@@ -104,6 +106,7 @@ power_attr(pm_test);
 static inline int suspend_test(int level) { return 0; }
 #endif /* !CONFIG_PM_DEBUG */
 
+
 #ifdef CONFIG_SUSPEND
 
 /* This is just an arbitrary number */
