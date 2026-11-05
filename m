Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894118;
	b=4sJnC3nqpps8H/3MTpzXUyablIQY0is7hvWB8R5B2EPI72teYQORv8TLpIS74Vf7TPWb
	 iSEOTUgl7seDCnG1j8PM+jcxZmxVCc55ByKiqtzVeqiD4LBeSEyrAoW6XEZ4n+yTJqTZd
	 V0yCsuXAzMm0/xDzSUlR476OGQVCJeuFTTYoxtyN/Gc/HAmPqpM1tloIgwAZq6V1oNh0W
	 jwEjQh6lqDNOCpRgvTX0g09L0yUJtk+syjUc5U5kNYXKHmvLmbkpgnTTEUGj4KuDlXBGK
	 2VkV9PKCVSwoNNyTncVTdRJ11+hTTstBnCR6NRO33WwD66q/eYgzJrYZz1PRb48M2mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894118;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tdKl+siKq28S91b9oYIgCcRRzZiP/IWdXCqV8LvsSrQ=;
	b=KTpJTxYQD/P7avDWLc9uYAK1k3VHNkDepVO/CsZMVfi0QRXFqXhrmMkW5mFx91uPW1tu
	 q9C2l6G27nOCiUfQT0zN+tC7FcvnLRmJMDmDdONWTqx+SFkW2SvB4tfDRCOxffMOE9LGO
	 2spp2+Ab2AKKbjKxGWaia7NUdTVftXR15NBAixnEG6X+dRUECQvqTujea3NL3etkT/epf
	 MbnUf6XZggy2WxuQzrPYmxlyhpeg1PdQ0ZG9+M7evuTIffEDnwyhwOr0X1YYRpUQvhA2B
	 w9ecxNtsDjsDRKTH/5ikuUxZ+/H2rrSFZn14eEvD/cNvZiBtwzBspG+6IjfqP6iREqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n3WfkUgW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="R36am/ln";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F8606CF91
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 803F8606CF91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n3WfkUgW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R36am/ln
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQBUg3644467
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 15:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tdKl+siKq28S91b9oYIgCc
	RRzZiP/IWdXCqV8LvsSrQ=; b=n3WfkUgWvmEYw4O7jKdcsHY4KqK4Q2Eif88Wb4
	jvnjttLvCZLaTu5Z1cCVlw6beDjWqT/mayJ+sEvZ3OvOZFis+XGcOqNF/QAXbu9G
	JGPUn+I1M1xDx5yZi1+Dm7bJJJt6ixzeyQm6hTk9cYNGknFAFi8xE/Rj9SxZuw1W
	AKjPDU0DJ6x9FL8U/RQMUCgFI1ZNc+iFYNGgsDRaUG+6cwpRuwPY1NWJ73H2nF35
	PUQgKYOG9sY0wLpBFr6i4Sjw6N8vPK/xgA08Ez+DnAGgj44q/lqvsUzuXeq+9ZBP
	scejxph7V3O625FpnC2OGsasKH7zh/bquQb+pPNSXVd4U3bA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkds890-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 15:55:17 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-980b637ed69so532853241.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 07:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793894117; x=1794498917; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tdKl+siKq28S91b9oYIgCcRRzZiP/IWdXCqV8LvsSrQ=;
        b=R36am/lnMC+A8C+3eZKUApSzZEGuad+nTG9xFMCrjbvTs53Xhp03aVdo2RxJFs6SeZ
         K2ktVjL5bQvewgPYjYJSB+kdXxJJqX9XS2c3XW1uhbxldBF7aNvmlgCCgCZMXc0u2K4H
         tMFiR/lV9TywKCqDzA3AfKWeaM1Ik9QrJ0X0BoFEv0GNCCBDICtH7Wlv3jHP3COhHtDp
         mooDc60lVcwzHFu/GnbZ8RS3vl0hjO1rbnf+Vc/w4YeukhIvqrs+yVLLj7Yjww4lT/Pg
         M6JclU1MFOkKQ81AtP7qFIaBIJZstBPAF5NnkywahBPeNGOWNh/thVy/C1O+K13aFQN8
         rmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793894117; x=1794498917;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tdKl+siKq28S91b9oYIgCcRRzZiP/IWdXCqV8LvsSrQ=;
        b=R93DbXOGZ0bBc34ucgl0yxLXoLMB+FwJAn1lL2uA+LYBZJQY1o9EZrUMG8Fp4lydZu
         HJUzIqCOCBW9K79URUULhYtCSjHKPlkPpI3eBr2wmy6Sg0HwnuwTdNBr+ixBkZPvdJCd
         vgWiMwC8l5Rmk1a9gBpSQNx0LJA/iIGRXYRelVupfATM03M2iPtemRD9chtIlOfr9NCn
         arzMS32x9wPH99g9JY9cPgrSDlchrZAChNwpH1Cki7bbzXE/fBR7zeSHUuNN3WtyQGDX
         Bk4jQKCN2iNJBJzKlGl8ecP5r9eePuUM/jpHyzYiGkHWSx38VszSfrB3QeM9Re5OttsN
         7VnQ==
X-Gm-Message-State: APuU4Z/QSin2yJm8zaPUMKc+mF8O88TGofR8mgRRPoa5vTL0sMsvCND4
	mkR6t1WXeGiN6Ct2IA0lUNAt1E/6pM7gT12Pld7MVT6AVupKhOUNCeek6lxbwnLCe27Kr3v22I3
	YwPh2nHr/2UdEszNCkGdR2qZG404/6OZmnG4AdBC3G7151JNHuxNw2bamZVtdYg==
X-Gm-Gg: AYBFou3wxyx7D+uwdw7xzsABhEJiTH/Ih2O7KAYPDaBJ74G8g4afDIaDLPjvBLJdcD+
	ONvU3oYN+W8ToKQfZz2IG2i7lIHbobww4TP5bZfXT/HgmKTuRgrvtwdzLZWQgt7WLjfeAXs0HCC
	qhnTnQzARscJugx/nmfO42hGs60UOaWte7inV0kGe8uXP8pmVyZxhsj4tPRAea4zLIV9NqEjRKw
	9Ezv/yI1KuLZwMRTRJ7ULjKWovwEAhjL5s/cS4AXIQFfaRuAqS0n+hfPitmv1R1TEKCElmDLs2E
	kpCLrvJPdx4kxD5M7EWkd3PnGSgSXhDyETSxWkN5U07zi8iD1uS+YvugUdUm8uqhwYLKPTPSBMH
	R/gLov5mE7TZIB94fOjtZtp8mKCZVsEHJ1HAqBqOaFCQ1yXwveQy3kxArjDtFx9Fbz310CWR/87
	5MAA==
X-Received: by 2002:a05:6102:604e:b0:7d0:9587:1b99 with SMTP id ada2fe7eead31-7d2a0fa8580mr4297137.0.1793894116634;
        Thu, 05 Nov 2026 07:55:16 -0800 (PST)
X-Received: by 2002:a05:6102:604e:b0:7d0:9587:1b99 with SMTP id ada2fe7eead31-7d2a0fa8580mr4268137.0.1793894115915;
        Thu, 05 Nov 2026 07:55:15 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda2007esm10612301f8f.47.2026.11.05.07.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:55:15 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 16:55:11 +0100
Subject: [PATCH] power: sequencing: core: add a note on descriptor
 serialization
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
Message-Id: <20261105-pwrseq-core-desc-kerneldoc-v1-1-e10a2b03ce1f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAN6m7GoC/x3MQQqDQAwF0KtI1g04arX0KqULyXw1WGZsAm1Bv
 LtDl2/zdnKYwule7WT4qGtOBeFSkSxjmsEai6mpmz6E+srb1xxvlmzgCBdeYQmvmIWHeAvSjX3
 bYqISbIZJf//88TyOE6ZYwCBsAAAA
X-Change-ID: 20261105-pwrseq-core-desc-kerneldoc-7d81c4a633ef
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6xeukmjDq+lNKkylfxdTWLXrBwaRiFMGYWd8X7CRWMw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7KbiU/r6BxsMkL3eFph1es2+13kLmLBWAoMNd
 HdxqUG2ysqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauym4gAKCRAFnS7L/zaE
 w+vbEACVQmqNgC3PnpXovbOuKQp7LzwsZfRRlf3xxAjakv1ZjSbPWwD9/C13Xezr9n6C6Q2p8Rm
 XTMdC1eY666HH9yFwyNoUV6tNNeO9jUOGV7X5JDutbMlp/k5dx+67DNJjiAbLWFiYtAtkG6kPe/
 4ryBo0yY2aKRaOVdNnyo6o8j43vaWdg+bDPsYmmmn8BK/0b1wwAYaHYpGQOFOnu38YDxceIZw+3
 3WGTv3qGGxhkmXbjzWVAulksIm+M6HFaMFAA6uWboxF87ToAE7ufoILjiSOrixPcfWApFHItOVm
 7oTB7QZdPYJRS2hsIXkiM0Xijo8Lf2CT84urTyy6Xim8rYHX+sii82M3KmO8MlLRmeDBcTd+aTd
 dZHR3FaY4KqIVrxLBD7+LbVWMQEM8hklbN4WL+uWDpeevQ8CugvCPoz7Olo8V6YSQQpDEDEbjsn
 nOEx0phuESu9HBaLO3hYOJJfan3Z1aBoS+RqcwSA70/mACdoLQYsYX9PDSRkn1uefg5J50ULBko
 EEDr3N4p3bpPfirvh0alQIVcC8wodg/4Jmw1TotWetQrM9myJfgOysWIWGdjUYrdVGy+WMElAX/
 2qNBPFCSUqybJZdmDupiLP+OMAYxf3e+UR+gziPOlNk+f6DR3Pu7vNhrpQMgpCoJaFubvuFkCgh
 KUW+P6tCOEi/UGA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aeca6e5 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=K8rka6OJ2oXCR8qD2JwA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 6oDZEZCqFjSSQi5ojX7PuID4dF9snNJ6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MyBTYWx0ZWRfX342wIUy7uErU
 fIvjN8QwmOfZKc1ScNB2PaYcJ8tCIK+CZhir9jE6PTKdWl5c++cS7nDTUCE4PmdYCiCSBRi77Tc
 T6o+UMKLwQm/qFRzHW5JwcCyc3sxUI4=
X-Proofpoint-GUID: 6oDZEZCqFjSSQi5ojX7PuID4dF9snNJ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MyBTYWx0ZWRfX7/nPlCWLVXbj
 fTNmHqdHkI8R2DvwkXJRGnIpWM6TRnnmORBi/s89FmJ51eLegH0Yy+1QZpDtmBES97kG5bCrmNo
 5NzKoewhxzQG2tibTJdSsLAA6//HEAinncLlbeayA3TsbqGd7y1zPnIHjynbspZmC6p0CR6LMta
 ROgGiBgmWoq6Y8r77FHmixTwTR+BWAH5KSGy02azg0g1CniqGq4hDeB2DryAeJFm9ZBBE0oGNKd
 D18rt+rWm5MGnCy/d27uvMfh8ProEc6a/e7JTyhG7ji7WkZDcCofB1jGgoviUvdi2hnFfcNGnP1
 dR7kc+PRDbeOhoxIraCc3FkK/Lrb+6EoeF5Emj8jvsX4OIrp3kstPTa1494iChhJB6RqCB0lQPR
 r7x6x6teKiVqlKWE5kG0HWTpqi7iQmLeraP0G/pJomTFraSKpGNBfiAJgNajPRtsDWewlQXjrUf
 GFWzWRzXJ8l/rriGp6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050063

Sashiko reported a race in pwrseq_enable/disable() which is a false
positive. The descriptor structures are not synchronized by power
sequencing core. Instead: the user that requested a descriptor is
responsible for serializing access to it. Add a note to the kerneldoc.

Closes: https://sashiko.dev/#/bug/linux-d409bd5b-8a5d-485d-aa53-cbc9ddeb8436
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index d7a545bb4ed2e22897843f4a81c337deb0c28062..588c6da12acbe942eb5b918e36be11b855c79e2b 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -270,6 +270,11 @@ static void pwrseq_device_put(struct pwrseq_device *pwrseq)
  * @target: Reference to the target this descriptor allows to control.
  * @powered_on: Power state set by the holder of the descriptor (not necessarily
  * corresponding to the actual power state of the device).
+ *
+ * @note: The user that requested the descriptor from the provider is
+ * responsible for the serialization of access to it. Concurrent threads must
+ * not access the descriptor structure without synchronization as power
+ * sequencing core does not provide any per-descriptor locking.
  */
 struct pwrseq_desc {
 	struct pwrseq_device *pwrseq;

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261105-pwrseq-core-desc-kerneldoc-7d81c4a633ef

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

