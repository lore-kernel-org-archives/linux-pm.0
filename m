Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719064343E7;
	Tue, 11 Aug 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458773; cv=none; b=FqAJLZMxxj6gXb+Jw8tnz6xLJ9Jwc8237Da34iMGJa3wivwEiO1OBZ3UU589iX5/DMJaAbHjoseJR4vER22+ACC9Tf8Sdy+RFAeO8RbmTDfD0YZKfdfFAJlwmQHttege/0DvLw5aSwTcoTlUFZCUbMGd2cEkU6oj3MzJbxW8Gxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458773; c=relaxed/simple;
	bh=2FznzG4ydf9U2k5MUHi+JsORAIzn0JqBlHDqTs1P8LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPcxqu+DOGr2vPltK6PzguwRGG9wxHC1I+XkTAiz4cD9TSd5j/ebEyrB01RsFfVb/Pbs0Hzo/wNSam2ucqQOu1eYK9ZTUMcpSjUROa6vLUOOoqz594BkTri1vcSGJSDACgILRDrUcqCSUy0uDOY1+kduKfYKmogXyhUQl3iqQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkimPLWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkimPLWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F911F00A3D;
	Tue, 11 Aug 2026 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786458772;
	bh=09Exon060ReBdwsGh/xKbGuadWEbTPQ0czNaH2d0FCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HkimPLWhDPhB9zSyAZMFsdQXQF+Cal53QOS3GMjIPDmnsY2NUxuTyRIXtem8czUtQ
	 m+aKqDrqm8sjo7PXLy2QNjz5PJxlV+d8cgrp4nI7phP9nJrrT+qyeHQaVBlx/oEw/e
	 uHJ5/GdFsVKtCbzgLG3LVv1E0a917uggtuyRwPDv3eZHZEaubG8iV28vwGUnFrvK6i
	 XvtZi8MgjbhPFHp0GXypz7y4UZpr7/zVPMktJ127OW1j7c8qFYy2XClpjvlfGhT/kr
	 N4TWxjfZSaBEGGoKgpL2zBUyjcF+s35vaXpkQ0I4QFDTTDQMZ4Uc9c/ANjT0gCe39Z
	 kya8cvkiaBocA==
Message-ID: <5e4fb03d-3ab9-4a45-a271-6f4be5c928f8@kernel.org>
Date: Tue, 11 Aug 2026 17:32:45 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm IPQ9650
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
 <20260519-ipq9650_icc-v1-1-4d3554c94257@oss.qualcomm.com>
 <n54sewn4sjafsncs2e64hkynxr5ct7qh3xukmgvdqankpsg2iu@kunxe57navul>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <n54sewn4sjafsncs2e64hkynxr5ct7qh3xukmgvdqankpsg2iu@kunxe57navul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/26 1:19 PM, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 02:17:05PM +0530, Kathiravan Thirumoorthy wrote:
>> Add master/slave IDs for Qualcomm IPQ9650 Network-on-Chip interfaces to
>> support the gcc-ipq9650 driver in providing interconnect services via
>> the icc-clk framework.
> 
> Please consider adding an explanatory text.  Something like:
> 
> On Qualcomm IPQ9650 platform the interconnect busses don't have separate
> RPM / RPMh controls. Instead they require direct votes through the GCC.
> To unify hardware descriptions (and software interfaces) between this
> platform and other Qualcomm platforms, make GCC export corresponding NoC
> clocks as interconnects. Add IDs for these Network-on-Chip interfaces.
> The GCC schema already defines #interconnect-cells since it was added in
> the commit f92b778251ad ("dt-bindings: clock: add Qualcomm IPQ9650
> GCC").
> 
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   include/dt-bindings/interconnect/qcom,ipq9650.h | 28 +++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
> 
> Georgi, any feedback from you? Would you ack merging this patch through
> the Bjorn's trees? Or would you rather pick it up on your own?
> 

I think it would be best if this goes together with the code that is using it.

Acked-by: Georgi Djakov <djakov@kernel.org>
