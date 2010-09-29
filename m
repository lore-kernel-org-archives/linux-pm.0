From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/5] intel_idle: Change mode 755 => 644
Date: Tue, 28 Sep 2010 23:53:05 -0400
Message-ID: <68f160125f0655c21a1c9f896ddff97d98012cb0.1285732130.git.len.brown@intel.com>
References: <1285732387-18629-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1285732387-18629-1-git-send-email-lenb@kernel.org>
In-reply-to: <4731fdcf6f7bdab3e369a3f844d4ea4d4017284d.1285732130.git.len.brown@intel.com>
References: <4731fdcf6f7bdab3e369a3f844d4ea4d4017284d.1285732130.git.len.brown@intel.com>
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
Cc: Thomas Weber <weber@corscience.de>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Thomas Weber <weber@corscience.de>

Remove execution permission from source file.

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 drivers/idle/intel_idle.c

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
old mode 100755
new mode 100644
-- 
1.7.3.2.g9027fa
