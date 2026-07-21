Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFF403142
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653916; cv=none; b=RHysM0HVYdhy0ip1qXEXrp1t8a005WTmnf7lu+Jv2oyOOspkovWqtB4TV0l+kR/K+Q2A5e0AmZmw5rseci6CSNPq4uy7wda2uQN8piUcQUEGcKSFVDrNlKGIqD1ZoxX1wiDlvcbM55++onz7G4bbDtCE+eT1D3xB23M4vQHl+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653916; c=relaxed/simple;
	bh=4U8yA0YUChRaMOVMbjLw28gimlUxZgOzczMBFEHezTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AegJj+Ks71pOBTXfoib6fsPkfdhW4s/apyQs6PoyloYp20sVLdDYq/A1RdH6FjO+ITMGao9jxKLlor6iIXg8VxTCGjfmoykYqBpQ5OiUo0+wWp++qfAwnxUrAxb05D3kAesGUJgLDdwRWSOn5cJKCNRL5x+rAXjnJSY2OBxhsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eiWTPPC+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UVxENp2U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eiWTPPC+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UVxENp2U"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LH2eFj2280245
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 17:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uYf94+pM2iIpd3sipisRWv
	mhtydcyHiqiNCiDAnwd/M=; b=eiWTPPC+oy4rgzT7NjtFlKtqflbav1w6LHZ/oK
	8zVR/DJlIUENt3VjGYClP24g6dqeeiLfi2TdAm43yNjDfi2aL4xsnFwCF7glNHkt
	e4iWLHyGU7Z5Oseocab0z9oZvremmXMsSrIUHCorQxBHfZTXQbWhv8LfHQK6oIca
	gGUalwgWH+9w+UZeC1dX+fxgi4doXYY9Ho4GumpI6d7dSZPzxl0qI6awqzR5noV6
	+UOgm/Au5LDRK10g1W9azrrmAGO/Y66ucVgXc/BDGKrySCzhkhFlv7gC0JSGAXlQ
	xeKtZbtxNkDYdkmQnnMAQ9Ef/3q8RlDypj8iocZdWZMaWdAQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6paa17c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 17:11:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cd01a14e81so168471245ad.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784653912; x=1785258712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYf94+pM2iIpd3sipisRWvmhtydcyHiqiNCiDAnwd/M=;
        b=UVxENp2Uefnzdlbn2Czj5qpSrMUfRiY2PcjgiWf/ob/EkjOLUXgKWUO9aaNi766pq5
         kVPYeaMwTOEOK8R2caHuNVYD3AXI7Q8OpJMPmOIR/iNm4EcC6rJY3Ghlm3hbmb+mHsiF
         rFPTBXLGrCx5RFDVFpVlawuZAcVPOH5doJoGAtOI3N127Slyflb4iRa5bw0l4W3IzAOL
         9ue6p+d4vZKErN6tsqiuot4aVPycIxsacZxzxdyBhcv6n+dkcnrmokRpqCKxnBTqnG/A
         SA4DyDP8xLG/YlkqG+MfOIIeMKFnpcpfd3cSoNeqAq/ipuYRghxgJkik7G3SQG1fLJDM
         cf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653912; x=1785258712;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uYf94+pM2iIpd3sipisRWvmhtydcyHiqiNCiDAnwd/M=;
        b=fwucv9JhoFGVXuFdDFU1cKCfXIrRdSx4y39uTFGtETqz35rJGK1s1XmvQFytqMzAWL
         +qfXfnmyhQih1HwAwEc9jDyDimCgbmfvO63vRnSekhTiKHkgjP+NJntvqvH50RmZpS6z
         AiT2Hg2YpSOBdmXZGXcNW/U9USYSc0szfi2wev4wiibJ9AHF05cUj//WwikyHvoQspTC
         ZwHktVrVLHru+UmVe26dKqKQUogNYN/emjqMLhJCGGMNSy/elcU1zHTCUdZA/wAuccIX
         NdtJfEgHXDE8BGDhoUXV+ATGFacAMptvqjtguGybSSIr3QdgrQF1zU6v1/RaUtkJTc5F
         CvGA==
X-Gm-Message-State: AOJu0YyYZlKUK23cb22iizfyluSh6jpfRVmZduMST4anZpeYV5uj7pUr
	7G5E7Is5wiuXKeZMbiJNitY0at8eUluItnxm0cnjJMc7Lisaw/+/U7owQMtAwugmzgKLBCT1AUy
	N1sECK0P6G+vp91u2Y1XVjwR0nwmqVWkuxe0WJHMgm3nqA+PR+D8FeTeeVebayQ==
X-Gm-Gg: AR+sD12t4B/aRuT5PmCbem5Qc4jxsIYPE+os8+rGRHbZYBSF76YOCtsZH79i0HgenHn
	AJEnA875iVCiH3DOOqeibASJ20Or+7h1e7UW6OYiN6nTY6kxK8s2Aoz9DMUu8uM1gm5gtyroJ/y
	vCxDGZ6PqmxsLkUJvwl34zi/l57t0qhYfY0PK/vt1vC1ZugV/ShNkcV/87lx//3sApz8l/oI/hF
	/P1DxoWl2GmCUBX6ZyLnkllE9ib1nmrlxZTWvCvziyK5DwrCLPCTg/5iiEY/3fXz+UiKmymNj0/
	L1essFWqHvhh8Us/B3D7BE3easNBupsRbPrxdYSZTI5O5dTJ+xV9cB8gGe2LquLsCkmbeD375zb
	zwyKQHTRBce3R88J1/T9r+HHOvws=
X-Received: by 2002:a17:903:2287:b0:2c9:9dc9:e423 with SMTP id d9443c01a7336-2cf349bc322mr210344645ad.25.1784653912290;
        Tue, 21 Jul 2026 10:11:52 -0700 (PDT)
X-Received: by 2002:a17:903:2287:b0:2c9:9dc9:e423 with SMTP id d9443c01a7336-2cf349bc322mr210344205ad.25.1784653911630;
        Tue, 21 Jul 2026 10:11:51 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1a67esm813646eec.2.2026.07.21.10.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:11:51 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rajagopal Venkat <rajagopal.venkat@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH] devfreq: stop monitor before calling governor GOV_STOP
Date: Tue, 21 Jul 2026 22:41:41 +0530
Message-ID: <20260721171141.1281754-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2rq-ow3XkKotDbwsBVdd-M3nTtMt1iuC
X-Proofpoint-ORIG-GUID: 2rq-ow3XkKotDbwsBVdd-M3nTtMt1iuC
X-Authority-Analysis: v=2.4 cv=eYYNubEH c=1 sm=1 tr=0 ts=6a5fa859 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QEJ3Dkhbv9rxNcAKX9QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE4MSBTYWx0ZWRfX9tgJnndGdN6l
 1gipyvMqdbyMqz0IWmgw8SrxsNbyE4TKnK8pOiDoP8deFbWQPXAMuaJz7JwoOmTe3+7YX7cJTNr
 dPeM4qaB1fsuMF4ZCAd3xkDAO1H7ZyuKtMeoxuqyVFTmyo5VX5zTMQRZxxr7Cg4nO0pmvaI0qMV
 MHaALV3Jwk2bzpLX7KjRoEsUuG8pAY5VNSArGVogFcEhdtU9bvi0aZFrH27+mLZVYTQkdVeQlsx
 E9BEXoDP4UK6qhYlnyRqGJdjhNz/XWjy/tUgz+GB7A4gWxGewMzlPnxk/BidoFN5tk1/zDBIJUu
 CqpgWdpPrGFcEOTxoGo/rSIN/teTsur2Sm8iWvgxkQxA/L1qBHfINC/EQWzrTIyK0GL8fq2nt4k
 a8xc91N+8WNh5v2n9rlNwiFqq0tYVtkzwuZ/lzqubK//RIa1Ge2nlRXehoqg6Fi+SISwY/JSxf7
 lj3gtXPbjpqBlFkq2Uw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE4MSBTYWx0ZWRfX7RgySTPX1Yz9
 bRdr9Zf26D32E4HfJUKuVe12GKIpSPdZksJg/zw5O027dTyUHlGuYq9QE82XikiBczvfEeEgTy4
 tXvtQf9jG/fFssY52UEQjH/fjYsdzbU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210181

The following NULL pointer dereference is observed when devfreq_monitor
fires after userspace_exit() has freed governor_data:

  pc : devfreq_userspace_func+0x10/0x2c
  Code: 39402109 --> ldrb w9, [x0, #8]   (x0 = NULL)
  Call trace:
   devfreq_userspace_func+0x10/0x2c
   devfreq_monitor+0x34/0x134
   process_scheduled_works+0x1d8/0x804
   worker_thread+0x1c0/0x458

The fault address 0x8 is userspace_data.valid — an 8-byte unsigned long
(user_frequency) precedes it, so governor_data == NULL is the cause.

The race: devfreq_resume_device() reads df->governor without holding
devfreq_list_lock, while governor_store() updates it under that lock.
The stale pointer dispatches GOV_RESUME to the old governor
(simple_ondemand) after the switch has already completed:

  CPU 0 (devfreq_resume_device)        CPU 1 (governor_store)

  read df->governor → simple_ondemand
                                       lock(devfreq_list_lock)
                                       GOV_STOP → monitor stopped
                                       df->governor = userspace
                                       GOV_START → governor_data alloc'd
                                       unlock(devfreq_list_lock)
  simple_ondemand->event_handler
    (DEVFREQ_GOV_RESUME)
    → devfreq_monitor_resume()
        stop_polling == true → re-queue work  ← stray monitor!
        stop_polling = false

devfreq_monitor is now queued with df->governor == userspace. When
devfreq_remove_device() or governor_store() next calls userspace GOV_STOP,
userspace_exit() frees governor_data. The stray monitor fires,
dereferences NULL governor_data, and crashes.

Call devfreq_monitor_stop() before every GOV_STOP dispatch in the core,
ensuring the polling work is fully cancelled before any governor tears down
its private data.  devfreq_monitor_stop() is safe unconditionally:
IRQ_DRIVEN governors return immediately, polling governors that already
call it in their own GOV_STOP handler make the second call a no-op
(stop_polling already true), and governors that never polled get a harmless
cancel_delayed_work_sync() on an empty queue.

Four sites are fixed: devfreq_remove_device(), governor_store(),
devfreq_remove_governor() (governor module unload), and timer_store()
(timer-type change performs a GOV_STOP + GOV_START cycle).

Fixes: 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices which can idle")
Cc: stable@vger.kernel.org
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/devfreq/devfreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f08fc6966eae..7538f20657b7 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -993,9 +993,12 @@ int devfreq_remove_device(struct devfreq *devfreq)
 
 	devfreq_cooling_unregister(devfreq->cdev);
 
-	if (devfreq->governor)
+	if (devfreq->governor) {
+		devfreq_monitor_stop(devfreq);
 		devfreq->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
+	}
+
 	device_unregister(&devfreq->dev);
 
 	return 0;
@@ -1344,6 +1347,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 
 		if (!strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
+			devfreq_monitor_stop(devfreq);
 			ret = devfreq->governor->event_handler(devfreq,
 						DEVFREQ_GOV_STOP, NULL);
 			if (ret) {
@@ -1416,6 +1420,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	 * Stop the current governor and remove the specific sysfs files
 	 * which depend on current governor.
 	 */
+	devfreq_monitor_stop(df);
 	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
@@ -1863,6 +1868,7 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
 	df->profile->timer = timer;
 	mutex_unlock(&df->lock);
 
+	devfreq_monitor_stop(df);
 	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
-- 
2.53.0

