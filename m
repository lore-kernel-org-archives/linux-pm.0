Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442180;
	b=M141p/RBzWJRU4bNAKsnE2Dp2WzkMC2yGTgteERDxX6Us6ARMEUU1IPK9YxECiZwXbd4
	 KeYvWdSfUQr18QXbspgM6PCBgdGgfP14Ivl7IxdIAJgsPNxlqbC2WjoJcU2ZoZ4PVSm5g
	 14DQ9blq4CsmD0m/WlLXUWAb2mIoBgwJaO0Why50J4uTnkeGexteBWNZpfOYlhW+YTWG0
	 S6KHlw4PHrM0WPLlfunDrLItA/dicNZOEAtmAyS23KNhXBnYj1c5aF0xe5QHcOicCiDCg
	 bY250yE1TPUYvAWDntTUbu+Bsc5DgteUtvRuRklr6sNxth1bDdbrgLj458Eox+egQIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442180;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=;
	b=eAvzy4oua/KySPZFNalLYP0rt+x7MB+0z4l7R2wWrxuzFUbm2s+l6pjTWey3vo3m9w9B
	 NBVlpcM6L31/Ptsgbf0Gddg0+qssTZSf31NoP+DOyXY1lWHsVvTvUWN/Q8ZmqrIdJ7Yzr
	 cW/J1OEa+WVami7F7zvkUvqt2yB+RUJbzqk5AWkyEcvLKhVfxyuKvFO/0RnuKC5l8Opqb
	 Wsu0YdqpJWOnsN7mjNd+3YWiJWN+nNu1058KZwOlkUO6gN8AMmZeAxVqK3nHo/Jegjoe6
	 JuLuXuYxIQXVz6lUqoE2X3gpjBxM+Q9FiLZTsTznUGnonFMEhCow0WuvShboUVrOQBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPz1nG6Q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ihsgwavl;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1BF60A2619
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB1BF60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPz1nG6Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ihsgwavl
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDLFrO4030419
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=; b=OPz1nG6QtqvIY99R
	0o+9QwtfAkRZRg3EX82sz02jE/W2gYYcXfYGAeun/FnN1X+ybipWWnkx5zydDR44
	vhpmn937JJ8xY2FqFNH57FRsE9AberMNL+oH1lFoUkKem9IOaZ6TAy7nDwm5rTEO
	Zk+zPbmZvBWA/K/abFU5GYtulpQf8TrC/jdYEZ2ROs1eTah8on57BJV/EeYeybWd
	yaUpQsjKO1CtvYKvMPze8OWzoV2X4XbOjmH2CD2ncePKX8LEy8oErwi7PqwhkKsq
	5yomR6mfRdJqHiIcOq8YroygOyIN9nRcBRbDsiGp5HKRn9EFGGUiqtvKKgxJBn7O
	/OZWpg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evshv7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f33438950so599658685a.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442178; x=1796046978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=;
        b=ihsgwavluhvVp8oGwO3hrlf+SR8+eZcJsJyonoQFrzfXF7HsLHP+YqKLoDjkOonBJz
         UTZqBC+OGL8s+nXHU1hDpGfBuVjavKyK03ckMKHU51Iia/gXAHID7gw+iM7G64/tRbFD
         cPkS1Ym6avMv8lzQCIa9RMMHo20hOu5+W+UWzg2aAZ/tb2YrM9BitryrkZW392uPbFwf
         DRSzdKJtnvSfIiUlMlLZbyPHP1HjGgkZJGpE3MeVtBBgRrDL8bsLy183QUNyyCmfLxxy
         zRcaZQYX6oYWCTKs8OzFQRh6NGOQxbuhyPHsJDfWUNC3VN2yaeP877A+48bZ7iD0qZnm
         Hd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442178; x=1796046978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=;
        b=KVGTPY/UwDPexFB/6PLeYZLfvkDcsqx3/xUo/o351Dpuk+B3f3NGtHQO7lw7taSe66
         GgaOkdaN8cY6Y3vrnWbaocOg+M1tSh8WtK8zAreahmLFgcBj7o075KLIuYBRRSo8j6aJ
         MUGcpESbl/CVtdjitpkcuP3jaNTiIEaVjXCBxsDIwwrgk0Tov18wThhnvjpJcpKtFbLO
         l6hzi2CCIXY3SuQdvvE5coT2A4A5IVYBF3BZmEa+59La+cO4b+83N/iVoDI2bpUhCY0U
         5RcM82y0NnNvV3Z3AucGjMQ96T0TnviS91D3XtygMCIFhVTY0U9jlRXJSDQC2DQoACUd
         aiRQ==
X-Forwarded-Encrypted: i=1; AL+hErGuslN8NtLeSkdoez6MR1cFradfKYyIvOewQo5ads0aDdpi7fRCAbc73Gp/WxN080wTFMwZRFBLRA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/lvX9UutZBgMzhf0ItG/rQSWgFASq5i288/aNkvUG9/ek29Hnq
	gQgljEvR44acbnSM6To/dWfce2L08z7pgdEvZXtwAyqnTcr8CfruYJPZ8NgtbSW4S3V7uDNDZRz
	TT2nhqR7FYdKWMNekQrtMaxGan1OVXHMds7jGj5kkzRpmKwmydrvVc2vK+sU5IQ==
X-Gm-Gg: AZFdTZeFuXR+DdGPzsImI2ULRmvYu2dbxK4h5zWrIKEh6YJ5xtETuTZo0e8hoyeoibQ
	FgdPnpnNtNbLI5p5yryevkV8HqYgz2kKWNGvThk2qc5qztWKyu+ikaAWquN9OhQJ/xRO0ie7q7i
	t5boJT/nzFbpgeYVLdwAnFgOqdZK7O94CQQsdFidrgdtmomTJ8LvfuO1w1vombu0jys0De2jpro
	gKXtei5Jh8swl/7vIjJI/eQEHUUONQxtroengpQxNMg7hFVrRphhjKG1JsnGUInQSHKBW2RZAKt
	3egZVq+6SMmfJRX5YXijP1p9b4OY+faWrFKALGGErr82PZx3WMl0uZ8GPJaHnhTRGEt9LyiG27P
	gpFzZwsYHLDOLovqXdYvmvZE0PNoz+z286mKgrdtZlYF6MBmcpegj8R1AjlNCy/Jhyoa6bWXIO5
	a7xTQ5OtArJ1fKtwNX/EC4IdWv6Tm06/avARB07UTyTB/9eaKEFnJ5dZ5j1cyCpwUtDXOwzg9om
	ME5EkQjg3cVdHJIj8gxDdkIzlQ6
X-Received: by 2002:a05:620a:2605:b0:949:6d5c:3fff with SMTP id af79cd13be357-949ba9acf03mr1821251885a.44.1795442177767;
        Mon, 23 Nov 2026 05:56:17 -0800 (PST)
X-Received: by 2002:a05:620a:2605:b0:949:6d5c:3fff with SMTP id af79cd13be357-949ba9acf03mr1821247685a.44.1795442177277;
        Mon, 23 Nov 2026 05:56:17 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:16 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:10 +0100
Subject: [PATCH v9 3/8] Bluetooth: hci_qca: Set 'bt_en_available' from
 pwrseq controllability
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
Message-Id: <20261123-monza-wireless-v9-3-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b044602 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8YyhkPy0JF_pzLATneMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: jE27MBsArsqqZ0SESgvhTPZrHGrYvonN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX26vs1rFL7Y0A
 W7KcfpldaiqZfPkq/ajpXStKxobEo+AfVg0llGOblJGZo6fo6ltmAAcYr1oXDL3SUdjIOwU7hjV
 TS/QPAFnMFjVcjGetm0+R3cZ6+177n31UrnpVwVXVjQ8cfUM0PdpaZdySgeo7pkyMHRG8VL2Cvm
 oLMFAKl2+SLaq4hGPjvBHp7GHYNhJshIYl3v+/uvouO8n5quUSsFBL8PIc9VmWwXP03ggPQIm8K
 OSWR/7elJsg77KZvBDtYY3ZnTQzZzkmKZOed51MYUSb+CBYNvbYOOzIuUSqHE6r+UheMxahGqyf
 jPQoqFniW7mb2Oq88OuOJu+pQfQu0mU01mWBcs3NtNFHDgbcZWeofUeHxH+lensfhlw4PyQfURl
 mdw42A+gWb8JLbcg+YDqXzvFTXmx1FRuxoEZcWY6tC3mA1ZVDe+XKd9DROjipcIIP8Yhv4CX2Qk
 MkH2pu9lhUlsjMqmi6g==
X-Proofpoint-GUID: jE27MBsArsqqZ0SESgvhTPZrHGrYvonN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX+e2oI/OrdPxh
 igim3Ps1AxzITGZhsNEyLCiqqwSGY8FaprCmgh2dsQWNeAUHP1fwy4eY3vuh6koeUGzQ+R6BV3w
 PhTZgTijOlBCXFkSCxIdLr0ml/CLgoU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

A Bluetooth device only needs the non-persistent setup if the host can
gate its power, so that it is actually reset on the next power-on. When the
power is controlled by a power sequencer, whether the host can gate it
depends on the hardware wiring, e.g. the presence of the BT_EN or
W_DISABLE2# line.

Query the generic pwrseq_is_controllable() helper whenever the BT power
comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
If the power is not controllable, clear 'bt_en_available' so that
HCI_QUIRK_NON_PERSISTENT_SETUP is not set.

This is based on Manivannan's original patch that keyed the decision off
the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
and handles the always-on case.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 5544dff9d10b5064797d41294b126fbc229a8dd5..3c0239e837fed7ff8d8261b0c61e5163945d157b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2632,7 +2632,24 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
+	if (qcadev->bt_power && qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+		if (!bt_en_available) {
+			/* The host cannot gate the BT power individually.
+			 * Treat it as always-on and drop the pwrseq handle.
+			 * The descriptor itself is still released by devres,
+			 * so dropping the handle here is not a leak.
+			 */
+			err = pwrseq_enable(qcadev->bt_power->pwrseq);
+			if (err)
+				return dev_err_probe(&serdev->dev, err,
+						     "failed to power on BT device\n");
+
+			qcadev->bt_power->pwrseq = NULL;
+		}
+	}
+
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 	if (err) {
 		BT_ERR("serdev registration failed");

-- 
2.34.1

