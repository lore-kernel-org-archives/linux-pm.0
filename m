From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 1/3] power: supply: sbs-battery: Remove FSF mailing address from comments
Date: Tue, 11 Jul 2017 17:43:41 +0800
Message-ID: <1499766223-130934-2-git-send-email-preid@electromag.com.au>
References: <1499766223-130934-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:37241 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753081AbdGKJnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 05:43:49 -0400
In-Reply-To: <1499766223-130934-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, preid@electromag.com.au, linux-pm@vger.kernel.org, posted@heine.so

checkpatch issued an error in having the FSF address in the comment.
As address may change and Linux already includes a copy.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/supply/sbs-battery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index a7150a6..d06c4ac 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -12,10 +12,6 @@
  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
 #include <linux/init.h>
-- 
1.8.3.1
