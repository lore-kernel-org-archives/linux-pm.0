Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237546;
	b=2n12CU9sx8rIuHnjAhK6rP0mLZZ+WjcfZvX/45+oZL+3bKaYp1hJlAAuVFkvZIREiNjb
	 meyQMCi+SpBvdArcRVGpcqNTZpE9FFN8eBysXIZwhGDFWB7wJ4ujW12TgnxckLCHywbSP
	 V+XmBMYj4xwSfIh3mdAk5XzqqJQkdqUBgIqaCh4kFbt5wdys8JElyekkkhwoDeiKLIXiX
	 9bQ1xZ440eHpwn8Sx552hM15Zjczmud9Xk+pWQFzwYdW3H869BxdV95j8JThZBKsvggDM
	 VZfCulY9cO1qu9g3IpfPvPsmvvxPWHupigtJ7mWvAjPgUAwvlQvR3hxRqRfuSQupvlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237546;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iwFF8BKohhD90cWqtniFT5V/ELFOr6EbD0JI52tbj+g=;
	b=cyheV0S/ACrQu3mdcK/AN+D/YFqVl4Bb7PLoquCFMB2nWszWFJJNcm/csfmGgN/U6CXg
	 Mbdj+fe9h0gYi5UDN8FEGLkydhvPvFOKwqgpuC96qAaqZ1p4FF2OkjGkMxTKazWytJbIM
	 63TpDgufKitBynpyJeT6h6tva11QKgnttfkeblPgDgT/JJG+xB+lZySxFbrp56YmPhI/n
	 jaXKRbjA74awVb0I2iAuubvjlYxpKlGyzR+5Il7MzuHMm4WfZuJF+dKH+vIOvQ/KhwxDn
	 uNQaodcenNT7XkqcBfgWOV8pQfnuh6r+FKePlRogj6gDNGQUA1+b2O80YdEry6GTXtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="fj3/uZ9+";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L1r+K3yy;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AA8606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70AA8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fj3/uZ9+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L1r+K3yy
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFTDK023147
	for <linux-pm@vger.kernel.org>; Mon, 9 Nov 2026 15:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iwFF8BKohhD90cWqtniFT5
	V/ELFOr6EbD0JI52tbj+g=; b=fj3/uZ9+EqjsXnIPMeon6uP7W3cMMIKEg1JKq7
	kbWlrRvFHPXGA9HIlyCVaRvPOB8xQmrqsgHzSSDUxfwc5qd2xNY2KxutsiTKnL/o
	FOQL4fCK4EZ+52gZimSFKbqhwJTtDYboByrJudSV2LUtn9pM9PRtBwFxEv0BbopF
	UhwetIUNMW0GosNN4TO33c71d6RK/zX7wS4hlPNVtt4Nml2Xx3u9YTNN506b/GQ6
	UoQjR01nzOy76mgkHMU4raeKqzZcg+2Oww+0lzEZ7Rd0nSh+HZSDv9rFm2qEK+8n
	wW/Lmk6v0WSJDNnZuhSLc5oJLzkyAglG7YsU/EdVFC8LY37A==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydgwgb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 15:19:05 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-99939c0007cso152883241.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794237545; x=1794842345; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iwFF8BKohhD90cWqtniFT5V/ELFOr6EbD0JI52tbj+g=;
        b=L1r+K3yyWuvsAR4a8bOfxh08gwOyoDPmKj56iQZJ6qv2HQi47kytP7qZrNcN5gj9HX
         6VGRmgl945+ChrDw+8HikrmILC/dMHEDaga+0pVyaQhcTnyGuDzruSO1+TIARikjzY2z
         7fawfBDMllDqVLib+18tEczGZ5CWsV/vfnG+uCTg7mQQ5efQrLONAtmebzTtxPo6aLhK
         gP5jWo9VSSFefZaLkDN4GqnGLV20+fPCmK2vEUXsu2aBeDp8z0M7kUjPn0UbgICluriq
         +zDbqJyPyxNn9LZWSkQtCOFwzwyNScp8iGDgU6FhHW6dx5o3DbRfpI3BPmT8tOu1CPoM
         n9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237545; x=1794842345;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iwFF8BKohhD90cWqtniFT5V/ELFOr6EbD0JI52tbj+g=;
        b=RTLqHH1J3ogpqehBfHhKYYDwyGnW9dO7f1uvO38EEJzLAxjyq9GkSIX1uKakW8b9/w
         1twYwGwXOvqp4Bgkal0FcTtode4LJZeW75wW2yiXhF+yPFwHPlIAXyLwwo5yiz6FdV9i
         iZ+OhuFkJ6h5VYz97zgbqf88RcUmiuKHZqqjrU26Voy+1CdlFCH9d4Q5RhOg255EQHL4
         WGY0Srxtnak2PhT8YVYntPT9CbVxD8pOYlO63kOSNHfvZwqN6hpBGwwjez3+ugmdY73w
         fwh1YFrdmjgez36KP/yNnd+1W7JJZIjWjXZfvwdiSPV/Qux4WhLiic67mQqPtcthS5cm
         tKiQ==
X-Gm-Message-State: APuU4Z9KCFTOJKfxEZIX7MOj7DGBRbBmoMxs8LcsG2NDTWfEJbfW0EU5
	eBBP2OA9z45wDWo5YrvzNaTGvvqEXtw5v80inE6/xp7/gBPy+Hs9k386MxW4R8EBfz/3J+652jU
	QqLaiIJKq1tVnc69ZeoWHTNNfDq2Sn9ngdRwz2SOelRQ5ab8PdUQPXKFMQE94/DQaNwsj7w==
X-Gm-Gg: AYBFou3UToE8YNKL1tEavhcRUmWK3+SPDWqfihcmYE+Umw65fYxuhsZRNS5qF2r1bfH
	13FVc2OxfrEaB9S2WKnvTdVrUemr5hFj0dLqXVLhP/GBwQ3PHM0jTperFbiEQygzjaSHPu9g3Ij
	GgV2TZDYbjpeCqJz6GnhlpUGM0iJh3gSRAtDbwPdKe9kJwZwQL++SmiPorGmwL8FAQ65whMZdwC
	k215ASVUxMhGJ7TPOWZldMpWMhVW6ZyqfQB8siioFl7D1IhhYWFQNpnA6ddOe45Pu+QSxm1g3JA
	lmRys3NJBGevetUP75KGX04v3+joALikc+W3BVLXWNO2e1h6kz5DzENmL+rEZyb9w18wcwb8iZm
	pXuoYLVAQKi5I1D2vawKV4mxbjNPHxSp8aYWQ8EM0EqIB6JJmCLVB7UWgaQtVYP8Ct5A7GyV2wA
	StHs9UwXOdQg88hxiMsLKQTfRyJfjcfMwOeaLvC2H8neB2uYPdX5M1crLdmCoTWbE=
X-Received: by 2002:a05:6102:c49:b0:7d2:75bf:2fb3 with SMTP id ada2fe7eead31-7d2daa8d95bmr1093894137.1.1794237544516;
        Mon, 09 Nov 2026 07:19:04 -0800 (PST)
X-Received: by 2002:a05:6102:c49:b0:7d2:75bf:2fb3 with SMTP id ada2fe7eead31-7d2daa8d95bmr1093880137.1.1794237544042;
        Mon, 09 Nov 2026 07:19:04 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597e0097dsm10700409f8f.57.2026.11.09.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:19:02 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 16:19:00 +0100
Subject: [PATCH v2] power: sequencing: core: add a note on descriptor
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
Message-Id: <20261109-pwrseq-core-desc-kerneldoc-v2-1-653e6b2749f1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGPk8WoC/x3MwQqCQBAG4FeROTfgrmXhq0QHmf3VodjVGahAf
 PeWjt/l28lhCqeh2cnwVteSK+KpIVnGPIM1VVNsYx9Ce+H1Y46NpRg4wYWfsIxXKsLXdAtyHvu
 uw0Q1WA2Tfv/5/XEcP/e5xM5sAAAA
X-Change-ID: 20261105-pwrseq-core-desc-kerneldoc-7d81c4a633ef
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=AuCPyzr6jDE4ZlToRA24pnr2oh0xNcHuZofYk+ko8vY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq8eRm/7OkszKYP4Wx1wZ00gjLCFdNlEbe/8W/U
 bBvhQoml8WJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavHkZgAKCRAFnS7L/zaE
 w7kPD/0UKizWHUYnZ6s6x7stzcEODJC+lBA0EpM6xAAk74M/2aFXdHDIXtYdU0gMh4KRqXbxoHA
 9bqZchUrTvHYRB47I9ZTw2xP+t4WVayTnrRnE0Sp01MzWKB87tdstJFBfcPSdtPwG8woPQQVL3z
 +x7hDYVQE+6AxRgiWEv5BLZg9q3HI9mQdx7rMIpmZSppOk2XZ59T5Kvmnjt9DcttbW9NUQPMxYM
 JgLkm8uLltJYLXN6MZjIqlCodTztf/PDS0i+Z+t1NfEXlvnuFTl2LDg2H461GotXf8eQhvLDgrz
 mgt8W6ZGyihY8d4x9d5Pem5vi/R+/z9Maj1VF6z6F4of7HielTrIMEGYwSoOixjKZptldj7Z5TL
 GCK2syz0zDIarzpT/0ENFu/E0Ba2pcRtOn3NBYObRXTOpKLQ3I8yvuGQ0J7tZx1/7TrmoAFD2YB
 lX2DpyazwnpfgNx6tFAsyxE7u8Bp+Aw77wklKQ1jjsKuT+5GyzDSjmuCh6nqCAXAPI1KBc8oQpo
 UeszSYZ42wKxT77Z//wiici5GVq3jajqDAFktUJIBqbzBafBhhbVI/3G5RMi5N+DcYQUMK79hgO
 wflqVNDNMZKKOescddVCLJzkQz/zR7dAVhEdtIa8byBoD6YlGbVCMMXogB3xueWSSPenqkDUYr0
 hphTt/DWJjJlnpg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2MCBTYWx0ZWRfXwFAVsMN73lvl
 HxA6mdH+9BVW5gIvBuJ88J3cQ1hZGoc6iZ8OUUTjxovyu3iA01q6+c3nYHrKTN69nOP47xwsg2y
 tVfcrQZJXV6UKszod5+zgKtKDXzCqFA=
X-Proofpoint-GUID: JeNGN3-mgH2vEnOy3uogfJ6CNHP9Encv
X-Proofpoint-ORIG-GUID: JeNGN3-mgH2vEnOy3uogfJ6CNHP9Encv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2MCBTYWx0ZWRfX2WUHht6BNg35
 dwuJs1JnvYNG7aGnY2+cb0T4fye4kFDuguyrB2U1mxmeIQrG8g1qu9DcTn3IJXG6P/J7uTlgwQC
 I9oPuV6uft7Fv1ZC17KIBGvtADubARJPvyeiIOZ531X0ix8j9jv4Zridcurb/+TqMg8/xLXKPLA
 I+CgonI0PQLKc8+R2U1tjALJvmDgDvE5yFfgwNiJhvmxAx6iq0aXmfXEhfy7plnwrfLEBzliMqc
 tbqtcSQlryFpH45GZ5R0o4opt37rRTPbrw4Z2Y1X9vLR8RIw6/EiVlB48y6AgsG1Iz7RoG+j5js
 xJfpTrYbzvHlTUE7mYdg3z/87JJ3jIMBTdqcyzVM80hBARaPuKFijKx5TOlkpZSUJVNFKPeI3Z7
 C6u3MN2YVHcgdpFNS7IA4UyYbJbmVy5Gky6iU7UG//cLPaUX+ZUawxgzthY28Kjg9IPvOpXaRAf
 qo8R2yPA9DZiLoT3g+A==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af1e469 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=oK9qCwPLU0sak5a2H6oA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090060

Sashiko reported a race in pwrseq_enable/disable() which is a false
positive. The descriptor structures are not synchronized by power
sequencing core. Instead: the user that requested a descriptor is
responsible for serializing access to it. Add a note to the kerneldoc.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Fix kerneldoc generation
- Link to v1: https://lore.kernel.org/all/20261105-pwrseq-core-desc-kerneldoc-v1-1-e10a2b03ce1f@oss.qualcomm.com/
---
 drivers/power/sequencing/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index d7a545bb4ed2e22897843f4a81c337deb0c28062..a40021526c8d245890bd735bcbe722c88989b3da 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -270,6 +270,11 @@ static void pwrseq_device_put(struct pwrseq_device *pwrseq)
  * @target: Reference to the target this descriptor allows to control.
  * @powered_on: Power state set by the holder of the descriptor (not necessarily
  * corresponding to the actual power state of the device).
+ *
+ * Note: The user that requested the descriptor from the provider is
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

