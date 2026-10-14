Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338E525A6C
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984614; cv=none; b=c6RDc+0T2jozj75LSDJTJOUdFzzSy3fx4Z9v8/p7nJKm+V7hdFNZ8xYfdLIPGXp1wW/Tt3Y63VMm66mvgj0KPXaycaNIV8o0PXFSVaEN3yALnIqPpOIdXvF/KpuSTrorLO1v2HX9Qdzk1qNs8fiQOX1XDdZ1/HToOeA6x7VaIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984614; c=relaxed/simple;
	bh=doXrUIwdT42lwD+d4QdKmHm+N56c6YBObxX4WBpagBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlSFxVVxaFwJF278gbXvhA2v3B5cR3prrIS4t4C7DXpaelWRtmJYi/iWiErMp4xdJ+tj1vMcZ+aMp07vaZfURfJfqyUMV1EzweH7vdYuJ/Pn6PCZ027vmvKyCbsa5K1UPArTYeyN8GA4fzYyjIIuTGgsP0pCsvYDHpQyB/dXx50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XA25ccZm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eRnmwEo6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XA25ccZm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eRnmwEo6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EDJCA53017725
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LZgnpAcn7mn
	WiJsfnca2KhxPPGKIsl9W8hnUoknYsA0=; b=XA25ccZmcxyw3/MrLag62tSgtBb
	tsqBjh1fsPQxjiznIimwm+69/fycJyuKQR8FULXyNEtOlqqRxeayEzpvEsAER8nK
	HQa0NEFf6MYacY8bcTh0H/xLi3PMTZpsrOdWOwqLLtClq8FTr5pqlkVS6gP/Xvqg
	gp51M3fIBzbU9q8QeRxH3V90RUg9DkD2QX53VsCetvBd9TWLRaI5fFXAWmqDczOR
	09mg6FbwW7OGJkhrufBtigucsWSwPMkagsYwzRCCsPy9oBVV6/kZRApedVeeG7Lj
	552uSQ6QHHPPy6tWT5Fbo8ghDrJ//nWvPQ6f1vWJJgJSdSpaM07XJJf84Tg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b4gw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:30:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934963b2bc0so799490385a.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791984604; x=1792589404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZgnpAcn7mnWiJsfnca2KhxPPGKIsl9W8hnUoknYsA0=;
        b=eRnmwEo6yrRPV6tKBAnPFLTd9eIWkJnK+SaiLsQUPMa1zEF7Vk4R38np7GQlqaA/zB
         08RK4xWe3u8i3I8RaLFIwUcFuHY1/wRGNveGVEjMb0N+d4oYqxHYnAlXhU7xWSpFuuN8
         cDMB371Di+PkdHbRyGrbIkCl/vYH0vveXDPysja7+/Y/GEu/E6CGFXTGaBETP+1K2RPo
         BpL8SUduZ68v36NEQ+dR81rAtM/wUSIo4AwsWYJ7XLnoNNMrf18yWoV8r1VQmhWGiYNx
         Od2+TqyvcvvQHCiisrIIKKito/0jQC2kh465IcLw2QWdBP/Q38B1kn9QD5JY01z6DaLC
         JNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984604; x=1792589404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZgnpAcn7mnWiJsfnca2KhxPPGKIsl9W8hnUoknYsA0=;
        b=Vwl95CWs2YxQcAfHnV5h6mKPDmvfyN9QBPnL9kVQExQR94098TpFFLIVetWP94t3pf
         6sFr27jOokwC+ILuEuZ/OjGwxZWFgY8Bavwl66nvleQq3lOoXxK1Fds+57yPUMRbegHB
         /2UEV1oQqhia6yEChBKkS86IgcFiEjf3ATxS0NM7WunlBq0ipV+h6EGWBO34BiRGPjRg
         9iNhsjgsXHiyUjs7O7guL94gP+k6sgUgf/FTCFP574F6eoaM/gm0eTgboQx8DIdet0bk
         Z/oD/jjK/l+7Z7rBnUfsng6CSWyvxmJUpYQjyfDcwT0JyVjG3i1j4j34UxmIa12RXJm8
         onUw==
X-Forwarded-Encrypted: i=1; AKwUvBwBf3Ewwt3iU/BHvRkurvJU5AZvWxa/Ix+3bnH1qqV06lLeBAgbJ8bs1QoGzqNxq7DIezx3fUSUPA==@vger.kernel.org
X-Gm-Message-State: AFq9FYInMOiOckExaYCHeDgOefwWOrDCn+0Eww1s7Zt0dgc52HBaVqkN
	GVvMQkBqm/Jss+04pNf0KUQGEmJhtSH0YzWUx9Numt9IT2jY44vtDplUwuWYXDG/BjD7WpuB8xR
	nhodjA0BkhEXkwpmqiZEPLlh9XWmwCWvnHhxG8Z6fMdEi2KBYdRt86vV8O5G5/g==
X-Gm-Gg: AYBFou3PBDxpTamtiy7qBNTYbKziiLw6u3GIFNtl8uYXGZBEI9mhMF0xW5SVAaLTEMJ
	13uVtkOtWut9kNyNI8P+CTyyxFpQaMAL+MtIo+YM6eQq6K3/OYpOQXgMmGd2gw0d3MCJY1LPWqb
	ZrnQQYFlYrYiqBvK/Tf6kOlWyvjOeea2TRaLzVLBVSsZICmgGWVu7e0UpVJ+WqKibvlehbbQZH0
	hzJNi9bIIgyP6NP19BwCYGfspnZXD4dAPju29aVahnEK2FzniwwEmGe6y7eU2vmLpsCDZMG37Ve
	J/glhEMID84GDIjYBDoEpR35hAsxnWwh1HmvWIT4O88HD4pN2iDxXQ7/xoUg/x6VcscE+ifQO2q
	92cL6HJ/GDSKqjyqunfeJahNkZvI=
X-Received: by 2002:a05:620a:2719:b0:93e:c12c:43ff with SMTP id af79cd13be357-93ec12c492amr2391108285a.76.1791984604076;
        Wed, 14 Oct 2026 06:30:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2719:b0:93e:c12c:43ff with SMTP id af79cd13be357-93ec12c492amr2391102685a.76.1791984603476;
        Wed, 14 Oct 2026 06:30:03 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcf552e8sm2027155e9.13.2026.10.14.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:30:02 -0700 (PDT)
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
Subject: [PATCH v1 1/4] platform profile: Separate handler locking from sysfs lifetime
Date: Wed, 14 Oct 2026 15:24:44 +0200
Message-ID: <20261014132500.3817549-2-daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6acf83dd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=x8GNUdOtJ_ZxbuW7bkUA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: WV550HrRmsROgU2DPCYBtvHlcqHqQmpm
X-Proofpoint-ORIG-GUID: WV550HrRmsROgU2DPCYBtvHlcqHqQmpm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX/CN39/8kRC2f
 L9RkcElwoT+XLXj8fA6ITELWmTx76gT3Fba57wLGL4F29l5hlQaKVhJ7ParJ8y/ntzXXVxCoVUg
 /foirCVeh26heMk6KilqKNJ4tTQPw8T9CdpjYN+65pT6F+GX3WCZ7V9CWxYCJMQP8zPZD++9syw
 aGVnZdo0TiFSa///b8ReVUjKF5s2K0zUD2Bn0YW0Z0bDeRY5DbaXzNz06lzaE+DQMY8bHTqR4/H
 mA0OGRzamPtRSTZYb4fPWZLfxD1hsFNe4am/HS8h1AP3KthMBsZOeWmBWJxZbrqrGSE/PYzJ+NV
 qnxSjDD042d7cmnYlhdjRDB+NPx9fyGuy/wwy2uteumFFJIaFcC3iOHQA0Io2P+1z3iXtdHzwSg
 1TQOgVwOQa4uCgp9Yx9EH5kyZ+qZHDipzuaZ7nVTYC8CAqbQLbftdOMg7dWWxqw2Lg5KGBKjY+K
 R0oUV33Rf+fVVvT+Tzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MyBTYWx0ZWRfX/nzBRbc+Esr9
 Gcpw+SHIy1YyIRoaY2uo0xEVRW8WVyHJwr/qJUgY5gKVJgwrw4vjmeAE5GOXBPnmKu4d4EfVwup
 7xw46NF/fqqVVJ0XzLA0cYfOf3gmGc0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140053

Registration and removal currently hold profile_lock across
device_unregister() and sysfs_update_group(). These operations can remove
sysfs attributes and wait for their active callbacks to finish. The
profile read and write callbacks acquire profile_lock themselves, so a
concurrent access can deadlock:

  Removal/update path             Active sysfs callback
  -------------------             ---------------------
  acquire profile_lock            hold kernfs active reference
  remove a sysfs attribute         wait for profile_lock
  wait for its active references

The removal path cannot finish until the callback returns, and the
callback cannot return until the removal path releases profile_lock.
This applies both to per-provider device teardown and to updates of the
legacy aggregate attribute group.

Simply dropping profile_lock around these operations is insufficient.
Aggregate operations currently discover providers through the class
device list. A provider being unregistered could therefore still be
selected for an aggregate read, write or cycle while its sysfs files are
being torn down. Concurrent registrations and removals would also race
when updating aggregate attribute visibility.

Introduce profile_registration_lock to serialize registration, removal
and aggregate sysfs updates. Sysfs callbacks never acquire this mutex.
Retain profile_lock for profile operations and use it to protect an
explicit list of handlers participating in the aggregate interface.

Add a handler to that list only after device_register() succeeds. On
removal, unlink it under profile_lock before calling device_unregister().
Acquiring profile_lock first waits for any aggregate operation already
using the handler to complete; unlinking prevents later aggregate
operations from finding it. Release profile_lock before draining sysfs
callbacks, allowing active per-provider callbacks to complete before the
device is released. Apply the same unlink-before-unregister ordering to
registration error cleanup.

Walk this list for aggregate reads, writes and profile cycling, and use
its emptiness to determine aggregate attribute visibility. The class
devices remain the per-provider userspace interface.

There can now be an interval between removing the last handler from the
list and removing the aggregate attributes. Explicitly reject choices
reads and writes during that interval: the intersection bitmap starts
with every bit set, so an empty traversal must not advertise all profiles
or report a successful write without updating a provider.

This also establishes the locking and lifetime boundary needed to expose
the aggregate operations through a second, firmware-independent sysfs
interface later in the series.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/acpi/platform_profile.c | 75 ++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 79d2e92e5c28..f98ce4cda02c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -8,6 +8,7 @@
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/init.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
@@ -15,8 +16,12 @@
 #define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, dev))
 
 static DEFINE_MUTEX(profile_lock);
+/* Serialize registration and sysfs updates without blocking sysfs callbacks. */
+static DEFINE_MUTEX(profile_registration_lock);
+static LIST_HEAD(profile_handlers);
 
 struct platform_profile_handler {
+	struct list_head node;
 	const char *name;
 	struct device dev;
 	int minor;
@@ -44,6 +49,22 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+static int profile_walk_handlers(void *data,
+				 int (*fn)(struct device *dev, void *data))
+{
+	struct platform_profile_handler *handler;
+	int ret;
+
+	lockdep_assert_held(&profile_lock);
+	list_for_each_entry(handler, &profile_handlers, node) {
+		ret = fn(&handler->dev, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * _commmon_choices_show - Show the available profile choices
  * @choices: The available profile choices
@@ -306,20 +327,18 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &data, _aggregate_choices);
+		err = profile_walk_handlers(&data, _aggregate_choices);
 		if (err)
 			return err;
 		if (data.count == 1) {
-			err = class_for_each_device(&platform_profile_class, NULL,
-						    &data, _remove_hidden_choices);
+			err = profile_walk_handlers(&data, _remove_hidden_choices);
 			if (err)
 				return err;
 		}
 	}
 
 	/* no profile handler registered any more */
-	if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
+	if (!data.count || bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
 		return -EINVAL;
 
 	return _commmon_choices_show(data.aggregate, buf);
@@ -384,8 +403,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &profile, _aggregate_profiles);
+		err = profile_walk_handlers(&profile, _aggregate_profiles);
 		if (err)
 			return err;
 	}
@@ -423,15 +441,13 @@ static ssize_t platform_profile_store(struct kobject *kobj,
 		return -EINVAL;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		ret = class_for_each_device(&platform_profile_class, NULL,
-					    &data, _aggregate_choices);
+		ret = profile_walk_handlers(&data, _aggregate_choices);
 		if (ret)
 			return ret;
-		if (!test_bit(i, data.aggregate))
+		if (!data.count || !test_bit(i, data.aggregate))
 			return -EOPNOTSUPP;
 
-		ret = class_for_each_device(&platform_profile_class, NULL, &i,
-					    _store_and_notify);
+		ret = profile_walk_handlers(&i, _store_and_notify);
 		if (ret)
 			return ret;
 	}
@@ -450,22 +466,11 @@ static struct attribute *platform_profile_attrs[] = {
 	NULL
 };
 
-static int profile_class_registered(struct device *dev, const void *data)
-{
-	return 1;
-}
-
 static umode_t profile_class_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
 {
-	struct device *dev;
-
-	dev = class_find_device(&platform_profile_class, NULL, NULL, profile_class_registered);
-	if (!dev)
-		return 0;
-
-	put_device(dev);
+	guard(mutex)(&profile_lock);
 
-	return attr->mode;
+	return list_empty(&profile_handlers) ? 0 : attr->mode;
 }
 
 static const struct attribute_group platform_profile_group = {
@@ -502,8 +507,7 @@ int platform_profile_cycle(void)
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &profile, _aggregate_profiles);
+		err = profile_walk_handlers(&profile, _aggregate_profiles);
 		if (err)
 			return err;
 
@@ -512,8 +516,7 @@ int platform_profile_cycle(void)
 		    profile == PLATFORM_PROFILE_LAST)
 			return -EINVAL;
 
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &data, _aggregate_choices);
+		err = profile_walk_handlers(&data, _aggregate_choices);
 		if (err)
 			return err;
 
@@ -525,8 +528,7 @@ int platform_profile_cycle(void)
 					  PLATFORM_PROFILE_LAST,
 					  profile + 1);
 
-		err = class_for_each_device(&platform_profile_class, NULL, &next,
-					    _store_and_notify);
+		err = profile_walk_handlers(&next, _store_and_notify);
 
 		if (err)
 			return err;
@@ -583,7 +585,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 		}
 	}
 
-	guard(mutex)(&profile_lock);
+	guard(mutex)(&profile_registration_lock);
 
 	/* create class interface for individual handler */
 	minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
@@ -604,6 +606,8 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 		put_device(ppdev);
 		goto cleanup_ida;
 	}
+	scoped_guard(mutex, &profile_lock)
+		list_add_tail(&to_pprof_handler(ppdev)->node, &profile_handlers);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
@@ -614,6 +618,8 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	return ppdev;
 
 cleanup_cur:
+	scoped_guard(mutex, &profile_lock)
+		list_del(&to_pprof_handler(ppdev)->node);
 	device_unregister(ppdev);
 
 cleanup_ida:
@@ -636,7 +642,10 @@ void platform_profile_remove(struct device *dev)
 
 	pprof = to_pprof_handler(dev);
 
-	guard(mutex)(&profile_lock);
+	guard(mutex)(&profile_registration_lock);
+
+	scoped_guard(mutex, &profile_lock)
+		list_del(&pprof->node);
 
 	ida_free(&platform_profile_ida, pprof->minor);
 	device_unregister(&pprof->dev);
-- 
2.43.0

