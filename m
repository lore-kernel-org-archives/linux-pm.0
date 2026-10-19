Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541884908DE
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395597; cv=none; b=bp3HkmqQB8POpGvG4+wTWP6m8EPqpiopUrnFdcLfZBZMS1wYtqnRRxzO+Zi+nkdbobwkR48kU/ugeh+/y6d8WpDxDf4z3hPtZu5P9klBz16LU9wlhkpA2ch6JyJCWN+eCQNXINorIlk+3UoE57WjBJcYtujV53mnEfrMEXJCPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395597; c=relaxed/simple;
	bh=hJjJGa4eBm7XtrMdXHGCS4ZkQZ5TfCxifDEVQsme3NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+MKew8pGO42Ga9cK8Ppf1vBBaJhq/uf+PLAhGJ/TdwOLvkP3Ym24Nd0c6Ea+cHXh6znpGU4Fpnkxi6lEj4moVzEXu5KzbvtzldD9DxufG6lQ3k7JToIzDTgxH1lOB2gwSyo1zQyUzSErhdKvnuvVYr+5WLv4nC0MONqQICF6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WmNiMSkg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QaQSVjAi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WmNiMSkg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QaQSVjAi"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4jAUl1750715
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tnpf683EmeZ
	q2xc7PTdD0vDegWDcKYsb++VcsnkPTqo=; b=WmNiMSkg5Mc/B0i1q7tBCLIZQv6
	3GIJZX8h+Hq1Jc3KHvwyxCnEBDUOsG38b1P7rvweKXkYsaxtwOar2R3PKgD99eaz
	1MhoMbb+oijoTJF5BlhS5WcNnHvk/iCgYfKS6q0XgFEZUTFDESKUpOLJQkfm5UjP
	Rx/0dJYLSk2p1PBQbBYhspEpmH7B8G6D8A5snqinSNZQlNNlqsozI7PzPeKZw042
	wUIHdB/WRXYi7eLMxdOle62rqiQ239kbKih7RjbTYFP7oS//31t+2Ls+nLCHmQmq
	a0QMjtinT5Zzj4Ga6Feh6oun/IyqQlJRzHp7CdGuozPwzV+EMc+CWxbUQnQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc183dgup-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:39:52 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91bebff9fcaso46676636d6.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792395591; x=1793000391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tnpf683EmeZq2xc7PTdD0vDegWDcKYsb++VcsnkPTqo=;
        b=QaQSVjAivoUnRpueJ7+/y1afEI65t/G/0TxZ+ySHLhnB2eYF+YoasnsAiBT9S5S+te
         eP8X/s1s28sjoLJE/eZQql6J/uxQhybTmMSBgyjRtazG+acABV/YNB0pM5UQ3zPHWqIZ
         l54M9gkXUf5pntGYvY8f+qVgkY0Q3d+l4gxaYOd3VpcicxqRQokvQWMWAHMtWy7icSSj
         acl3Fw9UbwC/tCvCfk8kd2wjaXTw7QmazK01+sg1cJllJv+Y3H01TQtx3SxInYobyktd
         qJR/1OOi9mY6yelIszutVuFM0ajz0E2ikMZnqyHZ8HR2hN5syu+8Quo8JqgLyQ2AQxAN
         bf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395591; x=1793000391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tnpf683EmeZq2xc7PTdD0vDegWDcKYsb++VcsnkPTqo=;
        b=0DTCeAUUN3I1tCbyGf9uHzwmUgLEbDuMMgb0vLTx0FsJBZsp5w+81B1fGIHzzrcO5h
         mOWpMxWBnIToPdPfRZ4FsOdQIm+BcmRSDMnINaQszncmpPexAS5EvOgyD0vIKcoWwFM8
         rChiBZsKSZM/+Dvi/7GZ+5lDHyKRyKiadeZ6kNCu6dzFVgrSbwr5Yk7SC0VQr10Hu8ZT
         LWAx/qRyqydScT3cDKRg5SU1D7g3lRWmMwFZyGRv8IVq+tn8TpfFXFt0qsAWxGSI532Q
         PO18Z2mIjrzxfxkjM7Frd6kNQG99Eyhg9cUnztJ+KHJJqk+FS+2Sc0H0BtgEesscTBtB
         2g4w==
X-Forwarded-Encrypted: i=1; AKwUvBzNpXMm8OGfw5qSx1gUTRgbiY5PulLEMIAaxTaKMl8WGLfCo51I9zwqCnOMVfoSwwfYXNLwNM4ISw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmN00PZNNJUbu61V/s1gOn3JV8aVuX3D2XgZf85IzDg9OV+aAp
	YNUicAF+BWXoERNVKibqB5y7DdT4GOptOb1KZDVrlR+TFPiXLCd4g7EP3neDqb7GzEgn9mxApp4
	SAVjdHVq2++vF0fRYVvn6O3Pm2k7kSmvVWjlq0BEiXeWaJ8ZuUq6qMuGlcs0Ibu0xyQwuLw==
X-Gm-Gg: AYBFou1Mj9FHydWeQQ7CTCuA/haCph4KKwZ0/H8MoxRoDWoxATcv8Pfm6TfesBG6n0y
	WJs90VQZtN3taSerZOs0a5Cpso/aY5/RS8Sv5rFWdMa88a0P9MjYXD3WzKRpLwba1ln0bCVR2Ux
	hA5LYB1TJvwyuE4M5LlMsEihNUk2XCQT7ip+ZtVFSzN3nN4eqruwQb5wSRI3f19h/cusjk3m5B9
	kjtVGMs2B0OfWs6Mb9pgEKd4Ht/f9vM77Z+poKdfyEQmzUD23iAJ5rLG79nte7o+VZOWZ4dhLnI
	z9+WrNOzGXWyrKPDdA72/GMSGF5lrzYboLpd8ViDwZgoAVvUiZpkZ3M5ZulETBKG9ZZ7C/fsK6J
	L/NkPYH5gJ28YoLJviUR6HJStJLQ=
X-Received: by 2002:a05:620a:40c7:b0:93f:26d6:d70d with SMTP id af79cd13be357-93f29cf7ddcmr1207148085a.31.1792395591504;
        Mon, 19 Oct 2026 00:39:51 -0700 (PDT)
X-Received: by 2002:a05:620a:40c7:b0:93f:26d6:d70d with SMTP id af79cd13be357-93f29cf7ddcmr1207146085a.31.1792395591068;
        Mon, 19 Oct 2026 00:39:51 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d01d:2002:4b7d:4c30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce325107sm212812955e9.3.2026.10.19.00.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:39:50 -0700 (PDT)
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
        Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        Jack Wu <jackbb_wu@compal.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Zhang DM <jixianqiang1540@gmail.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 3/5] platform profile: Complete class notifications and registration cleanup
Date: Mon, 19 Oct 2026 09:39:06 +0200
Message-ID: <20261019073930.2352283-4-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019073930.2352283-1-daniel.lezcano@oss.qualcomm.com>
References: <20261019073930.2352283-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX3vBHsBSPt9Zc
 LdheR+iPiDON0HsHTxuw/AyCpPx0K25guYcUi1QCH31fQ8PoVKf+Dxg2kwPRZjPuVllWR268PcM
 /N601lwRWnm3FwpEqMyhrftT5RyPUGA=
X-Proofpoint-GUID: poFgQjJmiZUkrEVArt3ZiwrcLzIIYBim
X-Authority-Analysis: v=2.4 cv=Bu8IUoX5 c=1 sm=1 tr=0 ts=6ad5c948 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=sNWLPp6fUqVo4Qx2xT0A:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfXzS+pxQxlI/g3
 oRVx/cvCqbUK/L62WC31VXe8zhq8vV9N66q6UYXKmijFfD+KxpVpqY8wLblKgO9Eg57IVIk6kRy
 sLEu3RhhIYVdWOYj9YphdCu2tUy4e0TTKrcY81C2u2MZj1Fpe7VrTG6L75rhlBxE8LlyLY/KU/r
 ldUVxtBQhJl8Rdb2qsu8BYne2c1O9VDPrdTX5xI2UAw/pEpyTVXTKE81epUIooPIyUSd8X67kX2
 /gAOvHqFhym6uZkOyv1AfQQzVuzPAUJz2R5VZpAdediIN5hOcV1+WBb6XIDz7zNm+Kyb4FtqmUS
 ZdoQGjnMrtIeFmKyqP6fQUCvATz156xA9HhVd8lSNjYyuHe3obPxOEE1In4eMIhv71MgRqtGaKO
 Kz0EuEMzGlExJ7jp4vdN5Qic3z/fCDnVC3qxdVk9E74g7ghlwkQlAAXIK0f4FVeYVuARmjm3T8M
 NjfzKLf31hbm0Mb5x2A==
X-Proofpoint-ORIG-GUID: poFgQjJmiZUkrEVArt3ZiwrcLzIIYBim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190030

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

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/platform/profile/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/profile/core.c b/drivers/platform/profile/core.c
index f18fd96b942c..320a5a964fea 100644
--- a/drivers/platform/profile/core.c
+++ b/drivers/platform/profile/core.c
@@ -250,6 +250,7 @@ static ssize_t profile_store(struct device *dev,
 		ret = _store_class_profile(dev, &index);
 		if (ret)
 			return ret;
+		_notify_class_profile(dev, NULL);
 	}
 
 	profile_notify();
@@ -324,7 +325,7 @@ static int _remove_hidden_choices(struct device *dev, void *arg)
 }
 
 /**
- * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
+ * platform_profile_choices_show - Show the aggregate profile choices
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -360,7 +361,7 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
 }
 
 /**
- * _aggregate_profiles - Aggregate the profiles for legacy sysfs interface
+ * _aggregate_profiles - Aggregate the profiles across providers
  * @dev: The device
  * @data: The profile to return
  *
@@ -385,7 +386,7 @@ static int _aggregate_profiles(struct device *dev, void *data)
 }
 
 /**
- * _store_and_notify - Store and notify a class from legacy sysfs interface
+ * _store_and_notify - Store and notify a provider from an aggregate write
  * @dev: The device
  * @data: The profile to return
  *
@@ -403,7 +404,7 @@ static int _store_and_notify(struct device *dev, void *data)
 }
 
 /**
- * platform_profile_show - Show the current profile for legacy sysfs interface
+ * platform_profile_show - Show the current aggregate profile
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
@@ -431,7 +432,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 }
 
 /**
- * platform_profile_store - Set the profile for legacy sysfs interface
+ * platform_profile_store - Set the profile across all providers
  * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to read from
@@ -502,7 +503,7 @@ static int profile_update(void)
 }
 
 /**
- * platform_profile_notify - Notify class device and legacy sysfs interface
+ * platform_profile_notify - Notify the provider and aggregate sysfs interfaces
  * @dev: The class device
  */
 void platform_profile_notify(struct device *dev)
@@ -643,6 +644,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 cleanup_cur:
 	scoped_guard(mutex, &profile_lock)
 		list_del(&to_pprof_handler(ppdev)->node);
+	profile_update();
 	device_unregister(ppdev);
 
 cleanup_ida:
-- 
2.43.0

