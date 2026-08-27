Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1248CD7C
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848721; cv=none; b=o2sWAUn6gm4eGfEZbIe+fMqH6ImdT6XpS64yqATCT25og+pDhB6hrng3yoHMTVxHdSJMxy7IBXA7ZQ2b9VokqkAkkh3LQXOdTcO2HlK2Qw8kG6xBdh3DlDuuGmCkTsYsKbp0WYzzsrXgRw35JymClevsZ9nuOFfyinmfLyDwO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848721; c=relaxed/simple;
	bh=ZHsN8zM/JbhignLDIxWKpOEJ0dJLsvtVmGGylPc0eUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P2DiGZYNuULJANV85U8Der0J3EG9e8ECJd7fJ5LcqQ3ZPRYYP2NCva7BuZMYYGndMYeGWWQl9mTfi49DTRYFCr/1u/7WdEVqojokiZhVpj6Ov3gBpVg4/CnQNfQYudGgCDcEretkh2vvM1u0y3/926GoZa+KVG/95SADckr63F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SaMxRdth; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VaR6zClE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SaMxRdth";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VaR6zClE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFbhux1310855
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tKKYzTTyUQNx49FteOTvUbeUFOC22ARPMGkTLmOUYjE=; b=SaMxRdthBszwPxye
	ahAPAjCu8wN15TieayAgyNv1rpccx0g2otWevM0wh1Vxiou7v5lCf6Eji6kot0Hq
	cJfWmknf3m0iXl2a4/J4e6NkYhw76YbfNr6mkgG/psRCZcJ2v94g3pQdDNuxaTmp
	z+AaWYdFQ5aUgbtfdZUSYIQJnD+PFTNogq6Oc3lrm3pazT8fCFSodLWRN0LvQLH/
	RkhbLete0IpvHZGYV58U5iaRYVJBYMf0Cd14esQA1pio3Hr5sTjbSmFu0LhCowOG
	p9cji3oDM2wF681yaqVAhsq9GjG3rhn1XCjpbvhOhDQ8Q+/0nA45A4Eyd3enyIBZ
	xbyLmg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5kstq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:38 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a7de733fa9so210592b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787848717; x=1788453517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKKYzTTyUQNx49FteOTvUbeUFOC22ARPMGkTLmOUYjE=;
        b=VaR6zClEaHCksA+uzy6NQNsRFUf6nPjN5Y8iGTo19saELLW6wOQqM1BpMgfNnCZTTg
         q47qjpSIg2YzbBIzSHIr6Fn5H/hPJPRfztUnny0EUDYaW3w3GWf+m3v1svl2d6L9TSTa
         Ihit/p/ey6TSvl3OZi5bE7ZrbgazSfESfAVN2RofDY63BZKyKtabIIsUkZr2PGT8SNcQ
         /V+UpDEtXWScAhcecM64Lk7MrWgXaAzF7AjM8oGm5u7Gu+GkxvlxEEtw30BcN+3oOxvV
         piFuVFjo7WBzJgkdZB7TbNWipzQpz49gL+qcjSfkbK8Ww8TKGq156MrHl2yqWJWMUvm2
         zKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848717; x=1788453517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKKYzTTyUQNx49FteOTvUbeUFOC22ARPMGkTLmOUYjE=;
        b=Cza2NBacUeydEViZ3BnPUUINXERpWeQZpDEyEUIqoTYfPgVNN97Wq+gFKKL6PAKF+V
         LlAKQM+7gKKbpqXgwPcS1lxsAfQQ8ErBSOm+ortvBd+FlidgH/OGr/i/F1Cr0eU6LcjR
         /jRKRSfNCGfCNl9VHTSg03cHnf/OdCOliG5Nk+K3VjKXb5fbJ8RcpBy0fvCUyr1KrA9A
         Xo4iEfWJ5IsXcw5R8l1dCgcNlsDNwdEJhGzK2JOZ+90VbREoEW4YIoi1OwS5/zQMgZgH
         C6ixW1XsNgtg4AlfVO+RukX/UJ4/FWrtTVJonC8nJGI8tIVr6F9pmBR5+6utzz24kcLA
         UIbg==
X-Forwarded-Encrypted: i=1; AHgh+RrObR6vEjAQaaY0sRVEE8QW8ipK/DwvDyro2PIXLk87WwSTmvArdrk7gWKAr/6YEOxIZ41m1WgpZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mZVnt8mvIxlC6DKD0ZaCZ0yE334waYE1saJNnQBeTMZDmoFiS/
	m1Mv7rC6FkantIu2LD79QbhF13rB+iv6kDah/uU9dopBZ1AmvN9u48C9ccrGIAkjPOJNJ3+VURu
	DhmdewdClyYpUczgBHMtSl4uaAEBMFbnBvC8qmPdBepuKFs24oUc3rPX2SSoc3w==
X-Gm-Gg: AR+sD12bDlmjXePzO4v+1cePje+w51j46pPGoY6MsWdROtRIz0TZwjDD9fkYGWPIG9G
	QDiyFhXc+GRPqtf2efH3UkGrHF1kq0qvzo7GAFtx319B3POnntHRjjNc5K6dAx2NWNodcwmVFVN
	l1oKaDd1dRJf9kB3rXffcg3+OCmrl+zaXHMA+UqHFGHFgVJfTgeT6szAxADGPRjR+pTl9LafgpI
	0Aj6c2Na76GcEHinR+TCw5OLPl+62cRhusb8plXAkFq1kix57xGYbuFrmdKsvyJXkScSxilNmpr
	aVwaGgLl0F9SkYASlEfa6qh4iIPwbqwY/zBi+HsLHoKK2FxMnnV5Pd2dtdVddYjmvyUsEIW4Wun
	vJZyAPboM7SFk50vAlsuSPreDSZJq0NJ654qNgLgec0VyUvdiV1yJq9BZjUXqO4eaRElecwtDZK
	F1d7Av6BRlBKRSBM/u7k058+c=
X-Received: by 2002:a05:6820:83c2:10b0:6b1:4061:4193 with SMTP id 006d021491bc7-6b1a01f68a6mr13170118eaf.0.1787848717212;
        Thu, 27 Aug 2026 09:38:37 -0700 (PDT)
X-Received: by 2002:a05:6820:83c2:10b0:6b1:4061:4193 with SMTP id 006d021491bc7-6b1a01f68a6mr13170053eaf.0.1787848716826;
        Thu, 27 Aug 2026 09:38:36 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bce78sm4253171eaf.3.2026.08.27.09.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:38:36 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 22:08:03 +0530
Subject: [PATCH v4 02/15] dt-bindings: power: rpmpd: Document Kuno RPMh
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v4-2-dd34f235fc1a@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787848688; l=871;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=ZHsN8zM/JbhignLDIxWKpOEJ0dJLsvtVmGGylPc0eUU=;
 b=RdWF85ZMBnw5+LTfMUb/XNYcxEP72DT9HKX+qTDzgA+lEhyPfHN012Y7yPzPmglz+6fhKR4F0
 g2mkfFKmFy9Dy+hrx7vcKwg2/5OCovy3VzCQSV8WPXTRk3eBrdKwbof
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: FC9NjrUF4dU761IRyW0dVFdhtPBVB4qw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX3Pr/K6kBKPjb
 t2QO07h+EsXA4rpAJZ7/YJZcPNCwbWFeAfrAo7Zj7XCZhnHpWEpJUCEg7Tmn/fXWZMFOuSMPNNy
 9We2B68Wf5OXHDFrnZ88+Oo5s6CDsQU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfXwXC2STYKS2gz
 4LbUbJ/HOh23oskl12dckIY/n8BzGFfiY/OCCmH21fLuG5wEYcZICYDnWPjZv3pQnHw6d8zSac3
 /PrcjzshWOts2/EbV1eavlY2dhdAqO+g8mvW/mVCPh4E4fm29Guu3uKHSEGDZ0hme87/NsYDwI3
 USgKlQtx/sCCHKDlS1smx8YJdnI2/GuDh9ctPyc2/qQavVRe5Sqg4rU6PwqyB92ppRoWlTOiY8S
 UXWhmDs6zOhdUS2vFij/Y6PEScNkWvZmAgTe2IdajWDKU4tujdDwc9qTUOL8PLEvSKDIhb1nIZA
 7ZfHpPyqiWd3l6w4QeJWl3hiBnNF4meftDBynSog5OImnZeYDN096VXS6vwlAL5K8Rq5KRMKolM
 VldK/Prq1zJiTtZeoV2ifOar+oUrqEolhTMGnGbBYWqmguLDpqLv5vy1ncYaZeDZ795a16eFeQh
 80RwQsvpUN7J18GORNQ==
X-Proofpoint-GUID: FC9NjrUF4dU761IRyW0dVFdhtPBVB4qw
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a90680e cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=lHgBgSUrZIjjmBdF2hoA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140

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

