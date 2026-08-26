Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29303C872C
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740106; cv=none; b=FJTDCqNx55yo8ZHLqWLpwcNthnUlDVW33Czz29e6EMX2UstMK83fkCLbZ5yCVlxTYtRSlA/3dTsyNs4N/1XeSeS4Dczf34VCzmgW7a20NjRf4pR2wj7ei+OxqJDh7ojnZiO/nr38OBR3rPBySWKmksNXdi0vEMjTX4az1n7Q7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740106; c=relaxed/simple;
	bh=vN61/FzjeMiTrd9k096ePQGc7+pdAfly5/tEHivPF5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJ3i6N/F+Zz3iTz0KrySMoG10wvqPj0KFzIPmCY2OXj/P6mOEExYbpMmxTgww+Dy+QovUzb6JY+VApuFJK/teeUzyGXhr4Cv4GcGr2puKWQDvtOUf1RRpwUfN4hnA0tY9AFx1duhzhNPuQ7epurbibkvFIQWzDRQFRsclVaR2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cmJUb33w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QVRvGxEA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cmJUb33w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QVRvGxEA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAGf0I121453
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VSGgkwbGZVC
	GUJBgzUmZwvbwjHmun0ki3hzihfIZ+ZA=; b=cmJUb33wC4Z3reKp9so8LVqyDBa
	vj80nBsihaB1z31K0n24ZNdgfReVI25wbtVZpS7FFFTDc+Jtd2H1kPQ20wvN8eTQ
	yfUuiGV5eBi3qhP2Sy1lKYUOKXSmZdFaifXN46DE6QqzsxPSW4YnJ6Bg5tS5xPUB
	r60zQdo31wN5o4cF3GTRxzwI/8qll7DwjFvnj/zjFuZwlgBseL0LGzjLWYHl0J/g
	IIuLBQlRlkM/imNwG8YefUVRnRU0Ple2FnAifE2QmLCzYWH7wMi/f9jeQmHsKhfK
	olq7SE6GtInDKV40xEa6n1A1bte0/+dL7Hj1H151nwDEwQ9T+7N0wc/Vqxw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smx9aqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so204366a91.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787740103; x=1788344903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VSGgkwbGZVCGUJBgzUmZwvbwjHmun0ki3hzihfIZ+ZA=;
        b=QVRvGxEAcbuHyUK3UA6LOJkYDmAJXw9SH76jM6u+KNcy0/qDrD77toPGuNngReQcqB
         NvuWIliIIkMOnseXQOEgsH7uNntyiscuhZ0318cVCpc/+nl+5ko3T3ceHXdV/ZVnfydQ
         6LEFZOwmeiWqpqvjuuMNJ5E0nJoKU2INPTJfwqIAPbx/TNRQ1K5Qk5s2X9PoBHWOIJIY
         W5VktQKBvnj6CQo7id6esQhTC1byWYje/riHNH/hUcvZMCe8sbjDkusaw4dxArw6xwCr
         8H8J8wif5qQfaiSHCS4GwkBhy0VD1tw8mdndO4kXuyEIiHOM08jd7nJg6ihl+E7LJFLv
         Oepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740103; x=1788344903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VSGgkwbGZVCGUJBgzUmZwvbwjHmun0ki3hzihfIZ+ZA=;
        b=GCpVWMVt24j80/u1MOhhxat44X8StPgLeUUaEPEpGcadks2FrtIwDYLgF9VnM7rYXJ
         iHv7cinzhfBkB1kb32ge880sWJF8F3EPc7u/gr8hdh4fXZTDfRQWlT+z3RBx9arVqNPD
         Wq/2lfV9d95j8Kv4o/LnC4/xqU7b1A///82pb+pvPjjeVTZ1o0TYsQ0LrQM+PGoa2QFH
         rDT+739O04dm5paLN2Yy1YSotTiALq5LCoU8KElY6RLHAuGsIin+khJsUQZhb9GV+6W+
         uHqhjCw39s5zJ7lf8GzDYVCrO3IGC9Sxpz/955rV4pKdlKbX7pu+24GCXj8iKass7+fT
         Dnkg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/vjTuaClrK7pwwN//fdomK/0Gwdqv9F1BiWCx4VltORa1wXIIJEH+nbqqlZv0gccN9u/CCAHZCw==@vger.kernel.org
X-Gm-Message-State: AFuF++nLfBsmfec34SD8xC0WDL2qQ2av5bqd2rDOV6lTvuF9F1/dfPxB
	uyJU6mhxJW+Dq2eNc8chKbqcbjllJd0jWnpIODO1EWlEEsdR35c6WzBDstockVwOMy1SwZ1j/GS
	qTj/w5fgJcZ3Y/fXB8hOlF3xEVyf35GMWJw4ePtkC3II0gdG3PaBqy3C36tOvaQ==
X-Gm-Gg: AR+sD10rErQSymsYZw4d3yEr3ZlGis5ry3nk6b79HwvpvGlHNkPJ3JxrErt/0Y5IibI
	OVLbWUpzq+gJ1vfiCiyCAa9UTiJwJK1BsPwVPr4l8ucagQ/ZXgmlBpm534gE6Lq8WZhdzj+cjvU
	mZfJ6CNBjc7ZSAxgGAamg6IIn+zErYlLmOv7ZD9SGIMTlXPd+tQusVfa3PswCJp3EC5P+mUD/DY
	6nogZRelIHKSHl30EmXNPyjgsIsVWklEMwX1zc7Ps+pji7OEN4zSm2cgaWwZitzrOHuCeOk3mbz
	WYUiBJtuhOpK1rEbGsv0pAb9rdk+9wE/WIuVYfafJ+NVDHkzB9y6zflXsEoovJAuWOZM6n4gj++
	cubKOs/jX4D/bIJfBfvYe9vAozs641CgEu+USDOAe4JtAjlC9L7JFxeRBiZef
X-Received: by 2002:a17:90b:2ecd:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-3966d484a97mr12789380a91.14.1787740103482;
        Wed, 26 Aug 2026 03:28:23 -0700 (PDT)
X-Received: by 2002:a17:90b:2ecd:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-3966d484a97mr12789277a91.14.1787740102954;
        Wed, 26 Aug 2026 03:28:22 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c291sm12935669eec.6.2026.08.26.03.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:28:22 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH 2/4] pmdomain: qcom: rpmhpd: Add NMXC power domain for Nord
Date: Wed, 26 Aug 2026 18:27:44 +0800
Message-ID: <20260826102746.633076-3-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8ebfc8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=lHabChWoiVafOPoG-uEA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 05OIqv0DOVuvfqbiQxgKbTcCDOtAkvhU
X-Proofpoint-ORIG-GUID: 05OIqv0DOVuvfqbiQxgKbTcCDOtAkvhU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4NyBTYWx0ZWRfX57cGEOOqbC+/
 m0tLFZxhNOlq6A5HlHKsejc/U/ehaNG7PiL7WBNqaH091KEXOwlFBxljXOgfSRvNuy5Zp6Elh4G
 LzQ+dXy9jpYxps/ZQXQmZz8DBRYTu9GNw7dMi5YSIrD+iOuX5TAS3JDBphH/P5WqONEJB9SSCh9
 ynpov3yNZKCTOOOMPiFfiUPLOgcSKEmzpIEYYWimrXt/FvvOyni4HnIstZLc6mzjJYyNOTr/52C
 8wws6zlFk1RKWRjr4G80480lt/FsW08lx5YRW/vQ4a+OyELFDrGWqF21XLF8JnMBJfTwWtb1kql
 DMsBPThgDSqho0cwqzdb/ffEoZgjkzA+4uJAXATslP3X/j5ukwAehahPrsGckYcdf57URXhsdNX
 M656epaPtFXJ5LTSwNOUNxENfnUxzKpakAD518hTO+nqheh2art2haBBV+vCb70371CBwgwopt+
 oQ0Mtz+OyGY28g1DqIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4NyBTYWx0ZWRfX6F3twvBj1OrC
 kGbi/7ULXrC+Ig3oUL1aP5iRqj5KxkoxVORvDQrRLKbq1ydtxX73/sJMly1yvTSobHpmRUI4r2g
 98bodbR57qHhPv6EjEtVu8hiVp8ABmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260087

From: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>

Add the nmxc.lvl RPMh resource and register it in the Nord power domain
table. Nord supplies the NSP memory rail from this dedicated resource
rather than from the shared MX rail, so consumers need it exposed as its
own power domain.

Signed-off-by: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 96e4bd2f5a14..717c44d1c39a 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -198,6 +198,11 @@ static struct rpmhpd mxc_ao = {
 	.res_name = "mxc.lvl",
 };
 
+static struct rpmhpd nmxc = {
+	.pd = { .name = "nmxc", },
+	.res_name = "nmxc.lvl",
+};
+
 static struct rpmhpd nsp = {
 	.pd = { .name = "nsp", },
 	.res_name = "nsp.lvl",
@@ -331,6 +336,7 @@ static struct rpmhpd *nord_rpmhpds[] = {
 	[RPMHPD_MX_AO] = &mx_ao,
 	[RPMHPD_MXC] = &mxc,
 	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NMXC] = &nmxc,
 	[RPMHPD_NSP0] = &nsp0,
 	[RPMHPD_NSP1] = &nsp1,
 	[RPMHPD_NSP2] = &nsp2,
-- 
2.43.0

