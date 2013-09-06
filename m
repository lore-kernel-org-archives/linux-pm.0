From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 5/5] cpufreq: Use signed type for 'ret' variable,
 to store negative error values
Date: Sat, 07 Sep 2013 01:24:06 +0530
Message-ID: <20130906195404.26919.21905.stgit@srivatsabhat.in.ibm.com>
References: <20130906195206.26919.20884.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:51178 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab3IFT6N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2013 15:58:13 -0400
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 6 Sep 2013 13:58:13 -0600
In-Reply-To: <20130906195206.26919.20884.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, sboyd@codeaurora.org, viresh.kumar@linaro.org
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

There are places where the variable 'ret' is declared as unsigned int
and then used to store negative return values such as -EINVAL. Fix them
by declaring the variable as a signed quantity.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/cpufreq/cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9909789..9cc5609 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -460,7 +460,7 @@ static int __cpufreq_set_policy(struct cpufreq_policy *policy,
 static ssize_t store_##file_name					\
 (struct cpufreq_policy *policy, const char *buf, size_t count)		\
 {									\
-	unsigned int ret;						\
+	int ret;							\
 	struct cpufreq_policy new_policy;				\
 									\
 	ret = cpufreq_get_policy(&new_policy, policy->cpu);		\
@@ -513,7 +513,7 @@ static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 					const char *buf, size_t count)
 {
-	unsigned int ret;
+	int ret;
 	char	str_governor[16];
 	struct cpufreq_policy new_policy;
 

