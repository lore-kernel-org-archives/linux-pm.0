Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749562;
	b=WSc5eBTl4bHvCEKlwCVu7lsju1lU6Nqzl06rg9E2CS7ZB+fDquqHhtpC1AaX3w8t9RGp
	 ub92N2pHaaj8452vKDnIy7NQ8Ot7C9/zAt3+PVKINVTONJSvU99bDXPuLlejYgKGAKxuI
	 h7js04OzOSU2ZRDizakAF5IRcqLSod95AavAcLDfFzL3SIBH+PYeiRnJxD83XAd9GGpbA
	 ZDCuAhnuFhG6H69LSEzubzTHtPCbSA+GVvpR3/DYEHyb5wpHhLJQbvWmqthoKdWNpHxlk
	 QWlAnVY79G1heoZHyVUZI0C/f3vcgx83S1wbVsuVntH7VOJKaJx6CdDNuY1ugf4Uodg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749562;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qObhk7P6qFFtcYvqpzRA+rRNnFaua2XVu7v9r0gfD6k=;
	b=oBPjYCbqlQj14f4STGrdXi+LC6pnDmS6YGmEqDjvQpwLfvirscZeScD91GXNGl5bYhMw
	 VSX1ZMVyAOpgBxXsoklqCkytaWyG7kPVwBHLYSEdav+4A7b8s0nTk2ivs6Gr0j/oWyqGC
	 pWjYgteodqJSw4oCIMENDz3CmT3ISlgoyu9sRuC5qk+hmsnA3jE8k3VRrJT7iusjhTiU6
	 R5XdIuJP+BteX2GYoEPcjZWtMxgF8wGog18fgHX6SPKsUfb0I851jxuxBAN+9ugZWQCHd
	 /fjyz3PpuX4+db7eXgYG0Y6BuVqBPGRknSirw2tr2JhFSydUd/d08h/0TboiZqdJ6LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VIu1ZjJP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jTQCQP3u;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84636606A31D
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 09:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84636606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VIu1ZjJP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jTQCQP3u
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F8SR1200806
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 09:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qObhk7P6qFFtcYvqpzRA+r
	RNnFaua2XVu7v9r0gfD6k=; b=VIu1ZjJPoBYcHKvUrgj7XR+WAuMUgGzYxq7Rm1
	9xUj2mY3wwBPh+BbC4LI1F0CXX9He5t40CJXo3n8GGXpRTt4EWxqdFAIIMWVvTsS
	EVMb5pna4us27CuvIKkg0F/BP8QpNDbWHUtizbaQokQXWVVlXsHp3AEZdJBazMvh
	uMK0PFIPPOZZQh3Lss0CLxLQa271M6gpDmfqKreXyA6jTKmNSXLIUU8JwH+mFbnA
	XO0+Y8OrJ32bqa7l2277h4sm+U6fyu6yOCFBgDDpJxQe2dSFYhdXWBujP/4HUSpR
	cc2knUinb+RZKcJ7VPIF5wnkNNHZUaiLAUtmtQfg6pLSK/FA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms33cc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 09:59:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93caf6c528aso113903485a.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 02:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792749560; x=1793354360; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qObhk7P6qFFtcYvqpzRA+rRNnFaua2XVu7v9r0gfD6k=;
        b=jTQCQP3uHIxlGiFL8WOl6ZNUAxW0MjvXzAzuiEHiaycm4EmNFVuWw+H0eCFtlokezo
         3VVpO8/UbjM1bZTNGIwnu5nxQMbkOsJXtlV39lWNKbya5hgNq+K+lDvweUT+y1X5nmN+
         EgfXLOzwiy0zMRuyUfXzEvACL7QLdvWLsjnqTECwR+YFr2cdqtz0SjzV6FeNZiveV8TD
         dXF5jDnV0mYq4zD0ZOdU0k7TAxFVyUS3NJ2eeZK9DY1dwO2Cxd4kq0jXB6wMTHq9ItRI
         A0RBvafBLIlSCfKirY/GheHWGaO9iXFn8QJLDPcQ3zt9Y5QYrLEI+2CbvzZSXMLdY5Zi
         c/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749560; x=1793354360;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qObhk7P6qFFtcYvqpzRA+rRNnFaua2XVu7v9r0gfD6k=;
        b=uz9Uxd9MUE+Hbe+Dk/rKyGxaCovBFc36RYN25WWs0A/zxSUg78xqoRZQTWQQVAhP1B
         shzR6P0N8cw+w8r7zop6vrHCjv58fnIve6TZzgYVoWkJaeSIRBVhc6Sgh4BzPcHQQCm+
         lGoNyPZaVZj1EDu/m2IJkxBPCPe5pf+JOVUW4eq9Er3TQFM7SxT44Q2vbKMXESzNjeY3
         i6ZfoLjti9blrpmbkpvUPPq3V1CO+8hl3Sy8TxV4sIdOGyqpho8WGrWXdYNhKVRuFi50
         95GvEIGrueU9ORiFNlqi6+K+SOi/1DylExhtiitVgbLOmFFMTmlcYLo1XeEJvFjlIbfW
         +ebg==
X-Forwarded-Encrypted: i=1; AKwUvBw4UDu45DJN5NU2UJ5VA/UafAK35Ay9GpcEoyjZHtePApTOh2vFj4wyz/5xL3xHUhSC5v5EId6uJA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKPkP3raT9SDqCAVBpw8JuN2hrh4hR7idkp5m4zbYuTemWoLnRG
	go6szqjj0jEaLsikipzdKpYsOR8m+d90QNu7ApmN9GCMhkLUFoog/tUgPxLYaJN7IYq/hlWFQLI
	pxoSof4PoFvos7qu+vbA8iozxETuwYtI+IPo3iNWYodNfF/4TthfBRoGDnxvmsw==
X-Gm-Gg: AYBFou3+HfMa7KMvKTvzAS5ywDo5A3XlUdxwFPTWHH7f2QBXNxZMuwq7O8Lo7AJ0Nne
	b7tia8mKoWckNFANxH2EuIsASANds2o1nmMZUJOOLAux+L3TPqld1zB1vSwZV7FpnyYJiy5ELlZ
	iv3pL8wsDdxg9dl/A1LIdf7+gN4UazdbUDGoJG7S18+mOBdX9Po+s+RhEGDUOZjdjQ0aI6UnwTW
	9UNUsNUQpE/DOhVi0PPWPbfoSapFJ5C1ypLwl4kO9xqiRrfpt2DzMsqi9504ujN8OgDuLaVuth0
	oAOUoE37s5zZk8nEh64rhcRaEkiQdSLYi+rKujbSq/awJVwZ6NNIhTZxmduoyfeyB5xYtxNeZWA
	C7997Pj7wPzHORJdC/L9As/3VrBcT
X-Received: by 2002:a05:620a:400b:b0:93f:57a3:71ab with SMTP id af79cd13be357-93f6f94e2a4mr298871285a.32.1792749559673;
        Fri, 23 Oct 2026 02:59:19 -0700 (PDT)
X-Received: by 2002:a05:620a:400b:b0:93f:57a3:71ab with SMTP id af79cd13be357-93f6f94e2a4mr298869185a.32.1792749559202;
        Fri, 23 Oct 2026 02:59:19 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21555fcd1sm22619935e9.4.2026.10.23.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:59:18 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 11:59:16 +0200
Subject: [PATCH] power: sequencing: add .kunitconfig
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
Message-Id: <20261023-pwrseq-kunitconfig-v1-1-0576e431565b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPMv22oC/x3MTQqAIBBA4avErBPUQKOrRIvKyYbATPsD8e5Jy
 2/xXoKIgTBCVyUIeFOk3RWIuoJ5HZ1FRqYYJJdKcNkw/4SIB9suR+e8u4Us47oxbav0hMpACX3
 Ahd5/2g85f6eCRPtkAAAA
X-Change-ID: 20261023-pwrseq-kunitconfig-073d8867be6d
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=810;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5Md/kZ+LiBWZqC7MEfaaUdwXUpxfghx5WOcwz1JD5lU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2y/1+goXEDhbljKDgJhVgwN6lbQk5QgvC0nP6
 GIevYmZOY6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatsv9QAKCRAFnS7L/zaE
 w34bD/9yQb9tfGk5aPNAfGbc3i0vI0MHL52KO2KTf7C4sOdXIEPtXVmduzM8euH6Q4anHy5FN6+
 W2ANoej2qAs2pkC440hahA1+ZQM7+a0e+9Tnr2BLqzDz8zjWuTC3ed8KV0c0dBfPRcA8s/sGfac
 eIlOyaw8K/gGfK8rOajKFEluvCCOPuNo72/aq8ELw5fk+/ljcl7WmFooqUKjOpqS/0kKIekNreN
 28/1G/0Xkjjw9wGPwkOTL79em81GV/D4r9ANqpLCmjT3UfSR3HwpcfLzpYF8VVfGyzeT4+Tlnmu
 zRQx78Z5Lkm9BeEZQ6qrrMtFP+jQwlV9qFB4lx0QLLiBRuuq1NBKdytPPV2lVtywM9q7RtBHDxt
 juSvE+PC/h5ej5+dwBYyISLjdpMNGO5Xj0SGAXbAB/HIYv7vdPEbmtVd00ddTp0KixwTf+7oTZd
 1hyd0JBxyzZtJ5Y0KwKot6kvNDCV8tT5ZhAtsZZpjmh74/srKQY3ugHIyW5hhs2oiMeyIPHppwX
 gk6W6E5qhbZ6IGuIsmf9t6i0EkY2ck2KFP1QSmf2E7/6NbhrwBit8xPca5mWmIiJA7DIWUrW9K9
 Btibo9E7fCX9BFkApb6uY/2pKFt7mBoePQdOPqHFr9Ud0O//S02HaAUX8jchboijis310yJWh0O
 7GKrJuBjrMe2pGg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX79rNkFtGTWC9
 78Y4vxo/wHv02WPa4Nt9Fh4XUn1qExNtE4CWvOfz+qFRGSZz0nLOEVtNL7g0v4g8cJ9aIuwwJlZ
 K9aFhqfOFvtkqpUjNWAdygzUfwqrdLGDJ85nW9i7tcOc0X4pG1bf6MaWtrYrj7iQMti+g+lwtAH
 fxebd+9xnv2ObOynXYL16BtixOB8tYCqwDVd9vYcYEBavxusDo5u8YgoHa14yxGieoiD7KlQRWr
 6N7p1KPGcOJjxm0X9jcENeWeBGI+YQkMrLiewLzwVfwUKXfm9Kjv56MRYVB4GlP5YdyIAEU9hSt
 dGKulf70ZgDLg+NCikGytagxRG3RdsNstL1+oZ8iWxert12LsJBQZKwE00DS6g6Rg3p1z7efMRs
 eKW1xnNEKBWmG3xPTEXu8aeE6cdD/WFkhe0+u8q2leaW1nYdIC+3omjy7s4HoLzYGiHfPaCWTPF
 DiRy9lKJYTWX7rJR/rQ==
X-Proofpoint-GUID: sOI6TdUlvFqzl4Dq5VAND99lc4fOsXoE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX43QJ1i/QjKSB
 Ek8syyUxkAbY9v5rE6hJQ9tPCys1o+N3uVu2D3wbjewNNPuYF+fFm/hW4szhNL3rw6BbBYIyE1o
 TmUM5AXFsXJJWCV1/ql+RPxM5Q5SNe8=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb2ff8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=DIZ46cZ5GcFYGT-oMLkA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: sOI6TdUlvFqzl4Dq5VAND99lc4fOsXoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230039

Add the Kconfig fragment allowing to run power sequencing kunit tests
with kunit.py.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/.kunitconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/sequencing/.kunitconfig b/drivers/power/sequencing/.kunitconfig
new file mode 100644
index 0000000000000000000000000000000000000000..c73b4e374d0742f4ab550ddba04f873f476218e3
--- /dev/null
+++ b/drivers/power/sequencing/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_POWER_SEQUENCING=y
+CONFIG_POWER_SEQUENCING_KUNIT=y

---
base-commit: bd1ecbb61afefc6a8b876ccbc31e9228b44e9eab
change-id: 20261023-pwrseq-kunitconfig-073d8867be6d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

