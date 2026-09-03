Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9674B8DE0
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445783; cv=none; b=mFMryPBXif53deZIXkqVeuOvjsRiVfZ+BQGR4hbc9VIIXK6G8gVTv5goVvbXjTOh0Bx9wPi4/ydFj/bQjdTE3JQxYgnV9Trf/vV5G3T+y+wACvu5/4bLNMOBLj3mIoZeLBfGHvSNCcWD8zKnQfeoMghEJRggCmCrmb8fKTzGxH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445783; c=relaxed/simple;
	bh=5Ns8HlqK6jXQoKvOFExlTMEc24MJgvb397khxg2WXXI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ssL7YAIzNtPSIXgv5eLveB+GqPs3CeH0RpP34vej9pFUOdbmFbR1r4CQ8qZzvs0fi2DKH1dNY9GRL4SrY7m2gDCNsBRw3vVQOLcMVcxE7bjYuxrD3ATSDSZp5XbkcvRFFld2QPDTy8vZk3FewomWGWVvSEuVm0j2GaUlvspTEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UFKLsaSk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KSfQrggN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UFKLsaSk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KSfQrggN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DAduC822691
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 14:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yg3JsRt++Y2Z9ldyLQ9p9L
	Y1TD4JNQrPvaJFdhGRtd4=; b=UFKLsaSk9NsQjH7CL1LCdgBm2oM6LM1yR++HrL
	lCEzDsvFdS9WXRGQmy/xoY8tko7ueC/yuRGxlxkDW+XwVe5dwOHffawmwdWKQeya
	hhvJ88RTMxOTbuf6FmoPPiah3t2VQ7SSHvLbinBl4EL0Ft3dpb9LiFBkCkmO3fsd
	2WhM5eEjuUxmMpuUZHNatFJA+0O2+MpVCnXr6NcS2dmNbztu0JjSS7wQ/Ipkhhzs
	7maANn1ITmTWjX8DyIk9R7oyotp2TQlx2IpLD05qpvkhkapp9xQnMOQaDggv+6sT
	IJEbS0kiyncrKMquVvpo8LkrMx1q2aTrEXkrrVO4xZEIEo2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p713n9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 14:29:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930edb4362dso413538185a.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788445762; x=1789050562; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yg3JsRt++Y2Z9ldyLQ9p9LY1TD4JNQrPvaJFdhGRtd4=;
        b=KSfQrggNf30nUPiUw197o/hLPAoJe9obPYU3cYtgy6LGKD2jcxqWfwdFt6PjOlSmLR
         ZqubJqpMowpZAOVYekkKU2Z2WnPp9SnIwqa6FXEblGGP/UOcv/Q9coziOmd9521nw020
         SCuvnrgMJ6460e/K+l08nx2zqYmsbeVi/s9OsocOLBCw9WILOarBQOcm+xIH84GsmOil
         WA8Kj+cHyivAq4ZS7mPJiOX0MPgYiIxEDzCaTCRz3YNadKdkvcBBtbmT9kegcm0TAwMc
         bwl5OeyVHGy0TY69qAGKq5o7RlCRiXNnYmwb559yElmCrmu3TUZz3w42UxJM1cizqjpn
         5+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445762; x=1789050562;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yg3JsRt++Y2Z9ldyLQ9p9LY1TD4JNQrPvaJFdhGRtd4=;
        b=poJSKeZjLqyb/zRx7JESaM1ygyOYw0YXgSzk+m3UE/EZTAU+0Q2GVxIlYIWeBqogrp
         stpZ04+bLGq2IyiHsPp7FnPREJtZ4lP/DVxKyQWNGpSgisuj22dHZkNgANcMoyBmhbPF
         2bX1NteQJhFdNxuP6zOgSqDcLjJjU39uTwhLvnZsYGMB/d5s+SeXJ8wW+IfqafxZeG6w
         +viXepex9qO7g/B5DTekT3IYuKzSz0mhq/aRe+48uzR5uPSuKWrDdrTxtKYhYC2NfATk
         H1V1KwB0SlVwazp3EPorgXlSRY8iZGgLD2pHAHrPG1R9eH2PkzwgjlnRuMmj+QaNlH2n
         3T+g==
X-Gm-Message-State: AFuF++nCShQ/RV9183jnTk/4HuUfqrD27ejkRttHoQastrm8aEQyxPEp
	gcbzuFTWA8sqDDSjJtebOjMLo0s2i4R7fMUW/lmkMURWCdJjrTd6k5HaGuYwcjbP+qZR0S6WBhW
	X5suMEH3A5/TrciM6563+ZMb61lZ38nvLjqOsEXSj33aXxyOHYvjd+ST+WG/brg==
X-Gm-Gg: AYBFou18rN0hMOq8ar+BvIRJf/xRPFUUsdi1I80jKcYaEIJ3OwvYi191OmUvFFXMfk8
	pUondZtpBJjZwRjhS1UIN5IDEBXz9fCf+lEqtEtbokcULmnL7d0C0U7YtcgTOFZeOew2ZtE8ov9
	z0CduCo5kIipHHDlOwQJUCPTbfSnNcc+9knLHLWc8owxcx1sOjGKAqhw8u4kG2m12/Fp3MNVC3D
	zIuzqtndNjpgNyAQyt8BT5BivZiDFAwLW2wIuwOvjpCFQZh4kzpwUF+uthrPy4QnvoGBaeWz2kB
	PWEDwZlxXfyHbAfn7wZVDFTG5ZGmnrJPoZ3Cg5EadAcE4IEw9MoaViKbPgdQxwEIRjFBhRWmLa/
	pxLumkFcwylZUpDRiwAXI1VbUmUUp
X-Received: by 2002:a05:620a:4109:b0:92e:5f90:c0de with SMTP id af79cd13be357-93960f28e64mr1446415885a.22.1788445761764;
        Thu, 03 Sep 2026 07:29:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4109:b0:92e:5f90:c0de with SMTP id af79cd13be357-93960f28e64mr1446406085a.22.1788445761076;
        Thu, 03 Sep 2026 07:29:21 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:1c7d:412b:f9d3:3bfc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f9114sm72799415e9.5.2026.09.03.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:29:20 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/2] power: sequencing: add kunit test cases
Date: Thu, 03 Sep 2026 16:29:07 +0200
Message-Id: <20260903-pwrseq-kunit-v1-0-1f893d2cabc2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOEmWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNL3YLyouLUQt3s0rzMEl1jM3MDI8s0yyQTEzMloJaCotS0zAqwcdG
 xtbUAQ5yAW14AAAA=
X-Change-ID: 20260629-pwrseq-kunit-367029f9b446
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=821;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5Ns8HlqK6jXQoKvOFExlTMEc24MJgvb397khxg2WXXI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqmYQ4Mb9pNFPt3w9PWSEtc6afI6dNv7yNUFrZX
 2iizrpvW9CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCapmEOAAKCRAFnS7L/zaE
 w5KHD/0f9k6NApXtF1gnb+yIZBSFVZtCQBqYdkklfCnXGHwSCHAhjuTW/7Zd1G5wttm+F1QRXMR
 N+OZ394aF/hHDqveBQZiAbmSWz6VeSo0cGzLTdzVEiuHdyqQ5EUvThsmlRiCaywHzqxOzDbWVMA
 8bTfnvBZ92jFvi6rW9u23RJg2HXk154lS3oleCU8+rnXdCPao0hsgoi3mz8haxfKtrKjXx3LyGc
 +FSYIyFUM2I/zDISC6F5Nj/0KrGR/3LucHukF7WfzXsCoJjsQMLL0PlLMS5knO3DcLJjPjD64w5
 VH63djgWB+a6a9CpJcc42+fivGJTGfbUQDLgxNbgXpBzsmlsrabb8uDAL6ML8kJV4ZmDKQubQyC
 A32s7rOSU4QDmgvqz9G9041mfKUfzULPXqJ4pravbc9xs1kkU3yOfg/bMPfvPFBWH0MBW0FOxDY
 eNiCrmaUmbNrJ+cn+auYGrvDu353e7r2vL7JJILxtOcDIFzC6xLCHWrZlThN6Q8eV6TCg0UZbZz
 1RaNTA50sQRFJxDDvZH2/jrDQ+vk0nkr1cwLVpZY2WqnTbeRHfT6bbpm5JJqKdDt41b/gdDXFqO
 3jdT9+0aj4ZYJrNPpPfPljc+cjHrGL0GtvV05++skmrRHxSAm8ATvsKjNKIZljN2PE23WGLVZcn
 Ra8UKmTrjFvq1hg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: NdEEnLh3-XCgYMu6YY0aM0R8IMy8k4ym
X-Proofpoint-ORIG-GUID: NdEEnLh3-XCgYMu6YY0aM0R8IMy8k4ym
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a998442 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=BnOhZuoTPVBHbJAVFpkA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyNiBTYWx0ZWRfX8tGfMTYxpf26
 p03j/vHmScYJ9SFwVlQtKC+ce+MKZ8c/A8IcSaNZgT2A6/dsYVqzOCrG+W8E1k0BF46OHHGKAXZ
 BMcgNPIgSrxRfyt5LmOmQgix0WTUGsU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyNiBTYWx0ZWRfX5wuaGQs6zZM/
 W7xKlscMYLmZOCV+766zyozL3PzoqCAdYbEqQLH4mg23HaKzp8CHU015LKlChjxWYDWgyMRBLub
 0EGJGMxUNf5eP/eCif83PB/Z1efjC2YFpt2MQN3O455Co4rsO9ZH5i7rwe0zSi6cQVJsYZ0xvAW
 iygKTntQeoUD24D5R79uI9DNAOp3tK9C9wFCLvsVqUwO/m4sgd7szeORg5kCtuKddgHvlQcMbBU
 XRH+NxN20/bnjLIhwL2pI9S45ZpLiHJoWsuZEA7Yh9qtu3s6VaBVznIiYrybYhX4iZzvgpjCtZj
 rGS62bXVgURMwQVtFcsdcod+3/EVPdDrCmWjgPYkdy5s9QAfADeE1A6NBdggm++g7EFldeq91TY
 r128DNVfASHfIXHEoXtf2OhUawUxcHmnvIEyQbTi/Xu4Lh2omzgyK0LHCtnrYKqCNOYo9aGfqLy
 yY6wNtgItX0z3j2e01Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030126

Add a set of kunit test cases for the power sequencing subsystem. Also
fix an issue I noticed when writing the tests.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (2):
      power: sequencing: don't call .post_enable() if pwrseq_unit_enable() failed
      power: sequencing: add kunit test cases

 drivers/power/sequencing/Kconfig        |   10 +
 drivers/power/sequencing/Makefile       |    1 +
 drivers/power/sequencing/core.c         |    2 +
 drivers/power/sequencing/pwrseq-kunit.c | 1497 +++++++++++++++++++++++++++++++
 4 files changed, 1510 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260629-pwrseq-kunit-367029f9b446

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

