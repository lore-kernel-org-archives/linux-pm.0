Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4036EAA2
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976979; cv=none; b=gbxJLx1RCJGBRLzTkQF0Ud5HUyAskbUD2EUhdJadmW6NJdgAl+LCfSLC8z0yPBNskDEtnjTMjgk6j9jGoG6ZPE+y6xbHhD1owKnQP/Rvc2FITrSjrcmeRooteeDDKWM1WnFRUCfPf6HZtBuI7Nb3IH4uUnweb4d+FcD710HN2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976979; c=relaxed/simple;
	bh=wZ5A8zQB6U5/N1THwRKAAjtWR5MdzQpY5lQYVmdviZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/g07feIgsapkPRbK/N/uwhd8DNZXlHlgrfvuvmG4lvj6pAnwjNQ3hp2ps7niUgDZH+3bser6pZ5CgXZicKy8vLFlDLDmMkfZX5XDwOPPcYpA1rzomj8HbbRLe1nwFzoO1UapLIa/CYz5UfmDzKW5WWy7rvTKA4ztDPSPJwT1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T1Lp6ZaL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=isdu0QkO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T1Lp6ZaL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isdu0QkO"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64560Pr0331121
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 10:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hxw8bfDrEzTfX0H1jlVJ2qshNz2Mm0JDawp
	ycKlI9PY=; b=T1Lp6ZaLYxF2WDfiR/RYkYj+G9umbx40cpe0hYBiyVDhN7e2RLd
	twTq/uPD81Ti4xntUmfaIHPr4zg5s7EYt01A1yv9QIyTcuodqfZ2cxXPzSRxeLXm
	0s58iXLnhAl8l+zM2HZUnV/Vw13U2hI5mYoNYFkVc8LbclhgknpkwpAg50Qg1jE6
	rKn2/K0jwaycGaXQqKaEsXbUPbEceFUqRcmO6vrjGIHC+JyTZ+uBhiVcY8TnuoFw
	Ljq5j+BaGj6OrPdZ4JE6rTDpifB/YcxWsFwkuiACT8R7fFDYYl75CMV91zRqLj2y
	mykYQaN/lncyY/o0EPl5skdn0g5OHcI4VvQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr1c0ux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 10:29:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b220c72bbso126371491cf.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777976976; x=1778581776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxw8bfDrEzTfX0H1jlVJ2qshNz2Mm0JDawpycKlI9PY=;
        b=isdu0QkOXKMN7tzOiAzX9MbUaKwDBn8gvbF6jeEwiNHFgZB3hWcdT/Aqt8jxXCZwX2
         l4Ht1NuIFiatWd10P1/kPm/xhEosBDIhcfE3Mmd+SYRtBBVM2KC+JvVThfGH2FSlXc5E
         2szIrUtPEGEXfJRos9675q/x8FjflKwtPJzwW9o2mqsdsuf/W02Z0ZATxWSUL6Qn6CfG
         FD7eUSxbLYekWM8MFtCH3HtKdj/Af55BnENCxINPlkTp6piXebhp/q0Zl4rKoFNsXmrA
         hHYK5HuuuFbECalIfBXLJbV4qu3WZQ7MWr2UywQ8h+j+Gzuki8YKmABbzYuC7qXSObtr
         QUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976976; x=1778581776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxw8bfDrEzTfX0H1jlVJ2qshNz2Mm0JDawpycKlI9PY=;
        b=H7HryhydO1mup8WpM1CnI7gpoUmCVJAyZmPucQNKjrcc18k9JWCbHyl/XotIL5NVVO
         9eRWyNpIlS7PLBS7U3WE2S5zYoR12XoAitiSFEvXf9BeqIA5Uirs6nrKEsp3lSmXTi26
         VXHZv37bUPH43P7kbtBW6uucP8Xa/fYLM40zvzhUnd5ii/KCWtJpGUgSIDSkzt0g5Vk0
         1Ip0XvqrLtSdCV4IYVN3k+VMH1ZUmPi8qZ5tJ8zHBgReOcC+2/FS7wbi5YMoNH/MW1cU
         rFcgkYwZWwbFDWghdp6JDvU/iv1Cen0De4icw88f+rS8nmtYq/Ib7gFJJFoSrv224dVu
         QKoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+btbZNPHQnSPgw++AFVBqfGuF3/ISxTd6a/GJFrpEmOOiZMDnzNDwi2QpwtvrjWBOsPbaJNM59YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnjM39rv+eq3VcGPyMcPQJQau6fSzMFAPbub9DP6wwUwBOEXVk
	yGvjgiJ+fLljJ9TqkYRYk6sDyZTaFidUk97MciBWP0vMkUpcWSqAZFJIJ9ALc+Jrt8yKUcrGKEY
	nuD5sgop6AN+du7dPfD7RlSbApnGYUv5EpNAnyAcWOAOWRgbuHbhAdj0OGDejfA==
X-Gm-Gg: AeBDiete9iZgpDoBNswmZvAKSYfKxf06DN5hco9N34MFgMwjXCcZ1ztM07y1sKi0VIr
	cUf65guTr1upioY1zikrcrX3nULMyI0Q7UrZgaTdW/dpO1Tv5gsWNgfqgZQAPH3JkGcPlylscBR
	ZBeFxCmko8fzlgYg+Cu/SqNa+IJFCM/WWJLgZVEQtGb6v/RpyOySakgxOtEy0r/cm0LWVbPQYhR
	HwoRN2x/9286in02xQ3ic3h/+yB/3FLMu32RVQt2zN3iMN8ZxDxixXbm8qEDV4ZuQhD4HLyQErl
	S5ICSvAUSccny2jwuF+oD8oSgSKEY+BnbkLksgc9MYsDEJLR7dMrybyuDkRK3HlYxJQMHGb1BG3
	SNVAOPLDg307jiDsbl39qnUBRR7Z43u7mO3WkAJpL5tl6qJ4=
X-Received: by 2002:a05:622a:1aa8:b0:50d:5a11:1b5 with SMTP id d75a77b69052e-513069d6e28mr35257991cf.17.1777976957693;
        Tue, 05 May 2026 03:29:17 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa8:b0:50d:5a11:1b5 with SMTP id d75a77b69052e-513069d6e28mr35248371cf.17.1777976940265;
        Tue, 05 May 2026 03:29:00 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm608468835e9.1.2026.05.05.03.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:28:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] interconnect: Move MODULE_DEVICE_TABLE next to the table itself
Date: Tue,  5 May 2026 12:28:55 +0200
Message-ID: <20260505102854.186925-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=wZ5A8zQB6U5/N1THwRKAAjtWR5MdzQpY5lQYVmdviZ4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp+cZmq/WRK1Q/FQYm2k73nIqYNW9+AaH7iw2V+
 vRSKTwogPKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafnGZgAKCRDBN2bmhouD
 1/OlEACO8pIqcWM0hqvY72i4Pm1dT5g9R+9nyZwsy5KlfWbrjlMQSIRZxHnBKMxn/rbBLI3FUtq
 34SCskRjGTYFnp6xCC3pL0Hm2z89CarweROXM2DfX/1WCWQMDKi2K/Kt4szGUalb6KfUJIQvEoP
 fI5puWeIb05yJ5t13uzYJ05DUYSuhkn9gFYtRrc+yt5ccsgAVwJIE5/FKb9OGrwu+0n/K+PSE4n
 QciaKDgYN++AtJo4tDf4EPDAmgKnEMrvwXrd8O8lF6J+dxWKZvisVN+b/gGujf1qsF2Hs7PE88S
 zQVQdOAdjQQh5ZLY6b5b5j4zGNMpP/vjHOxfreddocMkxp88hGPUPenQbuyxJJEkunPQ1WTgWMB
 VfEumU9aEGiV2LoI+gmoDUeNSzcW3mEs2PyuGa/vHUWdAsg0FI6fk7n/LB9louqCmt9TWNh+Ocs
 /edqgN1FP5bJxxQ2e2/gaS7zw2LJAIpng0UJRsfdPsEulX0zY5n81gSXrZg0UG75FKtMFzHG0WR
 xNKw6Y07s4p2u8ji6Cg0wk8lLWpt4Sr18gMkEX/ctcl7SCOgVPWvwOVe8NFawaN8VHwQBUI6XIG
 s0rPXUv0nvaCBS8FDw3Kdairqd/TvHg+d/JymHn3RksszVN3qNAoCGVUm707injGLr1/Y9dHeQ5 fPb+yN+lcXd1Nuw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o7gtFARcnqcKtX3NPGfUaAhAn2jejIaM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5NyBTYWx0ZWRfX5KSJlmozM5Bx
 +hA/g4z03H6+hVvhHvYKzVR4bRIvjXdOEJ80siSERyrpxe+cKqKhQ0/KaTStYkYxjfKlIkPjZj8
 6SbiOEEf2/VcPxc9WpsbY+e84phccqjh+EjUolk/LNg0nDhsq//IEmlgMQOQq46FQNU3t/OHKn5
 BU4UDFFd1inX/emNeuLXbMAmztpSf5rqzH605UTGBVNUHm2Q5PHSn+2HGRRzZ815I5KUsr0Hje4
 UZSjv5lP9pUPLlgAFiUOEi32+fsZddJSbvQSzTLkZLwVlrUUc7NioT2wvznTMTdmEeuI3sujZI+
 yL5aZohStlgQWnXoLUsSVm48aVWIemgocn8MNoygVO2LesU+QbwM2PIrKiSJWuv8ZPb6Od21LFs
 BIC2AWp6dSe6GFZk0T3j/EpevpDPPZJjdNOVHElvEWKyxL296zN971q6PMK8opW9eyAThzHJo2i
 GDjeQNKJerRWrd4oeYA==
X-Proofpoint-GUID: o7gtFARcnqcKtX3NPGfUaAhAn2jejIaM
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f9c691 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=BzP98TPolLMEYMmIy-QA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050097

By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
exports, because this is easier to read and verify.  It also makes more
sense since #ifdef for ACPI or OF could hide both of them.

Most of the privers already have this correctly placed, so adjust
the missing ones.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/msm8953.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/msm8953.c b/drivers/interconnect/qcom/msm8953.c
index be2b1a606612..94a9773d2970 100644
--- a/drivers/interconnect/qcom/msm8953.c
+++ b/drivers/interconnect/qcom/msm8953.c
@@ -1307,6 +1307,7 @@ static const struct of_device_id msm8953_noc_of_match[] = {
 	{ .compatible = "qcom,msm8953-snoc-mm", .data = &msm8953_snoc_mm },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, msm8953_noc_of_match);
 
 static struct platform_driver msm8953_noc_driver = {
 	.probe = qnoc_probe,
@@ -1318,6 +1319,5 @@ static struct platform_driver msm8953_noc_driver = {
 };
 
 module_platform_driver(msm8953_noc_driver);
-MODULE_DEVICE_TABLE(of, msm8953_noc_of_match);
 MODULE_DESCRIPTION("Qualcomm MSM8953 NoC driver");
 MODULE_LICENSE("GPL");
-- 
2.51.0

