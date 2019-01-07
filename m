From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] cpufreq: e_powersaver: Use struct_size() in kzalloc()
Date: Mon, 7 Jan 2019 11:33:43 -0600
Message-ID: <20190107173343.GA4258@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with memory
for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can now
use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/cpufreq/e_powersaver.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 60bea302abbe..2d3ef208dd70 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -323,9 +323,8 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 		states = 2;
 
 	/* Allocate private data and frequency table for current cpu */
-	centaur = kzalloc(sizeof(*centaur)
-		    + (states + 1) * sizeof(struct cpufreq_frequency_table),
-		    GFP_KERNEL);
+	centaur = kzalloc(struct_size(centaur, freq_table, states + 1),
+			  GFP_KERNEL);
 	if (!centaur)
 		return -ENOMEM;
 	eps_cpu[0] = centaur;
-- 
2.20.1
