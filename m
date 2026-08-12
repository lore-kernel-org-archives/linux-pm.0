Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA93AC0F8
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520947; cv=none; b=k5ZSNxeoYxFtuHP2XzyvTK/ktqvSxaBMYPUMjRRW8JQ7mNIbYoxXK6eC5FsVpJThtWYD46AMTR47gfqi2BKBXUr6ySCET0CNw9U7B8doaEy1MRS1zN/eb+n1ilXh3fGY1PXLgvwXLLtDZ4TibXVJ5o411vLe3cJwaBY7xqTq0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520947; c=relaxed/simple;
	bh=T4VuJfMx9MxRf7rLbt01upUu+iKdhsLLEDcpS9X1wrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fJZKTdHV61ZNm005raJbRaMQxmzAc9kPBkAX8+Xytz5fpOG4aGABFByrTySYDqqnFeCgdpoI19X5kci5RPn9NRcnuKp8mqdeLseEiDQOMTHTMNZ99ZrlC32mvZixZ24uh3RxspQ7xvsELyaJ/lRPsLjQyS6BuZYm896yxpRY8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B+iIWQwO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iWpGvQbc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B+iIWQwO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iWpGvQbc"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C79Uwh3144280
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 07:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tLSra2wpYTEdApChSyIfbP
	2TyrOLtjRXXKtLYInygb8=; b=B+iIWQwOCl3gqnVrqIpnByCuAfFV5jKOkLBGV4
	ckWVmnEN9ab5jfg9x1XJoX60OS5DnfUs7Un9xS82uWXz/qh/PEIIPovdimzKuArS
	G9dqX5r7OEJsudWw2K1U6yMIX2gVJrBbdpKAFYyllINGupb2/Qy8hmERRptE8Qx8
	X8MT7sucs+aM1BDBYQNdB0S6eGyvPeIu9crrPneVN25ClvRQLRzCaYtU/WAFOOC5
	tiEzb1rMqi5zvtMTBRg7BRpJ5KTl7JpkqZYDrbefN0cGTPtq/dPKzpva9dQ6q4yr
	tJvWvgte0SWKaSfTduwMah+aZaxvULXSW6SW141a5CZX/mXA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rg4t1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 07:48:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso971339a91.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786520939; x=1787125739; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tLSra2wpYTEdApChSyIfbP2TyrOLtjRXXKtLYInygb8=;
        b=iWpGvQbcng7axdiFCWr3IezgbqCUBuAVe1xKy0adEjr4M1QEVgwVystnxOSXUnvHxB
         GlX5SZn89C91u/0PK9dfeZW8DpZeFjMcKxEL003Fd3wK7ZrOLDViCNfTKZ6hOTniGElT
         Xev0+jp/0eyoOSVL8etS43vnr5wl9fGbC5H5Egrou1Jy18sYg4iAlnVQHLoLoYm4t+Sv
         GYArd6ARJaYp6q4H3LSLdblb3Mr2SyTI9hzvnUhy41Rn6UurcZ6x5aMRSzJKMeiCFhHx
         41HtlFOAqf0a3cFtBwMmz/YLC56I7IensPdbXUAMTae3O64ZvRFL7y76q5+elfCffJWR
         1Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786520939; x=1787125739;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tLSra2wpYTEdApChSyIfbP2TyrOLtjRXXKtLYInygb8=;
        b=BGj/Y1BVt06yaeCR1hoC2HsuISx7vft8o4CjGocqhbJQue9BmZzZlHg1PD4E8fE4PE
         Z2rPGQgBkpBp4VVSDJuK5hzqby0AdNQZPkC92Sr3X4ZfAEH0EFqXEeNiB5u64BDyVs8Q
         EN9eySdbAmnW1dcNf4C4UfvqA08LMRixkejhF/FoOu9EWxo/dPiqpNjT1nneC/uKKcns
         S+oHBbYCmnLZdUh7jZnMmALCfE3SCcjdoau0pe/FbfrKufXLHulZrTUKdH0XsdWSKYUd
         uOcebKqso21PmbQ2XL4GFaTYXk+KqJENhB5WtUwtn4UowbzHdKr0rRYIMPFY7WBQ2jIt
         gi9A==
X-Forwarded-Encrypted: i=1; AHgh+RqEfEp6AJmv7DU1o32Bvr0KVq5MHJ0nrPTHmCHJD0JDKBpciL/+gf3T8H5yooEuUl7L6diEW79Lpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3G9rhaTWcPKMkfU3SqrCMO9Ki1TFGIi3nqMlWC9a5Sy8oZVWW
	KLiB+ByqfzD5X6d0GYJ+Pngubn3Bex2X4Q/HllQP9qSSWPq0jFnRl3qqdDZQB0+4T5/EZPFBtdk
	pTzQeMh8yA2QOstW2DE+haqKgMHUXqjroX0I9wFmmwnHjXafQYrwWFYtmDbzJZA==
X-Gm-Gg: AR+sD13uBFKG09jMxkOpwoGUjd48/UMC4GaAlOMzuX2M9hZbYL5T7+0xHRXI7yIJubS
	9MtqJ7s2irGs/ETJFsiB7vCtt8bPOI9zNPxr18wOoTJ4YiB5CGR035P/KHZjwG7I7v1U3JbStle
	zOz1xt/7yKt8kdlbWz42VjB22guthaM7RgJi7KoJ7BsTiFphHjsMbY2ttgmzwCGUEneCn1n7BD2
	kAIq4n5xdXdJx0e1cVQb68ELPd+SsDCjy/z50Pswb0xv/4yohWc0SYY7hJCMxObBH/GbQ3/haj6
	hPGsGWEfVpOgPjAZW9i//i+woDP7nJbn7c8a8RevQLdiYQURZbyfp420vKgzmvgsxxEw7xOeEaE
	+RiLeePVAHzK9vrQwl3LL09wP9n4L39FBbpcMFucXQW1Vy4TiO1O0fA+/
X-Received: by 2002:a17:90b:254a:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-393013f86edmr3419183a91.11.1786520939111;
        Wed, 12 Aug 2026 00:48:59 -0700 (PDT)
X-Received: by 2002:a17:90b:254a:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-393013f86edmr3419136a91.11.1786520938561;
        Wed, 12 Aug 2026 00:48:58 -0700 (PDT)
Received: from hu-tingguoc-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141243819eesm7057741c88.0.2026.08.12.00.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:48:58 -0700 (PDT)
From: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 00:44:47 -0700
Subject: [PATCH] power: supply: qcom_battmgr: fix battery chemistry strncmp
 length
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-fix-qcom-batt-chemistry-strn-v1-1-458545e02641@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAG4kfGoC/y2NQQqDMBBFryKz7oBRK8WrFBdJOq1TSKzJWCzi3
 Tutbj48eLy/QqbElKErVkj05sxjVDCnAvxg44OQb8pQlVVbXkyFd15w8mNAZ0XQDxQ4S/qgTsS
 2qRvf1oa8O4MmXonU/+ev/c55dk/y8mseRqJp1l/ZNXA2E+pBYOmKSIvg8W2g37YvAHwxirEAA
 AA=
X-Change-ID: 20260812-fix-qcom-batt-chemistry-strn-6434c631ecb5
To: Sebastian Reichel <sre@kernel.org>
Cc: Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tingguo Cheng <tingguoc@qti.qualcomm.com>,
        Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786520937; l=1600;
 i=tingguo.cheng@oss.qualcomm.com; s=20260316; h=from:subject:message-id;
 bh=eDN+VD7WGKURC4qtRBVyk3xkee3IcFWDykNx6qhUbzg=;
 b=TmAuTe8pIsGoVETXya8flEHdBPufgI5iw8qBiZk8MeIRcUJCJfn772tDLbpo/9XHNcBQIwiyU
 HnSKkKqWGoyC1dEAskOhFiTcV/+OyB+yXLJpB8vbt9aNyWaS/tZtaTs
X-Developer-Key: i=tingguo.cheng@oss.qualcomm.com; a=ed25519;
 pk=T3R0T4olG2WHVswcdTJHHRrxxxuOHDk1nafJK500cms=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2MSBTYWx0ZWRfX/qqJX2ih3gMe
 7aSR7QKEQL727h4T0g5xfFT9EQFeHCM+mzoah/J63COLKDdcYz+Jcz0QERVC0QjhILVjA5OzQUr
 zqGm7aNIrIpfDo8TutvZOfNNqBdOzMHKUAL5YMHeVWyN3bXoAgd/zFvr6Q1WTZBx4Q0JItWIw/4
 NcbgxMsoEqcrsY8FDa9o2JoLMPdTG8kr11C0eii64NMWLAvPXZLtLakVnpIA6Noopsyh1UwGkKv
 +xE6/4K/IGfXivpWL2vZLvlf/nh+kgs6h48Blj1Qyerj1uYJc9d8feWptltMcJJNyzzbDH/7NRy
 jED+333r6sEm/bPgrqrUi1J1iwbofNZR3eI++M2jUEvvE0ASjJ8qBc720pZglTs1ielXbc/lHHt
 oX8N+DuXdOw4mAH6BtibPKmFm8JWdxauzT/FjYcmhR1yNFPgqlD1gSBGY+sHQrlYs8CweNviole
 wqhXybTsAzNsDvdWpCg==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c256b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=5RUhaqmk56rKhqzsUy0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: xucnamUvC5rDkqwL5BuP9_eJOx0T-YfB
X-Proofpoint-ORIG-GUID: xucnamUvC5rDkqwL5BuP9_eJOx0T-YfB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2MSBTYWx0ZWRfXyMjO9ZwpGpy/
 PdiuJVW7QC8cN1Cf8hspOlrqQG4sZTm4C1Mwfi28E5pr+daMHardVshmQTJ1qwyA/jYcTB65RnJ
 tD1+yTQ3rhOTleWj00TW23F3ETPl7N4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120061

From: Tingguo Cheng <tingguoc@qti.qualcomm.com>

The battery_chemistry field is a 4-byte array without guaranteed null
termination. Using BATTMGR_CHEMISTRY_LEN (4) as the strncmp length for
3-character string literals implicitly requires chemistry[3] == '\0',
which may not hold. Use 3 instead to match only the significant bytes.

Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 91cf39b0083a..7716eb9e1aff 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1238,11 +1238,11 @@ static void qcom_battmgr_sc8280xp_strcpy(char *dest, const char *src)
 
 static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry)
 {
-	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
-	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
+	if ((!strncmp(chemistry, "LIO", 3)) ||
+	    (!strncmp(chemistry, "OOI", 3)))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
-	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN) ||
-	    !strncmp(chemistry, "LiP", BATTMGR_CHEMISTRY_LEN))
+	if (!strncmp(chemistry, "LIP", 3) ||
+	    !strncmp(chemistry, "LiP", 3))
 		return POWER_SUPPLY_TECHNOLOGY_LIPO;
 
 	pr_err("Unknown battery technology '%s'\n", chemistry);

---
base-commit: 8ca3d2492e247e36fa9a4350fba2010ea5eec6f6
change-id: 20260812-fix-qcom-batt-chemistry-strn-6434c631ecb5

Best regards,
--  
Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>

