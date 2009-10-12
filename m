From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/1] PM / Hibernate: add \n to load_image fail
	path
Date: Mon, 12 Oct 2009 23:38:50 +0200
Message-ID: <1255383530-6778-1-git-send-email-jirislaby@gmail.com>
References: <4AD39FBA.6000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AD39FBA.6000509@gmail.com>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

Finish a line by \n when load_image fails in the middle of loading.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
---
 kernel/power/swap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 893f522..4bb5c3b 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -537,7 +537,8 @@ static int load_image(struct swap_map_handle *handle,
 		snapshot_write_finalize(snapshot);
 		if (!snapshot_image_loaded(snapshot))
 			error = -ENODATA;
-	}
+	} else
+		printk("\n");
 	swsusp_show_speed(&start, &stop, nr_to_read, "Read");
 	return error;
 }
-- 
1.6.4.2
