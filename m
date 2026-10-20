Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507547;
	b=SRZZYbJwpDU3XfdhaPh5JhoUt/Ophnq7Q/1xxB59sQBzlmJELaXYvEvm2YyWmDQyJ+br
	 5lZae9RHh1pkAh7vaNWopMzlxWkdrIA1xD+xYIEUBtl6TNl7xKCLr/2z+fn1I1YseGbeg
	 f4jj757JR4IUFoIXeNwKE2d+sOYfZqO+6q5TSFmesDXtcEyI3tSC1ymyXZWXFdhuJkt1P
	 R7BcFsp4tAVW1cR7cLfv/JYBkhEs8BrzeANJpcnXE/4GIApJOTINEdR7hwk4K7DyL/VBN
	 rxTpGoU50PVDRDuix0BfcK4wIGhFgRkrvFR5fM4U3dHJA/SwUWwx68nif0Yq2krSP2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507547;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8dbti84VQZnRoyeZV4350aERHO6muqhqQOQJux036u0=;
	b=0aFG9sEeLYL0y3LXwDxmXMjs4lqid/tE95lEVoT6RXcf6tyt/tiUD9lM3quk9giRWxLz
	 xHjvMGJwGIDqshGKjv1VAxsd6TK1XmbI7XdW0B7183CasLphmcE6apgKFi0iW/bZm4Abo
	 uW6CGlFk8M3P7eHgK/iBXPm7iPEzhBvFuB66zNhpfRhIrQqtXF1GM3IB09+90hcdW3YON
	 S1vLoXgxJ5QE28PcGRKP0VDZXUZf9c2udO9n+cYA6Lpvbj+w8TNittAF6KgxM4/0yR0mQ
	 0H8vZC19WFMxi42iq0Vqb0G2V/jaYdLtac/O3vLJ5hyh70D9J/CJxm5ae12B6MGRjZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hLMMg0QP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ids73i61;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518B606A31F
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A518B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hLMMg0QP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ids73i61
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDA4uO271996
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8dbti84VQZnRoyeZV4350aERHO6muqhqQOQ
	Jux036u0=; b=hLMMg0QPCCSRW1jxQN0pwOX162ofZo2sdj7Uph673jP7aGe2K7a
	/+rirvtt/Grar/hgd667SoVlXSplzEGDDDZ2NfWUXoDCmVN5b4qUntDRnmbmPLZW
	TgfzPoiQyXQCf1RoWSLOXotJ0wH6C0ONGfHtpf68OfTxQ9XpSXEmemUvvSEcUhfK
	xtCT8PjJSns+Z0jTYP0aRN2P5+wRFQUunr59qVRYQeM5LCKy2dIRZR2ECaXM3M7F
	b5227oqMXtn7yoi7dcJdPnsYWxi+5W/PlyDAdAb7PqjJvuopDwM6yUDomyci9D0t
	X3Yb9E/vByA3podX9AoPFZUamMaceyvF+2w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hv8ng8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:45:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934956beec8so701595785a.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792507545; x=1793112345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8dbti84VQZnRoyeZV4350aERHO6muqhqQOQJux036u0=;
        b=ids73i61zfzfbT1OHvtyC7WeOE/60r6cZf7JJIVDtlAtKZ5+AY6WZwbDW760OnXyuf
         q3aZWYPuGCy7tZ/OH1hc3xvmHm58JbSYUGEmtCj1qS85+AosBMLGZkfC0h8+KZjVg4w4
         QzOS9YhgdcoMyd7r7ruvag/YNyKe2AtQ4spbwbX+0q1vdRnWE/C80c8pT8apvc15Ceg9
         9f9ecnUe1O+x2m1Po25QYYmqsI41I2sa42eJNIXmdDo1p8gjk9zXw/l/RQLbPEMERryL
         nuRPixgbYmVSEd86kbc8vFoJ+DhS25gSERjdbBcCq3/hM33mRz0MMuE7ILvSl6WTLsSV
         9NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792507545; x=1793112345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8dbti84VQZnRoyeZV4350aERHO6muqhqQOQJux036u0=;
        b=a+JTn19Ac/pjRkPKye5vXIRxltYiz+I6ZVjCpIbeSPVWFh7CunJYt38uJ0B0/PblQb
         JUGUmLhvuanhvkRK14suk1jPXvVJNDqp/qmyBJjAwzVsEwdI+OYcHt66VKvJmd6q6ePF
         ZOQAkIy7p0u9o0NBHwqDUHTfI/SSz1i+rQL3u/+io8Gyxgq4FdKa0fK7F52byCDnLp2q
         DWXJdcyw15IfwkzQzNaNY37nqiCZua4Q7iM4hrCzTPRYmc5Edd++oPDt7O1ypYURj9Cp
         MdQGAe2EwYpT7F+GCRU7RoRaUkGycLkG1ZgbAzuN3eKXi4wk0I2ip4PTMuHK4eNJLllr
         s00g==
X-Forwarded-Encrypted: i=1; AKwUvBwggE0uXF6w1tlLIGG7jILLThcX+r0W7fNQliR0wOuFenC9bwJxK8xO7qwv0lbD4fQWAdtD5FeRlg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLCGA6YBeTrYGZXmasqIfTuDHOt5iDQz7kixcRfD4uzxin3FyTT
	uSZGz47MEcVdEaQGxbmGHvStmNG6/aav5hVOE51wzR1ufePuKrhKEZ/ForNouxtrGIfzji0HK+e
	HxsOLj7I2Az8BhI9IcYffgzM+jSXkgMwLNUVh2ylp3OK+SFl4RwH2TGgOO2G8Dw==
X-Gm-Gg: AYBFou1v8xcXJaYwjrRAD1/OGv7hdrc/CL3mv3E83RJhrCiqolbvQLI1/FQ2c+0s0A6
	mV8lazqZ2k+naXbNK3bC/ISVtRRxiGYD23VWomgWGQ5NBi/27pDoo+RrmYLBFNdZtxgZiJOkEx2
	8XZOF7MdLaMnWOI3WsEwk75fdRev8B0iK0KK//lCKI37XPfbyPcgJlozoUtx6BGiFVXw94LUBTZ
	tQp7peMUZLylCgPWH5qJSdM5jvMTJ9wRKx9gJ/O+U/K7yd/M3G9QWSMnQAcnx7dIhyn+ifujb5/
	XOgeZ1h4x54IrBXZVRrmp6/Uon0Roj6uYxYSSF1bDHUlQFAwRyWj4o+o3n3TUwstsrGo9oz9ho4
	Qv6fWPKv3ATvMJJmQaPMlYB89o/U=
X-Received: by 2002:a05:620a:7014:b0:912:1206:ddd1 with SMTP id af79cd13be357-93f29b46ad7mr1631405185a.1.1792507543007;
        Tue, 20 Oct 2026 07:45:43 -0700 (PDT)
X-Received: by 2002:a05:620a:7014:b0:912:1206:ddd1 with SMTP id af79cd13be357-93f29b46ad7mr1631380385a.1.1792507540863;
        Tue, 20 Oct 2026 07:45:40 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:4884:6e9a:d9ff:9fa6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1df370381sm179377585e9.1.2026.10.20.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:45:40 -0700 (PDT)
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
Subject: [PATCH v3] platform profile: Separate handler locking from sysfs lifetime
Date: Tue, 20 Oct 2026 16:45:25 +0200
Message-ID: <20261020144525.3265851-1-daniel.lezcano@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1OCBTYWx0ZWRfXxcGE+5xxp5DW
 qJD85aJkChxi0sspSKo1JrZqUJjoSorRIujQdb/hi1Pg+iFcRcDxX9wjJEGAJ7PNsNpYD2Q5y6z
 5NfRKeVfUKnmfuu6YVJGm8SnNLkYzQs31SC/pwK5PMHfvU8r1xV/gMZym2lHcxZVNOmTIoj4xyQ
 bZhcqxrjUQrTlKYeITf84JW1D48CXfqNCoiC2u8RDgwMNvjNkJ4f1rqIG6h7Ejk7CLYTz54D7uA
 1B5+NYqsj9sJCZYAcKecBpvJmwHwbQbpSvym/VuBWoIVlqTsWZHbh1mM/++pNYbsHxEFMijoc44
 Q7m15u/ON0XGK0tMqeYmt8eqX6uB7XfcOMPRdzXZAQzCZz4MezVqwfcBIKyi2B8rlp2ODVSYpeN
 WcYrxEnfPvAQHCokHvXNwWkVzkDcdoOtlHIaHdAHUkml6QI9pGZqayDdthfEsLPYCIDPb1tMl25
 Kfzt81OSARyBq0Hhueg==
X-Proofpoint-ORIG-GUID: imF6en1NGO_LqTfMZIk5ENB01ANOe0Do
X-Proofpoint-GUID: imF6en1NGO_LqTfMZIk5ENB01ANOe0Do
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1OCBTYWx0ZWRfXwgCCOloNTizZ
 lgkt4J6jhD1kgtWFBttjDYMXNPtUYhGWDaR1U2Jo63RpqzBUHB9ERiTkHO7cJ1osLVoePsifE3r
 e9IQsatNvJZYcPaNCddRE86l/DGgCH4=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad77e99 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=4c0kPULnjDDMktAHOzUA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200058

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

Commit 041142d7d252 ("ACPI: platform-profile: Fix possible deadlock in
platform_profile_remove()") previously fixed this lock ordering by moving
sysfs_remove_group() outside profile_lock. Commit 55b1e68134bf ("ACPI:
platform_profile: Use guard(mutex) for register/unregister") reintroduced
the issue by extending the mutex guard over sysfs_remove_group(). Later,
commit 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
platform profile") replaced that teardown with device_unregister() and
sysfs_update_group(), still under the same mutex, extending the problem
to class-device teardown and aggregate attribute updates.

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

This separates aggregate membership from class device teardown while
preserving the existing class and ACPI sysfs interfaces.

Fixes: 55b1e68134bf ("ACPI: platform_profile: Use guard(mutex) for register/unregister")
Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
Changes in v3:
  - Send the locking fix as a standalone patch, independently of the
    firmware-agnostic extraction and legacy-interface deprecation series.
  - Document that profile_lock protects handler-list membership and
    serializes profile operations against each other and handler removal.
    Explain why it must not be held across sysfs teardown.

Changes in v2:
  - Expand the deadlock and handler-lifetime explanation.
  - Add the Fixes tag and describe the earlier fix, regression and later
    extension to class-device teardown and sysfs group updates.

 drivers/acpi/platform_profile.c | 80 ++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 79d2e92e5c28..d79080a20e21 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -8,15 +8,25 @@
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/init.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
 #define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, dev))
 
+/*
+ * Protects profile_handlers membership and serializes profile operations
+ * against each other and handler removal. Never held across sysfs teardown,
+ * which can wait for callbacks that acquire this lock.
+ */
 static DEFINE_MUTEX(profile_lock);
+/* Serialize registration and sysfs updates without blocking sysfs callbacks. */
+static DEFINE_MUTEX(profile_registration_lock);
+static LIST_HEAD(profile_handlers);
 
 struct platform_profile_handler {
+	struct list_head node;
 	const char *name;
 	struct device dev;
 	int minor;
@@ -44,6 +54,22 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
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
@@ -306,20 +332,18 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
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
@@ -384,8 +408,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &profile, _aggregate_profiles);
+		err = profile_walk_handlers(&profile, _aggregate_profiles);
 		if (err)
 			return err;
 	}
@@ -423,15 +446,13 @@ static ssize_t platform_profile_store(struct kobject *kobj,
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
@@ -450,22 +471,11 @@ static struct attribute *platform_profile_attrs[] = {
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
@@ -502,8 +512,7 @@ int platform_profile_cycle(void)
 	int err;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &profile, _aggregate_profiles);
+		err = profile_walk_handlers(&profile, _aggregate_profiles);
 		if (err)
 			return err;
 
@@ -512,8 +521,7 @@ int platform_profile_cycle(void)
 		    profile == PLATFORM_PROFILE_LAST)
 			return -EINVAL;
 
-		err = class_for_each_device(&platform_profile_class, NULL,
-					    &data, _aggregate_choices);
+		err = profile_walk_handlers(&data, _aggregate_choices);
 		if (err)
 			return err;
 
@@ -525,8 +533,7 @@ int platform_profile_cycle(void)
 					  PLATFORM_PROFILE_LAST,
 					  profile + 1);
 
-		err = class_for_each_device(&platform_profile_class, NULL, &next,
-					    _store_and_notify);
+		err = profile_walk_handlers(&next, _store_and_notify);
 
 		if (err)
 			return err;
@@ -583,7 +590,7 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 		}
 	}
 
-	guard(mutex)(&profile_lock);
+	guard(mutex)(&profile_registration_lock);
 
 	/* create class interface for individual handler */
 	minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
@@ -604,6 +611,8 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 		put_device(ppdev);
 		goto cleanup_ida;
 	}
+	scoped_guard(mutex, &profile_lock)
+		list_add_tail(&to_pprof_handler(ppdev)->node, &profile_handlers);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
@@ -614,6 +623,8 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	return ppdev;
 
 cleanup_cur:
+	scoped_guard(mutex, &profile_lock)
+		list_del(&to_pprof_handler(ppdev)->node);
 	device_unregister(ppdev);
 
 cleanup_ida:
@@ -636,7 +647,10 @@ void platform_profile_remove(struct device *dev)
 
 	pprof = to_pprof_handler(dev);
 
-	guard(mutex)(&profile_lock);
+	guard(mutex)(&profile_registration_lock);
+
+	scoped_guard(mutex, &profile_lock)
+		list_del(&pprof->node);
 
 	ida_free(&platform_profile_ida, pprof->minor);
 	device_unregister(&pprof->dev);

base-commit: d0cd1e850e1602729dd60dc3c5fd96f80e0cdc5d
