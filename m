Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511055;
	b=LFYDqzWorVT8nDmxUsQUbHDGNK8LhU4pwePKjIkPF/kO4f+R81M6TGq9+t2C/OXapmvT
	 gfZUTXsixDP6pBycbPTqkzvoQ55kHwXRFlbLv1nELmG1lWRFOul7GLTPPyuvA8J7z9ZU2
	 QBVLYpA20C6Tq9c4X5031tNX3AVDAoj/STgh5a4eE1NsT/ONuWivavMkL7Hqv/GxI2/Ka
	 Lf1pJSiCmr56jBZKhdPBPn1FJUTbCZ71WW7GwWcOJ+Q8iie4NMwqq8omOPSdf0u9iq0rA
	 Fs0wOvkrthcdb7Sf+5arh4buUIDhD41aa4uiybXAE9nqIoJDjRDtY3jjmjlv8txQPrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511055;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1UQBuNMToGONG9hy3Du+9qM2XSmErbNq29UGtfHTpFo=;
	b=5tyqM5b/Wh5C/g+/A52WIi8UOebUjXTRX9Y3ujXOxJeid72lbQZqCZmQHQGi6KdWGGAo
	 w2T45x/wRKGbvEG4UCgfB1iuQoQPT7PSYNYo2jgXcXaRjVlENSAIWGDXRVDSavKNS1uR9
	 l9zRzlY3SZIddSqXI6JuZhLlMcRHB7PCK0g20wjpwl9JOERdwjNC516OMQuAdPpKm9Qka
	 xZSoJ6YJD3PK4XN5Y/8w4kBf+QkZ9YznigscvqbL1j8Z75IGkg5trD7bPDwj/MlLpNDl1
	 tTuznybQAXISl8cfwt6jNnsaaXu124zAJB5jrRTbvw+IYIeZlEmLwwrAKj6GE2NSQkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pVeIuy08;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z9UXAD8w;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5D606A31E
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D5D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pVeIuy08;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z9UXAD8w
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8cMwl3225393
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1UQBuNMToGONG9hy3Du+9q
	M2XSmErbNq29UGtfHTpFo=; b=pVeIuy08qEr2oNoNSLP8pTCIZGYmmF6m2eOFCy
	m57rGCXwzj+u5sUgM0dI/Gvf0/Czoxz6lEbF6ucvpCInNiQ11JWKPv1HzvWJj9aD
	wOohjS4NWevM0K+cjWLfBPzyRl1cKfiPNuYhj8zyyY1Y5oLUD9FGmzbzmnv0/vKx
	jAD4UiIDmaVnWx1mNXk1jEjiub7EZVoKrUoec+wF6OY/yoQpF8IbO6sSHW/bADvK
	/Lo38n9kznB8Y1AMhj/wJnJPLwREn1qbuDfrxQLwf2yT9BwPJAXrfN7yKY0YphE3
	zKw3IH2UoQsUY3ytwr03HpeWQW2Tw6xRilpfYdmvYBmvUfaQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4x8f25dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:04:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3869865a304so3304867eec.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 01:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795511054; x=1796115854; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1UQBuNMToGONG9hy3Du+9qM2XSmErbNq29UGtfHTpFo=;
        b=Z9UXAD8wve1UhhiCqSvEwMV97LY1f0MKtBzt6hCpyqJH0RbqLxmx1BlQxWJbMNmpM3
         /eXdBzWgiIBnPsTYxv6DS/EOikExbMQPL6hZJihAgMHrpYBo2z5rK3NM1X/F+g/jKm66
         o2QZ5sAmy7FEQTWgS0UZlgOnzISAGtGzyyEyDz2jiiWI1uEeKCaccSy/MjOf5yRoBuba
         xNfipuOEfG9rASFg97eic8nOjGyjAx7SYj/gBTKKLd4E8b2OQOs9mooAHKq5GMLMwyjJ
         89bRUgrIedV9Fgh7AAYDDd0G2pp98f9sNUcENDzBdH8CBMmXzPxMLAzlVcJ00tFGsqMQ
         J1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511054; x=1796115854;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1UQBuNMToGONG9hy3Du+9qM2XSmErbNq29UGtfHTpFo=;
        b=jrwwYjC2qEagZKQGvdGKPkRl5RySsZ4GH+7MSzI06gijAN3U7IOTVzW6V9/Nvqv25F
         yJEz9hQEt4loUvAbpIajf4dJYUh/a/zIbckBxPjwrJaBLkpUzuf+/n6UvZHccCT4EKJM
         rvpxnyJvNzShtGWLwNtI7LMvhvxBZnXfvnknP82e+LWW4SmyCl7YyDGGfuOXS/IGK4gh
         fUTYvYQjMj1TC9Fe+cZzEQOxe2cdcZGlhbbbjz8wAImG172f4QGfuVRbQiIIl/j/32Aj
         mMTqWCtg8KNsouk/hBsQazigWuxHeNGtk7uWsH2z4w4p/q0rGM7up5t3Vp31aHGaYrQZ
         PCKQ==
X-Forwarded-Encrypted: i=1; AL+hErF5Y/lVY2ZCzQlMaJ++YOT5j30PZ+Tsx38lCyKgQbvTx1MH8AbFNdLj/X/pXlt+SkFlq9JJ4vATLw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/YVfk3M042kazlrJqOkaKFDnWDnKzced3sSPoWhc3/6mdb8d8B
	z0LkwhMmdMVPJtu387UBY2ro4+GXyYGiFTKPTgtBxf9cG4QKDBGsa73TWraz/2cZX2IBIwc2ifs
	wNxHfgJo94bm2AjBat64AvLISu1fKXgn1IEk1UC6j7frLCBj4WFlTTEyKGs63dFuju5OSCg==
X-Gm-Gg: AZFdTZe4MqXZqJlRNXIoqou+ry9yAE8mSiwOEF2uzbyJ2JXFsXuUf0D84aYrPK6nGqA
	kyGFQwQoWz9pwq03RIEBD3HARpE9diXLiflc1LCErMZelWHkEFTHlzQvmkpqRqpBolF3abr7+6M
	Xutp111dYVIFS5ytOke9svwVoxpPSAml9loprrzq5iLZMV7P1HOGCRtre9I/dnwbkmIxFBHxHa/
	ZTfIcdnE9Wac6fN+UxhZcEj4zNoY0wmjKT5R1c8grSJZipGmV4zWkTYhKIaHV11eASJJxZezRYp
	HzV3zeBkVNZy8bdk4t1hpJ7OFkGzTJWOneNFnrhnY8VOEtMCEKDdNHMkn60tTwaVBr96tOJQ110
	C6teWuRoaGLe1vY23fzkInbeeYNNQS6aqMR4CJb+YHd6p7RMyYqTVX6CqwwcgLn7he199
X-Received: by 2002:a05:693c:60d4:b0:360:5f7e:2eb9 with SMTP id 5a478bee46e88-3857111f65amr16288656eec.32.1795511053678;
        Tue, 24 Nov 2026 01:04:13 -0800 (PST)
X-Received: by 2002:a05:693c:60d4:b0:360:5f7e:2eb9 with SMTP id 5a478bee46e88-3857111f65amr16288619eec.32.1795511053078;
        Tue, 24 Nov 2026 01:04:13 -0800 (PST)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm75516157eec.3.2026.11.24.01.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:04:12 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 14:33:49 +0530
Subject: [PATCH v3] thermal: qcom-spmi-adc-tm5-gen3: move hardirq actions
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
Message-Id: <20261124-adctm5_gen3_hardirq_removal-v3-1-c7923e9a54c1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPRSBWsC/43N0Q6CIBQG4FdpXIcDUdSueo/WHMFJaSIJymrOd
 w/tpovWOhdn+7d/3z8jD06DR4fdjBwE7bXtY2D7HZKt6BvAWsWMUpJyGg8LJUeT1w30rG6FU9o
 NtQNjg+hwxguRsUIUJVAUhbuDq35s+un8zn663ECOK7k2Wu1H657bfKBr77+lQDHFOeOgcsJYx
 eXRep8Mk+ikNSaJD62DIf0k2W8yjaQgspJZSUiV0S/ksiwv7TqkvjIBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795511048; l=5207;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=Oow7SbHjlqlBkog7Fq729nsTBAo6RGjET/g3jAQ1r/I=;
 b=4SjAUaKOLDBt5BAzga6Qw8+zDqlN2EiPL2NXOKUN2mZVWhJOrwzjDeNUlnD3agVp1vt9eizWw
 hRvPfV7qcFlBDGJocCEqMc0GxhgutAAtPg3PD7ypDik4B8M9rJmw4y8
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX6yhfEwnsbpBZ
 Hdb5H+lrok0TIlhyZAG3KrbGAqyZfY3/WbiUep9/Ib0MMoR0yMf6EN7PDRxrABKyElFGwWaQw+0
 wPfdt95MDmS1xTRx4VTx7DfokL+MWQE=
X-Authority-Analysis: v=2.4 cv=JbgpPkKV c=1 sm=1 tr=0 ts=6b05530e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=2T0weqYnj29I6vGzhR4A:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 9w6IOoS_Kf1ixyEO7bscmZLpW5mev0mm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX1NswJGb5AqMH
 oS3BLYHtEpVo8VlaeAJ5lcvhMB31RC8J4Ctv/kgQiR+5vdWF0L0Kq0cLrb85McAl+9PUrqKwv9z
 1gBSon23ClVBYrxmrvYt2c+l847J+4qBcyrkALjhyB5ZLvoFk7xchI0TNQvKXDt0qSwxIBLRnJ4
 0div/uER5I/7vwSaZsekR9NRSV22mUbomd7UmI6hZNvc6035hu4FUis0Dqb94j9meIaLipI3Igq
 xmE7rOwPnsHuCMJtkRiyhScR+ZrM0qWGS40QuXm/7eLxYAcA0UT2dtcYMYmzubZOJSnVAsDhw7v
 KjckAmvSrmMjAkoS0fpbGJfOVrhxf0jaZMcfusfK+tGogu6WpS6PupKZk9NFR1GVqWMii359hqm
 H0I+TF0cj+uXqOWOpdrqE6Ap2o5Cpw1p8LG7AeUopR/8XVUwRsRrfBbcQVqtFVBBpI9mjbHYVkU
 CbrVGtj+rgVNDAXpjAA==
X-Proofpoint-ORIG-GUID: 9w6IOoS_Kf1ixyEO7bscmZLpW5mev0mm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240034

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
different names and 'sdam_index' is kept now, since the variable
represents an index, not a count.

Reported-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Closes: https://lore.kernel.org/all/1cb6d902-73f3-4d65-96f4-4b3c5217253c@oss.qualcomm.com/
Fixes: 948ee3a74f35 ("thermal/drivers/qcom: add support for PMIC5 Gen3 ADC thermal monitoring")
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes in v3:
- Updated commit message with right justification for using the variable
  name 'sdam_index' and moved its declaration to separate line in
  adctm5_gen3_isr_thread(), as suggested by Andy.
- Link to v2: https://patch.msgid.link/20261113-adctm5_gen3_hardirq_removal-v2-1-a0c9c4800941@oss.qualcomm.com

Changes in v2:
- Trimmed call stack and error lines and added clarification about sdam_index
  in commit message, as suggested by Andy.
- Link to v1: https://patch.msgid.link/20261111-adctm5_gen3_hardirq_removal-v1-1-536ed503396c@oss.qualcomm.com
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 42 +++++++--------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
index 910b241fa94d..9e9019f5009d 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
@@ -73,58 +73,39 @@ static int get_sdam_from_irq(struct adc_tm5_gen3_chip *adc_tm5, int irq)
 	return -ENOENT;
 }
 
-static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
+static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
 {
 	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
-	int ret, sdam_num;
 	u8 tm_status[2];
 	u8 status, val;
+	int sdam_index;
+	int ret;
 
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
@@ -405,8 +386,7 @@ static int adc_tm5_probe(struct auxiliary_device *aux_dev,
 
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

