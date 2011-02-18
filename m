From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] PM QoS: Allow parsing of ASCII values
Date: Fri, 18 Feb 2011 10:54:56 +0900
Message-ID: <1297994096-1839-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Dan Carpenter <error27@gmail.com>, Mark Gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

In "PM QoS: Correct pr_debug() misuse and improve parameter checks"
the parsing of the ASCII hex value was tightened. Unfortunately
it was tightened to the point where no value is valid.

Root of the problem seems to lie in wheather the ASCII hex is followed
by a '\n' or not. My reading of the documentation is that the '\n' should
not be present. However the code previously only accepted that version.
The current code accepts neither. My fix is to accept both.

Cc: Mark Gross <markgross@thegnar.org>
Cc: Dan Carpenter <error27@gmail.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Simon Horman <horms@verge.net.au>

---
This appears to have been introduced around 2.6.36-rc4.
And was an @stable patch. As such I believe this change
is stable material.
---
 kernel/pm_qos_params.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index aeaa7f8..98a34ea 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -387,10 +387,11 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 	if (count == sizeof(s32)) {
 		if (copy_from_user(&value, buf, sizeof(s32)))
 			return -EFAULT;
-	} else if (count == 11) { /* len('0x12345678/0') */
-		if (copy_from_user(ascii_value, buf, 11))
+	} else if (count == 11 || count == 10) { /* len('0x12345678\n') or
+						  * len('0x12345678') */
+		if (copy_from_user(ascii_value, buf, count))
 			return -EFAULT;
-		if (strlen(ascii_value) != 10)
+		if (strlen(ascii_value) != count)
 			return -EINVAL;
 		x = sscanf(ascii_value, "%x", &value);
 		if (x != 1)
-- 
1.7.2.3
