Received: from outbound9.mail.transip.nl (outbound9.mail.transip.nl [136.144.136.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF84071DD;
	Sat,  6 Jun 2026 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780756352; cv=none; b=Ptxi/vpl9m9eMLfI8XcXTSmRv+2qxzFVB679VkGjKyuoUg9UyM7vGBJVI8uHnQwJrP8EEuU0cdtvsfkMSZ6MCZyFZocPsUAB72v0er7h3aMljlb0J+Qk/w5IjkN7EjI7VW9BRTFvhaSUoldJwq/9iJ3Jql6xZMPEUKRM4e6dG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780756352; c=relaxed/simple;
	bh=hJnO0ktBlS3bJymbQHSMg6fEyhjmpIcZiEiUqsptTIg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ijI3S48BdfAejNHZxuqafpG94LeJ/6ZdUBfQUABX0ih4roib3Umi/f+Ix2VV3WUyh/TzPlEMwZmYZrG65+84bDW6QNqNK/ojGzuVj7Kww+jEd0+LzweLo86XZX6LEXKlIhD4z7I7FAPJX+SyHyrDkjxYJ0/L2Swavt5TMDDWdFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=VbCM4MBm; arc=none smtp.client-ip=136.144.136.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="VbCM4MBm"
Received: from submission12.mail.transip.nl (unknown [10.103.8.163])
	by outbound9.mail.transip.nl (Postfix) with ESMTP id 4gXgkG1s6GzTPNMN;
	Sat,  6 Jun 2026 16:32:22 +0200 (CEST)
Received: from transip.email (unknown [10.103.8.120])
	by submission12.mail.transip.nl (Postfix) with ESMTPA id 4gXgkF39BTz3SJ37P;
	Sat,  6 Jun 2026 16:32:21 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 06 Jun 2026 16:32:21 +0200
From: me@herrie.org
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Herman van Hazendonk <github.com@herrie.org>, Georgi Djakov
 <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: qcom: add msm8660 NoC
Reply-To: github.com@herrie.org
Mail-Reply-To: github.com@herrie.org
In-Reply-To: <wypnu53w5pesj52zyrj3pydqzf2rbfrxa72uplz3mq64u447wf@gypyaug7iwkd>
References: <20260606-submit-interconnect-msm8660-v3-0-f9da0158cdf8@herrie.org>
 <20260606-submit-interconnect-msm8660-v3-1-f9da0158cdf8@herrie.org>
 <wypnu53w5pesj52zyrj3pydqzf2rbfrxa72uplz3mq64u447wf@gypyaug7iwkd>
User-Agent: Webmail
Message-ID: <d6a95e9626845469764a11587ed65c7e@herrie.org>
X-Sender: me@herrie.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: ClueGetter at submission12.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780756341; h=from:reply-to:subject:to:
 cc:references:in-reply-to:date:mime-version:content-type;
 bh=BLg8RdQjzbzwPed3l+3qhZrxFGnBMWHv4/rl3Vrfrbw=;
 b=VbCM4MBmmzAH5mEl1uRmJCQbrOryFYA35wAitRYtADZZRAF7KVskHMpcXzu5LsWJh3INBm
 F0qrVrdwZIVzDByAOO0SemeSs+g1AMObmuwHOb8bR5aYGH9wJr/lksXCH6zJLZlcJeruvf
 ZTsL+GXlfQp4tXdYzAYqj77ymRYLMcdQiBHmoXW9orY8aoijT6a4J+x4rFvoJZhNX7w8aI
 Yjvn864MpPnvBsSioAlhMpn/+4q10XtWVOVE6cqFR8YOHE9ZsdEVOwWQx9BZblUir6lN4N
 AUBE2g0jG7FHg4OhFoSZi6aLj7F+NVgorl8iduODVPi4vLhMISUQR7TPaXnVKA==
X-Report-Abuse-To: abuse@transip.nl

On 2026-06-06 15:23, Dmitry Baryshkov wrote:
> On Sat, Jun 06, 2026 at 02:34:50PM +0200, Herman van Hazendonk wrote:
>> Add a dt-binding schema and an interconnect master/slave ID header for
>> the MSM8x60 family (MSM8260/MSM8660/APQ8060) Network-on-Chip.  The
>> chip exposes four NoC fabrics that the qnoc-msm8660 driver models:
>> 
>>   AFAB  - Applications fabric (Scorpion CPU + L2)
>>   SFAB  - System fabric (DMA, SPS, security)
>>   MMFAB - Multimedia fabric (MDP, GPU, camera, video, rotator)
>>   DFAB  - Daytona fabric (SDC, ADM master/slave)
>> 
>> The schema covers all four compatible strings, per-fabric clock-name
>> lists (bus / bus_a / ebi1 / ebi1_a for AFAB; bus / bus_a / smi /
>> smi_a for MMFAB; bus / bus_a for SFAB and DFAB), the required
>> qcom,rpm phandle through which the provider hands the arbitration
>> buffer to RPM firmware, and #interconnect-cells = <1>.
>> 
>> The ID header lists per-fabric master / slave / gateway indices
>> derived from the legacy vendor msm_bus_board_8660.c enums,
>> normalised to the upstream interconnect-framework naming convention.
>> 
>> Assisted-by: Claude:claude-opus-4-7 Sashiko:claude-haiku-4-5
>> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
>> ---
>>  .../bindings/interconnect/qcom,msm8660.yaml        | 166 
>> +++++++++++++++++++++
>>  include/dt-bindings/interconnect/qcom,msm8660.h    | 156 
>> +++++++++++++++++++
>>  2 files changed, 322 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml 
>> b/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml
>> new file mode 100644
>> index 000000000000..ff28c7d46c32
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml
>> @@ -0,0 +1,166 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8660.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm MSM8x60 family Network-On-Chip interconnect
>> +
>> +maintainers:
>> +  - Herman van Hazendonk <github.com@herrie.org>
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,rpmcc.h>
>> +
>> +    interconnect-afab {
>> +        compatible = "qcom,msm8660-apps-fabric";
>> +        clocks = <&rpmcc RPM_APPS_FABRIC_CLK>,
>> +                 <&rpmcc RPM_APPS_FABRIC_A_CLK>,
>> +                 <&rpmcc RPM_EBI1_CLK>,
>> +                 <&rpmcc RPM_EBI1_A_CLK>;
>> +        clock-names = "bus", "bus_a", "ebi1", "ebi1_a";
>> +        qcom,rpm = <&rpm>;
>> +        #interconnect-cells = <1>;
>> +    };
>> +
>> +    interconnect-sfab {
>> +        compatible = "qcom,msm8660-system-fabric";
>> +        clocks = <&rpmcc RPM_SYS_FABRIC_CLK>,
>> +                 <&rpmcc RPM_SYS_FABRIC_A_CLK>;
>> +        clock-names = "bus", "bus_a";
>> +        qcom,rpm = <&rpm>;
>> +        #interconnect-cells = <1>;
>> +    };
>> +
>> +    interconnect-mmfab {
>> +        compatible = "qcom,msm8660-mmss-fabric";
>> +        clocks = <&rpmcc RPM_MM_FABRIC_CLK>,
>> +                 <&rpmcc RPM_MM_FABRIC_A_CLK>,
>> +                 <&rpmcc RPM_SMI_CLK>,
>> +                 <&rpmcc RPM_SMI_A_CLK>;
>> +        clock-names = "bus", "bus_a", "smi", "smi_a";
>> +        qcom,rpm = <&rpm>;
>> +        #interconnect-cells = <1>;
>> +    };
>> +
>> +    interconnect-dfab {
>> +        compatible = "qcom,msm8660-daytona-fabric";
>> +        clocks = <&rpmcc RPM_DAYTONA_FABRIC_CLK>,
>> +                 <&rpmcc RPM_DAYTONA_FABRIC_A_CLK>;
> 
> Looking at it, I don't think those clocks sould be exposed here. Please
> follow what Konrad did some time ago for smd-rpm interconnects: add
> direct voting to the interconnect driver, them drop them from the 
> clocks
> driver. Ping me if you need help finding corresponding patch series (as
> there were few more tricks.
Feel free to send it. This is my first work on kernel ever and to be 
fair a lot of it comes from piggy backing on previous work, legacy 
kernels and insights from Claude & Gemini.

I can say it "works" for my limited tests, but I haven't run a full 
fledged OS yet to stress test most things.

HP TouchPad boots, audio works (though no Q6 (yet)), graphics works 
(Adreno 220), camera works (camss & vfe31), video plays via vidc, 
rotator, vfe works, sensors work (ALS, magnetometer, gyro), leds work, 
usb works, touchscreen works. Only thing I'm struggling with is wifi & 
bluetooth for the moment. It could very well be that when I rework 
things "properly" my wifi and bluetooth issues disappear and start to 
work. This old silicon is very unforgiving when it comes to bits set the 
wrong way.

So any guidance is much appreciated :)

As always there are multiple roads that lead to Rome :)

Thanks,
Herman

> 
>> +        clock-names = "bus", "bus_a";
>> +        qcom,rpm = <&rpm>;
>> +        #interconnect-cells = <1>;
>> +    };
>> +...
