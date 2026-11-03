Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704902;
	b=Iw1/DzSfSVzme6katYm3G7Ni8+AjGZjnIs01DFLFEy8eEijQtXcjbhefz7oKBeI8gavz
	 2e6mmZv3h7fL1fu2XZtmld/Z5APjf7zriL4NK+bnC8bQVUXBP7aYiQkTcNWqCzd20zY0F
	 w5q7jc1PlyrfquiyDCYnSkGzZiWUIa95y/qbWauM8HbvcAmKd8516XQBseeFNhedt7+/N
	 C4/bcPq+dLRgaTHjtWzx5hJg1daUsrk+OKPZsY2dpmnHigw9gUy6tXLQr2XXPMts8Nx33
	 /2MKwGu5yaZVudfK9q4K4BAs6bGfA/Tu9UlAyBn+2HJb4c63gXFvFQhaD0Hl6x9aPSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704902;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Change-ID:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aSwLV1CBcuXDV7sv0OALbaamU2BuWrR2qGPK92B099k=;
	b=plSqUcHsvsTa5AAs8f3wwfQhAYe63FtkJKfDkF8f5d/OH7zl0r2lJYnJwTR2zf7B4YOa
	 MmwaUBb3F56sZg2mFWKbs7P4FUvLQZyyk78SA+noyVpo4dSUg/2n2yWoCHlzYEHpPKfOo
	 JGZsSrgxwCeoAI4eEeizCyFm2N7yDLvs/CmByenyPs08n5WL9Y4TIJwkmNPjV/Sf+tLxe
	 9vnMHCDVWWjQOcM+FSyz1UDkEhYJZ8SVS/V24a3LhICox80N8AfsLUmhG9d3FfhcOuJLJ
	 DXeeyiMX7n9FXcjpsqh524kv0E/MBABWFOv1jxn8pvQPkv5wv06Uh95+u2C7dcIZWkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P+1cc2w8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PnXW6+U0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A0606A82F
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 11:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D81A0606A82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P+1cc2w8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PnXW6+U0
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAHHs2522092
	for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2026 11:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aSwLV1CBcuXDV7sv0OALba
	amU2BuWrR2qGPK92B099k=; b=P+1cc2w8oJC3yzQgPPiOqHDtK7+2IhP2qRDRGz
	S9kjt62s7L+Asd8laUMgzkWuhZkN6p6mQk0SvKq7Qr5mx7k2XP8B9OUw5BihXeDC
	XvB+cgBJA4dWljoUDfd7Aw/esJIw9p/CG4t2kdI6lQXfv3fqU3hmZbNecT0hw55R
	8gNmLOdbV+4Kkf4nAfg4fTWPOE4CuuoU2wqiHPTxS2g3bTvtBsFWYle+Xh+oknPC
	xL09gWMxwPTJ3jzyxclbO1YJAr60mFLflYTIJsFDKLN9GjFycf2zSZeLzIcW0aHK
	RNdxa5FGr3cHupXZ83lsuugz+SBEz3qYk5vlErHuO8Z1OReQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5jd76-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 11:21:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e869e00005so62408115ad.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 03:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793704900; x=1794309700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSwLV1CBcuXDV7sv0OALbaamU2BuWrR2qGPK92B099k=;
        b=PnXW6+U0Cm8yWp9a39792Ai2IMyIiN23LmPSbsEQxOe7YRyQ3MIUck+KHh/9syB8jz
         1E7bhFc0g9CDCuiVd+y0ka9T2hTFJC9GOKLgGzaRlgLfvJo+qv7ch2zWqz57LOCFs4RK
         r9UMIb78MZBR3trW6rMJ1X4CDqvDQ+lJPC47Y5Rwri7Hok6Vl9KTHnU9YujavfrR0zyN
         8v31X3fMxNQGyYLroQC3GqPR1Idz4pM/l9VCHsOqM7JAwFBYshZFttEq/rO4Vd1MTTua
         rBCnbFY5pT6FxYnjeSPQb7RyuVtKP7LmtkPiN8J/rsanQh/dXdVEQEN75e64BWJ1E4cx
         xgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704900; x=1794309700;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSwLV1CBcuXDV7sv0OALbaamU2BuWrR2qGPK92B099k=;
        b=g1JCQ1BBy1mHibkG+wOrSpKV+brspSSoZHQuN505UQz6LkH901i+NngHCBmCEiz14z
         nh0bcJe7LmcWOvlp7SM3M6QU1RbnSJ8KQSMp/cg+1CCwcPhTxrDZCf5rGp5k0rcpVlv7
         zxcx6BsTgQa51qXg0ZJkd6/R5R6VXtLCQo3/IJL8AyOY9NpMfiyjNONUiOBCgelFAsjc
         r0e5VU2GbvhgCHf7860IuXLnYdVryG5Mjy+E0qDlTbBQD7utP1WHLDLCyQGn1pNj+ArB
         H2BOGSCjLr9bOpq8yJJLwH//yaV/1ik5acz4dsubvVoqMRjBNLyU4xoEGfADkEOuS5cT
         tlhg==
X-Forwarded-Encrypted: i=1; AKwUvBwsn9d1GAMA0sd/LwLUgnlOUn81WI1eulpBDrLwnNwIxTUigcgxkoGYBZVUsKUZLd/GHFm5utenJA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Du8qizfSCPFPtzdyQrxlveRlQDemZwYx2ZbUO0siTLbqLdqGR
	nq+Kdl6m43rZsZMgFOu1ZRq2E5VrhpYzkPWsQeJq12gdOnWKnopsJQFiD2frFwHyXBpvkuYcuQo
	1WCXEobP5ycIW8Qr0nqLWrwY+LNKMcKWJtGJzvb12jHlFqkhNaQU9bFA6KGpNIw==
X-Gm-Gg: AYBFou0U0d57bOj7GVKxqI9IMe5qNP4usC4g8GZqFnZaEExv4KdocID/GKSXc5IUn7t
	45W7413y/r+AaO2zU4va/uc6GPP9HRIMUoOF0KaPVoZrM6wxQo4aILW+6TcUNDLM4XmHsQYGdtR
	aAhqi0oq/rJ7GN8xf5gH/2k90O8BZaGAZxLjseIVGWHuVOAURPZN/RBYWZHr9mHTa8kzz2Yg02o
	VQDzoUp6ZkyslNF7lrjPiMLCgQ29++kTnTeC0KIWRBfL0eYmNDaZn2g8RUL/vCscU84SnuTKvYG
	IeavR5iUUVA+JUnC3giyOjCKIarlXGwRggqNtRW3fCGftF/9iM0q372HY03eYWhUh092twAw0Mm
	TuqLrSuczyOUgyzuYBlmbNX1P8WG4vs/yMA0mvpCkckMPRVafXWLR1j9DictuDGEhri2dzw30RS
	qG9eLDPO8IhRgwJSPZuy3cFw8asOI0
X-Received: by 2002:a17:90b:224f:b0:3ab:33b6:2c27 with SMTP id 98e67ed59e1d1-3ae897c93d2mr10975171a91.23.1793704900295;
        Tue, 03 Nov 2026 03:21:40 -0800 (PST)
X-Received: by 2002:a17:90b:224f:b0:3ab:33b6:2c27 with SMTP id 98e67ed59e1d1-3ae897c93d2mr10975145a91.23.1793704899707;
        Tue, 03 Nov 2026 03:21:39 -0800 (PST)
Received: from QCOM-utBXLfHQRa.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm4135296a91.13.2026.11.03.03.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:21:39 -0800 (PST)
From: Guo Chen <guo.chen@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, xin.liu@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, tengfei.fan@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com
Subject: [PATCH v2] PM: EM: Exclude boost frequencies from inefficiency ranking
Date: Tue,  3 Nov 2026 19:21:28 +0800
Message-ID: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261029-em-rank-boost-separately-a7e7c7d78058
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6wV0_JUQN_9b0ktWOXyzhdNz-IH9uJqU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX3X+hGCg5Mnw4
 UDhy4BlXLzKkN58fREzEbXUNonfDt3MxVQRt20tknwPAvUbtB5dCFr6q/s/ZWoudk4pBm7Pfc+b
 SZKfElhHOw+K6qcZPTU0F5m4oZqp/7n1/uEdTkX4EjkCKwGyaU+747ZxYQc6sfreOF3n8VQ2SAR
 51fh+d7OFy/MmH46ygqSJDx95bwrSHtRNZmMEFCmcGp50qlRMW+QzOLmht+NH3o1fSI54MgqC69
 jeXBa1dfk6NbdixkBp5GyJUYsLDZbpEnSgPW60LU9wSo5Y4P7MKcPnweBW/izN8COOgNlmlqlu1
 L+J6jPaMZ17/s6QcaWtaUQN+r/YYDbMdZhDk8GCAt3Df5d8sFAWqRnlHWaRaQDakq51guaIEUWW
 eyu5yVGnVgXMgZRilyKteeJVJacO6vr+5mw3D8zMFJZzDZYkP2bvCS5t9NFWN/uzg1RcYjjwZtZ
 jJpGiSjheXMLlXJMyYA==
X-Proofpoint-GUID: 6wV0_JUQN_9b0ktWOXyzhdNz-IH9uJqU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX/Df2NbVezbLr
 6/iNiWWGOD7ARFXx8C6DGcHBHuceCYa99U8s11zmA2mdmT8AQFuq7Ii2Cun1I86V3ycgfnRhoBk
 Sz89o60xjrG586fTVI7B8ws3brKkLc0=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9c3c5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EJyEkKy6ZwYBekfyMqcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045

em_compute_costs() ranks all the frequencies of the table, boost ones
included. A non-boost frequency can be marked inefficient only because
a faster boost frequency has a lower or equal cost, e.g.

  3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)

With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is still
skipped by governors rounding down to efficient frequencies (e.g.
ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead of
the best selectable frequency. Several frequencies can be affected.

Exclude the boost frequencies from the ranking in em_compute_costs() and
keep them all efficient, using the highest non-boost frequency of the
CPUFreq table, returned by the new helper
cpufreq_table_max_nonboost_freq(), as the boundary.

Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
---
Changes in v2:
- Drop prev_boost and keep all boost states efficient by resetting
  prev_cost for them, as suggested by Lukasz. Boost states are no
  longer ranked against each other.
- Retitle the patch to match the new behaviour (was "Rank boost and
  non-boost frequencies separately") and reword the commit message.

Link to v1: https://lore.kernel.org/all/20261030-em-rank-boost-separately-v1-1-238a6b2bb888@oss.qualcomm.com/
---
 include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
 kernel/power/energy_model.c | 16 ++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d3d0d9d02aa4..c93316141a11 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1155,6 +1155,24 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
 	return -EINVAL;
 }
 
+static inline unsigned int
+cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos;
+	unsigned int max = 0;
+
+	if (!policy->freq_table)
+		return 0;
+
+	/* The table may be unsorted, scan all of it for the highest one. */
+	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
+		if (!(pos->flags & CPUFREQ_BOOST_FREQ) && pos->frequency > max)
+			max = pos->frequency;
+	}
+
+	return max;
+}
+
 static inline int parse_perf_domain(int cpu, const char *list_name,
 				    const char *cell_name,
 				    struct of_phandle_args *args)
@@ -1219,6 +1237,12 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
 	return -EINVAL;
 }
 
+static inline unsigned int
+cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
 static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
 						     const char *cell_name, struct cpumask *cpumask,
 						     struct of_phandle_args *pargs)
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d19a65461ae8..5b1d095fd376 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -255,15 +255,24 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			    unsigned long flags)
 {
 	unsigned long prev_cost = ULONG_MAX;
+	struct cpufreq_policy *policy;
+	unsigned int max_nonboost = 0;
 	int i, ret;
 
 	/* This is needed only for CPUs and EAS skip other devices */
 	if (!_is_cpu_device(dev))
 		return 0;
 
+	policy = cpufreq_cpu_get(dev->id);
+	if (policy) {
+		max_nonboost = cpufreq_table_max_nonboost_freq(policy);
+		cpufreq_cpu_put(policy);
+	}
+
 	/* Compute the cost of each performance state. */
 	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res, cost;
+		bool boost = max_nonboost && table[i].frequency > max_nonboost;
 
 		if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
 			ret = cb->get_cost(dev, table[i].frequency, &cost);
@@ -284,6 +293,13 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			table[i].flags = EM_PERF_STATE_INEFFICIENT;
 			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
 				table[i].frequency);
+		} else if (boost) {
+			/*
+			 * Keep all boost states efficient. Resetting prev_cost
+			 * also keeps the highest non-boost state efficient,
+			 * then rank the rest on their own.
+			 */
+			prev_cost = ULONG_MAX;
 		} else {
 			prev_cost = table[i].cost;
 		}

---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261029-em-rank-boost-separately-a7e7c7d78058

Best regards,
--  
Guo Chen <guo.chen@oss.qualcomm.com>
