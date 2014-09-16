From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 11/22] cpufreq: Replace strnicmp with strncasecmp
Date: Tue, 16 Sep 2014 22:51:25 +0200
Message-ID: <1410900696-6481-12-git-send-email-linux@rasmusvillemoes.dk>
References: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:58295 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbaIPUwK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Sep 2014 16:52:10 -0400
Received: by mail-lb0-f172.google.com with SMTP id w7so598525lbi.17
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2014 13:52:09 -0700 (PDT)
In-Reply-To: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

The kernel used to contain two functions for length-delimited,
case-insensitive string comparison, strnicmp with correct semantics
and a slightly buggy strncasecmp. The latter is the POSIX name, so
strnicmp was renamed to strncasecmp, and strnicmp made into a wrapper
for the new strncasecmp to avoid breaking existing users.

To allow the compat wrapper strnicmp to be removed at some point in
the future, and to avoid the extra indirection cost, do
s/strnicmp/strncasecmp/g.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d9fdedd..3330f51 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -437,7 +437,7 @@ static struct cpufreq_governor *__find_governor(const char *str_governor)
 	struct cpufreq_governor *t;
 
 	list_for_each_entry(t, &cpufreq_governor_list, governor_list)
-		if (!strnicmp(str_governor, t->name, CPUFREQ_NAME_LEN))
+		if (!strncasecmp(str_governor, t->name, CPUFREQ_NAME_LEN))
 			return t;
 
 	return NULL;
@@ -455,10 +455,10 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 		goto out;
 
 	if (cpufreq_driver->setpolicy) {
-		if (!strnicmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
+		if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
 			*policy = CPUFREQ_POLICY_PERFORMANCE;
 			err = 0;
-		} else if (!strnicmp(str_governor, "powersave",
+		} else if (!strncasecmp(str_governor, "powersave",
 						CPUFREQ_NAME_LEN)) {
 			*policy = CPUFREQ_POLICY_POWERSAVE;
 			err = 0;
-- 
2.0.4

