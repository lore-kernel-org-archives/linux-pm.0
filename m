Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7B480960
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853101; cv=none; b=RMnHcI/nBq7LGkZgg66l6XcSUU/Cjm9kS+qA5AZw1R662TdE7CFvggFL/Sxc9uNYo+Zm/fLjLUg0Hdn17h2dy9pGkjGB8fAeJSj9csK1osmslCTg4xFl8fxbpJhxhdNotbR9Mxsx5PDGkyctPdKzmNhfOXSXxH9EvLkjmh7h6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853101; c=relaxed/simple;
	bh=ZHsN8zM/JbhignLDIxWKpOEJ0dJLsvtVmGGylPc0eUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leMyj97rAsCLeABrMJo2gpM4Xaq5EHxrd7wJUu5qK63IYC+QGYop1pjgaYNo4vXSfnhL/H7F/lSAXmW2Y3uH0puziKXzqeT8KSNofl4EaTxdgLcYT/2cddwvqUZ9tXWZKccTO4YX3Zt5w6IAV8l9QIDXxuIYq2OWPwifTqQJjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zu220O01; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FGbfvHU6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zu220O01";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FGbfvHU6"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXdFf419814
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tKKYzTTyUQNx49FteOTvUbeUFOC22ARPMGkTLmOUYjE=; b=Zu220O01n5yJNHX5
	ySNhJyILhSpvi7mx53R3ja2RAMxFAAyh0WET2xjnoMBnNZMZziK09Rnwvvsypy/o
	DCqfCeKDCb21BWS1Fknfyk6WtYfTaS6YG1+yy9nIBdlxKbnqTPteYujtBBaaAiQu
	e6x7PwmPYrQVWGuxq6gHdb4tJgrphRNfzjfH4CaPB7pPDMI0pjn3+KyyvTj204bX
	u+9y805bwL1jRuMLN801CmC7mbeWdD9D9qYbDKadhPvEZ0oXcHPdgU9esRbg4rHX
	Ovb8ABQX1r6DRL2/sgDS2GOqzLUe3K1rc/mDtIRqoaCud4eCP+UhO2g/i8/Wgl/K
	PW/qHw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjftkup-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so291835a91.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853096; x=1788457896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKKYzTTyUQNx49FteOTvUbeUFOC22ARPMGkTLmOUYjE=;
        b=FGbfvHU6PN2aMlI67zU5m9IPSlPWWH+4MPhu23fWjzpu1zMJU1MnMiaqWrv22YUyo9
         Tj3ytE5FR13o+663T4m6AQXBs0B7K1+jOs55tRr6IlGW29yAQ3gDm1Juy5L/UvG86x9Q
         nCdKXzLq7DjoNeBeY8/JtFzKa7dq/qDZmEiz0MAjmGTgF0EjvqabKx7xPW0IfxqhE5bk
         duDZM/gn2UvVtS7/7vwbwS63HsweMrA6M/ruySVFvtKRSZgEby/kBW4hs0Horj6puxl9
         zQH6WTjRA7JFN6KiVi7eD71lY2FrC8xYsOx2R6UdkjVu+8xKQx5V1+i9gSeNEHELWhS0
         LH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853096; x=1788457896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKKYzTTyUQNx49FteOTvUbeUFOC22ARPMGkTLmOUYjE=;
        b=o9nppuUvQNSVdx/qYeTzL/6odZLP/rU0Brgt2LXWAOhIoSJ8dmyfWtpyNkSPNwFl+L
         5sh24HTVpKmfrvrTrvtULZPl8h35cyS2WnKgZrUjV5eS5DaHdKFxH1aaSlPZabX5oePs
         iMgBvjuKV0QKPF9hULTFw7liJXry9dOqODIkvbiRy8F/qnfa0ACH0CxU/2Ah7ZbGIPVA
         Gj1HJ3e6OVZZfQswz0QTBRlqVgG5vSuJ97+DlHUkZIrjKXxmB0mDYYoPU7GlRYi8ycb5
         8bICMUpjO4JFtluHobY2QphwRiiLSfJmeSJlAo8lihf2TdpCatMY5LJ1naAd6JlGqRLf
         j4rA==
X-Forwarded-Encrypted: i=1; AHgh+RpCBbP74irDIcaGWUG4awbSQxlTUfFXnnpsG5GuY82oVq+Pa0wmaLXo1EF7/m+CCDFxeKSLi1Ah5g==@vger.kernel.org
X-Gm-Message-State: AFuF++l+hxe4bRp30EiCYdi1e87YucCJsPYBp27rFpucf0VpVgOsjq49
	b210vSu3TMopwsMsMbIT5F0VOrZ3M0gKq/tooegbCH76T8Bourdfe4mX+eilCPDcAr2gfwdvp04
	fQXvHkaZwPQYYY1qkOPScIgogIS/YM8AoafmGRGzhIZJVK5lNKcrE3WDpwHDbgQ==
X-Gm-Gg: AR+sD12Fd0naXzA1RPdBu8KIf383XSsQ9rNXxxZ0xHtBqBPG7rC+a69xtDt0Q2ihmrN
	KggyJ/ghATjzumNeM0QMwzx1rdWHnbJhB+2ZCBoTQ6buHLUaOrbl/Br2zi0o7qAbDKEO/0/Qtfd
	56x4CmTVdRJfDpTa1OSOt3u30hes67MHbH0LXYrnwjqoSGOLH4Ix7Z4d+7bvlzAunUYxLn3kTJI
	Z/DfZftl+UepKvmO7PRTrYH5ZesaTIG+aKVjXQ7pm5uTeIttcYW36VJcZmfKhI4GjjSxyph+Dyu
	H5ZAZfWrT2bvjSSqMxifnoa4/Fu9QWzNys4uJd6YJvjyS3ALIu1DCLSNyRiKuyfS3rXFciH9Ikg
	sh1VwE/rxJK/cCyxsO/BRbMmf72T3uBszmtcBy6+V30hFBpltYx9izV3TxSIaRbkoQNb3IFq38O
	O0ahgtnys+z8qagFN7EPxW50s=
X-Received: by 2002:a17:90b:5443:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-396d100313fmr1670021a91.16.1787853095945;
        Thu, 27 Aug 2026 10:51:35 -0700 (PDT)
X-Received: by 2002:a17:90b:5443:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-396d100313fmr1669920a91.16.1787853095439;
        Thu, 27 Aug 2026 10:51:35 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60d25esm23889316eec.4.2026.08.27.10.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:51:35 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:21:05 +0530
Subject: [PATCH v5 02/15] dt-bindings: power: rpmpd: Document Kuno RPMh
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v5-2-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853069; l=871;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=ZHsN8zM/JbhignLDIxWKpOEJ0dJLsvtVmGGylPc0eUU=;
 b=vzpCJkMB6+PuXviINwNp3FHtz7nk5WS01Bo1zaRtxjr+lSRFC5WQzJQ1BawfNs62WmAgjGZz3
 7ciUxDb3xWuBXJwtYwyZR+4oRn74aMGz3NiBwSWu57vDqmcxYmMWTid
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: FyJ9NkkfSZKtmAey1NonpqZZ5Q6sLdt9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX8UW3WDIudR3Z
 8dZqfiT2GfgDr+JIS1r4dDZWrdQ5j2db/KAvR0FOCzZwzS3/Py0kXBTLl8S5XccOWan/O9MKV95
 kZvh4Ey7w3fyimZEZ3Z2G7OUu1ENVlwtfAGcjq45SeYid597x+G4z4tpQqMadxHbXoQQL5VUTNg
 DAtFJKQe1r5GNKXFICAUUaN3O0YOMtWcbgenu+zBATvfo8bMUPIQ6FWUPn3z1/W53qHE7gjjt4t
 DRVchMHK2gnMKNoGqLmLs0r1am6QK4h01JjyGlrJZGrYN2lzw3jYf1h/2dU6SYwH05+Zf9ayHbW
 o9HoZovFUduW7E68sBB9fzJx7GE6lISbo6k6c88w/+n7kPpL/Ud5DUrj1AMAYctQ+6UEf5XvFqS
 QI9cUsboxUZzr8cNBeFZIsjYi1S2f3fbnwnpftdi0FkUy8ijGdJr2r3g9ae269SB9V7w/M/6TRt
 HpJHRUwrm6oyQjbICSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX2LiYLXwKbUEg
 jWt6Nxc8oB1pDBr62cg+8xMHsXNwRClw090+ah+0eY1qD5wM7zFe3OXxo1ycV/zQpuJ85wh2jKU
 KAigUNMwYW2nklIXcBtJpU8WYzzJ50I=
X-Proofpoint-GUID: FyJ9NkkfSZKtmAey1NonpqZZ5Q6sLdt9
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a907928 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=lHgBgSUrZIjjmBdF2hoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Document the RPMh power domains for the Qualcomm Kuno SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 0a45e1f55062..7fc3927efa27 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,glymur-rpmhpd
           - qcom,hawi-rpmhpd
           - qcom,kaanapali-rpmhpd
+          - qcom,kuno-rpmhpd
           - qcom,mdm9607-rpmpd
           - qcom,milos-rpmhpd
           - qcom,msm8226-rpmpd

-- 
2.43.0

