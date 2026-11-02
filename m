Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630825;
	b=b3w5GyhI+DXeNdlHj6e8KYVNw0xd83/+dnCzkCsWOxVBAxTyxOtVGQEmHmZIc+y7oswl
	 adinlvgLJYOwhFbl9Qm0sK04cNEgtjRRhBhZ14B2nx2/yj7OjeDdKnHzVeOzcNycyFjHN
	 0+PgqsX4pcoEAjSngjsY08KFJAZtHkG8VFcle646ebKojetojoEvoIbXH8FcmBWiNPBO7
	 c8knnwPzSzP8oXw633VpRM9l6g2QUbP5WiInt/6BVSI1OwT9hSVDUPP6u+DxsG3dz53vI
	 SvsbP4ryMgOUEfz/n4lMG3qGvhwejMfpVQfex6oZja7zc1gZ8EuqEceKrmzUqMhREbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630825;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2qrJ3KtJ0cuR3JwG4sVYGEim2RKQKNEp6dMT2f4JvhQ=;
	b=TZcZCppLVYc0HynjrjlM14OGa5D3PWaTFHM23v9QCMY5wFJf9tElAEjZpv9kfKEsFk/f
	 DccMcuDuGfpfGTDk4W309MYnhsngCvg1bwGUmnk+E8OsbN9JjxpBPZbC+rogG2gvTSYkr
	 b7znN72RUkwlYg9EffP0s3jRsixsSYnu/3w9TK64efAIKVb1kPlpYBIII7fZOp9KyUXlZ
	 T0T21iUIJ7UQMrgK5c4cBcwLTNZtRC4fOIOt3ucpq4EttJMvaZI3pDZtjQ92HPBagad+q
	 cE8f+AUzGkvkyXRovkLevagQc519pmJ17qPEysHLCfdiXgs4RTX4SVDbOWCY1fSd4Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="nYZSh/MJ";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="GpTD/Pv5";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A960A6F59
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 14:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F8A960A6F59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nYZSh/MJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GpTD/Pv5
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpU89477163
	for <linux-pm@vger.kernel.org>; Mon, 2 Nov 2026 14:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2qrJ3KtJ0cuR3JwG4sVYGEim2RKQKNEp6dMT2f4JvhQ=; b=nYZSh/MJpImfDoLt
	fimkIqi99tBaoECD0BbvXHKcK6HLzFQWp0pVl1FQpXnWVc404mzEpvp4rDARHmIj
	3XoSZ2cJygs5hQxqSmOeQpEfuu48+FgnCBGeXDjhoCQ6xKLOrCtXtYqXEB3bPfZu
	X8ZYTc26UQ7V9bFxBYbK7CrAdsIfejidJQPH25nB1OokmK27Lv/hJVenvv1VNOup
	9mT/bZ0gHNHM8ZiodW+qf1gc9MWeditQoIjstT77gKb3YVmE2DErAJoFMQw2qBBc
	kdO4/3UrFoiI1k3YPFwGEAKDR//xHaxPEIXMT42YOCNU942j23DwJwi2WpK6nQWi
	ZMay8w==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph19mba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 14:47:03 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7c0bad5ec1cso821011137.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 06:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793630823; x=1794235623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qrJ3KtJ0cuR3JwG4sVYGEim2RKQKNEp6dMT2f4JvhQ=;
        b=GpTD/Pv549kUlw9cQQEEWqPpS0yA4ULzwXKKK3KlOOQ8t4WOZkd/KFEIgaisObSeo7
         M7Mcig9swPhLurX+B5sFy4ru6Z8whCyu/rBPrYQ6s4yIBDCYRzI+u/ARCT0G6AL7ZgGj
         42MqmZTc5qZ60WV0H6+IRxcaAiB35DH71FSou1WObRuAQSWztbRp/882XtBtR7inCPHJ
         +waju3XG+ODHoUaEX7ZBLjqJLZgku02e4clhnP0hGDl7PqO6ZXotch0tdJHo0knxJsqv
         HSE7vNtppgQs/I8M8u057VM5EYSlwsLYZK4bBKGQekRUdSIay4xTx00KaAQuNvAHSfpU
         5hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630823; x=1794235623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2qrJ3KtJ0cuR3JwG4sVYGEim2RKQKNEp6dMT2f4JvhQ=;
        b=ynV6jIeRwfnHCpkMPcEhYcq3N4g2vpBkJhsmz4fxNDO6qbOITXxxhdEVy26cmyqF7Y
         9k0Dwzs4nyQou5GkbDN0ibPDpK/dI83QchVOD1a3GViRnkzaLSt1ghKAVjeBzC0ZiEWY
         AjRbtfmvmADhBVLvyKLlUq8sk86nYs28u2r1yuVDAEMnOqmnNHRFX3rvsqnHZKHvHzAp
         hKWsyuoMqDJSZWfUmXD+BOd8O4M/qf0O2Sv3JVQDcQW4OBQtmy02De30Gers/cp4n4fz
         cadKhtvQpDt5PcCh7Ev/o8nSE5bzLh8+8dG0yDnuWboMxWiG99pmrLHG5ZFoVxzFtT7Z
         DGag==
X-Forwarded-Encrypted: i=1; AKwUvBzgKqtszl0/aXCmfkAD8r/E74VEq+9St4BD0JUba63REGkZO4dZ1MTCbBvtppAk75hg7WbHdmmHmw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8u3+WKxHHZfgGBVhLRHSJsX7RxZjQAJ1Mjf5rhLuxJUpweJpUD
	PsDvtTn7i7L/FLksSrYjopxWFzqfpmJoGrusR45IQOPLYXBnRyjB/yni9WHtiXqRoJMgdnS4fFc
	1EYaZ5XmvqQ6rZkoDBZ0HBfixZQnUE3bcQoMmrk4mdJ43Nc1L+5PYe7gNa7k/LbkGonBHmm2H
X-Gm-Gg: AYBFou0inOHzHE5aXBjM/kOQT1yCyMoB2jomTHuY6lQ6GLHLrChVxfIysFyksWN3ol+
	HgmxoCHByEoM4ksO15FlKdh01lsbxuzslEzL7y5hy6qqgKdNE0ZWj8VxaOpTkEtMTcIZIhlaTFD
	ADDYOp29lnmkAWmxyQQR+PwXav0ADUZ7RVs6doUBAZ0VWpfETu+2mPoOfPeSsM1u2HcJezpwaS5
	ifg0m514YHph4LXlRVqK6MFuRiB4MhZY8ADF49yEjM9JCbceMLEkiyAqgkpi5sVVPNHk57yIbjO
	6EKhEcj2L051yTMHX0SZWfQbrCKlgr7AJASAtcomWre0ylDkdepehm4uv8+3kNJe4E3yMlTY7Ks
	Ocz+82h8lVfe7entLGv+CeY0xNKLY7Rr5ZmgSaXMDa0SP6ZgW64K5JyGGrA==
X-Received: by 2002:a05:6102:809e:b0:7cc:2152:4f95 with SMTP id ada2fe7eead31-7d0727b11f1mr3608536137.3.1793630822556;
        Mon, 02 Nov 2026 06:47:02 -0800 (PST)
X-Received: by 2002:a05:6102:809e:b0:7cc:2152:4f95 with SMTP id ada2fe7eead31-7d0727b11f1mr3608514137.3.1793630821879;
        Mon, 02 Nov 2026 06:47:01 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e86a06078sm4004893f8f.54.2026.11.02.06.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:47:01 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 16:46:51 +0200
Subject: [PATCH 2/2] PM: sleep: Do not arm wakeup IRQs for hibernation
 freeze and quiesce
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-b4-pm-sleep-hibernation-fixes-v1-2-51fac96d080d@oss.qualcomm.com>
References: <20261102-b4-pm-sleep-hibernation-fixes-v1-0-51fac96d080d@oss.qualcomm.com>
In-Reply-To: <20261102-b4-pm-sleep-hibernation-fixes-v1-0-51fac96d080d@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Ulf Hansson <ulfh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2992;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=dmhw+rLh3YLAA0NQErytWkrrn7ttASoaBIZrNZToO5M=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq6KJfLC8dxd2kJGunctvD8mTL1bgFM/yemD+25
 uop4+UbEg6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCauiiXwAKCRAbX0TJAJUV
 VlFqEACFoJpTr+nxhgWU8nLWjdloXdv30Zu8UjDTVVI6VhiGDCJN8HDUdxwfeMhXsFpdnIbm6IL
 kkxAjkFUGQ5Ppfj1T/N9zg2PJ2AcgJNLm1J3EP7c29ijV7weV4Bi1u0ppZUihip5RNqsq85xQAi
 MBT+9ZN4aeOFk9Q8pH5jlQTZDa/++MprSuV3BJ8XO0q19IWARVRWRZbWDx/Hi6DZpnSD9gjqXZ+
 kpnilG9KppwnAOXwuE93TPypfVJRlWrs4FcN7HSXadxVUTrvW4JCBE25BVgzzp/zMdAFQdtjIi9
 vWX4jFReWhAJmSwvjDHMwaWC08CX03MaJ4ANLZ8eXcctavIT4O/mk1go/TaBeUS3b0Ku+d6Fxy4
 057eYlCMCLwKu7Athi8RqiRYNVTiX1II+9ipE6RGgqFdVlvlmDmgQZhcFFFy4yDGrEeyHpyoWBl
 Ss4PmzxIqqve3K4jHz/4I5UHI5CbXZcV5ITOQB7xE7e6KVn3c6bLtL9F1U9YbryvWM09pxdspMG
 zAZNLhK5Djh6UkYK6NhLZBkWj3dE432ss99d1KxKPsTf7D2LqUp6vvoAyg2R4tREHAJkEj1khoY
 DTH7rP/357LoMvta+WR1/vts16R/Yab3R/vx+vB/DoCbbf1w53B6BKWCoSU/MDbLP8GuQ2UvcQW
 zQZMEXmB+UsGdKg==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: c7vaWW7XhnayCcTvHvjy5C3fYeVTDiRB
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae8a267 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=YW8Bwjmn6SJj6jUQKWgA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: c7vaWW7XhnayCcTvHvjy5C3fYeVTDiRB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX7NUpr/jN+caV
 YBdUMhUIpxJlpEDQfuzoYm8w5AtfNtXLyA0HSyaZP4zx68nGjSwmrDIRDaK9eefTmVgiswjm/C4
 KXhyyOHtnM+oS7EQNNTEIf8tsCEc8MCe4rPF+EYwRyNn2wP4lX9epKO1QLeC9goVR9yfL7DGF6j
 N7qoDfTlp4v3UWKMTbpTInUHBMqFCkdQ4497DdixMdi+a0bMzI5k1n4xyfLNIKC2QrWCpiNtcNF
 bNzDIXajH4pspvgRyvTzzuAnBPwJTxrTmTJwH3pqegZMRGqRtz6j/v+iTN3ifkRZ8DBxbfu/t2i
 U4ZT3QwurKR2yUgJxxjl1y+Ienw/D04s/BQhpkgr+b53lRhzQQlVLSHT6W1CJrR5hTYDCEl5XnN
 zMZLAEvucV52ZaCHaCp9VfWWZxLyY3+adgRIwRV/tQc3JajgBHfsBTd586qYqGgWZ27inMHIQ4Z
 fFsf4QneedhU/WO/3Ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX/GRjurbokSUz
 w901qSz0Y7QLtC76M1rIKOT4gcpUfEWIab7cqUbFho2Gn/GKmu+74k9/0QA2yaRpIdLffZTD545
 ekjmCuQm79kg9j2FdB/rLV0QStOqbkE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020058

Freezing devices to take a hibernation image and quiescing them before
jumping into one go through the regular noirq suspend path, which arms
the wakeup IRQs of all devices that may wake up the system. A wakeup
IRQ firing then aborts the hibernation or the restore:

  PM: Triggering wakeup from IRQ 180
  Wakeup pending. Abort CPU freeze
  PM: hibernation: Failed to load image, recovering.

On a Qualcomm Glymur CRD this happens on every hibernation and every
restore. The WWAN modem keeps asserting WAKE# once its root port goes
down, after its driver has shut it down for the freeze, and the WAKE#
GPIO of a PCIe port is a dedicated wakeup IRQ with wakeup enabled by
default.

Neither transition is one the system can be woken up from, as nothing
goes to sleep, and Documentation/driver-api/pm/devices.rst already says
that in the freeze_late and freeze_noirq phases a device "should not be
allowed to generate wakeup events". Do not arm the wakeup IRQs for
them, and only disarm them in the noirq resume path if they have been
armed. Wakeup IRQs are still armed for the final transition to sleep,
PM_EVENT_HIBERNATE, and for suspend.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/base/power/main.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 16a1f017051e..34ba0e5941a3 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -949,6 +949,9 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
 }
 
+/* Whether dpm_suspend_noirq() has armed the wakeup IRQs of devices */
+static bool dpm_wake_irqs_armed;
+
 /**
  * dpm_resume_noirq - Execute "noirq resume" callbacks for all devices.
  * @state: PM transition of the system being carried out.
@@ -961,7 +964,11 @@ void dpm_resume_noirq(pm_message_t state)
 	dpm_noirq_resume_devices(state);
 
 	resume_device_irqs();
-	device_wakeup_disarm_wake_irqs();
+
+	if (dpm_wake_irqs_armed) {
+		device_wakeup_disarm_wake_irqs();
+		dpm_wake_irqs_armed = false;
+	}
 }
 
 static void async_resume_early(void *data, async_cookie_t cookie);
@@ -1685,7 +1692,17 @@ int dpm_suspend_noirq(pm_message_t state)
 {
 	int ret;
 
-	device_wakeup_arm_wake_irqs();
+	/*
+	 * Freezing devices to take a hibernation image, and quiescing them
+	 * before jumping into one, are not transitions the system can be woken
+	 * up from, as nothing goes to sleep. A wakeup IRQ of a device that
+	 * signals for attention once its link goes down, like a PCIe endpoint
+	 * asserting WAKE#, would only abort the hibernation or the restore.
+	 */
+	if (state.event != PM_EVENT_FREEZE && state.event != PM_EVENT_QUIESCE) {
+		device_wakeup_arm_wake_irqs();
+		dpm_wake_irqs_armed = true;
+	}
 	suspend_device_irqs();
 
 	ret = dpm_noirq_suspend_devices(state);

-- 
2.54.0

