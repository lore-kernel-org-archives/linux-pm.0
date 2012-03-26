From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] cpuidle: remove useless array definition in
	cpuidle_structure
Date: Mon, 26 Mar 2012 14:51:27 +0200
Message-ID: <1332766288-30412-2-git-send-email-daniel.lezcano@linaro.org>
References: <1332766288-30412-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1332766288-30412-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

All the modules name are ro-data, it is never copied to the array.

eg.

static struct cpuidle_driver intel_idle_driver = {
        .name = "intel_idle",
        .owner = THIS_MODULE,
};

It safe to assign the pointer of this ro-data to a const char *.
By this way we save 12 bytes.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Deepthi Dharwar <deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Tested-by: Deepthi Dharwar <deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 include/linux/cpuidle.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index ca4e498..f7f1d90 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -120,7 +120,7 @@ static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
  ****************************/
 
 struct cpuidle_driver {
-	char			name[CPUIDLE_NAME_LEN];
+	const char		*name;
 	struct module 		*owner;
 
 	unsigned int		power_specified:1;
-- 
1.7.5.4
