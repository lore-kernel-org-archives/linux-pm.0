Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A023016F5
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976882; cv=none; b=F3AxU+y2fR3Gtun+jWYxdZlXhN8dmdX9y9bVQXY6Wyllkh1haWidxUViHlOVrbsLgbgoE+av4Yh20F7M7CjbBc4FbpjSZIRa1j3Fr1o/RBjzCSW+8h68zoaw/xAG3z9lCBevpCe7R6zzY1My3Ae810XKT4fDVlIZJdrWr06vo/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976882; c=relaxed/simple;
	bh=esUHlcrRUA+pHtsk1PBRB39p13V3lPQMBpZSJ6iPyMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c/0ENmaI79V6uXRKfZ02Y/bPXu3kK+qSbzIkTAuMVtLUCnYujqX3+cttjtEMHS6sf52d8/mp7vncNpvIaeg4YaoFZsBktsxmnuhQQkqOg2S4ICa8lBbG8ikYK+S4L83L+jjuaUJBO2UBc8gfb0gy1xwTHmW76yEm49yn3d0Qego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SJt8f3nT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=beoeXOMh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SJt8f3nT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="beoeXOMh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456lhSk3187538
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 10:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TweDK+EJ2ANXPJLzcxDTiq
	Bm3BP0/M0cHfrljY9hpyc=; b=SJt8f3nTM4+wRWUAVN3e/6y2A+hbSRyt8mGF3H
	+cWKae5pJdb+9hVLAl/Av6dGJJFH07hB72wc8CcZoo9l77BFhFTgs7mK4jdQRFYO
	XSOULhgT8dCnN0TCc5q2tP4IOR59LE/GLJ3Cr6dqJmxjEgG+OD/Ind4JA4QvtYmE
	HrA19xZot2zDGuU4QtCRemLdVRqzY9JZGw3pSyWmw2Vi4HbDmaWoOcXVXvBfNqia
	ZkU6YRn7uDsQVH0kfHPYGC7U9PEhSXY/AnFYZ8GY0uCKo20hlqZiLMVifk2BMwJ7
	Wk/IfhitfAvnteeOFbcwD1PhA5HOAFz00YLlueevMNLZlB/w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkk8t83-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 10:28:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50fba8d8c40so130151271cf.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777976880; x=1778581680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TweDK+EJ2ANXPJLzcxDTiqBm3BP0/M0cHfrljY9hpyc=;
        b=beoeXOMhjPN01mI/rhxdh5eCLb9qUd1HV6J7a5sIcrx0t/CC3/6MLDZozwlNACwe5N
         1yIiI1EZDkWkagglND4EDxvmfqCD2IzA2JHX5Z0vLoY0OMIYcgplgdNrIvXQO/lrVCTm
         tf7yYBWbzh6g2Y7IiXdBJaJuBqkh2CSs4HVcDBrJQY6YGoRPitZUaNZKTfAhn8dGFWWk
         NgZK32RWhzP+s/v0Oox36DjXw7n9V/yRwIGBGpDhmMlkpz3qteCWEteFdwGHwW37/bQH
         pMrMJMmOy5NemSl0KGJ/3gfazQinOAYc/ODugxP2KxTwMYeIs91pmwLjMKhIp74y/xn8
         lwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976880; x=1778581680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TweDK+EJ2ANXPJLzcxDTiqBm3BP0/M0cHfrljY9hpyc=;
        b=Pd+1TPwFNXVvRR2+Ud7yzwoBUbqLlCaLKDT/Msz+DPvqfBf0kfkrmeQehpD77j43XW
         UPZtrbfIYlynwx9U+eAam7Cb3b3d4USJWebZI/UHMOaB/Z2VmOXTu+nM3IrmaqgaSxX8
         Eo5bWb0o8iaWgIm0MhTjOb1Y+9DTd/MA5wxolOJNhYdFDcqoMSOXUH8Gqurf5ufQbJXH
         Z3atbrjNNd7zpGR601bBzmQ4XoQQyD59OoWoKBLHVxHaYwbiVfgp7gxTAnfaazYZ2oPx
         hm5ajsEeth2gqbfZXOkoiX9DSwZBh1H7WsL6M9TvPmzpZp6jx7Q5S/2FlLep/1cFLcs3
         Ngug==
X-Forwarded-Encrypted: i=1; AFNElJ/JmMADG7hwN0viZY1gGnRStN9WkLSr3QSWgrxJFcl33J495873dw/wHsNAnhdUgHw+0DsZQdPJRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMC9JSyOTmhRNIB7mC3dGDpmKWQeLct95ElinyZd36e2tmaVoe
	u7rSNM0UHUBL5ELQdIJvJ7WNfZrQwYoXOB0vNEO2bXL1f08VnqF75QCL+Vywvl3Q0Ii0OrYjcu5
	BXJk3iFPheJxjdtIQK/olfWhofzjzWWiCz4DhbzsaBRZG9P7ZY1DpJcCKXNsIFA==
X-Gm-Gg: AeBDieu2i7XtaCxBJDlszio++O5KKsyPVB0y11PAL9Gm4R7trrNW50wqUfAy1hARUiQ
	F7kZPg2WIYmsoMoojX9j4UflzvAansiGxPFvqgXzB4wHTqUJBMZAZvbPvkhBTHRuIipIxhDQdMJ
	YRJxaYzFerd0q36GZZFllpgXN2vzgWDgE1/iXyELFHosQoO2Y0erRnDM4lPC5uVhhgxRN5b6hT7
	pOPUqjkJznOSmHXR5EBkFb/gwZ61Nx6yNTO/C5NhNWuh34TI+KMdWUvN3vvqglANcxiSPTk3t1k
	vPdUwjKiV34WJJQPKGyCnRqlDzVcOPah3EyECR/3PzckCSZD1HboyFke1UOUfNFCR+jaejlHr+7
	b7brCVW3MEdxfFQiOV/9Ej0YrCcju49+k50W5PSgS4lOMTK4=
X-Received: by 2002:ac8:5a81:0:b0:50f:b81e:c65b with SMTP id d75a77b69052e-51306b43477mr32427471cf.59.1777976879768;
        Tue, 05 May 2026 03:27:59 -0700 (PDT)
X-Received: by 2002:ac8:5a81:0:b0:50f:b81e:c65b with SMTP id d75a77b69052e-51306b43477mr32427361cf.59.1777976879382;
        Tue, 05 May 2026 03:27:59 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f249bbsm3189429f8f.36.2026.05.05.03.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:27:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, chrome-platform@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] power: supply: cros_charge-control: Move MODULE_DEVICE_TABLE next to the table itself
Date: Tue,  5 May 2026 12:27:52 +0200
Message-ID: <20260505102752.182089-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=esUHlcrRUA+pHtsk1PBRB39p13V3lPQMBpZSJ6iPyMI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp+cYoxNO4ryDqtiJmdaOnGQ9p4fOKrW1flHj1p
 sG7Eez3iY2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafnGKAAKCRDBN2bmhouD
 1+CsD/4thZbfIWqhsgH1OLmIjgNTZdRfe+hF3YvZzy0p/Q+u4n0146FuBEf+ES/aVHUsIxSqjox
 R6aERZNSeKvJwm6J/qEl9gcVjvwVBKjljTPeNOm4ZcPBgRYGyy1lHVod5cMPx24Ztf6PpspGjuZ
 b/gbrtbjuqKMWokfkzNjk4YBK9VaQTJdUzXujFHrnR4xj+Htg5fzaXUWhx/M8LZbfV2prHV6f/6
 j2XlPLi1JhGF5Q8JHBdruTvSCse1Cl7D9nbwTZUoen+Q4Zx30bBfTe+lmHtMlorzT+GuUBObQsW
 dcB3g0EYUld86lnZOH2JSk0oIuK5KCrztkxwTTxfvbwUGzoGGS8WnjVCJPlqcJZplkgVPrtgJ3P
 cFjXvxyD74n5qZmTXzCUKE0lwC37ZUbqzJKtdrCtLbYciI51YI5sSIPLpDcihTFOG0/hnjg4b+T
 CZXhVWtdOcQ5mxz8+c+K+gHjI9vLmCP7MUD1dom+4GeSikE3QqH5rbDbr7DeeLILhObIoZGOxQO
 bLUUnKWKA7B6HRlGRwgNypm0Lmwg+pf3q843dr6UACjhkTx0tZcmEj0XlYKsKjmslKnR5HE0iTM
 9WcSjRvJnXtTBqkNyD4YFR3EDEJ9qCBi9wZDZyU6wjNqA8eo3leO4wt25w4Bz20rwkws36EG20l P9vhun7ngypVJNw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5NyBTYWx0ZWRfXx/QT/L0rbE1V
 wFbXfJF7EkuSsFLWGcqFBI7zpkRYgaN2ZtmZWAo5NRXhO5BkxOwzCHuIAXO/AZdNU8a0z2jEhgt
 yGYGXoyy2n9vXO2U4ZuQapyIX7EgU/R5tGuPlNe7U0qGJsGjFSm+Y0A7e1SeFa/iuDb2USmKGin
 jb0TjUYP0/74cFmGbIoKsryq7CyfYAMX/xSONqEScSWslznJP8GTVfrvCPgqv8xwCLUu+dZgnI4
 lJuPHfUWruO2dbar9toK5azQyM9qZbEdZfhia03+sUudAvzIsiqSRdlH3DCtwibSDQpdbpzsVEQ
 UVre9GRWI6rUFM7UssSX3iU5xuH9RhFEoQ1mmAbMI0diOUvO1Gn17DVOsxvOa7AKtQ4xz7hcsmt
 ObbrW0lKjVte+Xn6LQ+FhfKVx6sjo0ZVAmexjLMfvKTT03If53OXOxc6z8JsyUfUlmg5cpxtLlJ
 jkH07kxFaKQbeqZyN0w==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69f9c630 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=-VWkRg1N4B0ATEIe:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VTue-mJiAAAA:8 a=BzP98TPolLMEYMmIy-QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=S9YjYK_EKPFYWS37g-LV:22
X-Proofpoint-GUID: 72qTpDWJzo9hSpc2iWtDNikaJwY2MrV9
X-Proofpoint-ORIG-GUID: 72qTpDWJzo9hSpc2iWtDNikaJwY2MrV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050097

By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
exports, because this is easier to read and verify.  It also makes more
sense since #ifdef for ACPI or OF could hide both of them.

Most of the privers already have this correctly placed, so adjust
the missing ones.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/power/supply/cros_charge-control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 53e6a77e03fc..6a5e54218178 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -323,6 +323,7 @@ static const struct platform_device_id cros_chctl_id[] = {
 	{ "cros-charge-control", 0 },
 	{}
 };
+MODULE_DEVICE_TABLE(platform, cros_chctl_id);
 
 static struct platform_driver cros_chctl_driver = {
 	.driver.name	= "cros-charge-control",
@@ -331,7 +332,6 @@ static struct platform_driver cros_chctl_driver = {
 };
 module_platform_driver(cros_chctl_driver);
 
-MODULE_DEVICE_TABLE(platform, cros_chctl_id);
 MODULE_DESCRIPTION("ChromeOS EC charge control");
 MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net>");
 MODULE_LICENSE("GPL");
-- 
2.51.0

