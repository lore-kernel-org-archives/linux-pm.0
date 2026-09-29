Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B551615D
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681927; cv=none; b=q9ehNATpWURRtIbk/eavEu5RgqKh1nGjKUNVZnUos/cDtGMeD/Oa2DuCQJz/bDGGPr0hHGcLv6iYeJwLALR4H5Hv3IUk042j6qR/21UVo5QJPf1/UNhXAmQzICfibPSEJzTFURGFDlLkpH9v0geixhidlsvdnH+/sUwLrk98TRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681927; c=relaxed/simple;
	bh=IRkPQ48QnFX19GoN/M4c8BIX+Ad9l2A+S+ag7idBrDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETQ8zsxc7Hn9aX31pFBAiWjFO6DZdcyM7NBGcMdO7/qCwIp5YdlsYsRsPuQ9UozosOm8RuTBe797eXHpH+ckWDS1BCXCNNOW4f1ULpVE9e7FMxi2IdxxtNt5Eg0vb+yys5MQHfkPOJ+rIHpuIPGY0YnPT+rOnkCmAJsmzFoN6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y+ToRTXC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OYB3IP9P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y+ToRTXC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OYB3IP9P"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAj6q4335139
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sjuBHnNOqcpw5ApUs2RooCq8aTsOYyQ4QeK2GhXHYlI=; b=Y+ToRTXCNjUAfeFE
	C/6ElZeFVpKv0drkZ59SiNBa+mh/wd0ne1qZtFd57k9DSn4zDhaGZvxxXJzDztYF
	6VVedoYihiJ36xnYCLBMCqeCNntkxyElKg/T8/aqvBKPIWfOzjHaC6zVcb7wiLGs
	hAtoOwhPMnm7C/YPyd5xuWTafLsMyAGzth881TIVaaHJpOPufD5fcR/PVbrWSzR4
	ZDf4o9vx3iJm0Fnr9VIFNneyuNH3yRvvTht1sgj3j14CqUiJOfRnzYLGYSDf13AD
	0pUl7dnf++XUSCbk3wcyFN6S2uBw9WRw74yJC/5tcPwxKQ6/lvdkbwCgS6JcxM5t
	zy5wbA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew27ey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:38:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34afa104860so1096992eec.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790681922; x=1791286722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjuBHnNOqcpw5ApUs2RooCq8aTsOYyQ4QeK2GhXHYlI=;
        b=OYB3IP9PGBAV9ZEzdIVXCwsJdxhNEVZggdJyQ3jqrq0rqUtSziWhBpAGGVR89sjhs3
         fWnJrfUnFDenRBnA5QGyHf9D7+Z8rwAiMABPL7RiRnUbhTYNo4T3+f8tEuN0k1XlJyn5
         vC39I9mPs2mvJzcgzBKmp29p4WEggiDzh4SLDUQSgvJk+FBpi9j2E/0STSALv/STc60u
         76QYN4nL3x7zXgaHzBmRmeAcqrrFOudN3PJBlms8KOwyt18rdrt69ZCOGMOqhzJeIynB
         +Axb9flijYtUd8KkzJp9uhVq8M+Jtzl1SdpQQmTl6YbHNFJHUUvoa6+HMGzNygMahZKy
         famQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790681922; x=1791286722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sjuBHnNOqcpw5ApUs2RooCq8aTsOYyQ4QeK2GhXHYlI=;
        b=0UEyvXuk980jD31RJR0Jg8k90e7zjujozV3hSaIGFXCr4OJ2FvsggC+L55gE+t+qr8
         uwUosNBYK1vcSQRUwKfD17hUcvxbgq7CFtoNCksJR+CsICsGftW2OM0aZNXT6UIlcXzL
         4rFnbSgMtDLPX6CbrE1jzHDHpE/hI0MlHlgZGZmpQC80HVo2q//dpc6tBA6D9kaN+sWd
         YKWoABeiQI0O2S4wDMx0wJQH1i3+832/gvZm3ATpRr94UGoCedWusxBcHBtrb7eeEf9b
         8x4N73dQPEzNIyroZna9wY3ZPQC/+U9CmwtIzCt+1m+7Tsj5tv3I9LpccEflI7g2jlgk
         gebw==
X-Forwarded-Encrypted: i=1; AKwUvBzeq0oOUJIrlPm2YIM6b9qBd9qW7rmQq9adnx3KTIrIIpaQLeVhp/YDdl8xHvX3u8ycRcSb3W8ARg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLgDvqJmXWTDpHndWo1rjBvEmTCNwsatGzrbItOpEGR8Fs2zJf+
	uicDc4wA9RiBngvYfN3sCzUC85gK5Shcrh0Kj3fW200Ue7zVdDr0YlBSQgl+EViVeLhU8y/zst7
	PJruJRb3CCE9dY4LW+h+tgnUMRrhYKRyoilV7e1qTL19HpsXwBsr7Yy7UkT30vw==
X-Gm-Gg: AYBFou0MpA69SWU/KgmMjk8nrZUz6voPfAvzOCRKG53HIavRcdu0Tdb2CineZN2PHNG
	e3+yJuWSF1dDCOhY2TJmPIdwdgkXVi68GbANMpF+qGjbFFhv/JWqOIbHatvEzm/ymwv4weZXfNN
	yKJ5WjKzuX7n7+vt5sZSPakMGyyX8q0ac9hsrTx8+dddbS6mSWWGTqqU22xW+yEJ5R9AzNUO7BN
	EaR0TtZs1XTjlpYukQyU/otwW8zoyHXPWy5jRr9ijiG+FgqzpRRtkY/ZIjGWujU7SApSB0Edfq1
	U6trZHOslFMn2XsNMpwfS86THT5CWtdCLUEIahSKNpIAoerU2t2cehGMJ0LBWJh9rjcycot1xIW
	y2AytLkvoJsUL6w5z4umsj8kPPw75DT+MKJltaMmYdAdbx30q18LNpKb5x14H77UvFcG4+n79Re
	Ay95rPkHVmlYL3gnE=
X-Received: by 2002:a05:7300:b90a:b0:343:4dcc:d29a with SMTP id 5a478bee46e88-3434dcce606mr16197163eec.28.1790681922089;
        Tue, 29 Sep 2026 04:38:42 -0700 (PDT)
X-Received: by 2002:a05:7300:b90a:b0:343:4dcc:d29a with SMTP id 5a478bee46e88-3434dcce606mr16197123eec.28.1790681921508;
        Tue, 29 Sep 2026 04:38:41 -0700 (PDT)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm37145604eec.25.2026.09.29.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 04:38:41 -0700 (PDT)
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 17:08:07 +0530
Subject: [PATCH v3 2/2] cpufreq: fix policy max not returning to non-boost
 freq on boost disable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
In-Reply-To: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oleg Keri <okerixx@gmail.com>,
        Ananthu C V <ananthu.cv@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790681906; l=4806;
 i=ananthu.cv@oss.qualcomm.com; s=20260903; h=from:subject:message-id;
 bh=IRkPQ48QnFX19GoN/M4c8BIX+Ad9l2A+S+ag7idBrDI=;
 b=IXje9iJZJznKOH54JVQd3nu1rEXtSKUyWr1zXv8ANd3q3Y8tn+bLjdFRhZ2pBZa6Imz3RWOHQ
 c5nkPHitCXICHMBd9pYCH1G9canzcpyjXv521zmVY19/DHGmPvrSL48
X-Developer-Key: i=ananthu.cv@oss.qualcomm.com; a=ed25519;
 pk=gutNfLSMVTRkB+MxVviMFq9I07C5qPe9xHY2J5XCMpo=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NiBTYWx0ZWRfX+eVbWd5X2JFl
 eiL+QmhuBoPIDmvdZvedaCuY5ZZPVdM08TpB22zNn+0V0ssSx/K1rDtvk3AFQ/YmwOMepOkofiC
 2YtQUWpb9ZEVyLYpIAJU7X1WHMKMdGY=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abba343 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=2yvpktbjYSEXaF6n4vkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NiBTYWx0ZWRfX3RGHUB7FpGsx
 ZP/2La1bPw1szgA+FVCSDfE1MXt6hI4bAyE86vLPJLkMNx6n9ymkUC1YWXC9h2Y7QAuu6v+u4T0
 VWbIYG4Cdb7/yPkVMzlGEfrYi3Xz2PFUW3kG8UKJ20G/+gtjoRss4LzgR998R1OGlK4ptZffK5z
 S/TnTxzJE7VZWbhYnVaaVvMTUXYsKN0O2Q9Szs+WUtB99FyfFGK9vPMrQH9aBrevgYKCj6YhiFb
 3t12uBZA4Zl5bXGKd45TUh+RJUe5YyUJqSEfZX3UG63eGhmfWRFD84erwTODs2wHcT6OAQFiiMn
 rlNm5GORDKw2dU6Y+Q5KNpdWoYcg8HuF6MavZSNczXGY/BeBAMjz/VJ6siiL+nG1V/6DCOqKS8d
 X7fjxfRWjVUagB5zHlsUbzCYEiU0t4q+YStqRfhtSmupWAwAqCqvgmI2lkaKZCgd0aMLtrzcGrM
 8pccl9jmxwDY+cgbqOQ==
X-Proofpoint-GUID: oALN3nj9XtKMY8fasfwKWL-KjV-rXLTd
X-Proofpoint-ORIG-GUID: oALN3nj9XtKMY8fasfwKWL-KjV-rXLTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290046

Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if
max boost is known") introduced a guard for cpuinfo max updates to only
increase, to preserve driver-set values above the freq table maximum.
Later commit db80ad776cd2 ("cpufreq: Remove driver default policy->min/max
init") dropped the 'policy->max = max_freq' assignment from
cpufreq_frequency_table_cpuinfo, leaving that one-way-guard to be the only
path for cpuinfo max and consequently policy max to be updated, causing
both values to be stuck at boost frequency even when boost is disabled.

Unconditionally track the highest non-boost frequency (max_base_freq)
in the freq table. If boost frequencies are available, use the highest
frequency from the table/max_base_freq instead of cpuinfo->max_freq to
control boost values, so the value can decrease again when boost is
disabled.

Fixes: db80ad776cd2 ("cpufreq: Remove driver default policy->min/max init")
Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq.c    | 16 +++++++++++++++-
 drivers/cpufreq/freq_table.c |  9 ++++++++-
 include/linux/cpufreq.h      |  3 +++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 96515880b4ac..5e6afb6f8826 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -574,6 +574,8 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
 
 static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
 {
+	unsigned int max_freq;
+	unsigned int max_table_freq;
 	int ret;
 
 	if (policy->boost_enabled == enable)
@@ -587,7 +589,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
 		return ret;
 	}
 
-	ret = freq_qos_update_request(&policy->boost_freq_req, policy->cpuinfo.max_freq);
+	max_table_freq = cpufreq_frequency_table_max(policy);
+
+	if (policy_has_boost_freq(policy)) {
+		max_freq = enable ? max_table_freq : policy->cpuinfo.max_base_freq;
+
+		if (!max_freq)
+			/* when the freq table contains only boost frequencies */
+			max_freq = max_table_freq;
+	} else {
+		max_freq = policy->cpuinfo.max_freq;
+	}
+
+	ret = freq_qos_update_request(&policy->boost_freq_req, max_freq);
 	if (ret < 0) {
 		policy->boost_enabled = !policy->boost_enabled;
 		cpufreq_driver->set_boost(policy, policy->boost_enabled);
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index ea994647abc8..820ed4559f6c 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -14,7 +14,7 @@
  *                     FREQUENCY TABLE HELPERS                       *
  *********************************************************************/
 
-static bool policy_has_boost_freq(struct cpufreq_policy *policy)
+bool policy_has_boost_freq(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
 
@@ -27,17 +27,22 @@ static bool policy_has_boost_freq(struct cpufreq_policy *policy)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(policy_has_boost_freq);
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
 	unsigned int min_freq = ~0;
 	unsigned int max_freq = 0;
+	unsigned int max_base_freq = 0;
 	unsigned int freq, i;
 
 	cpufreq_for_each_valid_entry_idx(pos, table, i) {
 		freq = pos->frequency;
 
+		if (!(pos->flags & CPUFREQ_BOOST_FREQ) && freq > max_base_freq)
+			max_base_freq = freq;
+
 		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
 		    && (pos->flags & CPUFREQ_BOOST_FREQ))
 			continue;
@@ -57,6 +62,8 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 	if (policy->cpuinfo.max_freq < max_freq)
 		policy->cpuinfo.max_freq = max_freq;
 
+	policy->cpuinfo.max_base_freq = max_base_freq;
+
 	if (min_freq == ~0)
 		return -EINVAL;
 	else
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index f048c925fd98..7bb58405e004 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -45,6 +45,7 @@ enum cpufreq_table_sorting {
 struct cpufreq_cpuinfo {
 	unsigned int		max_freq;
 	unsigned int		min_freq;
+	unsigned int		max_base_freq; /* Highest non-boost frequency in the table */
 
 	/* in 10^(-9) s = nanoseconds */
 	unsigned int		transition_latency;
@@ -791,6 +792,8 @@ struct cpufreq_frequency_table {
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy);
 
+bool policy_has_boost_freq(struct cpufreq_policy *policy);
+
 int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy);
 
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy);

-- 
2.43.0

