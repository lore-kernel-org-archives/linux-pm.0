Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620283;
	b=1ZWZnE3jhcJRGx2BHwbUSLjuJ8YgU4si1pOVCCynzga9ZLPrgnQ3c+TTrW9qY4leRuv6
	 hNv0IwrK3K1MeijOU4cjLPYd6nLeIttieit6Uv+qNUSL+oIyrfbTG4Mzeg++BuOUy1irJ
	 BKQ7cnMCXGkMhBwFn0ibywcfoW+72t9ABI0A3XaAgkeGJv9BVCxVlVL2Dxe5SCxf453WR
	 lUlMzLTo3xqgDZxrS4BaLcWZ4CWyMalFUYbt0uaAaB0wnaOKdmt8nQmbgojqpP5urjKPl
	 8T9v5nrT++mfJABVWCgB6qM2WPm50S+YCv3aChRZe5Vf2z5Hme//+nGgVg2OktvXT8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620283;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BWI0oTPS6UWP+KHreqzTyFzt/bLKfNI1fMUEgGA2TjQ=;
	b=AaHHRo3Lti7AiUjKj/5x97SNiRbCCxzQA8GXs6hP+87wvzDAXU7bLhaHajIbhljbmhHu
	 WOK8M2GjDWOcaCfxeE0yLo3llFvGE5/sqvOkRf5Mb8hGZCY9FBII4A+uOyvmhptXn8RZL
	 3/zQUFmoAqZzocaAx9J0tEUZyHtYdFBb6wLwIRphrxParNvAWO9pHc0Ioxn09NLZYLjUL
	 kp3gvzj6cDv3F4WogJCaCn7FPR28ABX0QE6xiQiDx6g3Mfj3nY3XwrzHR8wJmWu3WrNG1
	 QU5r5iRQw9QmIrhHItxDYh3tJjx3g6p5ko7M1KBhMo44/xbP9K22DtUwetNgtBQK1Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="OpB6FU//";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cJM3cew1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A4606A333
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A47A4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OpB6FU//;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cJM3cew1
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APELmFa724151
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BWI0oTPS6UWP+KHreqzTyFzt/bLKfNI1fMUEgGA2TjQ=; b=OpB6FU//8xOqb7OS
	5fVG54KpU7ZjNVKjctadQgIBzM1pOMtfT+p8RLJQKyYAAI7DZyJ5qt+UOaP/9pq4
	u8sBWRPln3bzRSPYJOuCVV7hYFjGloUQUfoatqf+FTAUdrFoUXI8IRA4nJgD5hO1
	itivGuWNLrBgEQ4KnYHzi73YpEIkNS2hpwNeAhy7ZKl8SxdU6IFb+LEhb4BFL6GZ
	DmcN5Y+58aqVqcFdGV9uBwFeAW+ByxC0qjFbCfgk8N4RUZhVJhAGLOUIiB4jt5Kz
	fAq9A5IwNKwk2eFTo41CSn49JtybruJZBKPkwkWdyxqWMvEUDUxgC06m1qXnG5Yg
	jtr1nw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5yaxrs55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb86c39250so3171225a12.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795620281; cv=none;
        d=google.com; s=arc-20260327;
        b=Q1JhpXBqqGf4J9U9Wz4rFQZ4FlJWqv1rE4R0r7qAi34KbfJR+Meu39dezqDi2N8N6v
         cjTdyPCP2t3w7Cnf9t+W+JkujZJsaIKS2dsP/4A383hUVTfGN8DmgRw4PVPKRbBMTDV2
         xDH2P0dvFk4Wzpph8qIrw39rQ8PMHkRePenomZCt/tELY2UlOBKGb7Xl0L4WiaWPBZbA
         4bqSJisqgy+IERhl2EnPRI+9Je5Cof0hfUm60iXYyOo32SWRF8PlMeoDWMpGvTIqJjET
         L0f0y6aVPWuBC5OcFgq2cNJobnjVyKU9aznV4WGEo+PFk+vxbZBZ6jrUPM+Bb/keGqq9
         6v7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BWI0oTPS6UWP+KHreqzTyFzt/bLKfNI1fMUEgGA2TjQ=;
        fh=R1YIz0n37ZGUVGJalHkxxnlE+JW2LumVV7z6eFTYi6w=;
        b=VvxlWTggx2bCsGS6gXjDRTNmtDNHgL/FDbNKdqARjaZl03WxmtmvVxvKgBAKSZ/KAH
         l+onfTLgTvm/dDYYQB+MdgeSTkCTzdvFLqUtwIE3N4vzPW1okXDWgprkVmsL0IMoiKuj
         g3t8gz7CcjnvJlhcrz7LIFn6cPc0fS87cz9mmu9ELP2v4q4EST/P8GHDSADhRtLYBa29
         KDi1YomsMuE7FlqOBOMyhhEkZ3tDmnxNlDFZxlSkgUO1Mkp8k8ytPZ1OuLcadQ+1wABA
         9ix1B6A1MDBDiUcHLLUVLyHsoP0nya+r6i/i9hTrno70OTWxQw//9f30Shas6o7n2qAi
         1dmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795620281; x=1796225081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BWI0oTPS6UWP+KHreqzTyFzt/bLKfNI1fMUEgGA2TjQ=;
        b=cJM3cew1hkvYIyL1ViCsj3kK76klrSGicdUUgE9mOCNL1W6o5ORm0MgbmkkbZ++ky/
         2vUkNgT84tLjE6cV8KtUcoRzbEb4AngRs2uu2ze3e9psU18rHrty8zOfx2nTRki6hsLi
         ntrpPDqvdLM4Wo8v4CGdX4tcetEwGUIhKyej55Krwtwr4kzuKa6iIn6MVOxmio/d6kwT
         5b4N2UeS1wwaV3RF6Zb0f+T2aTYGrOhSSvPL+aVi08R7KJALyVVCmJEa0Ui6lQZvUKQM
         ArdimzhQYaG2Y4q3n+7rcEbhRmBce9JUP/ag7s9govOUlGhur1nxeuCr65eOi75ajjRT
         pU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620281; x=1796225081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BWI0oTPS6UWP+KHreqzTyFzt/bLKfNI1fMUEgGA2TjQ=;
        b=AGkHynNXR1SU8Yom+iOKUwYS2L3ET2VWHspwjFLaT3dKDigc4tl20CGz9oc0S8ZGvJ
         brdFkdlnKXbcgNePPW8q/VhqyPolCKHQSwn73/PSnXdbg0YW+g/FGpww17SeAxGYDk3P
         r2tyGn/5XFzy1a4DDN6QDn5JTGgr/53dL1zNT2VvyuMga0DWupGuVTk1CV8CZZxW1ws6
         zxEQS186CZXUY0HC819IeXJ0crzbv5riNmyrKIH/0WvTDFRgKZXRpe4kHWnFlQj7SKcM
         3QA7RPwhkJmzZOvMR5crM0BI111Da+ixxpupk96mvAR0oqKX3C3AbN3ggxIYxvuDk2Uv
         0VXg==
X-Forwarded-Encrypted: i=1; AL+hErE0qz81N80wGjLuHrSiq6DAJ2lf59i53mcOatf7/GyKV5JECnximkEwSBN/2HJojrd/So4I/MHELQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+M7bpNzUfxXAp3NdeW6zi0Qa6oKXWCAQ9gPaACtk8pJQmu4oF5
	H/kCAejo1a3phEI1CwzJfU7+/Uln4pDB3cmIWcrXDinszk6u6F8R4tzk/cx387bymAmrJPlyF5F
	GXXs9uDSuIxQMkxtaFUbPrAucVs7sZUxcv3FFnBohf9HzhuQbKpH/G49nWIBq0eoojfxznFMklX
	iJh5OtZlMqmFueQMQODup4XAGLayL63Qff+IeC
X-Gm-Gg: AZFdTZcUdJ4Uu46s4FrISup4a/iC2VppZeRhWYq+taca10ix0J8N7+FnDmBmn+Gb8PN
	7GSd+KzhaiqBQpE6AHYT05RdTVn2YS75MUWoID5nfBAaUO4hJwbQm18PSRXdAMWQZBkizznJXKF
	MjYETirXptqQyRi+t3zMUcgJrjwQNhqDIdhWhFDF6CI9oPvfm51T+h5tdTXw==
X-Received: by 2002:a17:90b:2ecb:b0:3ac:8446:c1a5 with SMTP id 98e67ed59e1d1-3b41c988620mr15762971a91.48.1795620281114;
        Wed, 25 Nov 2026 07:24:41 -0800 (PST)
X-Received: by 2002:a17:90b:2ecb:b0:3ac:8446:c1a5 with SMTP id
 98e67ed59e1d1-3b41c988620mr15762922a91.48.1795620280668; Wed, 25 Nov 2026
 07:24:40 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com> <20261125-halliday-dts-v3-2-5c8311c0b70b@gmail.com>
In-Reply-To: <20261125-halliday-dts-v3-2-5c8311c0b70b@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:24:29 +0100
X-Gm-Features: Aa3M54pQyww1I_PbdCBse1VupHYmzcQQ8jGP2HKCbG8YvURb7jcXXUW3MJhTLAI
Message-ID: <CAPx+jO9aHqEwVu3j5CdVTsfrhk8cMRawA5rj51EA7AdVtn-U+A@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] dt-bindings: power: qcom,rpmpd: document the
 Halliday RPMh Power Domains
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        Stanley Jhu <stanleyjhu@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: u-abbuKxUFuM00uaqzue5C6UIRx9w1kE
X-Proofpoint-ORIG-GUID: u-abbuKxUFuM00uaqzue5C6UIRx9w1kE
X-Authority-Analysis: v=2.4 cv=ULpIjyfy c=1 sm=1 tr=0 ts=6b06fdb9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=yRSEYQ9GznzmN70rNvQA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX1OA4OCjS00Iy
 8xMd7NZ9rthzmAkL5MfNb8RTkYLSnVautkkaYpI5VvsQJNxouXM4n/39tPfpiy0Y9gfVnD/hykZ
 Vny7las3b9sS/FEsA3xCJ3dPPgxW85xxrA2pXjWq6HajA/4RHTuWUh0K3t2X77+uQqDiEUWBzlB
 WEsmt2Ji5RsVWsfevSLhjCki2so4qdjlKlQe1UFNLY4M/i9p8T6c7HPBSphpDeP/XhLCt0zhyLp
 NM7U7F+0LPyMpGRxCrrOZ8lvm3RToFg67Y2HDUDvxy6AfKST70fRX/3ozW07FWicCjvbPPlmDwQ
 XZP/u+LUob+0ZpJ/0CGSvHg7TnX49Su5xZSEHImkoFmkxiR1C/IPxLtmPsshIfiIWQQeBrsbpuN
 GuuRuqxcMK+7bf/9cKs8ApKFJ60t5VK7F69gT27LmlkQXGcCZUBDm10vbX5rU34rPaJaRexM9kd
 TYcdCvuj/A0X5hdFsHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX45TqrnacxUYJ
 vkkG9d18Ym+7RtRHb83yV37IXrPlSuPOWNMatPk83ZR+Wg7p5ceHL0PXFM1GF+j21gNls0N8f0F
 Ki2PObzr9CXG/zOV0/7/fzWTdiwSlaU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250061

On Wed, Nov 25, 2026 at 4:44=E2=80=AFAM Stanislav Aleksandrov
<lightofmysoul@gmail.com> wrote:
>
> Document the RPMh Power Domains on the Qualcomm Halliday SoC
> (SXR2250P). Its command DB has the same power domains as SM8450
> (CX, EBI, GFX, LCX, LMX, MMCX, MSS, MX and MXC), so use
> qcom,sm8450-rpmhpd as the fallback compatible.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>

Applied for next (available at the immutable dt branch as well), thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Do=
cumentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index 8ee1c25a7c9d..663baae9cc64 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -82,6 +82,10 @@ properties:
>            - enum:
>                - qcom,maili-rpmhpd
>            - const: qcom,hawi-rpmhpd
> +      - items:
> +          - enum:
> +              - qcom,halliday-rpmhpd
> +          - const: qcom,sm8450-rpmhpd
>
>    '#power-domain-cells':
>      const: 1
>
> --
> 2.55.0
>
