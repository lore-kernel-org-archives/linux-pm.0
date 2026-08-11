Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369E43DA28
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786449553; cv=none; b=LxpnXoqRgJdZAQsax4ZIGUeYqBXcmwYavuC7gZMNHEGlrTtmKl0Zp21MwxtQ6RjFE+SmAM+LY+V2UzVqxjUE74FP5vIyyVrE2CghZn00qRHnj4uX46Zi8Qf1Aol8rzHCl3XzOaBCW4iJrR2PVbn5ICSYaQhlkCxgg9fUkWTCojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786449553; c=relaxed/simple;
	bh=fTxHabRxBNwSPRaJrmSZGhNkgofrszNnJ5r9Qkcfalo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sISXa80MjDujGYloUjAnO3a6TTHfJqQP9fQtNMOzuXI1hxk5C3XxMqfySpysRhpphCkhnWg9f6okRmAe89rljsmrvPjserbw1xz27hwv6BueN76z83RR+NlCAPA+zZI6NapLSd+5XdWhxYxJGjYF4oooLUxWkjJCYC4G+rR/aW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kQm5Qio8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SztkTubT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kQm5Qio8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SztkTubT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BALm033288763
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 11:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jb+XzvopgHCxwDLurQ8H6QiWmaD68mggVpSkrt6Rll8=; b=kQm5Qio8sr2JvdO3
	bpxCDnM7qwYNGxZFMLqJhx/05BP1aR64NJUFkI33ynIunjWcnqjWhN3bv+HOocXR
	1llZA46lpRsKReFnl9MJ3dITf+hrekmwiSTJIyUC9tNwkdRu0oy7dxxu5TAkZebW
	lakmjwTkIiQI0ehoedhcaex5tVr2d5PBJN+pIFkjomsP0T5UelC2WQUISUD2P9Te
	0imzVsyMlHUJ+POXbaAzYD7CCls+Y79cRcpzWrdCCHcmoZZMJc2ylGP4bjG6AkZ5
	2FhwkLFC+uddBLXO853Ijc19hpmlKNL/uRXBWxxXwZ+0aE1smPIdX8y6InFkmlt8
	mpGwvA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwes389-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 11:59:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso8254641cf.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786449550; x=1787054350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jb+XzvopgHCxwDLurQ8H6QiWmaD68mggVpSkrt6Rll8=;
        b=SztkTubTdxh2BErP8KUA8Ow5Gsst6ak72xT+ggEMgsHTMpHn9MHaneIH25tH78IYeL
         sTp7Q/jV/fygm7NZ5n9DB82j2aZeRlOwHI2PxVwyRiOgXnEGJkmMFEsGZ5w1PHNe6C35
         CK6DVQhmilspj1vgtDNtuNzmRbee1v5xhSLT4xqEeuwsIMMMFq27UhJzCWCUtW5/AspM
         2BoADDg4A4qvhCycg89EILLNppLIMLiN4fHTNJTyxE8PHOo63UXX/Jh0Ba4VZFaQgCfd
         tm34c6weLJZW77C72XamRMLkXpNGli/pQKFaDY7cnL+106aP3SFRagG3SW0OODv78kFT
         yAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786449550; x=1787054350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jb+XzvopgHCxwDLurQ8H6QiWmaD68mggVpSkrt6Rll8=;
        b=cKhD5F3Sf9RyDp6hhAqhrt70wvN1sUZNZod+/TkC/Gycekq+Wrv+p2lnYEzKg62Lsq
         K9BmBFICUgIT1KCq55OH+L5vap6bKrO//tQJouLy5CyTe3aqDEpqaPNbqREVQD0iRAbX
         HTsVn+MigNMFeQBtOaZzjyh+FZ9jf6fA4YX0GCXTgK8T+9N998uEp1xKuGT4UgwkWrsT
         eVs0inq49HiIEgNjbmi0HmkFLtxQKt1aNqQF2NreFppRV8ZFh1UPhuINv7J/5hOB9pOw
         u5wxqsf4dahDC10Y/Rb5O3zCZOwcavZAZTZkv9fbhjnu9eeXcA7fSTl1wWpk3aCdz6CE
         8rPg==
X-Forwarded-Encrypted: i=1; AHgh+RqD2tvSuZdDwnZL/DwxCL/FumphATK7GL40IMrdKgMvemu6nT0Fgz/OY4fmKcaYVbsgTVUMGTYY+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWlnRCuyjasGvay6ZPKy+ko2cT+751mPvtjGKVrqCE5LwAzakF
	00aUOJhrpxrg2Rgbyklwm3oxrGGkEN1MjcDtXkHVvJDkjZtu26XqFxZDypKcw9otNCPvv0NLJhp
	5PG0HqsQYtGBlY9Q4Vw/gnPdt7rK60Fds5h9FFrQAVw84fv4iBEz3pMOSgdaUPg==
X-Gm-Gg: AR+sD13GJq4SKefOymOTC69IHoSPO/Gfr4xC+uCFC+4JBddvzETDWJdObSt6ygTmOml
	KNNxS8BRiwccinbyEt2GCzOxZgeWAXzJ9xlGRcPtsz3tVl/9LDUt/Ac+OcfbippbIdEOmYaE51C
	KDi7Fh2MHyaGnQewi+wWMMFxu8lHQgW1Z3LWQapd5nzgoYF11KtcsZSJO4qh3jOYAKoCc4fhsMN
	ONcz+sdCG4+yQotzH+OIQ1P+a3tXOgsZvDN7LpIR6nxJCgWHd28r+VJX28kyj4SSc7wHryAbXSU
	gzHy/6HDialO20nynrdRJMtc+RFpqazpT7bpKk9/iQlSS5axLSw1jTCS1foocZHTEGQ/LCxal+g
	RA+SlnDb0nXL3IsAN4/HhbhQXgf4Rie41
X-Received: by 2002:a05:622a:22a3:b0:51c:164b:b240 with SMTP id d75a77b69052e-52d584f769fmr20137601cf.4.1786449550029;
        Tue, 11 Aug 2026 04:59:10 -0700 (PDT)
X-Received: by 2002:a05:622a:22a3:b0:51c:164b:b240 with SMTP id d75a77b69052e-52d584f769fmr20137291cf.4.1786449549524;
        Tue, 11 Aug 2026 04:59:09 -0700 (PDT)
Received: from [192.168.1.73] ([92.247.57.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e438cf1fsm43142066b.57.2026.08.11.04.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 04:59:06 -0700 (PDT)
Message-ID: <65c47a9b-5f1d-4e17-bbed-4c37369025ff@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 14:59:04 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: interconnect: Add Qualcomm CAMNOC ICC
 binding
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: djakov@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski@oss.qualcomm.com, odelu.kukatla@oss.qualcomm.com,
        raviteja.laggyshetty@oss.qualcomm.com, vivek.aknurwar@oss.qualcomm.com,
        quic_afilipov@quicinc.com, loic.poulain@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260807114951.4164439-1-atanas.filipov@oss.qualcomm.com>
 <20260807114951.4164439-2-atanas.filipov@oss.qualcomm.com>
 <2ssduce25rimjg7bry6dxzrf2d4f7msqqa2lvukwuxxacm36yc@lylvi42lwmm3>
Content-Language: en-US
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
In-Reply-To: <2ssduce25rimjg7bry6dxzrf2d4f7msqqa2lvukwuxxacm36yc@lylvi42lwmm3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QouB5sdu4XOA6d6rOPI8vLe2a96QvB9X
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7b0e8e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ybD9qRDIDfZaXNPQ7Ca20A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=XjyBLfglfZADH4DKDeQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: QouB5sdu4XOA6d6rOPI8vLe2a96QvB9X
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5OSBTYWx0ZWRfX/sG5+L/rASW5
 fMdfzszSll51ZaGeoHgyGBR6/J/OJmc0k9HS4Icw2XLIX3mx6tsdodKlM1IMFVKWRpeBunUZxEs
 ULyfUnAFJlwjXTtMqWtqg+lG124NFSY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5OSBTYWx0ZWRfX44dQBlEjQzQ+
 e25u7K/qcnTqE6BtnyqAA4RTSpP9uJ9ean63Rkh20muY5KPQo6/RiXXgy0NwheTS1mH4EjRWv93
 Tr+yhieiD+pfZR2NgAedMbKoHTsplCTaNJrS5qrhIfi0MYu6A/inmJV7FnJDrmn4gzGpU+M1u4E
 Wll+BGGdnshOvwLfY/GyQAOOi4SNGR9hqDBLxWhvwY9Ye+gtlwHdU3NhYtZVEKV7gY1xthtR/BA
 VS5kKnWDKPMFeNirsfI46qIV9EeZrhZ6J+OZWzhGfbtDgwcwe9qd9I/LUyfDRqo1X+NqJ58MpSe
 lrJHyqb7vV9iHS4fIlEGrsEx2yHyjPzApCHATIl2jODbT2GAtnTZ0ICP+cBSBVMxAmhf+POdABJ
 rvmPd+baYHyWYjgKJN1X8j5kq62lD/dBflh4XOtcE5QYn8TkYfUPMlt713fybwqPj7SwkS26c/G
 xCfTVT2bkjPraPzd+GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110099

On 8/8/2026 12:12 AM, Dmitry Baryshkov wrote:
> On Fri, Aug 07, 2026 at 02:49:49PM +0300, Atanas Filipov wrote:
>> Add a device tree binding for the Qualcomm Camera Network-on-Chip
>> (CAMNOC) interconnect provider. CAMNOC is the internal AXI
>> interconnect within the camera subsystem that arbitrates bandwidth
>> between camera sub-devices and the external memory interconnect.
>>
>> The CAMNOC ICC provider aggregates bandwidth requests from multiple
>> independent consumers and scales the CAMNOC AXI clock accordingly,
>> avoiding the race conditions that arise when each consumer calls
>> clk_set_rate() directly on the shared clock.
>>
>> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
>> ---
>>   .../bindings/interconnect/qcom,camnoc.yaml    | 98 +++++++++++++++++++
>>   .../dt-bindings/interconnect/qcom,camnoc.h    | 12 +++
>>   2 files changed, 110 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
>>   create mode 100644 include/dt-bindings/interconnect/qcom,camnoc.h
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
>> new file mode 100644
>> index 000000000000..b2f5c140ff80
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
>> @@ -0,0 +1,98 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,camnoc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Camera NOC (CAMNOC) Interconnect Provider
>> +
>> +maintainers:
>> +  - Aleksandar Filipov <quic_afilipov@quicinc.com>
>> +
>> +description:
>> +  The Camera Network-on-Chip (CAMNOC) is the internal AXI interconnect
>> +  within the Qualcomm camera subsystem. It arbitrates AXI bandwidth
>> +  between camera sub-devices (IFE, JPEG, BPS, etc.) and the external
>> +  memory interconnect. Multiple consumers may independently request
>> +  bandwidth; the CAMNOC ICC provider aggregates these requests and
>> +  scales CAM_CC_CAMNOC_AXI_CLK accordingly.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sm8250-cam-virt
>> +
>> +  clocks:
>> +    items:
>> +      - description: CAMNOC AXI clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: camnoc_axi
>> +
>> +  '#interconnect-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - '#interconnect-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,camcc-sm8250.h>
>> +    #include <dt-bindings/interconnect/qcom,camnoc.h>
>> +
>> +    camnoc_icc: interconnect {
>> +        compatible = "qcom,sm8250-cam-virt";
>> +        clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>;
>> +        clock-names = "camnoc_axi";
>> +        #interconnect-cells = <1>;
>> +    };
>> +
>> +    /* Example camera sub-device consuming the CAMNOC provider above */
>> +    camera-subsystem@ac53000 {
>> +        reg = <0x0ac53000 0x1000>;
>> +
>> +        interconnects = <&camnoc_icc MASTER_CAMNOC_JPEG
>> +                         &camnoc_icc SLAVE_CAMNOC_AXI>;
>> +        interconnect-names = "camnoc";
>> +
>> +        /*
>> +         * Optional: an operating-points-v2 table lets the consumer
>> +         * drive its CAMNOC bandwidth vote from the same OPP that
>> +         * selects its core clock rate and RPMh performance state.
> 
> Is this a table for the camera-subsystem or for the CAMNOC_AXI_CLK? In
> the latter case, the OPP table should be a part of the camnoc device.
> 

The OPP table in the example belongs to the consumer device, not to the 
CAMNOC provider. It describes the operating points
of the camera sub-device itself: core clock frequency, RPMh performance 
state, and CAMNOC bandwidth vote bundled together in
a single OPP entry. The opp-peak-kBps field is the bandwidth the 
consumer passes to icc_set_bw() when it transitions to that
operating point.

This follows the standard ICC consumer pattern: the consumer owns the 
OPP table and uses opp-peak-kBps to drive its bandwidth
vote. The CAMNOC provider has no per-consumer bandwidth table of its own 
— it only aggregates the votes it receives.

The comment in the example was perhaps misleading. I will reword it in 
v2 to make it clear that the OPP table belongs to the
consumer and that opp-peak-kBps is the ICC bandwidth vote, not a clock 
rate table for CAMNOC_AXI_CLK.

>> +         */
>> +        operating-points-v2 = <&camera_opp_table>;
>> +
>> +        camera_opp_table: opp-table {
>> +            compatible = "operating-points-v2";
>> +
>> +            opp-100000000 {
>> +                opp-hz = /bits/ 64 <100000000>;
>> +                opp-peak-kBps = <22246>;
>> +                required-opps = <&rpmhpd_opp_min_svs>;
>> +            };
>> +
>> +            opp-200000000 {
>> +                opp-hz = /bits/ 64 <200000000>;
>> +                opp-peak-kBps = <44492>;
>> +                required-opps = <&rpmhpd_opp_low_svs>;
>> +            };
>> +
>> +            opp-400000000 {
>> +                opp-hz = /bits/ 64 <400000000>;
>> +                opp-peak-kBps = <88983>;
>> +                required-opps = <&rpmhpd_opp_svs>;
>> +            };
>> +
>> +            opp-480000000 {
>> +                opp-hz = /bits/ 64 <480000000>;
>> +                opp-peak-kBps = <106780>;
>> +                required-opps = <&rpmhpd_opp_svs_l1>;
>> +            };
>> +        };
>> +    };
>> diff --git a/include/dt-bindings/interconnect/qcom,camnoc.h b/include/dt-bindings/interconnect/qcom,camnoc.h
>> new file mode 100644
>> index 000000000000..a03f5e3f6446
>> --- /dev/null
>> +++ b/include/dt-bindings/interconnect/qcom,camnoc.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H
>> +#define __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H
>> +
>> +#define MASTER_CAMNOC_JPEG	0
> 
> I guess, there are other connection ports. Please describe them.
> 
>> +#define SLAVE_CAMNOC_AXI	1
>> +
>> +#endif /* __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H */
>> -- 
>> 2.34.1
>>
> 

