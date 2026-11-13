Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570803;
	b=q6gVco7ZnIHZmim6u3vOAlsHz3OBlwniGmbEg/vxGuxhJUErzuqHLn9uegbH3mcB7RSl
	 g/Y1/m7ysiThjIA7zMrs4FTUxoinxy8XuSgdOLWtb8WwprFGlDjz/tOxXpVdgCBHF0E00
	 1ExolkKSt72T62qSwrhNIfRONwa86YO8RU3DuPUkY2Oe3jG22jGz3/KmjGYbH1vbMQSEN
	 irS1v8wC59dFCmonXil2p+DnAk7HBLs6o47bsImxhrdjg2oLwtlwiNE5NRitDSDzGMO56
	 8TUwnYcVODUm+2dJJd9OwHlqVk5XjAhB5vdolqdaaS8VTJgUzY32yLwuBSWDAsI4AIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570803;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=WJKu/Arzc/EEikAwb/64EDyrzwUJzgSWmdnai7x0pgw=;
	b=5DNw2ccLCp0zLDHXemyjBTqgVVxw6f4Nq6mJ1XdKqkF7kLj7Pv1aLUMVl+NFDh9/lQ8m
	 xBEu/ad5WsY+QSTpLsgPXE4uoFqTpRfC9mZUTXkczGKVOQfW5oC5T/KjWrK3vnWsG7e34
	 6ZR1DkiG/pSsgIF1Vnrke6eOW+A2zeQj/HY088BPn0S5vK3oELBtiQgnJtkQU5qYxB6KH
	 NEvOTJ7WXyhCKUldZayZgd/9pp0uydfx8TDqz1yFHNuHj5hK1Gpv8EgffIRAbfKMX4rJo
	 bwz76u0hLC0f847jRCWIRDYuchfyKZ5gjs2tOlKaWPkejNWnVw1l8Y7Qx+y/FlUuAYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mYmuN+lS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XN8k3S9f;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E37606A327
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 11:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7E37606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mYmuN+lS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XN8k3S9f
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8V0FM4101625
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 11:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WJKu/Arzc/EEikAwb/64ED
	yrzwUJzgSWmdnai7x0pgw=; b=mYmuN+lSYZHEnSKGy4FbftClmGXf7HPhkAS4N6
	QKSIS8NeEeGXSa4pDagZVQ8nGcFV9Eib7WYg8YeA0ZGGQp418q42S5GHH8KWby1s
	OZTXOLIvU+3gsoW+KnBp4n1lMVEP+yU+59zBJjP2tlwO8w8P0o9zTEvwVDStKGCu
	/ouEl06bpZ2OmUIOrVLwrP544lSvnyu5mXuEVD4dxHk9KAKCdpGII/40mxHPHqZ4
	HyzMW9dpWmHg6rZ4TK2aMlVdFlj9NakrJpq8AsvJlpBlKpUZTtICJ86O6itYKA0Y
	VSmuiKjvrC5xT5PP41Nnwd1uoaAeQnBZt7a4nQ3oKIxwB/wA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkfdjyvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 11:53:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3724667bc16so499488eec.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 03:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794570800; x=1795175600; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WJKu/Arzc/EEikAwb/64EDyrzwUJzgSWmdnai7x0pgw=;
        b=XN8k3S9f0FiCJC4Gci2ZxY/0OiNHHA+ZWImSqwyL1rcn0IEWjnRHL6kdr2TQZMDck8
         sOtXClkGTEyhZX/O0fsQXXVuAf066bLskJ+S77g9N48sf35C2DVZ5unXUy40V2FfL+44
         i5VclIuzU5pm3oj/kKXDEpa4k++0zsBdXlr9P459Gmy+zxyocyhFWP9G/6kMBq9CBPzV
         Ie3w1uu3a3ozwWQ3y8nFM6BHWrTwthbUYK2UuYl13kEE2+Ai4YVWEecqzzCZUG5G281o
         HqRT8alwEzSRKjm/6dWIzncb5+N1PYaLj8EjpcK5GAW1WjB+riLhwp4nluGficdZEfkG
         1bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570800; x=1795175600;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WJKu/Arzc/EEikAwb/64EDyrzwUJzgSWmdnai7x0pgw=;
        b=xhwQ4GjTqRtFenwgFdSRSy+3XXSPa0y2OyB1wWpFOZgNq2wu7ODX5sTubWdqgpqn6W
         sgUej6+mWMffefrTOH+8FRhgErBHR3fFfXNwYSYicD9dCYakkwW8UhsTPWg3EDLGWkDG
         hlM7viTCeYrdMluKBlw4Js4mmaoEb0eKiQ1XH5i9X4ocnOpE5zsTmM5JI8E8NvMH5NE/
         3fs4JlqF2DFE1ewkIN7t2CIkR03EWim4noVnyrMbdaAFNiYB3jsJmK9u2Y9Yyusbo3lW
         bLzJGcvrh75/mEefrYnP0oQZ5QZrncBYOUdO0Fz8WgZa4zV7Q0Uo4qHmyyyjNiEQ9UUl
         RK/w==
X-Forwarded-Encrypted: i=1; AL+hErEpf7b1XkSpf2rihWS5RqdkXUdyNe7VE6vN5MFyC2y3rmPXtB7oA6w6eT1rqNFfo/3Zrfc1GirQKg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/5k3McfVj/gSGhWKGjdHBu9+1Ut9pEbPCF7JXjIgB0wrQlPtCF
	oFVPK4MReKpvojzde9rd+pQi+mOCnG/PxybBKosvjQ/H2FGRnP1Qgl3Hnfo10LyJiVNoilk/jc/
	DtIrbBymJp5nCgGSI7Omk1ClZ1u/hqqxovC2hyRPSZfyhHPjInsS5elJIQGxiNQ==
X-Gm-Gg: AYBFou12DifaIAIOGJ3C05aAntRLlCxYGz6ekGJTqH5xhuEAba/54pddInP61pHp4gg
	mD1H9Xw8CCoRd0+KVZkUHjmMVz7P4b/yk50k288vJYFyp2bDGWgtoIKDyIgfyPIOtipXSoKyq3l
	7Qt2+zGgwrX8WgEjpuz+mTALa2RdGmSR8T6VGeJzcwPNHWJeNlfQQxa8lxUzOJSUjZFAZeosxkT
	NRnUNnSceUY7Wvr/qCY51jOaWhsUBqk9GUqjHQf2+dw3h9NQd0W/7fLXI2V5CgwZXe9hWmEfGBP
	tWRmIjwiCsan7WeUi9zP5cLkaR2mOhXunBEYIoTJrjhz61BBN/YFhEEp7INO+A4X4PsdeuOilU7
	ANvnMnRn+EjtqfqnxjgpItx++jntFddBMXQTeg/LAXM48ixTnCNPcdFgPrB2clJJkEthY
X-Received: by 2002:a05:7301:1887:b0:36d:6a77:960a with SMTP id 5a478bee46e88-37963564b9fmr1866749eec.1.1794570800315;
        Fri, 13 Nov 2026 03:53:20 -0800 (PST)
X-Received: by 2002:a05:7301:1887:b0:36d:6a77:960a with SMTP id 5a478bee46e88-37963564b9fmr1866702eec.1.1794570799506;
        Fri, 13 Nov 2026 03:53:19 -0800 (PST)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm12740333eec.21.2026.11.13.03.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:53:19 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 17:23:03 +0530
Subject: [PATCH v2] thermal: qcom-spmi-adc-tm5-gen3: move hardirq actions
 into threaded handler
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
Message-Id: <20261113-adctm5_gen3_hardirq_removal-v2-1-a0c9c4800941@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAB769moC/42NQQ6CMBREr0K6toRSKMrKexhCavuFGkrlFxoN4
 e4WvICzmOQlkzcr8YAGPKmTlSAE440bI+SnhKhejh1QoyOTPMsFi6FSq9mWbQcjb3uJ2uDUIlg
 X5EALUcmCV7I6AyPR8EJ4mPdhvzU/9sv9CWrelfuiN352+DnuA9t3/z0FRhktuQBdZpxfhLo67
 9NpkYNy1qaxSLNt2xcE859c3wAAAA==
X-Change-ID: 20261111-adctm5_gen3_hardirq_removal-467a437a78e1
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794570795; l=4889;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=dYTBs/gsix6DWkwlV/rymYVg/SxEk2rX5m0nPPqS4HI=;
 b=W8aBul3VWFbYUg2/3ETwIvkOaNl4e3QLQDAm+qI946/8WtaSMEOCRLj3N34U5EvwfoZqhj9Cq
 ERYmjHN3zNCCvbQ23Vs3ckUbiW+g7RkqL/UxUHGCgAxxe480PWGocX3
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0NyBTYWx0ZWRfX/OmngfqfsEnp
 ADgqiRbkYQHghXo7iiPXSfmT1gm7yWpB9BEpGtmnyZIYzp/PaxqoExA2njaPwuUSf//aYBxzwKp
 J4WOPnldWkUoPKzskXTOW5LL3anve5o=
X-Proofpoint-ORIG-GUID: yb0ISMoLw9cU-jRrlvIV5n-UUJ1n3hpf
X-Authority-Analysis: v=2.4 cv=DoTDa2/+ c=1 sm=1 tr=0 ts=6af6fa31 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=zlfbmXi6rwQ6R9OsHyEA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0NyBTYWx0ZWRfX0HTg7n0q4hKI
 eE6ZSvi5e1XEfFfK2QBrIaXwdrcXK3tIq3FryVK1j7DdWCGQb0rtpT2nWvcMRrH8hGxo+m+Wejl
 ZnGfNLx+/LGu0CXPOAF28ErEwK4FOgcymurRS9GVJ/bT87vZQg2+QxaVFwwVBxfECoWV0UxmUE2
 wr9Ye92UZqXftiIeh3WnrzgfJcvNow2srDfPFXWQ4cNoqVmVz8I+yC4JpjfqSRV8fsch2s42sLp
 pFYnkBIwNsddKYC8a8mOj6htFqLcVnVDDVPtiEqxIsNwi1i3RPQZC91vSEKis/lXwP+vUihUhBe
 KeOh3NO8FUZBy4PZzFDwoe920hEoP5/559MnIxPeNxjgx418E+/UYHCIzM7KT/RMI64CfDasCxi
 /0XzjbhVfG5IWHn09Z0QPWy6HnBn0DMJvosmeiTM3NT+8mj8M5AYnMrVnndoxC1GwTuLKmJ8wiT
 /jadL/QHOJyNv9K2hig==
X-Proofpoint-GUID: yb0ISMoLw9cU-jRrlvIV5n-UUJ1n3hpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130047

adc_tm5_probe() registers the ADC_TM interrupt with both a primary
handler and thread function (adctm5_gen3_isr/adctm5_gen3_isr_thread)
with IRQF_ONESHOT. The primary handler calls adc5_gen3_read(), which
takes the SPMI regmap's lock (a regular, non-raw spinlock) from hardirq
context. With CONFIG_PROVE_LOCKING enabled, this leads to a warning
about an attempt to take a lock in an invalid wait context:

  swapper/0/0 is trying to lock:
  ffff000b67201018
  (qcom_spmi_pmic:259:(&spmi_regmap_config)->lock){....}-{3:3}, at:
  regmap_lock_spinlock+0x20/0x40
  other info that might help us debug this:
  context-{2:2}

  Call trace:
  regmap_lock_spinlock+0x20/0x40
  regmap_raw_read+0x88/0x328
  regmap_bulk_read+0x10c/0x340
  adc5_gen3_read+0x38/0x50 [qcom_spmi_adc5_gen3]
  adctm5_gen3_isr+0x90/0x130 [qcom_spmi_adc_tm5_gen3]

There is no requirement for any of the work done in the primary handler
to run in hardirq context. Drop the primary handler and move all the
actions in it to the threaded handler, which removes the invalid wait
context warning.

Note that both handlers used a local variable to hold the index of the
SDAM whose IRQ was triggered ('sdam_num' in the primary handler and
'sdam_index' in the thread function). These are the same value under
different names and 'sdam_index' is kept now, since that is the name
used for it at other places in the file.

Reported-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Closes: https://lore.kernel.org/all/1cb6d902-73f3-4d65-96f4-4b3c5217253c@oss.qualcomm.com/
Fixes: 948ee3a74f35 ("thermal/drivers/qcom: add support for PMIC5 Gen3 ADC thermal monitoring")
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes in v2:
- Trimmed call stack and error lines and added clarification about sdam_index
  in commit message, as suggested by Andy.
- Link to v1: https://patch.msgid.link/20261111-adctm5_gen3_hardirq_removal-v1-1-536ed503396c@oss.qualcomm.com
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 41 +++++++--------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
index 910b241fa94d..996bfcfcac35 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
@@ -73,58 +73,38 @@ static int get_sdam_from_irq(struct adc_tm5_gen3_chip *adc_tm5, int irq)
 	return -ENOENT;
 }
 
-static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
+static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
 {
 	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
-	int ret, sdam_num;
+	int sdam_index, ret;
 	u8 tm_status[2];
 	u8 status, val;
 
-	sdam_num = get_sdam_from_irq(adc_tm5, irq);
-	if (sdam_num < 0)
+	sdam_index = get_sdam_from_irq(adc_tm5, irq);
+	if (sdam_index < 0)
 		return IRQ_NONE;
 
-	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_STATUS1,
+	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_STATUS1,
 			     &status, sizeof(status));
 	if (ret)
 		return IRQ_NONE;
 
 	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
 		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
-		adc5_gen3_status_clear(adc_tm5->dev_data, sdam_num,
+		adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index,
 				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
 		return IRQ_HANDLED;
 	}
 
-	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_TM_HIGH_STS,
-			     tm_status, sizeof(tm_status));
-	if (ret)
-		return IRQ_NONE;
-
-	if (tm_status[0] || tm_status[1])
-		return IRQ_WAKE_THREAD;
-
-	return IRQ_NONE;
-}
-
-static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
-{
-	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
-	u8 tm_status[2];
-	int sdam_index;
-
-	sdam_index = get_sdam_from_irq(adc_tm5, irq);
-	if (sdam_index < 0)
-		return IRQ_NONE;
-
 	scoped_guard(adc5_gen3, adc_tm5) {
-		int ret;
-
 		ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS,
 				     tm_status, sizeof(tm_status));
 		if (ret)
 			return IRQ_NONE;
 
+		if (!(tm_status[0] || tm_status[1]))
+			return IRQ_NONE;
+
 		ret = adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index,
 					     ADC5_GEN3_TM_HIGH_STS_CLR, tm_status,
 					     sizeof(tm_status));
@@ -405,8 +385,7 @@ static int adc_tm5_probe(struct auxiliary_device *aux_dev,
 
 		ret = devm_request_threaded_irq(dev,
 						adc_tm5->dev_data->base[i].irq,
-						adctm5_gen3_isr,
-						adctm5_gen3_isr_thread,
+						NULL, adctm5_gen3_isr_thread,
 						irq_flags,
 						adc_tm5->dev_data->base[i].irq_name,
 						adc_tm5);

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261111-adctm5_gen3_hardirq_removal-467a437a78e1

Best regards,
--  
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

