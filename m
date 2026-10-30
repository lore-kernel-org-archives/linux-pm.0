Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347876;
	b=YErLFU4qe5z2vqn43TnEMKu0tyAnbwOJ8tYue3r0OjGFZ2iKmnpXiBRMmtYuO35zfacQ
	 zVnZz6Zv8WAe/A+stKBn0yXqVyymyzJSACwv6pDp+QodeqgQ8G10AOGDS8kCcaWJKi9sv
	 HF7sa5i2U/XzxrGr3QACtROD+ujSWk+Zq4pU8UIR38FdCl1lTLxHDhJPzln6oqVY+mKpt
	 JTY3BTLH+g3yD5MVZ7zpVtF+NLGJEjSp5x/B8QGq2B9Q7uwcjvtAEStIBnxGNIVfKHx8B
	 Vyn7Rn66tQ/Ot3fcJ7HsYyiDULsI/PVfvm+7bYBYKyqH8TqIWrbbUTx59OWK25N/7cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347876;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Change-ID:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=krV9rPevm1y0iw7HwKLM2j4q0Lx/o/rTqYyh873iSTw=;
	b=s50WdpXqdXsGF1UJH931BoQeiwNkkUYaX6+dg1LEpxYUYf6cBL3jz6UpTRNEODNcVt+A
	 QtgEnhXMgB4QJKNYbYEGynnhW3cK8p2tO0/jvwa6hbO+1w0GCHfnfNhZrZXfIKb3AKGH/
	 oMiUT5TpZ5T/xYUnPeoHkU+2ldBrW2hfUfBsfyzKQmzLOisKKnCrzYMVZGZiIBmfnM7sl
	 8sBpbRYAkEOqL97CuQjL4mQ02FKp2MFzd5k5axbcVOrTooDkhi/HPnACCqA3BNA4JN3FJ
	 jgKKkW10/KiynFrPJuG9oaHFnrTRXl2bUTEytPy6AZz2qDf0DcQhrtKuAvqTMsLQx4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KqHc0PDi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i8oS+oAt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159E606A31D
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 08:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C159E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KqHc0PDi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i8oS+oAt
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U5FCtU2287123
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 08:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=krV9rPevm1y0iw7HwKLM2j
	4q0Lx/o/rTqYyh873iSTw=; b=KqHc0PDiWu/d7ZMt/OorqRJXCtSshRDzvbcJB8
	xo2VZE2pJoCuRr5WIbd7Gcbmv/fNcOmlMTTxe1IyR9PtGFZbP1uRQOou60WNmBA5
	6Ih4WFrM42Pa68VLb+vbixKL7DgWzoQlppSF3ZRoXdYCWXcyMYwSpzPXP1yvEltI
	UkumPriopkgc3E2i4sUutZ1s2Xy+PJYMePPmjtpGH7KGW4HRFUNkpzJ2bunDwMEN
	ONQl0RtqsCzwyDIqdWpsutrhFoURWXdKQViPAILBxDBcOMImuvzu4agIPF2Mv8Cj
	hzH4CKtL9vJiCePpfpIXINvQEJywwlCgYQQmgLCQ0q5Yf4aw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qhxaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 08:11:14 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-154e9d2d94fso903802c88.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793347874; x=1793952674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=krV9rPevm1y0iw7HwKLM2j4q0Lx/o/rTqYyh873iSTw=;
        b=i8oS+oAt4ZbQ2VViSNYyHycwOROWr+Ezprikon5LpAdjVLgLPg/+QDPvEEdPlcuM7R
         pLZjvuBG+J9P9i++hD/RdjfUvRDLsYm/A6PfcaCczX/3iU5EFzxuE2KfHlnuqJfL/EiU
         qDfa+E3vYridpfX24tjdRv6bV3EGoiXz+8u6sAZprElghoBchAbneNv+qdqS8xFOM/r2
         Bm7fE72WwtZWjaR8WoQRLfSzUrPGmbO+V6S2WLYiO4JoP6XFKONCeVFeuphZA8vwExZF
         rWJ6DujnEx50KKWfO0t8skeKeQu9hIOJBvJyDk348u/+OUzSbjfvEnJIKDsRShGo6Ayf
         FvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793347874; x=1793952674;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=krV9rPevm1y0iw7HwKLM2j4q0Lx/o/rTqYyh873iSTw=;
        b=KEQPwBEpd9qkNKca0gOLqQFDG5HfJoWon7JRlEafsN9/sNFaBHhmksJrjI20JOudrm
         ypS6b9+DicjdKtFZJH7JBi2VGKfKUTCG+Z3baNYn7Gc4jRLYbixeVcJPwHu4TE/c4JfX
         G1Cd0JDa5EK4kXPRIvn48jxtEjeyV5ESTJPSq/68uO0BABGYZwov3FRPOpjPo5YWNDoU
         wi62ZvXCIPocm+vrjOGOnr7m+eBKVh+ynu/KIFcFh/XOJYPi3Ca3halAByBhHTyp+C0d
         h59d5rtgpGZNrpHCSxGgWsvPty/NRn7KlopcTyortSiBgu/8cemD3MmLt1xN40QIR8Wq
         T9KA==
X-Forwarded-Encrypted: i=1; AKwUvBwtfVHg24brfkK9gZy60l+pukxIDANw26ZMSBamtwG11Tv/j2cf/AhNQRArof/41IIrPy0ZBF7tjQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJRAPsK9Zv34N6DD78am/V+pXwnG0XuWQdexTqMNpvt6cUczX66
	7U0FuaI6Jh9tGAKfIXnTbZEcc6yptuue1/8yvpxvQ8Ei7+HnsbywTvuPelUhovlGn7Jg7Koovnu
	N8fKbKZBbbjTNavAhhBLsksC1IL2vuIVDa5JH/GILE5vfxqt0JsmwUF/MK+klYw==
X-Gm-Gg: AYBFou1pEXZh841EXvMMuInL3OqbaNx1N2xyJ9nh0VLYrJ1RzSEINmfzPGm8uaTdfkr
	Dm56XlinckhoGvNnf3y/LBb+k9q//5STmuv2Grj9v9Uc+egpOJ63nRFD31aWFaGDPXb0XgO4Kmq
	9SpGBm+8JOaO5zm2vlaXGb25rB+oKJj4ZSvnhvG3Hjvv6zzrTqdY4IN2kxKcwHYQxCLam/r4ICw
	HBcnU8XbcwIn87Db0evS5f34UJybBPyIY4eh62WfGepan9KKMO8zv0Qb2DXsfhKWZZ1N4HyGMnS
	e7o76N8BR17L40vgmWrSJXGRgjEJj8Q9nvqI7TPdtmdNI8XIlXDug24bS+y4AuKx2zLfnI6fMsZ
	WoFvStUnfG5wGmOWVvaFHj7C45F2wXsUkgl2NEMoYPi+i/EE9dVI5/KTaZ/44q0ITNBEHAMiPMt
	GOzUAXSF7A9H9Zoib7fD7T4uw8TSLx1Q==
X-Received: by 2002:a05:7022:3c04:b0:1a9:c52f:655c with SMTP id a92af1059eb24-1ac5c555f7cmr2006779c88.36.1793347874063;
        Fri, 30 Oct 2026 01:11:14 -0700 (PDT)
X-Received: by 2002:a05:7022:3c04:b0:1a9:c52f:655c with SMTP id a92af1059eb24-1ac5c555f7cmr2006731c88.36.1793347873397;
        Fri, 30 Oct 2026 01:11:13 -0700 (PDT)
Received: from QCOM-utBXLfHQRa.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac194b5437sm5706777c88.13.2026.10.30.01.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:11:12 -0700 (PDT)
From: Guo Chen <guo.chen@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xin.liu@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        tengfei.fan@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com
Subject: [PATCH] PM: EM: Rank boost and non-boost frequencies separately
Date: Fri, 30 Oct 2026 16:10:56 +0800
Message-ID: <20261030-em-rank-boost-separately-v1-1-238a6b2bb888@oss.qualcomm.com>
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
X-Proofpoint-GUID: I5vQv4OJjkz9BRyh_8AjQumMjy9JTSLR
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae45122 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=2hJP1i3fRuUWVGmBDcQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzMiBTYWx0ZWRfX97PnwzSUaV08
 Ndl1g82LtCi2wowhW8+l9Ay7krwlg3vn6lwkhNqyfEqtOGRSthx7wnouwvSkk0ZeZYqXzyFPw6u
 oq+s26iCfASRW9ihQgTrv3Q3fJz+897xXT0vDDAwhYniaGCFowEeV+rHZNfzpufAU3DKUQlaYwx
 tzRHlZz01er3vWPBbJc9tBd5wrNQbNSu6CN83lVmVr78n5SrgnVY3P8dzV8hgg1cqS1IcN6tes0
 zvS4IW6rhU9fm3h4cq00RLjIr9gL0xCtbSiayTF+cdvlXeA2E6dQzaiDF7v9c/rn8GRkNtLHY0x
 k+KA4sYDhMjChXLZUPpnq1alclG7fhPgJ7Fidwq3fCu55gQ52SUwoz6p7RoaQaYH03Y4LitevXP
 0RIhAitkwZdllJE5h3dUZu1bX3pCNL2QacbWNvJE3Dt5efR+kqsdYFsuaPYYszzzHD32rvYGgiO
 8uViGGAln9bMmExOnRg==
X-Proofpoint-ORIG-GUID: I5vQv4OJjkz9BRyh_8AjQumMjy9JTSLR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzMiBTYWx0ZWRfX7hE86OWdiOoZ
 Ei2sFByhUhbd+lUtEw6nJz3kU6MKMyiI3saRy8FlhGtJh5mthb3vl9faXVSR3IYxKdx1QF8X5Qa
 m53o9DJt6LIYXUA3Nn6xEqYoZQTH0Pw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300032

em_compute_costs() ranks all the frequencies of the table, boost ones
included. A non-boost frequency can be marked inefficient only because
a faster boost frequency has a lower or equal cost, e.g.

  3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)

With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is still
skipped by governors rounding down to efficient frequencies (e.g.
ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead of
the best selectable frequency. Several frequencies can be affected.

Rank boost and non-boost frequencies separately in em_compute_costs(),
using the highest non-boost frequency of the CPUFreq table, returned by
the new helper cpufreq_table_max_nonboost_freq(), as the boundary.

Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
---
 include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
 kernel/power/energy_model.c | 15 +++++++++++++++
 2 files changed, 39 insertions(+)

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
index d19a65461ae8..253c53ca6a74 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -255,15 +255,30 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			    unsigned long flags)
 {
 	unsigned long prev_cost = ULONG_MAX;
+	struct cpufreq_policy *policy;
+	unsigned int max_nonboost = 0;
+	bool prev_boost = false;
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
+		bool boost = table[i].frequency > max_nonboost;
+
+		if (boost != prev_boost) {
+			prev_boost = boost;
+			prev_cost = ULONG_MAX;
+		}
 
 		if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
 			ret = cb->get_cost(dev, table[i].frequency, &cost);

---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261029-em-rank-boost-separately-a7e7c7d78058

Best regards,
--  
Guo Chen <guo.chen@oss.qualcomm.com>
