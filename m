Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3D3F8257
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965422; cv=none; b=M+H46gS8mn82q2F3L6eDXvL0u/sWNpMPy0EpbrV1KXT1cUuezUPuORa+rx/4JauiIrj5Ny9yhhSoz+TFVlwMfOnbL4y2GVzqi6R8nnGTwgEtlP8KL3WwqmoXjZiSWegjTmDTZbLIlLJe0cW/BwftG0Hg4N231nCPLU5uv47NScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965422; c=relaxed/simple;
	bh=2wfWP6H/3nksqWj0OPT5pd7J9hPiUH+LOqOSe8S00tk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z9i7igVqJvKomiqaRIrhmR0CmQ5zGbJe8c/HXbvpldpMT8GGntde8hQx2hKgl97fKhht75osX94P/3dktppytHBDoR4Dvwi0O/JWz+DDF6XNRkIYc2Ep1tfmEoqjbCeD9W9BXx93ZljIMVaMhGVk9PISC9gscAvS6W4W2/esKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NoZzNLBu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O/4CxQts; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NoZzNLBu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O/4CxQts"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H9dfMx1533560
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 11:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bV8ZOhAcbGhQlSu4TLOqqTEjXBrty3GGurN3PrivxxA=; b=NoZzNLBukgr2NHHP
	aw5otS6og+gH1DJVj4XSmG16L/yQfThdXY3eqd5Xuffz5J0hjgfzI/yEIfT4RL4B
	Xrmz5k6L4k3aJyANzgjljawbRqKJkIcOfqQ/NV47F9ivO5US7aZhlvjGFOUdZ8Np
	jTIgu4mZWPaTQjdWo+HWU6qkN810moqR7ahvw9Gi8Hqipy896HCaU2vD11YDKN1o
	dLQ++vxonggX09ovUa8+VBuZ111Bnrbxlo99nzWd4aXRqS6rO+VwYnAQqh6TC/zs
	aU0uCboXrtBKjLm73wcfQhE41NExWBZi6ToUt+GvVhkyBgESeaPPjtLLbX9Zqatd
	EyMZvA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xb1gr4s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 11:16:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-933023a5980so557974285a.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786965418; x=1787570218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bV8ZOhAcbGhQlSu4TLOqqTEjXBrty3GGurN3PrivxxA=;
        b=O/4CxQtsVOStF28mGmFzvL/qrT1dc1RHUU0DRlpxDjrbaPRzdaOTr0gKUWlnKon0S/
         ThcZYJ+mRjvO1UshsUJUZiXRc3VxZ4nF4r34Ln/KFIiKL8HRt9mGyQvLIWcHVg+7d5Uv
         JcUmkd/e9jTejVyy8Rl4JxXDsadiNl+VJvkHSyRO/8PVPQg74VRklKDGeM5MsKF2S54N
         PvAYSKSBg8cz4l3Q9100eTL+KefCQEKDaJ7JNJD2pkh5kH1CxAsQroA2pJZy8edguhL6
         zjXUG22N8s6t9VWicH0s7YGMsUjmtK3XbegqhcsvL9OEuORBaCQ7vLODlQc73cgp2TI3
         xBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786965418; x=1787570218;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bV8ZOhAcbGhQlSu4TLOqqTEjXBrty3GGurN3PrivxxA=;
        b=nZlHXzrAgvymBYVUEkDvFvB1m9VJXhCPJoNI/1GSsidQ4Sc0wPthKR6yhrxeGe21RS
         qtgRRwbZnXAzpaLc0thXn+/lpgpeVCOKHgEEWWL5rJBPGL0pFA2ueVG3V7jtWF+H6tPx
         M2iAsm/Ale9pEsoosJS0noOIiIWuUIdu5yrnFJwrcYCYemePO7t5vHWxL3Cv68rGun4H
         UOOQrCm6NkgA4qvW14swXVFLcYA0K/KDdmFVX4HubJtXBz9iqenff2DHvSZry1dLMhBU
         Ae1z8sR9+sF45f+IVXhHBiSV5i6RSEIFjJ2SHWWVVVOJleDz1X3n2IMtAZT4VPJAklqS
         3NXg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1NXYCbERDI2e/0NSwG3Hag41M5Vw5cfXfrPApRw+lqpHmBARf540C61N/jPWcscCIT6k5m5ZkeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4twEy4ce8JDbx2uAZs2U2jOerT+dlrEineW1dO19RvrQ/eaB
	ZcUL0eUWXsWdi4WolBuMwZRi1EGm83thKCKIRqFIgWQQcQhTVbziA0hzgWlPPhyNpNmzVXqbRI8
	FO0OFxss8qBgddjPSJAzB6jWEEtws3Tq/Rye0PowFmBlUxmgdpbm1LYo569b/5g==
X-Gm-Gg: AR+sD12h2B4QFKtzWUqT5znhCV3K8guN1aZTAStbpV2MzYr25L7Rq1GHRuYe8IOVVt6
	FEh/+mxOZQLX8QfzMIs1+XEzu3nQnD8c5MnEIMcfz6O9xS8jkqBW9Mi7sjhBdfXlUaOeO7qGjsV
	6CBTEQBuZBBn95hgGJ+qFiIGfYMXXcfOEu/x6txZ7uOrWt9za+ITWk5xpdKND2ux2dU6nfyXOez
	Zpbqjn4WH1qBHQhB2OgjSQFFTSW42s5twatfuzXo7t8vYzcGth25T/iIhH7Go3H1zqlahRE+v9N
	7KfXKCk9SfFunKdvlkyfjSnHreTweo/a5blXW2NJiVYF3FykLyy2VzUOinkM4w/ByU+NTGJFdga
	RvVmz1jTPCDC76MbolnxuSNNUCIxSWjIB
X-Received: by 2002:a05:620a:1a07:b0:920:4f78:3d7 with SMTP id af79cd13be357-936d2142788mr2264667485a.3.1786965417620;
        Mon, 17 Aug 2026 04:16:57 -0700 (PDT)
X-Received: by 2002:a05:620a:1a07:b0:920:4f78:3d7 with SMTP id af79cd13be357-936d2142788mr2264661685a.3.1786965416937;
        Mon, 17 Aug 2026 04:16:56 -0700 (PDT)
Received: from [192.168.1.73] ([92.247.57.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0fb85csm45234705e9.11.2026.08.17.04.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 04:16:56 -0700 (PDT)
Message-ID: <3345fb17-aea0-4568-b7b2-c394cd76900c@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 14:16:54 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: interconnect: Add Qualcomm CAMNOC ICC
 binding
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: djakov@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski@oss.qualcomm.com, odelu.kukatla@oss.qualcomm.com,
        raviteja.laggyshetty@oss.qualcomm.com, vivek.aknurwar@oss.qualcomm.com,
        quic_afilipov@quicinc.com, loic.poulain@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gjorgji Rosikopulos (Consultant)" <gjorgji.rosikopulos@oss.qualcomm.com>
References: <20260807114951.4164439-1-atanas.filipov@oss.qualcomm.com>
 <20260807114951.4164439-2-atanas.filipov@oss.qualcomm.com>
 <2ssduce25rimjg7bry6dxzrf2d4f7msqqa2lvukwuxxacm36yc@lylvi42lwmm3>
 <65c47a9b-5f1d-4e17-bbed-4c37369025ff@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <65c47a9b-5f1d-4e17-bbed-4c37369025ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ua9hjqSN c=1 sm=1 tr=0 ts=6a82edaa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ybD9qRDIDfZaXNPQ7Ca20A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=b0g1OgHxPeTUUs2uv0QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: y7icoGNXp2U3nEo3NxnTcbYSGPIPFspa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4NSBTYWx0ZWRfX0gMJd9yiQqPx
 /+6IYVnBQUhiYpGUU6cjjJOwEfOTZQVZmx/YqpcgYg8CueQPwKYAnu6CkHgM51Pg1SlLW6p6bkL
 APZPRWNU1q8RQVj7O9lgsVBryStXr4LumxIe5TOjPxSodyeDLIP4F6HLbKnINzm3ElRHi2+b7ZP
 kFd43Evluzj+AbQkjpVtSU7PQ15P3YEv47+IVWgiz88p4epmHw4PaMzfCWgeMd5rLPv81lFurgr
 1IiIA03L/aCyfEwGzGnbyhDhiVwf/ynmk/vO31RbzhwLl5S2bbfBz7nFKmeIJTLRFaGWru84Wd+
 iQqZ2n3s/MJosHq2ogwzN0ZkFvg+8jB+OWHxCGFIt6J4dR2/pTfQHbmdz04mBiNKfwsGZseH2lE
 JSYQYXCsF1za2oyOhPY26HPiTh+UOzklB2jmeoI6hwEdnIFE7+f7f/erLG2IvoGmNGvxUyphUo6
 0PkyjyzihKKfSerVhnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4NSBTYWx0ZWRfXwzZq7LGB19n8
 Z3SBc1aKnV07HKmH77K7yMvyTldZcSZUXyyN1FiFX5tc7r5I8jO1cpy+nmx6wdQasKrrWepREtE
 xRqt819Ah4+bpiYElSEV4I9py/fuEzU=
X-Proofpoint-ORIG-GUID: y7icoGNXp2U3nEo3NxnTcbYSGPIPFspa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170085

On 8/11/2026 2:59 PM, Atanas Filipov wrote:
> On 8/8/2026 12:12 AM, Dmitry Baryshkov wrote:
>> On Fri, Aug 07, 2026 at 02:49:49PM +0300, Atanas Filipov wrote:
>>> Add a device tree binding for the Qualcomm Camera Network-on-Chip
>>> (CAMNOC) interconnect provider. CAMNOC is the internal AXI
>>> interconnect within the camera subsystem that arbitrates bandwidth
>>> between camera sub-devices and the external memory interconnect.
>>>
>>> The CAMNOC ICC provider aggregates bandwidth requests from multiple
>>> independent consumers and scales the CAMNOC AXI clock accordingly,
>>> avoiding the race conditions that arise when each consumer calls
>>> clk_set_rate() directly on the shared clock.
>>>
>>> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
>>> ---
>>>   .../bindings/interconnect/qcom,camnoc.yaml    | 98 +++++++++++++++++++
>>>   .../dt-bindings/interconnect/qcom,camnoc.h    | 12 +++
>>>   2 files changed, 110 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/interconnect/ 
>>> qcom,camnoc.yaml
>>>   create mode 100644 include/dt-bindings/interconnect/qcom,camnoc.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/interconnect/ 
>>> qcom,camnoc.yaml b/Documentation/devicetree/bindings/interconnect/ 
>>> qcom,camnoc.yaml
>>> new file mode 100644
>>> index 000000000000..b2f5c140ff80
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
>>> @@ -0,0 +1,98 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/interconnect/qcom,camnoc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Camera NOC (CAMNOC) Interconnect Provider
>>> +
>>> +maintainers:
>>> +  - Aleksandar Filipov <quic_afilipov@quicinc.com>
>>> +
>>> +description:
>>> +  The Camera Network-on-Chip (CAMNOC) is the internal AXI interconnect
>>> +  within the Qualcomm camera subsystem. It arbitrates AXI bandwidth
>>> +  between camera sub-devices (IFE, JPEG, BPS, etc.) and the external
>>> +  memory interconnect. Multiple consumers may independently request
>>> +  bandwidth; the CAMNOC ICC provider aggregates these requests and
>>> +  scales CAM_CC_CAMNOC_AXI_CLK accordingly.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,sm8250-cam-virt
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: CAMNOC AXI clock
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: camnoc_axi
>>> +
>>> +  '#interconnect-cells':
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - clocks
>>> +  - clock-names
>>> +  - '#interconnect-cells'
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/qcom,camcc-sm8250.h>
>>> +    #include <dt-bindings/interconnect/qcom,camnoc.h>
>>> +
>>> +    camnoc_icc: interconnect {
>>> +        compatible = "qcom,sm8250-cam-virt";
>>> +        clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>;
>>> +        clock-names = "camnoc_axi";
>>> +        #interconnect-cells = <1>;
>>> +    };
>>> +
>>> +    /* Example camera sub-device consuming the CAMNOC provider above */
>>> +    camera-subsystem@ac53000 {
>>> +        reg = <0x0ac53000 0x1000>;
>>> +
>>> +        interconnects = <&camnoc_icc MASTER_CAMNOC_JPEG
>>> +                         &camnoc_icc SLAVE_CAMNOC_AXI>;
>>> +        interconnect-names = "camnoc";
>>> +
>>> +        /*
>>> +         * Optional: an operating-points-v2 table lets the consumer
>>> +         * drive its CAMNOC bandwidth vote from the same OPP that
>>> +         * selects its core clock rate and RPMh performance state.
>>
>> Is this a table for the camera-subsystem or for the CAMNOC_AXI_CLK? In
>> the latter case, the OPP table should be a part of the camnoc device.
>>

The OPP table belongs to the consumer, not to the CAMNOC provider.
Each consumer (IFE, JPEG, BPS, etc.) has its own dedicated core clock
(opp-hz) and its own CAMNOC bandwidth requirement (opp-peak-kBps) that
depends on its operating point, resolution, and quality settings. These
differ per sub-device, so a single shared OPP table in cam_virt would
not be meaningful.

The cam_virt node only owns CAM_CC_CAMNOC_AXI_CLK and aggregates votes
from all consumers -- it has no knowledge of individual consumer
operating points.

> 
> The OPP table in the example belongs to the consumer device, not to the 
> CAMNOC provider. It describes the operating points
> of the camera sub-device itself: core clock frequency, RPMh performance 
> state, and CAMNOC bandwidth vote bundled together in
> a single OPP entry. The opp-peak-kBps field is the bandwidth the 
> consumer passes to icc_set_bw() when it transitions to that
> operating point.
> 
> This follows the standard ICC consumer pattern: the consumer owns the 
> OPP table and uses opp-peak-kBps to drive its bandwidth
> vote. The CAMNOC provider has no per-consumer bandwidth table of its own 
> — it only aggregates the votes it receives.
> 
> The comment in the example was perhaps misleading. I will reword it in 
> v2 to make it clear that the OPP table belongs to the
> consumer and that opp-peak-kBps is the ICC bandwidth vote, not a clock 
> rate table for CAMNOC_AXI_CLK.
> 
>>> +         */
>>> +        operating-points-v2 = <&camera_opp_table>;
>>> +
>>> +        camera_opp_table: opp-table {
>>> +            compatible = "operating-points-v2";
>>> +
>>> +            opp-100000000 {
>>> +                opp-hz = /bits/ 64 <100000000>;
>>> +                opp-peak-kBps = <22246>;
>>> +                required-opps = <&rpmhpd_opp_min_svs>;
>>> +            };
>>> +
>>> +            opp-200000000 {
>>> +                opp-hz = /bits/ 64 <200000000>;
>>> +                opp-peak-kBps = <44492>;
>>> +                required-opps = <&rpmhpd_opp_low_svs>;
>>> +            };
>>> +
>>> +            opp-400000000 {
>>> +                opp-hz = /bits/ 64 <400000000>;
>>> +                opp-peak-kBps = <88983>;
>>> +                required-opps = <&rpmhpd_opp_svs>;
>>> +            };
>>> +
>>> +            opp-480000000 {
>>> +                opp-hz = /bits/ 64 <480000000>;
>>> +                opp-peak-kBps = <106780>;
>>> +                required-opps = <&rpmhpd_opp_svs_l1>;
>>> +            };
>>> +        };
>>> +    };
>>> diff --git a/include/dt-bindings/interconnect/qcom,camnoc.h b/ 
>>> include/dt-bindings/interconnect/qcom,camnoc.h
>>> new file mode 100644
>>> index 000000000000..a03f5e3f6446
>>> --- /dev/null
>>> +++ b/include/dt-bindings/interconnect/qcom,camnoc.h
>>> @@ -0,0 +1,12 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>>> +/*
>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>> + */
>>> +
>>> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H
>>> +#define __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H
>>> +
>>> +#define MASTER_CAMNOC_JPEG    0
>>
>> I guess, there are other connection ports. Please describe them.

Addressed in v2: qcom,camnoc.h now lists all SM8250 CAMNOC master ports
(IFE 0/1, IFE Lite 0-4, BPS, IPE 0/1, JPEG, JPEG DMA, CDM, FD, SBI,
ICP) with a short comment per group.

Thanks for the review.
Atanas

>>
>>> +#define SLAVE_CAMNOC_AXI    1
>>> +
>>> +#endif /* __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H */
>>> -- 
>>> 2.34.1
>>>
>>
> 

