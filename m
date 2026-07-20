Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBC38F249
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574223; cv=none; b=DzkI3ViWUP7VEb6QsBbrM6MVXSl+TNYgwA75/nlbX9qq0/960RW0lIrrLxSf4VCocx956DyG45t9XCp39o2D7H3MOp3oVPSwFRpSKi7jukGevq/35mYXQLOCKE0QpTVjJNvCZzJ3npkvG6YnS2a51MwH/9Fy5Eof71mHmT1g9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574223; c=relaxed/simple;
	bh=imxuGMzvwoNW6yNDOJKPCD+UHZpzgStrg6didKXVX9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I9ZXBLiyXx0CXpkcn0F05dCm3UtYHimk1mlmx6PCQpCBmQPhbVPe48BMms0x3WvfvOTpRvgMXlVKetEcrTtI7hzzUtnpNQmkbKSS/VNsSiwJv5qWdKO1B8tM9/eshGFwh/Tytvg6JjCnSCf9jHZxCwWj4Sx+f5DwnsrB+1Sn5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=exA2JKMo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MizgAtJF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="exA2JKMo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MizgAtJF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBrXJ137382
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T8pwpTHVxKFUW9eWFUcZ6JIUKqN03SZt/B2SWptMgIs=; b=exA2JKMooIWR639R
	7mDKZ7AKQ16XkmPe0Iv5e+fo7UQCpjZ9AJ1VeoEP5AdJiw6i32E/N5bO4RFDv8eZ
	xuTQs/3BGqZJQ2BrtHG3pnMR/dazNOB4JO9iDE84818RO1ijxLglLTd6cWkcECva
	VhOe9mZ3rXiYP+wabP0Pmi+bWdlzzZylonRJzZUpXtypmbgDeLRtzBnljm1lHcBP
	Dc0uctNWder+0Uz21V2QBzud0u1NnwaELl7eOKhyDfM2mMZ+bfxd1bnDbYNPeD5c
	3u2pzdIWH8PB85SsoaFWRlKI+HrpZidjhls7cZh2puG8kT1mUo+VGbir1MZ/4buw
	9tEE4g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5rf4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-522de3c645dso63268701cf.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784574220; x=1785179020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8pwpTHVxKFUW9eWFUcZ6JIUKqN03SZt/B2SWptMgIs=;
        b=MizgAtJFXf/A3nc/U4LEaKkc6HbuqhB/qpqbRlTOR/LyOU7cUh13STha+1VW6MDvHf
         NeMZQ0VwkrtYvNrfFM5ce+IGW0yJw2lQ6TB5yOvBTDvfs6Y9EEF/SUahL51Odv24TBxP
         utLeQmjfCPSHAkuGrzHx/zq55+Y8aWIOmV34PJu+UWgHdFMJiNsKr+3XELdifjYW7luY
         c2QtHzxqB7Kp0CApopwqZS28/eKraPXhjnervgnxcogdWDG9CvtCCQllVUTaSOQ7X0E0
         b2nHVlBqTet/Thw+5aNXSMVqqMcgInw94kRHzyPO+eMlVB1ET7ZBr2NqDZ7twIGaOADi
         teng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574220; x=1785179020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8pwpTHVxKFUW9eWFUcZ6JIUKqN03SZt/B2SWptMgIs=;
        b=f9q3oEhz9uilax8jhpE78KFbj/rdTGTFa/72vUaKGpVPqICPPlVdVO42uifgx6KtrM
         JELZPGJU3uUpuO7yZSbO0PnEkJCWxPZGL7kH94kVlzJFxcrYdoZxiKfB5B6C/RaeYsyr
         NZquE3sCQdgbOC3P4gMuAhQAEoRlET4saMF2XvZyBHEM+4JNYvm6X6yt8cr/x3uFOdrI
         8JuxxOz5e5wp7+jkZLd4RZymyKWgJevzrkJ7ojLyUK2YSl6/zu4LFYVLHCLH1LwNd8od
         vZxnxHHUCHtRsMsuolPw3GTDDMjY2qTpI0vX8NYpfo6S7jh8W2NQjCmhhFmnYEw8Z4N4
         uTAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/10N/8296SBQdM90GmKuoCeyvruqHqI9BEupOL+AYusHHOjTOq6HDJ9i5yQ1UqRU3UrkBMoPzHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+KMqqzvpPLqLAP7KsJFky2JS1VWAfV092v7eO+9KN9fzhwCq
	DjCE5PHdJ8dhi+DqzqWHt9wQpu+iNCPrmxqMd+jPR/iI5tzLCmUzQgt/gWwpPGX3MngzNgn5gEx
	MYIqAW7/Ec2jvy0DP3E63ZyGNEhF9EcOCHw+eso4zd2NvM173bAEHaVq7/+pUmIssYxouHQ==
X-Gm-Gg: AfdE7clP6YsWZd+WEibx6oJb8wZjAkLVaEZtFPGzYmONhlPdqgwsXfplVTSr8A0kkzE
	LsK2MEt5zKqZfsIxOHMO7qb09LRkxyOxx8zt4dhBk6lpZl7k2E5jLEPp1EUr3fz/1HVwv1vNdBB
	5+yZiID8gO8YRW1NB0XWCVwoU7o7YqbJSxvKsTvmc5lyBb1dB1fVZGsevPcDvM4pvfHktq5ZM/9
	lg+dH9IdCTFWAqjquc5pQbt91rSZ7gvIMBOBon7OJqWx8mNaBaXgnaCl+wQkqD9xZLUkuSwlCVD
	SN4HJDFzjzikQ0rKr79bCKPLuEW+7IpyGKhrMYMbZ8ceihYR9Zd718XNuR6b5zMWVHmIRYkoMVG
	WivoPSC4IJXS5nz6RdN35IK4y
X-Received: by 2002:a05:622a:4d:b0:51c:7b12:5fce with SMTP id d75a77b69052e-5213cec8679mr147242551cf.74.1784574219242;
        Mon, 20 Jul 2026 12:03:39 -0700 (PDT)
X-Received: by 2002:a05:622a:4d:b0:51c:7b12:5fce with SMTP id d75a77b69052e-5213cec8679mr147241851cf.74.1784574218309;
        Mon, 20 Jul 2026 12:03:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954aa1a231sm181509845e9.1.2026.07.20.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:03:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 21:03:27 +0200
Subject: [PATCH v3 1/3] interconnect: qcom: Make important drivers default
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-interconnect-qcom-clean-arm64-v3-1-942e8ee7ebda@oss.qualcomm.com>
References: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
In-Reply-To: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13634;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=imxuGMzvwoNW6yNDOJKPCD+UHZpzgStrg6didKXVX9g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqXnEDx9cJo0HuorJP3fzoEM6yQtjw9/OGnH/Zx
 NlhzSYtOHqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCal5xAwAKCRDBN2bmhouD
 1wpVD/4g0dR4ma3BYT4o9yYE+36pL7e0pX7Mja1UpudkMX1VgojjPDLU/NPg/J+KUnm7R7njjgH
 9xyjih1In2uapozXAg9d6B27XQLMGYItsEs1/SBVBu0EO3H7jcJjcdyw0GOp8cTolAhjN0tb3S/
 ApyRn5MVbm6xWIlhCQKH1B4nEC42NSwn4LO18dlCtKE+akaF108A5iMwSK/e3d9opCxewLnDqZh
 SMahqHWw1SPvtjhnPkeL/iv0GenGUaVXRh5bG2wgWm9HqRtylIlbMI9WIDB9zMgp99+c9LQ/h9r
 N3YyoPo62yDquD8lz2AdDorWPUxPo3F3C4pg8BuggwUaXbm37o+uDKOCzOOkp+xGBOXtCQCO8pt
 2/GKcU+pwIerb32IbA2pWvOYedul9+cOkxP8ZSQeFW4At1fbs2qz+6UJfdsS8Naeu6Ea9bKV1+E
 TgxjIMqAZyStBZrx/9pY08HvhobMl54db5XUSXUgBXJAaw0IrTjKZX5EzWP2pwtMLeTdQ6pTjnt
 rqr72313UmY4CDWhihOUiAKrX15vECSDmVCfj6vZynBF28TXF+O3VjQwOQWjg6GFlYUqsTeItip
 kfgP3H5pW7yNVrmqKBxYlkcvw40DXiteLV+Obn5wsYNeY2TMQgp2GbPuoegdyahDb7k/5gZPdLb
 GFC/VucKB57ovow==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: Mr-4e6d9UUjZb9Gt_F7EV24ABo9bGJRJ
X-Proofpoint-ORIG-GUID: Mr-4e6d9UUjZb9Gt_F7EV24ABo9bGJRJ
X-Authority-Analysis: v=2.4 cv=e+U2j6p/ c=1 sm=1 tr=0 ts=6a5e710c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=SgRPkAPvXIXIjLLMwDcA:9 a=4VlVeAog_cEay8Ou:21
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwOCBTYWx0ZWRfX388LJIK6PDaR
 grp5gCUYarD9bfNfpKEEha+tvi7SJE9ZGcpx3ucHyOEWR/cqfnp9cqW4sUvHTBYxIg1Pj2RL/Fh
 679RmyPbQNODytp2C4n3q8Qd8xhglUI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwOCBTYWx0ZWRfX5ZfcQwEdBfwg
 zBn110aAj6CdLX7XNLi8bHPPvafwB/42OeMDp5zv8y/7DqoiiqUOtw3GbPMDHzmlNZ/J1oMM7S8
 mena94Tp+jDXAbXKeOMRSwx9mK0mLtrUmfg813ixPwxrbTc1LKK8MwriG2MZf/LxF7Xhcz/GdfO
 9a6HWQdmdvT5LOmKyMCdgOH/0jn7+/Dr8vawosnVkawe1DLZ71ujR66UJMszINELD66D+JQnt99
 1mX/n3McwhP1HcHPt8xbMTDeAojb7tNQcDlrSDeM9lH2wFrjY3ax6iy4T/BrkKzkT8KPggHA6F8
 raBr9soN2h12cnpOL/MaiwiTMmGkiZhl6AuwwfgdV8oufyjzH0HzM/kShGsC++IGQndsV5JpQ01
 9cDR/1jE194jsliYQZ26fIMUn7S6ot4MRyyhEF/b0BJXp9q3hoTPpAalBdAWp3WA8fDq5A6ZE5Z
 /fi+/+Ar+glyR6ozAJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200208

The interconnect drivers for Qualcomm SoC Network-on-Chip are covering a
basic or fundamental SoC feature: bandwidth management between internal
SoC blocks.  SoC can boot without these, but power management or
performance will be affected.  These drivers do not represent any sort
of buses visible to the board designers/configurators, thus they should
be always enabled, regardless how SoC is used in the final board.

Kernel configuration should not ask users choice of drivers when that
choice is obvious and known to the developers that answer should be
'yes' or 'module'.

Switch all almost Qualcomm interconnect drivers to a default 'yes' for
ARCH_QCOM.  This has impact:

1. arm64 defconfig:
   a. Enable as built-in INTERCONNECT_QCOM_HAWI, INTERCONNECT_QCOM_NORD,
      INTERCONNECT_QCOM_SDM660, INTERCONNECT_QCOM_SDM670,
      INTERCONNECT_QCOM_SM7150 and INTERCONNECT_QCOM_SAR2130P, which
      were not selected before but should be, because these platforms
      need them anyway for proper functioning.

   b. Switch to built-in from a module INTERCONNECT_QCOM_QCS404 and
      INTERCONNECT_QCOM_MSM8916, which as modules would not make the
      platform bootable in most cases, and INTERCONNECT_QCOM_OSM_L3,
      which when module might slow down boot considerably by having
      caches running at slow speed.

2. arm qcom_defconfig: Switch to built-in from a module
   INTERCONNECT_QCOM_RPMH, INTERCONNECT_QCOM_SMD_RPM,
   INTERCONNECT_QCOM_BCM_VOTER, INTERCONNECT_QCOM_MSM8974,
   INTERCONNECT_QCOM_SDX55, which as modules would not make the
   platform bootable in most cases.

3. arm multi_v7 defconfig: Enable drivers necessary to boot
   ARM 32-bit platforms, which are already enabled on qcom_defconfig:

   a. Enable as built-in INTERCONNECT_QCOM_MSM8974.
   b. Enable as modules (other dependencies prevent from built-in)
      INTERCONNECT_QCOM_RPMH, INTERCONNECT_QCOM_BCM_VOTER and
      INTERCONNECT_QCOM_SDX55.

4. COMPILE_TEST builds: Enable by default all drivers for arm or arm64
   builds, whenever ARCH_QCOM is selected.  This has impact on build
   time and feels logical, because if one selects ARCH_QCOM then
   probably by default wants to build test it entirely.  Kernels with
   COMPILE_TEST are not supposed to be used for booting.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index e4806bd7929c..dd8774d84321 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -2,6 +2,7 @@
 config INTERCONNECT_QCOM
 	tristate "Qualcomm Network-on-Chip interconnect drivers"
 	depends on ARCH_QCOM
+	default ARCH_QCOM
 	help
 	  Support for Qualcomm's Network-on-Chip interconnect hardware.
 
@@ -14,6 +15,7 @@ config INTERCONNECT_QCOM_ELIZA
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on Eliza-based
 	  platforms.
@@ -24,6 +26,7 @@ config INTERCONNECT_QCOM_GLYMUR
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on glymur-based
 	  platforms.
@@ -33,6 +36,7 @@ config INTERCONNECT_QCOM_HAWI
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on hawi-based
 	  platforms.
@@ -43,6 +47,7 @@ config INTERCONNECT_QCOM_KAANAPALI
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on kaanapali-based
 	  platforms.
@@ -72,6 +77,7 @@ config INTERCONNECT_QCOM_MSM8916
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8916-based
 	  platforms.
@@ -100,6 +106,7 @@ config INTERCONNECT_QCOM_MSM8953
 	depends on QCOM_SMD_RPM
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8953-based
 	  platforms.
@@ -110,6 +117,7 @@ config INTERCONNECT_QCOM_MSM8974
 	depends on QCOM_SMD_RPM
 	depends on ARM || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	 This is a driver for the Qualcomm Network-on-Chip on msm8974-based
 	 platforms.
@@ -130,6 +138,7 @@ config INTERCONNECT_QCOM_MSM8996
 	depends on QCOM_SMD_RPM
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8996-based
 	  platforms.
@@ -139,6 +148,7 @@ config INTERCONNECT_QCOM_NORD
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on Nord-based
 	  platforms. The topology consists of several NoCs controlled by
@@ -149,6 +159,7 @@ config INTERCONNECT_QCOM_OSM_L3
 	tristate "Qualcomm OSM L3 interconnect driver"
 	depends on INTERCONNECT_QCOM || COMPILE_TEST
 	depends on ARM64 || COMPILE_TEST
+	default ARCH_QCOM
 	help
 	  Say y here to support the Operating State Manager (OSM) interconnect
 	  driver which controls the scaling of L3 caches on Qualcomm SoCs.
@@ -159,6 +170,7 @@ config INTERCONNECT_QCOM_QCM2290
 	depends on QCOM_SMD_RPM
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcm2290-based
 	  platforms.
@@ -169,6 +181,7 @@ config INTERCONNECT_QCOM_QCS404
 	depends on QCOM_SMD_RPM
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
 	  platforms.
@@ -179,6 +192,7 @@ config INTERCONNECT_QCOM_QCS615
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcs615-based
 	  platforms.
@@ -189,6 +203,7 @@ config INTERCONNECT_QCOM_QCS8300
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Technologies, Inc. Network-on-Chip
 	  on QCS8300-based platforms. The interconnect provider collects and
@@ -201,6 +216,7 @@ config INTERCONNECT_QCOM_QDU1000
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on QDU1000-based
 	  and QRU1000-based platforms.
@@ -225,6 +241,7 @@ config INTERCONNECT_QCOM_SA8775P
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sa8775p-based
 	  platforms.
@@ -235,6 +252,7 @@ config INTERCONNECT_QCOM_SAR2130P
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SAR2130P-based
 	  platforms.
@@ -245,6 +263,7 @@ config INTERCONNECT_QCOM_SC7180
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sc7180-based
 	  platforms.
@@ -255,6 +274,7 @@ config INTERCONNECT_QCOM_SC7280
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sc7280-based
 	  platforms.
@@ -265,6 +285,7 @@ config INTERCONNECT_QCOM_SC8180X
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sc8180x-based
 	  platforms.
@@ -275,6 +296,7 @@ config INTERCONNECT_QCOM_SC8280XP
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SC8280XP-based
 	  platforms.
@@ -285,6 +307,7 @@ config INTERCONNECT_QCOM_SDM660
 	depends on ARM64 || COMPILE_TEST
 	depends on QCOM_SMD_RPM
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdm660-based
 	  platforms.
@@ -295,6 +318,7 @@ config INTERCONNECT_QCOM_SDM670
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdm670-based
 	  platforms.
@@ -305,6 +329,7 @@ config INTERCONNECT_QCOM_SDM845
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
 	  platforms.
@@ -315,6 +340,7 @@ config INTERCONNECT_QCOM_SDX55
 	depends on ARM || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdx55-based
 	  platforms.
@@ -335,6 +361,7 @@ config INTERCONNECT_QCOM_SDX75
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdx75-based
 	  platforms.
@@ -355,6 +382,7 @@ config INTERCONNECT_QCOM_SM6115
 	depends on QCOM_SMD_RPM
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm6115-based
 	  platforms.
@@ -365,6 +393,7 @@ config INTERCONNECT_QCOM_SM6350
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm6350-based
 	  platforms.
@@ -375,6 +404,7 @@ config INTERCONNECT_QCOM_SM7150
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm7150-based
 	  platforms.
@@ -385,6 +415,7 @@ config INTERCONNECT_QCOM_MILOS
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on Milos-based
 	  platforms.
@@ -395,6 +426,7 @@ config INTERCONNECT_QCOM_SM8150
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm8150-based
 	  platforms.
@@ -405,6 +437,7 @@ config INTERCONNECT_QCOM_SM8250
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm8250-based
 	  platforms.
@@ -415,6 +448,7 @@ config INTERCONNECT_QCOM_SM8350
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SM8350-based
 	  platforms.
@@ -425,6 +459,7 @@ config INTERCONNECT_QCOM_SM8450
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SM8450-based
 	  platforms.
@@ -435,6 +470,7 @@ config INTERCONNECT_QCOM_SM8550
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SM8550-based
 	  platforms.
@@ -445,6 +481,7 @@ config INTERCONNECT_QCOM_SM8650
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SM8650-based
 	  platforms.
@@ -455,6 +492,7 @@ config INTERCONNECT_QCOM_SM8750
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SM8750-based
 	  platforms.
@@ -465,6 +503,7 @@ config INTERCONNECT_QCOM_X1E80100
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on X1E80100-based
 	  platforms.

-- 
2.53.0

