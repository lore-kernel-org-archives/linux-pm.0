Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B94386440
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779342229; cv=none; b=RIjwVVhuOzJuFjrp4LWik4grrLcNux1tLKG0VnNuWTEV1rBBn6tmztBitFWvWp6UJv0kQerplfWoOtBZd7EdS7JNbpk3aC8vzscbEDAjE4ckA5m7SiPYYe3sEP5l07hWmn5FM2TaI84OOoTwfBsN0ERxkf75yxrNwohjdgCv8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779342229; c=relaxed/simple;
	bh=UX9mPeVXdPlTrdlral1b8cH24Evvjas7dfYJnZiHGPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uASJ2O1M2gjmypBNlPQAFJuyI72UKO7b79gKl7WIivt+gmsCWpqitb2FNxdirKqzc+GJyOWRZNrqst+8U887NzXzWCkuVjlu0vchnOEdK/IjzCU4F57GUIuYn7Fdb5+2J2DjTgDMh7R4sLtOIQjtQL//u89wPhyR4TcC1Q5wQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IL5yV/Cw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bkp6gV8B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IL5yV/Cw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bkp6gV8B"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L30YBH267045
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 05:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qKpUrY9c+Nt+cLeu7+AnKXbXJe0Cc0NQbiZYl9VY2Jg=; b=IL5yV/CwcYMQyn5m
	/h6sydk6UgX2c8dXRHHLGCn7K8tGjGWz1X/c5y9XU/j0iGBBbKhV04rPGTcwAP8y
	JJXtojBzBmZQ/teID7+GZYBJqs+gI9xj1P81cHzqzoApwL3BioWHf0LDFYouXdVQ
	VkLKM7SUpjMY8NOuxGmyxNV9QSievzjbg5GZ9STPRBUuHjgT2/Ja6kO3X2vz+80y
	YMUd7FLzr0uCg1j88gBE5faMQ3MqE/skHkr/+spAD4ZKZtg/bRZKIE8tKG9j10bv
	CS+7bIxLBNGwHHUkOAcRxJPzeDFWezqh7z4XE5E/oT/YQvI3XKZw8uNOABPaKNdM
	+7tiyg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9amxv4df-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 05:43:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso56946875ad.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 22:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779342226; x=1779947026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qKpUrY9c+Nt+cLeu7+AnKXbXJe0Cc0NQbiZYl9VY2Jg=;
        b=bkp6gV8BDgDwbDLUy7VgfQS3IwbJYX7AZvErbbsg+ri+Zf28er813JAmybo1VgpXDO
         cDzGnspsFATB9Lw3IcmRPcvIWaObYPODXdMSyd4TZwW8/8ZZ1N8U672q37W0x84UrxXy
         3Uf/Hc9D1kvBUsIVlwwP4q8LKUq5XLMa3d8tOHMWfM1KFq+DgkotVQ254zKXh0IwMinu
         MjDK/Imqu5ARAGCVaVpBUS0sKfZKfXqeTOBUBbg6qFZ78rSXlXmS6O/fq/PIat8es8Cr
         vv4n5uSmuAZoWTpBDCg7VAieYYGxnbpO2NlC8GxgSWE73OSZQTUmUq8mukmZTyvhZZ7g
         /QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779342226; x=1779947026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKpUrY9c+Nt+cLeu7+AnKXbXJe0Cc0NQbiZYl9VY2Jg=;
        b=pJWdtIdIdxUxuu/zxrLIirGZqXlVbTSLHByTs0rgn3bzorhqiSCssAa93KYyEmZXfu
         y5LqLMfKHeD2Q94dTA338gYT/2gZsriHChOZjFHRaitCnl0XtQgnUJ+kPZZW8K0plyjk
         wM8kqf27hojgAhoM3P0ADWWXAQzb4D9Bgzic9KzhtI7HIwTXTxxyioWBjfNgvc2i+/tR
         M4rQPzdc7/T6nsSHzQ0yIjupDwMLOkJjCjWlHSLC3tC5D02sX44Lmu5cZaChqfv1mq6f
         TerizAbof7RrNoX4rnvcR1pTXGA0udSWOXY3PoK62QWJHJn1ep3w9ETESlOHD+chWe0Z
         IBtw==
X-Forwarded-Encrypted: i=1; AFNElJ/K5F0uqPf30azpwZw1FHUfQNBhJ+68YptBQXu8Oi+w0R2+IeCFSBBwGk8F3XIZtT4MqLJOqepmlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcW2OFRNuYpaygg5yyJSM/yYlNVxmRLwATy1jZQdaxTfcQZfZ1
	5E8kGEF1FI+sWEaQ6Q20veLuSjw1YNF2PvFxqNxRRI4lMJGbbfIO0THZiF2hBkW7/fX+98gLkHg
	IV1a2KKCW+Cc87+r+plYZAtWIUN0xdWCENDVCB3YdU67RmrueCAt95RX/uaw0xWO4RfzlSQ==
X-Gm-Gg: Acq92OGue/3KKZvGP6P3T0ELnpKH4++NsXULjqXczKffnTKu1VA1NoRZOeNGyDn2xH4
	2G/jGnITDEuUvpWxm9OeUm/Zg/UE3JVmsP6DQtFpX78s2GSO9YB0atMqJzTkIt38XKQGQHqNBb1
	iA1jMoLuO/Htlkd+a0EsNYLksfjzncQyuqAPhvY+glOI4XH+cELrSu8oAoK2vlgbqtM6fGOeHfW
	iYKKo0PfsEQFbSWT6WPdQh+/6JIKDZw1bhZ18J2Rk3Jse61RkE60dF3Dfqt2IOVuwaMXoHhv33W
	MrYmkmUPMl6Xgrr12u9orgEWzzGKq14eJ1aQdQ/AzwRa27xZFhUR7WCr+Gptw/E4OTuHM6+oOWZ
	JZiN98QwJDjJf9IrltfPy8WjfQ6NZCMXSD4jwmZFoZI29M8tt7g==
X-Received: by 2002:a17:902:f60b:b0:2b2:ebed:7af8 with SMTP id d9443c01a7336-2bea2fa2c4fmr14909095ad.1.1779342225214;
        Wed, 20 May 2026 22:43:45 -0700 (PDT)
X-Received: by 2002:a17:902:f60b:b0:2b2:ebed:7af8 with SMTP id d9443c01a7336-2bea2fa2c4fmr14908675ad.1.1779342224666;
        Wed, 20 May 2026 22:43:44 -0700 (PDT)
Received: from [10.92.215.233] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f30bsm273593915ad.16.2026.05.20.22.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 22:43:44 -0700 (PDT)
Message-ID: <10674bd3-d98b-44d6-9846-37bf5a22f583@oss.qualcomm.com>
Date: Thu, 21 May 2026 11:12:57 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: qcom-hw: Document Shikra
 CPUFREQ Hardware
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260519-shikra-cpufreq-scaling-v2-0-2b09f0e1c9d8@oss.qualcomm.com>
 <20260519-shikra-cpufreq-scaling-v2-1-2b09f0e1c9d8@oss.qualcomm.com>
 <20260520-hissing-rook-of-penetration-b4d6c5@quoll>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20260520-hissing-rook-of-penetration-b4d6c5@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: txg9QuGW-jwsUOml4b8Axc7-uve-8V4D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA1MiBTYWx0ZWRfX48APmgzMQObN
 fT/5Qa9/+Epsx1sxxHfhIb47eteDlzKMOG6Z0D9JFn3BgIzAo611JmB/29UXjP1blzCgdjznJaS
 Mn9vVSPZc1FvlStQoK2ng2FaNAl90eft0EMdnEsNeetj3TFUYdRVyV30XdBygsODxibZACpmovG
 6hCQSAr1gNB8Bgn4RBXYXE4Onoe0QGUDM5Gm+Xa34MSJvZxHpxZFl0VrK9stJwrjeHG0AF8Mh91
 +Zx0/mOt7IFBGeKwI/FrQp162c4TMzgE85jcdAF8owx2AwdYfenTjsKg57MBwSpWlEDrz+tWNck
 8eKeONLGf7CpmIytJiXSR+GdZwflHM2l5/FQHABX/avTFBf3qLBZMFq4YJdmsu8cssDExkSV0xf
 zu+vbG2oA6OdyUod2Geo6oXzGtrMu4//gvf7M+JOEKW3TD//DFcf5Vwv4S4ikLQrXBWcPJOGqNj
 L+DlLAFZQ9+trOYPrYQ==
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a0e9b92 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=DFSuKv5auc15g7BGkicA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: txg9QuGW-jwsUOml4b8Axc7-uve-8V4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210052



On 20-05-2026 03:50 pm, Krzysztof Kozlowski wrote:
> On Tue, May 19, 2026 at 10:58:03PM +0530, Imran Shaik wrote:
>> The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
>> but supports only up to 12 frequency lookup table (LUT) entries. Introduce
>> Shikra specific bindings to represent this constrained EPSS variant.
>>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> ---
>>   .../bindings/cpufreq/shikra-cpufreq-qcom-hw.yaml   | 133 +++++++++++++++++++++
> 
> Filename must match compatible. Please read writing-bindings doc.
> 

Sure, kept it aligned with the existing epss file name. Will rename it 
to match the Shikra compatible name.

>>   1 file changed, 133 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/shikra-cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/shikra-cpufreq-qcom-hw.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..52079ed661671554fcca8677409ee11199f5727b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/shikra-cpufreq-qcom-hw.yaml
>> @@ -0,0 +1,133 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/cpufreq/shikra-cpufreq-qcom-hw.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: CPUFREQ HW for Qualcomm Shikra SoC
>> +
>> +maintainers:
>> +  - Imran Shaik <imran.shaik@oss.qualcomm.com>
>> +  - Taniya Das <taniya.das@oss.qualcomm.com>
>> +
>> +description: |
>> +
> 
> Drop blank line
> 

Sure.

>> +  CPUFREQ HW is a hardware engine used by some Qualcomm SoCs to manage
>> +  frequency in hardware. It is capable of controlling frequency for
>> +  multiple clusters.
>> +
>> +  The Qualcomm Shikra CPUFREQ HW supports up to 12 frequency lookup table
>> +  (LUT) entries.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,shikra-cpufreq-epss
> 
> cpufreq is Linux term. How the device called in manual? EPSS? cpufreq?
> cpufreq-epss?
> 

Its EPSS. Will update the compatible name as qcom,shikra-epss.

>> +
>> +  reg:
>> +    items:
>> +      - description: Frequency domain 0 register region
>> +      - description: Frequency domain 1 register region
>> +
>> +  reg-names:
>> +    items:
>> +      - const: freq-domain0
>> +      - const: freq-domain1
>> +
>> +  clocks:
>> +    items:
>> +      - description: XO Clock
>> +      - description: GPLL0 Clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xo
>> +      - const: alternate
>> +
>> +  interrupts:
>> +    items:
>> +      - description: IRQ line for DCVSH 0
>> +      - description: IRQ line for DCVSH 1
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: dcvsh-irq-0
>> +      - const: dcvsh-irq-1
>> +
>> +  '#freq-domain-cells':
>> +    const: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - '#freq-domain-cells'
> 
> Why interrupts are not required?
> 
> Why clock-cells are missing? The device is a clock provider, no? Does it
> differ per each board?
> 

I will add clock-cells also to required list.

>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,rpmcc.h>
>> +
>> +      cpus {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +
>> +        cpu0: cpu@0 {
>> +          device_type = "cpu";
>> +          compatible = "arm,cortex-a55";
>> +          reg = <0x0 0x0>;
>> +          enable-method = "psci";
>> +          qcom,freq-domain = <&cpufreq_hw 0>;
>> +          clocks = <&cpufreq_hw 0>;
>> +        };
>> +
>> +        cpu1: cpu@100 {
>> +          device_type = "cpu";
>> +          compatible = "arm,cortex-a55";
>> +          reg = <0x0 0x100>;
>> +          enable-method = "psci";
>> +          qcom,freq-domain = <&cpufreq_hw 0>;
>> +          clocks = <&cpufreq_hw 0>;
>> +        };
>> +
>> +        cpu2: cpu@200 {
>> +          device_type = "cpu";
>> +          compatible = "arm,cortex-a55";
>> +          reg = <0x0 0x200>;
>> +          enable-method = "psci";
>> +          qcom,freq-domain = <&cpufreq_hw 0>;
>> +          clocks = <&cpufreq_hw 0>;
>> +        };
>> +
>> +        cpu3: cpu@300 {
>> +          device_type = "cpu";
>> +          compatible = "arm,cortex-a78c";
>> +          reg = <0x0 0x300>;
>> +          enable-method = "psci";
>> +          qcom,freq-domain = <&cpufreq_hw 1>;
>> +          clocks = <&cpufreq_hw 1>;
>> +        };
>> +      };
> 
> Drop all nodes above.
> 

Sure, will drop in next series.

>> +
>> +    soc {
>> +      #address-cells = <1>;
>> +      #size-cells = <1>;
>> +
>> +      cpufreq@fd91000 {
>> +        compatible = "qcom,shikra-cpufreq-epss";
>> +        reg = <0x0fd91000 0x1000>, <0x0fd92000 0x1000>;
>> +        reg-names = "freq-domain0", "freq-domain1";
>> +
>> +        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gpll0>;
>> +        clock-names = "xo", "alternate";
> 
> Incomplete example.
> 

Sure, will update with IRQ details as well in next series.

Thanks,
Imran

>> +
>> +        #freq-domain-cells = <1>;
>> +        #clock-cells = <1>;
>> +      };
>> +    };
>> +...
>>
>> -- 
>> 2.34.1
>>

