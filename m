Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729950;
	b=K5K8hz0H+rgdhPs40CsQQTYnXvJ6n1pLfpxqAArZ8YyofKHkrhegGtgfzo1jMkbylCyR
	 RNCyuF87ehXkYNRexd3C9cOymBWlkgXXtJtG0p7LNikkFpT+vClb869N6GwrDq1NVSQRt
	 t/n6XRStG+m5Lza3cZTOUj/ysMKobvjEpRXCPL0Hz135/RFy1pW26QDpfnvA7m4fQYu61
	 l9eTEqCNsS9PO/R9H0WAXFZkWdLSrPAqIYk338CP/APdf5ypeTiqF4cblyAOUcblZFbok
	 gr2gWsKIfgUnJfg1uE2UJj9ibDQYTOl/9IDUWWPKXAzapnYNJotCE0eKBlpTXCxr9ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729950;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=S3NR8+tH8Ja8EZBhStdlVvbKqTQGg0M1Pij1uvAsKrQ=;
	b=gPHO7xZdtmGCsHed+2sxmNJvk3MRdDGlZvhiW4eLgqbEmk6Zn3HleXxkR8QJGycmrOIh
	 bQUfK8aBd8Ff+NsQ6JfufBoEf8GlGq/RrEQKW40NBfW17RC9tVx/rQbNHMAb5Dr1RMINZ
	 Q8QfvzwZKiS+64KPyTmZKM92emsKVGu6bTYo1pKOT/ZIfOdFBDECTrFw3LPwMAN1O6nAl
	 mZ16d8gnIzbKxPP0pgZW2QrNQG8PdS3U5Idhiosbly16/NBE76i9C3bzbeYHD382nyXHS
	 cFtHqeAtrmHftTkf2QRCKIUFXSbKDz+/i3hdl6uFWoufbM7FrOEUIQhb5Fb6t7tETBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vvGvmaZ1;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5369F606A336;
	Tue,  3 Nov 2026 18:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5369F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vvGvmaZ1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8270D1595;
	Tue,  3 Nov 2026 10:19:05 -0800 (PST)
Received: from [10.57.64.115] (unknown [10.57.64.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AFA33F628;
	Tue,  3 Nov 2026 10:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793729948; bh=nPvxwv/d4G12ox+75qW2valPIilnOBTndTK4vYOxYdQ=;
	h=Date:To:Cc:From:Subject:From;
	b=vvGvmaZ1lDrDvMcqhPuv0M7MEcmOV8J+bilz6qRXIJEZKVOrdF/nSV7aYqh0XjEEV
	 6rJVObQvBKNA+SRedd3uUsaUSuXyExcD/FIL2bAN8giT0HDXZy38kawL/EJGIu/par
	 FT9Lbkhmn1iJPGR8vgd/SW6LoUqKnKvAPDu16aAw=
Message-ID: <be3739f8-e668-4711-912c-91459d77ed35@arm.com>
Date: Tue, 3 Nov 2026 18:19:03 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mario Limonciello <superm1@kernel.org>, Sumit Gupta <sumitg@nvidia.com>,
 Jie Zhan <zhanjie9@hisilicon.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] cpufreq: Hold the policy write lock when changing boost state
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The per-policy boost sysfs handler calls policy_set_boost() under
policy->rwsem, but the global boost handler and cpufreq_online() do not.
Consequently, global and per-policy boost changes can concurrently
update policy->boost_enabled, invoke the driver callback and update the
boost frequency QoS request. The driver callbacks also access policy
state, e.g. CPPC updates cpuinfo.max_freq that assumes policy->rw_sem
held.

Take policy->rwsem around policy_set_boost() in both unlocked
callers. Keep locking at the call sites because the per-policy sysfs
handler already holds the lock.

Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc..015962e6c1fe 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -576,6 +576,8 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
 {
 	int ret;
 
+	lockdep_assert_held_write(&policy->rwsem);
+
 	if (policy->boost_enabled == enable)
 		return 0;
 
@@ -1629,6 +1631,8 @@ static int cpufreq_online(unsigned int cpu)
 	 */
 	if (cpufreq_driver->set_boost && policy->boost_supported &&
 	    (new_policy || !cpufreq_boost_enabled())) {
+		guard(cpufreq_policy_write)(policy);
+
 		ret = policy_set_boost(policy, cpufreq_boost_enabled());
 		if (ret) {
 			/* If the set_boost fails, the online operation is not affected */
@@ -2830,6 +2834,8 @@ static int cpufreq_boost_trigger_state(int state)
 		if (!policy->boost_supported)
 			continue;
 
+		guard(cpufreq_policy_write)(policy);
+
 		ret = policy_set_boost(policy, state);
 		if (unlikely(ret))
 			break;
-- 
2.34.1
