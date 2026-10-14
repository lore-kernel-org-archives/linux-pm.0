Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97DB525A9E
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984619; cv=none; b=enqdvIVigq9lrfwKIf/nSAiSvOuELw5yOC5QCRzbcvq18L0QvxuCpN/yMFUbkRTY/8cErwyPZvXArMAOCcgsG/bRRwCLCKvv89A1IQ8yI9EO9rNUl7tvbXsDoTpkMzshdX6+/3oaD9fLumCd8saTJClYb5xhHydmJZ7BQJ9hkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984619; c=relaxed/simple;
	bh=ZqlX1hRIaj1kNOTv80mV1ls3MopFwV4oAlEM09KwzP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xyy9p8wRIUdzzaxSqDAidLj4nistPbE+59g3JoQEN2MPfrWrjUfbfhK0gKhdAuz6uzGosEPeI/1XxgPG3d8HgyWdK3seJhSoske/urBzZpDyhVz6JReTR9my8vPe/xxPuHRkpSgT/MUobaq8VOZn0RfbfzGotyRs0TUOWjvDK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lfAf9o9n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ITYDKnnK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lfAf9o9n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ITYDKnnK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E9eEsw3696497
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=518A7MdhUG6
	ATdQPl9l39rO9JNHyIKuwzqURvGyB7UY=; b=lfAf9o9nHm8qqI2xH0NZRIRDEDd
	OoN7JDZF/OFnQnj+y4eoTcQCSZqvAeDNA5eL/OgGB/oW/jmtFaQJmm7Nl50OarrE
	LanoX4o9CCBw3+ZWwCdBEKDyJEYt86ntwr2BZKfK2rexRa3lyOpkDsmcBAMFJidn
	kvnOtRoxIEkFhao5ZlnOtBoHSSyiHw7fTrJi+SqXCwoNOPAzj2xEVsElTHiNeTMc
	1Ky4byKSGgpHjyOkbt33kclestv4En/Zzmpe9k6I/hn+KLycmt/v7QA1BjhM2Dp1
	45Q4xVff1u8I5hEwKf/XOa1xDRmPgllEH351ixvhwMQFQdbUL4WUBoaxdqg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aegvd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93dd3c3badbso80364785a.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791984610; x=1792589410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=518A7MdhUG6ATdQPl9l39rO9JNHyIKuwzqURvGyB7UY=;
        b=ITYDKnnKIsGRsCosOw0km7MudQqE9uUMvg9XynfdXcIyGlzb0ldEBDIy7zfIx+IGzm
         L7FSxtDRMCVv+4BrF2TLVzLwBsgMjMBsLkptdQQeIg330Y5uZIC20oJ3/pDejI4x0lVG
         7f2rHotNtyplV2f5gv2xgTxYvwLCHAcmJVqOTS1nAWFav1mIrHY/MDhc+quFH80ddbqN
         4p+MjQD2cTxfrO0Chn40UkpJOzVBVmggpVq/a1GA9AfM4Nl+YwYsPBzHfeYNbErVj3on
         5lI9BySGrZtwvdVn5NUr0ZLVa52MqIjbMgywq2hWHPl2Ax4OHzx0Xhq8UuS08m/ak9Kr
         oIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984610; x=1792589410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=518A7MdhUG6ATdQPl9l39rO9JNHyIKuwzqURvGyB7UY=;
        b=bdkjNxV/PXuQd2hEysMVTfBsVlb0lmLEjOVKWxSZ+Xa9aXLytW9jcu31D07QG29hFZ
         XmVuRFXVQrVXSt0BC2cO8Rt84oKbiZP8bWPRHryc6ggakL1jd0EwWB15l3moihWYvIf0
         MAySFDqF84UB0ootxQRT+SgHILb04sBAVVa8OOX//z0Snb1K7eS4IgJQaQdCFghD83iz
         xih+NQgZMo+No1ltrOkCI8B2CQuKN/UyZLk5Ua9vnTzxrfL59xcPz/6glVbBFYl1AW31
         vYLgMcpM0DF1k7AL5z7NpsafgRXrJCUWwsArS7HmhKCFOQBA1bzJGyoxiwunld3TkZDJ
         vVJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjNajlzMU026b15BQVXVUVg5rKov6Cf/r2+LKgEdFYjXLlvhfqlhbjUAn66Frs5e0hKWDhx6gfNQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLmsoMUhqPJ56dyaztUcKt6ooQ3xPh23JzC9Ui1pl4HdfTg7KiM
	SHA3vorF16PHJdxdctlsUqVrrAq7XtBGbcOMGvfiapGCOByHD4Iy7ELzVwcZhqOJ8pVEqMXPm2G
	CyWhPvXuZJg3eSIILmR7+5/k00L6mBlj1Xrsyc6k9DN7zN9qNW0bZEyQSOo8QYg==
X-Gm-Gg: AYBFou1va8xSnxhATMoj48ZFTdh7cYAgF4N8fzyu/k5gBGjgcY5fmR+OvqsCCExxBjC
	NZQUSNMwJhF4cUluDSQC5W4RHA5IZOIoX5RzckdyiJIbYnk45KQG5VcxRbrfC2qIK/keMg7TgDJ
	+V6wXOGojFQNgkUE37RkrOj018YpKA/sTUSY75SSly9HQe8qqrbzsJjiwt5TagTVRdx/bsHsJyI
	nBP5hrL+oJJnE1zFB9uxRuHJia61r5KP11V0Yoy2uieaaL79AiszV5xg6kw9mKwFW5sidekRJzO
	l+0OHPpaybFq/G5pPB0YIzZP9a0fmdh6VwQ8zqqMyRywaBvcdL3v4e5uIOWB+UZeaJKK9l/Qp1k
	u6J5eu1v7yi/7xgb7pnpqLgkyRmo=
X-Received: by 2002:a05:620a:2304:20b0:93e:d854:4b83 with SMTP id af79cd13be357-93ed8544be5mr1273680785a.22.1791984610277;
        Wed, 14 Oct 2026 06:30:10 -0700 (PDT)
X-Received: by 2002:a05:620a:2304:20b0:93e:d854:4b83 with SMTP id af79cd13be357-93ed8544be5mr1273676585a.22.1791984609774;
        Wed, 14 Oct 2026 06:30:09 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcf552e8sm2027155e9.13.2026.10.14.06.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:30:08 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Armin Wolf <W_Armin@gmx.de>, Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 3/4] platform profile: Add firmware-neutral aggregate sysfs interface
Date: Wed, 14 Oct 2026 15:24:46 +0200
Message-ID: <20261014132500.3817549-4-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zpii_dZ_t63VcEjHkzZD3lpWZxk_Tu4v
X-Proofpoint-GUID: zpii_dZ_t63VcEjHkzZD3lpWZxk_Tu4v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX8LQPag3eAJte
 YGQ3n9izRTMhqJPPnwOIF1KjgjnLG+IKL8A9bRAamwvkNYKtmULenw2Cg2537a1LPlIBSTHDm3Z
 xKNf+hBKiqqBntmOCAn5gdy49Cq4tuI=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acf83e3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=8ZtbILYAgf2ziLaPuYcA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfXxU9+lEDJK7Sh
 CpDWP8LYO4RjEfNuTzfkLMelG1FmT3CstUdljmF4iuwPjlN/Tb2IvRB1uk/fKFyyrwCBic/yZkx
 uebiIvhFbBBiin8L9DVTW6Ie98caPl0KFaslmE0tLdbfR3mHXhf8yGpCVnTXJAmEN+/n3HLDEk6
 JHQ5cduftw3sZtKaUa+JXKAAO3xSnre5v8ryipjxgsh8g2h4WPBM7VR68Yg7gpbyAwEGO/UCh0Z
 uKGfb/a5JdKMW7VYRx7WgAD7subK+pokgLpJa5EXUsiCB1uzcpm26uS/Q0j0k8T4Pu2Blc2MGp1
 t0uEhSIoyV3dg2yS5Z1QMfmUqx/q/MQ1QbO+Wc9kxYgFt0bp9Md3SOuNstEz7cTGkRBHvuNxqYq
 QuwKPQ8mjgc4YTeZjGvojJj9Kn8D4ulYVmCC5btvUkTbK4KAfBpEhqXUOxkOdBkd7oots3jnSZC
 c0T7Pn92br3sYYIjlPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140053

The per-provider class interface is firmware-independent, but system-
wide profile selection is only exposed under /sys/firmware/acpi.

Add /sys/kernel/platform_profile/{choices,profile}, sharing the existing
aggregate callbacks and semantics with the legacy interface. Keep
attributes hidden until a provider is registered and remove them after
the last provider.

Notify both aggregate frontends on profile changes. Also notify the
provider class device on a direct profile write, matching its documented
POLLPRI ABI. Restore aggregate visibility after a failed registration.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/platform/profile/core.c | 60 +++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/profile/core.c b/drivers/platform/profile/core.c
index f18fd96b942c..507b96bdfdb1 100644
--- a/drivers/platform/profile/core.c
+++ b/drivers/platform/profile/core.c
@@ -26,9 +26,11 @@ static DEFINE_MUTEX(profile_lock);
 static DEFINE_MUTEX(profile_registration_lock);
 static LIST_HEAD(profile_handlers);
 static struct kobject *compat_kobj;
+static struct kobject *profile_kobj;
 
 static void profile_notify(void)
 {
+	sysfs_notify(profile_kobj, NULL, "profile");
 	if (compat_kobj)
 		sysfs_notify(compat_kobj, NULL, "platform_profile");
 }
@@ -250,6 +252,7 @@ static ssize_t profile_store(struct device *dev,
 		ret = _store_class_profile(dev, &index);
 		if (ret)
 			return ret;
+		_notify_class_profile(dev, NULL);
 	}
 
 	profile_notify();
@@ -324,7 +327,7 @@ static int _remove_hidden_choices(struct device *dev, void *arg)
 }
 
 /**
- * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
+ * platform_profile_choices_show - Show the aggregate profile choices
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -360,7 +363,7 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
 }
 
 /**
- * _aggregate_profiles - Aggregate the profiles for legacy sysfs interface
+ * _aggregate_profiles - Aggregate the profiles across providers
  * @dev: The device
  * @data: The profile to return
  *
@@ -385,7 +388,7 @@ static int _aggregate_profiles(struct device *dev, void *data)
 }
 
 /**
- * _store_and_notify - Store and notify a class from legacy sysfs interface
+ * _store_and_notify - Store and notify a provider from an aggregate write
  * @dev: The device
  * @data: The profile to return
  *
@@ -403,7 +406,7 @@ static int _store_and_notify(struct device *dev, void *data)
 }
 
 /**
- * platform_profile_show - Show the current profile for legacy sysfs interface
+ * platform_profile_show - Show the current aggregate profile
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -431,7 +434,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 }
 
 /**
- * platform_profile_store - Set the profile for legacy sysfs interface
+ * platform_profile_store - Set the profile across all providers
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to read from
@@ -493,8 +496,30 @@ static const struct attribute_group platform_profile_group = {
 	.is_visible = profile_class_is_visible,
 };
 
+static struct kobj_attribute aggregate_choices =
+	__ATTR(choices, 0444, platform_profile_choices_show, NULL);
+static struct kobj_attribute aggregate_profile =
+	__ATTR(profile, 0644, platform_profile_show, platform_profile_store);
+
+static struct attribute *aggregate_attrs[] = {
+	&aggregate_choices.attr,
+	&aggregate_profile.attr,
+	NULL
+};
+
+static const struct attribute_group aggregate_group = {
+	.attrs = aggregate_attrs,
+	.is_visible = profile_class_is_visible,
+};
+
 static int profile_update(void)
 {
+	int err;
+
+	err = sysfs_update_group(profile_kobj, &aggregate_group);
+	if (err)
+		return err;
+
 	if (compat_kobj)
 		return sysfs_update_group(compat_kobj, &platform_profile_group);
 
@@ -502,7 +527,7 @@ static int profile_update(void)
 }
 
 /**
- * platform_profile_notify - Notify class device and legacy sysfs interface
+ * platform_profile_notify - Notify the provider and aggregate sysfs interfaces
  * @dev: The class device
  */
 void platform_profile_notify(struct device *dev)
@@ -643,6 +668,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 cleanup_cur:
 	scoped_guard(mutex, &profile_lock)
 		list_del(&to_pprof_handler(ppdev)->node);
+	profile_update();
 	device_unregister(ppdev);
 
 cleanup_ida:
@@ -726,15 +752,33 @@ static int __init platform_profile_init(void)
 	if (err)
 		return err;
 
+	profile_kobj = kobject_create_and_add("platform_profile", kernel_kobj);
+	if (!profile_kobj) {
+		err = -ENOMEM;
+		goto unregister_class;
+	}
+
+	err = sysfs_create_group(profile_kobj, &aggregate_group);
+	if (err)
+		goto put_kobj;
+
 	compat_kobj = platform_profile_compat_kobj();
 	if (compat_kobj) {
 		err = sysfs_create_group(compat_kobj, &platform_profile_group);
 		if (err) {
 			kobject_put(compat_kobj);
-			class_unregister(&platform_profile_class);
+			goto remove_group;
 		}
 	}
 
+	return 0;
+
+remove_group:
+	sysfs_remove_group(profile_kobj, &aggregate_group);
+put_kobj:
+	kobject_put(profile_kobj);
+unregister_class:
+	class_unregister(&platform_profile_class);
 	return err;
 }
 
@@ -744,6 +788,8 @@ static void __exit platform_profile_exit(void)
 		sysfs_remove_group(compat_kobj, &platform_profile_group);
 		kobject_put(compat_kobj);
 	}
+	sysfs_remove_group(profile_kobj, &aggregate_group);
+	kobject_put(profile_kobj);
 	class_unregister(&platform_profile_class);
 }
 subsys_initcall_sync(platform_profile_init);
-- 
2.43.0

