Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817853F2118;
	Thu, 27 Aug 2026 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822774; cv=none; b=LtopCIGBUkVHGN9xQzlD3kMEeIKlzLLi/fojV/YkLXd2Y3srw9Gu1EjVRPkIJEA/AQS37Z0AzUDKaENAM1p8tuVE2XBgSWQA0XrEBHHgcdm9iHJHHabubsacNATP8MeFKGURHboeAY7raVFF3uGctJoBCsATVdypv0cTmCYqwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822774; c=relaxed/simple;
	bh=rIE65/ymZpAcqtr4AlJjpEOm2I1rQ2xgB2QT2KYdumk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gzXa6rwoYWiAhK1nIczS+xElNmwyU+CYVbVGuFFuPvpqMJ5hGMj84VzLozgsjN+5WX0NEJTHI2B4xdmANdoxWekwTq89sdmEYGkrKMXQxK3KaFzKvVh8+1MPuk+C5+uwcQ/JBmrY7pLXCC2jPKRZh1eJOMKlY5/1votWDl1abTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPxq5cmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPxq5cmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A19B1F000E9;
	Thu, 27 Aug 2026 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787822773;
	bh=E99rsOQcbaa882Nk3LrLKvAFqT3/73tCOShiFdtmlyo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=kPxq5cmMaNxBSvb9DNCcZYsIJiVzhvvP6l9+l2xf4WHdD7SVvvokXODcH9F2bDpO6
	 qSnTlsVVRQVRjl3OM54hEAea+bxKEhLpzI440u1tJNmE6YNBlThoZlOJfnRp9ld0N0
	 aSszUUWeikwcn2V4EJ+zMPkur+Yi3WPRRBTVNohT3aAb9CsDM4Iil4COAsZMRrjR16
	 eOF+GFrBWr+m4xgvV/1xix29gwL/sIqEEVZVnoWePoGZCbWz/kMPv0l6w9qLLXQPgS
	 SWP2yQktZHkjGVsYVJZCTs0vtkF7WHQj1OPnjoierlRSn/Q6ZfHeoFoQHFq2yjjNzK
	 gPupAooKgZxoA==
Message-ID: <dace72f7-d514-4e14-b16a-f02cfa6f7829@kernel.org>
Date: Thu, 27 Aug 2026 11:26:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: Add Qualcomm CAMNOC ICC
 binding
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>
References: <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
 <20260819093211.1436275-2-atanas.filipov@oss.qualcomm.com>
 <20260827-thistle-puffin-of-chivalry-bccc47@quoll>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260827-thistle-puffin-of-chivalry-bccc47@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2026 11:23, Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2026 at 12:32:09PM +0300, Atanas Filipov wrote:
>> Add binding for the Qualcomm CAMNOC interconnect provider. CAMNOC is
>> the internal AXI interconnect within the camera subsystem. Multiple
>> sub-devices share CAM_CC_CAMNOC_AXI_CLK; the ICC provider aggregates
>> their bandwidth votes and scales the clock accordingly, avoiding the
>> last-writer-wins race from direct clk_set_rate() calls.
>>
>> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
>> ---
>>  .../bindings/interconnect/qcom,camnoc.yaml    | 124 ++++++++++++++++++
>>  .../dt-bindings/interconnect/qcom,camnoc.h    |  52 ++++++++
>>  2 files changed, 176 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
>>  create mode 100644 include/dt-bindings/interconnect/qcom,camnoc.h
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
>> new file mode 100644
>> index 000000000000..b2659db2cf27
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
> 
> Filename must match compatible.
> 
>> @@ -0,0 +1,124 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,camnoc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Camera NOC (CAMNOC) Interconnect Provider
>> +
>> +maintainers:
>> +  - Atanas Filipov <atanas.filipov@oss.qualcomm.com>
>> +
>> +description:
>> +  The Camera Network-on-Chip (CAMNOC) is the internal AXI interconnect
>> +  within the Qualcomm camera subsystem. It arbitrates AXI bandwidth
>> +  between camera sub-devices (IFE, JPEG, BPS, IPE, etc.) and the external
>> +  memory interconnect. Multiple consumers may independently request
>> +  bandwidth via icc_set_bw(); the CAMNOC ICC provider aggregates all active
>> +  votes and scales CAM_CC_CAMNOC_AXI_CLK accordingly, avoiding the
>> +  last-writer-wins race that arises when each consumer calls clk_set_rate()
>> +  directly on the shared clock.
>> +
>> +  Each camera sub-device driver that shares the CAMNOC AXI clock should
>> +  obtain an ICC path from its master port to SLAVE_CAMNOC_AXI and vote for
>> +  bandwidth using the port IDs defined in
>> +  include/dt-bindings/interconnect/qcom,camnoc.h.
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
>> +    /* CAMNOC ICC provider node */
> 
> Drop, redundant.
> 
>> +    cam_virt: interconnect-cam-virt {
> 
> Drop unused label
> 
>> +        compatible = "qcom,sm8250-cam-virt";
>> +        clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>;
>> +        clock-names = "camnoc_axi";
>> +        #interconnect-cells = <1>;
>> +    };
>> +
>> +    /*
>> +     * Simple consumer example: IFE sub-device voting for CAMNOC bandwidth
> 
> 
> And what are the writing schema/bindings asking about consumers? Or
> DTS101 slides? Look at other bindings instead of coming with own style.
> 


And:
Drop second/last, redundant "binding". The "dt-bindings" prefix is
already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

Best regards,
Krzysztof
