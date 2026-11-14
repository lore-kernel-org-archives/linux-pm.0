Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794620737;
	b=KxXLuF9OlzM/Tz4JaTBcH+haq0Ed0vXizXcktjis3E4sVxMtZ6iMbRxfMdetQhd3W47y
	 gm9bcYTcD65nwWu+nQNUwlPM9ZCerJ6cMhtf2j37Y4e332w5k1JUp6rYS25pFHbvs4b8+
	 cAW/izNrzlwOq2x+rDYfwMqUAvs/HIeI+SOyMxzzMZ+mO9tn+Md1wwRrQHH+jiW2n5lXq
	 3yJQlPg6D9Ub86Ecsckwl+UoLQTQ6vdFUw3MF2KUqnAW0y0euN3tKQN22xg1S0mkITZDW
	 Ursc4RsImNPixukCWh5Jrm4h2TnZuyoGANkZw2Mhh6Y6glrmlMQbt/Gd27hC5K0j5vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794620737;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bUC8F3wPwRKVstO+kanXkCggIsRCOD4L4lrynOWzJfU=;
	b=zQug0zSiXY1gGGuFAEzjRsgOwe6HgqTL7EnYPXqj3EQZw62vjL8tHY5ILoycveJIm8WP
	 dFHWFYVniz8VxT/oZGngXl4mYvkFwE3bc1JwncIaYo691zl2bD+n+iBfDxVjPpJ44dSLP
	 6CJ3ODvDbioa/u2Sp6x3PVJTAPshEvqk6ufwPzey2lAV4AGFlnihIEHR5Qomy2fp35gvN
	 KD4S9dL3A0f+t34QwK8HY0FR0Ek/moGqhRiAv4/d4DSFhlcjeH24fsDmKx6wS1GZ3gvGo
	 KCsmz5OPlT/pYGwQ/1fHTobJM9rwoHCZMjuhEuw/93nY43t+xXwvFA/W/HWl0Y83+fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IfRPy50j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DS1NUd8k;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE21606A337
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 01:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE21606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IfRPy50j;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DS1NUd8k
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE1M2K82078126
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 01:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bUC8F3wPwRKVstO+kanXkCggIsRCOD4L4lrynOWzJfU=; b=IfRPy50jd95DW3Bv
	SBCOOcQ8wGgPB3iSDr0360NmkoZmI1JjyXDEZAkj2AGjpE8Z5xRtEELF2m8UZ9br
	vGsXXOzx1rFJbaqr2p7Ko2Ct+CpvmVC2iIqRd3B0zs8nbXbD+NAcrdwIhvx4pg+S
	TAjHlomvWTPQ9W4Op0HUJS7gtDF/WCTnFNbrP1C1kBpOOSKdE/xe+beYFJur71Nb
	MRq2n53c+sooMZRAOeuUSDU5O17Rba83Qnmbe76OVXjpyerb2dCG3pceMeY+O0FU
	hY+fMQlCWeNsEVUhJ9IBCGwNgypo1uaxkBrPHcSLkUYRzGbY5eQGCy/GD5XxIv9N
	f+KjXA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxdwwg1j3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 01:45:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36ecd5db581so2156700eec.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794620735; x=1795225535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bUC8F3wPwRKVstO+kanXkCggIsRCOD4L4lrynOWzJfU=;
        b=DS1NUd8kLCC6pP8HLvXbsWX6HHGqa27EAL4mDOUny1dAheqcH7P5AWqvwtasYFqFBg
         KQJc6uHTuQ1NSFpFShgBSdN5BCBFXasgZCR1yU5A883r2SjQPWWCR6Nm5dvhtPW8UdJ0
         cuHDyHvZ+w4VpXl+oCI2JfkJx23DecpF1UL0lP4juwAe0d3kc7M8yC9OpvAONK8iXvEx
         Uo22DAJ/wUfbh2dU8N93JSOFYvZ9kJV3NhYB3kWRDRA9H5QJrV1BA5sVTHJCAzd/63na
         QURJ7FyW3NE9zksB+DBzM2u+e+cyYpHHtEtKcTK9FG6fVpmfC7GRZW37S3AXLxMqJxXe
         IW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794620735; x=1795225535;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUC8F3wPwRKVstO+kanXkCggIsRCOD4L4lrynOWzJfU=;
        b=FaaJdYFq1o3+sT8/1hooZC7mqoeK0pkKgPQlm49qAB+8tcQi7MyY6l6kJefVTjK2lB
         OevaBOOV0HcC2FEAd4lwNn3uPE2Yu9XmPgZ2Wm0b7JF0CHs9GFdSSfJaMJFYEh8ANXVq
         IzzGy28tN0imlEbd3cyF2YtcduWxvyMpXj78OFAsC7s1sR+F/DQt67fgVb2Bh+7k/f9T
         jV5LnTdn1f1qM+lzrLrkOh8CD6gYWHyfyEo/d9yCjSLw3ZlKmD+Gx1y6SpwN7xg4qoBY
         hW/D6D/Jy6abH08FMrckk6YrvjCoYffmq0FDJqsDB4w9ofyuXzJ9rGFluCEYLAQsD0Mh
         gq7g==
X-Forwarded-Encrypted: i=1; AL+hErEdPMPWuRslCrEGKrC2ZikhZeoHw1EdXyoQtHOtf6dnhsaPCEvndFKkKgi7BOwJk1fBRAqdgorzsw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9P2erDSMJRpuP8pyO25nHddVQQZ65RKOqtoUmlBhCFgbc70PRm
	5QRUciYtcimLg+zN4sqjxEwjrI8OF3QvHJTwvtq9S/gQPd34gNbkhtD1Z/Foa2aOfhWCThxLyIl
	sDNaGbTZMVwrwqUaI7J9QKep0Am3LZmWWF/9qQHgjZGRSPNwJA5UbBhRWa0zkmg==
X-Gm-Gg: AYBFou2pmiD4UQqZ0mMCVjUUwKJgqpVu/ZJklg0jCwTF7MQYtla6C2cNLrlzGTX6pAm
	2fBdeZlfWWHXniYN2VrF0k8RM4DxrB0r51jAbF6Nqlm5TzyxGxVBpy/CKb+fhTS4fFAs1YQgyL+
	4Y2iCf5AeGEiPQRqV92P41SuonUjmRykCIVx7NxnDYYToEjCtnYetihNOEHICG6WZ2rNiG4pb9j
	TLcObO8iZngyQpr4rHdQG3p8RyeH95SlEmjKhqoIe4T2rxAizpPwSwByupunQL+F0oAzPiFUOVU
	3GZK7EmAm/vb01QXgUZZJ3dYbkcC28sFXbSM4BbpmKu+fYj+7idSfy+L72Rh9+g9KQwLwbIrl1l
	ISGfbJ5/4PRyDNxoOGXfE9iPARtI1I0C12suHKfdRnh99FFdDAYTZZTIPMdbUJlMWiSBlAHaEjw
	oqk4VY+40N
X-Received: by 2002:a05:701b:2810:b0:1b5:58d:fd4f with SMTP id a92af1059eb24-1b5058e03e0mr2577977c88.43.1794620734651;
        Fri, 13 Nov 2026 17:45:34 -0800 (PST)
X-Received: by 2002:a05:701b:2810:b0:1b5:58d:fd4f with SMTP id a92af1059eb24-1b5058e03e0mr2577931c88.43.1794620734054;
        Fri, 13 Nov 2026 17:45:34 -0800 (PST)
Received: from [192.168.29.63] ([49.43.231.124])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm15907935c88.9.2026.11.13.17.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 17:45:33 -0800 (PST)
Message-ID: <8b9d14a7-47cf-4020-a5cd-9d17d559170c@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:15:28 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key B
 connector
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
 <20261030174429.GA781972-robh@kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20261030174429.GA781972-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TxVgj2D1K5DAADP0phvXa_C9FLJbjqRj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNiBTYWx0ZWRfXxf2guECDL5ZL
 29c0R0eYIbsu5RzClzRSDHDXId92h5qwoIvlvbSLvfC0agaPWI4g+TaT1Chp8z1xtQ5+Q7NKaUu
 /icxV7lRtoym1Xl5jht53AGHw8ZUV2A=
X-Authority-Analysis: v=2.4 cv=eb+o7LEH c=1 sm=1 tr=0 ts=6af7bd3f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=OgdsqUoHhxF4GfobPiU6/w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=MaBVSKTy7IHi2HvaTlUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: TxVgj2D1K5DAADP0phvXa_C9FLJbjqRj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNiBTYWx0ZWRfX4j5UwW9GoBq1
 55fd0gQLo4eQDChy2Z4C6FQ4/rOj8MjbRAGpX0xtIGcYb9w1rZJ0RBZn3lg0cwxJzpFt4/XHzOL
 u1Tqp07BwfoYQ3n9t/GSMjJwom2R8Wd+9h+Ap4zqCm1vwRJfy6sezeEtSSoBAmzddn01OiyK6mO
 qRUuwxmdol+LqF159G8vGwcM8h2+Db/i70a9PcbBb5uFxm64iJcuhIOQNvQXLUs1SL1Uxw/4HM/
 tmtyF8UIJvAK0ZhqBPh/O2HE+VDleyEWdH5ciYcQdlYJ7ocLZ1mdUJEU5FsJXzbrJYS3BVlrGwH
 N3mXL9k8zaYam+wXISw1o7LJZbusuDxgZLA17TaYXoa6I9Eq9m8AQbckz6ZNUx4Gfce/EPTfXZN
 czrwJD32qy+OWod1qbl+ShNQ6IUyDBtLTqyOHvffExOY4h/r9E/QiUTFD3dFKf4mtU6mqVB4B5O
 yqUABBzivHI7XUuvRog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_07,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611140006



On 10/30/2026 11:14 PM, Rob Herring wrote:
> On Wed, Oct 21, 2026 at 07:21:22PM +0530, Krishna Chaitanya Chundru wrote:
>> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
>> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
>> connector is used to attach WWAN Adapters to the host machine over
>> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by the
>> Adapter's configuration pins.
>>
>> The connector provides a primary power supply of 3.3V/VBAT, along with
>> optional GPIO signals for WWAN-specific power/radio control:
>> FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_ON_WWAN#, and DPR.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  .../bindings/connector/pcie-m2-b-connector.yaml    | 146 +++++++++++++++++++++
>>  MAINTAINERS                                        |   1 +
>>  2 files changed, 147 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
>> new file mode 100644
>> index 000000000000..a7f4bcbc5119
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
>> @@ -0,0 +1,146 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: PCIe M.2 Mechanical Key B Connector
>> +
>> +maintainers:
>> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> +
>> +description:
>> +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical Key B
>> +  connector. Mechanical Key B connectors are used to connect WWAN devices to
>> +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB 2.0,
>> +  selected by the Adapter's configuration pins.
>> +
>> +properties:
>> +  compatible:
>> +    const: pcie-m2-b-connector
>> +
>> +  vpcie3v3-supply:
>> +    description: A phandle to the regulator for the 3.3v/VBAT supply.
>> +
>> +  full-card-power-off-gpios:
>> +    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal is
>> +      used by the host system to turn off the entire Adapter. Refer, PCI
>> +      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    description: GPIO output to RESET# signal. This signal is used by the
>> +      host system to place the WWAN Adapter into a power-on reset condition.
>> +      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
>> +      details.
>> +    maxItems: 1
>> +
>> +  w-disable1-gpios:
>> +    description: GPIO output to W_DISABLE1# signal. This signal is used by
>> +      the host system to disable the WWAN radio on the Adapter. Refer, PCI
>> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
>> +    maxItems: 1
>> +
>> +  w-disable2-gpios:
>> +    description: GPIO output to W_DISABLE2# signal (default function of
>> +      GPIO_10). This signal is used by the host system to disable a second
>> +      radio on the Adapter. Refer, PCI Express M.2 Specification r4.0,
>> +      sec 3.1.12.3 for more details.
>> +    maxItems: 1
> On the pinouts I find, I only see 0 or 1 w_disable.
W_DISABLE1# is pin 8. W_DISABLE2# is GPIO_10 (pin 26), valid in Port
Config_0..2 only and absent from the SSD pinouts. It stays optional, and I'll
document the dependency.
>> +
>> +  wowwan-gpios:
>> +    description: GPIO input to WAKE_ON_WWAN# (WoWWAN#) signal. The Adapter
>> +      asserts this signal to wake up the host system. Refer, PCI Express M.2 
>> +      Specification r4.0, sec 3.2.13.3.6 for more details.
>> +    maxItems: 1
> Don't see this on any of them. There is an ALERT# signal.
 WoWWAN# is GPIO_11 (pin 23) in Tables 3-21/3-22, Config_0..2 only. ALERT#
(pin 44) is the SSD SMBus alert in 3-23/3-24.  I'll keep WoWWAN# optional and
add ALERT# separately, since Alexey noted the socket also takes SSDs.+
>> +  dpr-gpios:
>> +    description: GPIO output to the Dynamic Power Reduction (DPR) signal.
>> +      This signal is provided by a host system proximity sensor to the
>> +      Adapter to trigger a reduction in the radio transmit output power to
>> +      meet regulatory SAR requirements. Refer, PCI Express M.2 Specification
>> +      r4.0, sec 3.2.13.4 for more details.
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
>> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
>> +      more details.
>> +    maxItems: 1
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    description: OF graph bindings modeling the interfaces exposed on the
>> +      connector. Since a single connector can have multiple interfaces, every
>> +      interface has an assigned OF graph port number as described below.
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: PCIe interface for WWAN
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: SSIC interface for WWAN
>> +
>> +      port@2:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: USB 2.0 interface for WWAN
>> +
>> +      port@3:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: USB3.1 Gen1 interface for WWAN
> Port nodes are generally independent. Endpoints are muxed connections. 
> As SSIC and USB3 are the same pins, they should be the same port. You 
> could use endpoint numbering to define SSIC vs. USB3.
 Agreed. I'll use pin-group ports with endpoints as the alternatives. Should
PCIe lane 1 be an endpoint on the 29-37 port,  or should the PCIe port imply
link width and leave lane 1 out of the graph?

- Krishna Chaitanya.
> Rob

