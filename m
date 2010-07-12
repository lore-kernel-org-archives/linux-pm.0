From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] idle: intel_idle: Change mode 755 => 644
Date: Mon, 12 Jul 2010 08:56:43 +0200
Message-ID: <1278917804-4456-1-git-send-email-weber__979.109135414724$1278949114$gmane$org@corscience.de>
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
To: lenb@kernel.org
Cc: Thomas Weber <weber@corscience.de>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Remove execution permission from source file.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 drivers/idle/intel_idle.c

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
old mode 100755
new mode 100644
-- 
1.7.1
