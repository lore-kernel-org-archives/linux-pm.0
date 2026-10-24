Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792882588;
	b=toa+yJqfH1jZ/c56xmeRK0zDF7337fMyyX6lIRCPTnvCrBXKUqy8Ojm6eRVUR3FOJkQB
	 /THnUzzb+VQmGBcE8t2sowL2dkBmtFcRrGLYHQhDVYL9MLFpLEN7EG6abbHnCzKMH6T25
	 l41rJDliXLUepvs4bTPp2555yxN/0GR4aLbDKiqhSs+21eDs4iJ0KwYIAZmqOWdZXyAJ4
	 xTR6y6U+ueBRguP+SJxqu4/U9HJQ0gOOwXSP0sS/nJxIPs2gFdyn0ATcf99DwlLBzNFqw
	 1ApA0jCFdm0Y/m6wBvzvq7THm6EAz8fpKSKeOJt1lxlO+O86x+s5wCUNttmiuZl/rAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792882588;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=f1HiuzAgbnoiP6XLEgSVQ76HAxeufd2AMG70LmlGRec=;
	b=wAy4E11x7KJKeQ2Cr+0aWKP0sGcuuvb8P7puU0KjJjhLh/Vt9KVxNxox9uKFLTRFSEox
	 y15i5wC/7PfJajzlFK1QjKGmoUFzlaRry6gWwaOBYhvFKJMjc7VpM9pbLmYpOl1kiq4m+
	 vWFomPZyqhBqHFvWFgRjDij0PkRi2q6QHRfkE7wPdLl2OaC98PDmpdpiLn6AH/Iq2CnC2
	 OiXko/nnlnDkahBniDvECQdTECJ7Q/XV1W/4fGkurjOQhipuXhFApZC2ABuPHLyP6/PEG
	 qjn80q0q34JqrNWMwgLvvLxz4bbw7yHSgZCSpFBThodNy9H0KnPF2noxSFhaGD/tTLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PizwXrXp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FGtEvaxW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD6606A332
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 22:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44AD6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PizwXrXp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FGtEvaxW
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69OLbmWD3170261
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 22:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=f1HiuzAgbno
	iP6XLEgSVQ76HAxeufd2AMG70LmlGRec=; b=PizwXrXp+SPjrmqdYg9i6ij5B1G
	TZmW+sBXMnfz2c9Y+aqxy87GCWrhPL0G7LlSKAYx13IGlAGMpRLJoPInG4OMH4hH
	eJIFRvx1Vgz3lmQix8QsLjm/kMdkOHTO9XIHp/q97OO+KxiUBOPzuhluNq/YHunh
	g2lGmA+HI9Yc1DrczktFzBFiZ2SJM6D3rfUmb45SfsCfZ/Vun8x+YOQg1GZcDo+g
	7noF6UixRadUdlv/nWdxoo3v60x9gwF9Swkt4D+uyWj3iE6buZ8jUdm34plvOiK9
	Rq0koMe/EHpLMEIHVYHwgbn453Yp1uiimiIWVIESeUol7c3WZ1O1bR3WVRg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6j3ff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 22:56:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f62934ef6so116741285a.3
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792882586; x=1793487386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1HiuzAgbnoiP6XLEgSVQ76HAxeufd2AMG70LmlGRec=;
        b=FGtEvaxW5KKcAB5khzlZF5TTY0puzq5/dNS4AYRkBQ2kV4v7U4wed65MbME9/sbbl8
         IZo+1wYfn6gyhugmRvqoe8m3h1pksqqzJDB+ChCgv3A+JZlpXKgo7TDnnGGI5rw3c9ts
         zLXOeid/TirWP88v12cr4ti8U358o57nw+taK7+T/SKFGfBDBRIFHgGh+k+GSxQpT4x3
         4G+fM84/ZGRHPnjpAql73fM29E+wQnBbnBXeZOZgsCya8haC2Iexx7IxXVZ7t/hk8L5q
         esQjhthhcCnzeFyAMx70Q1LY2+McRh4uUA7OxSMPNbYJ9cZFv7QW7lchIomUou10QowN
         vKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792882586; x=1793487386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1HiuzAgbnoiP6XLEgSVQ76HAxeufd2AMG70LmlGRec=;
        b=Sb5+E4igniBsEkQIqZ84a0qG7P9YB2RcK1+6vMIZnv0UD+GZHKGZNvriMR/mJ99/KQ
         VEcpwJWsleqmgEoLSVVjrZh5Lfe8qvU/C1IgIJHLJxthfnH6xAImLh3zRxcY9Myb8DzI
         irB2X9R00h8okVaFZfUz5F3NTLs1z2OYTkyjGXN4PpqLdc7paK1bGk8jsIKk0P7QM+SF
         FTTD0Uca+eyTsLoE6BCpEgq4HPO95qdJUphUXF6nlxrvdxiF7atI+9aO/C4yOrp1oWxU
         Q+Zix1z/Sk5g7bgKFFqWn6i+fNEU1vCwhKXmAxO41dub86KrgiP/pHmaqYfQpn7BqfFL
         r60A==
X-Forwarded-Encrypted: i=1; AKwUvBz4j9X4EqOQ4ukkJxtiG/cYWVLoCdVlNR+YYQqp83fQ7UfyVXj44mhpI+YCy1SB0MbjTOxR6Y1WIg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3JnDIJF+2soC9RXpzp3zdSWvbJZ6UbU879usCAG8srDR24+4h
	J4qcrfKmeKtmRxzup7im4MaQZCc67AQs0/WFdvD+MCefCMyCzVBoxDHpOQIHagmt+bBZM+F9fuA
	fMlj2EsE1zXfGnqkWxPThUipMWWWUs2VqGGX+frsO1m1IYfJEDlams0Zia3hATA==
X-Gm-Gg: AYBFou2gt8FqSPXkX5P0MRAKFaiWAc5LP8X2X8WjDEFarMj+47sQVkVgT27qiiaZvwJ
	r+EmCVGYJOtosHIFQQ4ejXCE7bAzzCW5szenEGiScxNyzYoBopFW/g5SsOEvIz2UfUzWhli3ItX
	7hnSWXsfTBcfTalHhy046ISGeglBgeodm2EqB2V66Wq4Q/0cA84neSNL/bSJJIjAHrP6PyOL1fs
	m5ovTMShweU1tPWXJOQtzViCtc34r2uTdMUGPS/fDND7idUeKc75cuaNQGDeLnzxZCyodzdaEOg
	uBExxKdoo5tVNJoFXC6JmwXTygNTuSOHiXOO1VZyzLVf4Xi2ZcW/2we/0p48j74oravymRh/RdQ
	IOfy/WbsBSua5GThBY3O7WJ3Hhlo=
X-Received: by 2002:a05:620a:4042:b0:93e:6325:ae6d with SMTP id af79cd13be357-940ef8db90amr453551885a.40.1792882586493;
        Sat, 24 Oct 2026 15:56:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4042:b0:93e:6325:ae6d with SMTP id af79cd13be357-940ef8db90amr453548885a.40.1792882586057;
        Sat, 24 Oct 2026 15:56:26 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359ff2189sm98564145e9.1.2026.10.24.15.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:56:25 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 2/4] platform profile: Complete class notifications and registration cleanup
Date: Sun, 25 Oct 2026 00:34:27 +0200
Message-ID: <20261024223501.1420953-3-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lQanCTH6EozPYb3Jy3CGbGgpNA0uciQM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA5MSBTYWx0ZWRfX6UDbHsJrYC+i
 Ik6Gy/ucBHEwW9PBWmHUDkCwQZk/9UemIUBuBZHFu+DgqnL5PemklzUewJWUTo8ULQTXZC4u+U5
 5GnbT0pdGAOBi0BFTtfeN2aTFa1IobU=
X-Proofpoint-GUID: lQanCTH6EozPYb3Jy3CGbGgpNA0uciQM
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6add379b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=sNWLPp6fUqVo4Qx2xT0A:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA5MSBTYWx0ZWRfX/TO1/iBpBPdp
 xrONG7sPoCe0gHYpO3e3fPlcUx3Hk80GNtnL5YcJioMyZpj5yUOoPDbqv+tw7NST6eZpqryFJ2c
 fE9PMqFexHjrjQrY4kY4cOhQ8kfD7PTeWvLyaILSrVG2AO3mmeVd2ZjdteJnuHhd1i+RugMHBey
 mfOAlZgeJuCa9aikIfcWnYtpWE7bcBk9OT3mhs4fGzbzkYVQJINVZRxZwlEEHrRDyLTZXCf7HDJ
 PtooJSCS5pRsZ22YhWh3l86wjwAoHR85wAfKQNXzCpB04dGjSt8xZ0glR4CEl8/01lBe5r7brlD
 yStnxiu7etZN2swzLwKmF39snUNP70ybZSatq3qvn7w1Vqm9TTjIHJf/3AyegSqtO1wzM5aT+2z
 pAohx5AxTYlQuohBDsmz1INOJZWlTcP+WUv7iM5lt5eCzQFaQh0rKWl9EAnBSKU7oL5q24Om+5y
 rdXzsMsJFFrRWrRlfSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240091

The class profile attribute documents POLLPRI notifications for changes
made through userspace writes as well as changes reported by providers.
However, a direct write currently notifies only the legacy ACPI aggregate
attribute, leaving listeners on the provider's own profile attribute
unaware of the change.

Notify the class device after a successful direct write, using the same
helper as aggregate writes and provider-originated notifications. This
also makes notifications available when ACPI is absent or disabled.

Restore aggregate attribute visibility after unlinking a handler whose
registration failed during a sysfs group update. Keep aggregation exposed
only through the existing ACPI interface; the existing class devices
provide firmware-independent userspace access.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/platform/profile/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/profile/core.c b/drivers/platform/profile/core.c
index 57c3dad2732b..a850942131cd 100644
--- a/drivers/platform/profile/core.c
+++ b/drivers/platform/profile/core.c
@@ -256,6 +256,7 @@ static ssize_t profile_store(struct device *dev,
 		ret = _store_class_profile(dev, &index);
 		if (ret)
 			return ret;
+		_notify_class_profile(dev, NULL);
 	}
 
 	profile_notify();
@@ -330,7 +331,7 @@ static int _remove_hidden_choices(struct device *dev, void *arg)
 }
 
 /**
- * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
+ * platform_profile_choices_show - Show the aggregate profile choices
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -366,7 +367,7 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
 }
 
 /**
- * _aggregate_profiles - Aggregate the profiles for legacy sysfs interface
+ * _aggregate_profiles - Aggregate the profiles across providers
  * @dev: The device
  * @data: The profile to return
  *
@@ -391,7 +392,7 @@ static int _aggregate_profiles(struct device *dev, void *data)
 }
 
 /**
- * _store_and_notify - Store and notify a class from legacy sysfs interface
+ * _store_and_notify - Store and notify a provider from an aggregate write
  * @dev: The device
  * @data: The profile to return
  *
@@ -409,7 +410,7 @@ static int _store_and_notify(struct device *dev, void *data)
 }
 
 /**
- * platform_profile_show - Show the current profile for legacy sysfs interface
+ * platform_profile_show - Show the current aggregate profile
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -437,7 +438,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 }
 
 /**
- * platform_profile_store - Set the profile for legacy sysfs interface
+ * platform_profile_store - Set the profile across all providers
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to read from
@@ -508,7 +509,7 @@ static int profile_update(void)
 }
 
 /**
- * platform_profile_notify - Notify class device and legacy sysfs interface
+ * platform_profile_notify - Notify the provider and aggregate sysfs interfaces
  * @dev: The class device
  */
 void platform_profile_notify(struct device *dev)
@@ -650,6 +651,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	scoped_guard(mutex, &profile_lock)
 		list_del(&to_pprof_handler(ppdev)->node);
 
+	profile_update();
 	device_unregister(ppdev);
 
 cleanup_ida:
-- 
2.43.0
