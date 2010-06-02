From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 8/9] PM / Hibernate: dealign swsusp_info
Date: Wed,  2 Jun 2010 10:52:47 +0200
Message-ID: <1275468768-28229-8-git-send-email-jslaby@suse.cz>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-pm@vger.kernel.org

From: Jiri Slaby <jirislaby@gmail.com>

Now there is no need to have swsusp_info page aligned thanks to chunk
i/o support. We may add more info after it on the very same page.
Later...

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 kernel/power/power.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index 6e2e796..1fdbfe7 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -12,7 +12,7 @@ struct swsusp_info {
 	unsigned long		image_pages;
 	unsigned long		pages;
 	unsigned long		size;
-} __attribute__((aligned(PAGE_SIZE)));
+};
 
 #ifdef CONFIG_HIBERNATION
 #ifdef CONFIG_ARCH_HIBERNATION_HEADER
-- 
1.7.1
