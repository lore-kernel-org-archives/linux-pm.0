Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6640586F;
	Mon, 18 May 2026 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107334; cv=none; b=JpeTmKdyDUEwZUNZhMcsNZZUPAon7V3rnNQ1qnHssAlZHUat5LxLo9lY3ZgQX05aLFJn5qd4EIznB6D41o09dJniNbM+/PHM8HEsLCi1CkNo8i03x7TYPyM3QCnQ6oY/IKUA4nBsfm5wH9P9ZRGRudFv0P2q9jTmEcY03Qm4u1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107334; c=relaxed/simple;
	bh=5xK7eBFJjZ1QYUgjb1y/5i+cX2QZ3wiGUMyJFbDID90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzmYb01LkLnh5ZuMSHlxYxrH6uazWRL6ap5qA83o7SAEBvDelqAm0kl/PZC1OL3jpjJuFNzPBz3wSp8XuRUwAvSjxRVjT4+V/qJm0fr+oSGmbOi9fionOCsdMH8pLFgLUXJ0X1ul4WHKdLhXLt9RAaUOl3dQCXSIWNFUpY3qOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3o/0WIS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3o/0WIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63024C2BCC7;
	Mon, 18 May 2026 12:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779107334;
	bh=5xK7eBFJjZ1QYUgjb1y/5i+cX2QZ3wiGUMyJFbDID90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j3o/0WISsCWR4F2qY6fBZyLevfWfEWCguD6w3OiTwdZI2XLcqW9a+zD6ENpHNBzcx
	 Ixb6qmpjFQTx4Yoi5jgoU9qqMdtc2tjTiLYqcG9zM6Lt+UOO1PB8ZOUMjVZTyR0Zr7
	 CK/LZeTS0vi35e5gmS0C+MRXqjz03RpPbQumMd2th+uJ1U220Nq65WeuhjnvHhOirL
	 TJSKCW4tVZ06GFYOnMwD6FoQNGjQ434zLtOzVT/FjWGE3D35UjI61IcPuOg6JdkjGn
	 Mz0OZ73vH9KYznrr6jRXXSgUi8PTOB9FwuM1CTnQH/Ib5kRmwf/sM1Xq9lGXw7NxUw
	 FRtvOE1hgB+HQ==
Message-ID: <5d80590e-d443-4e16-9203-7251d52faf49@kernel.org>
Date: Mon, 18 May 2026 15:28:49 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Add Hawi cpu-bwmon
 compatible
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260427182255.3649922-1-mukesh.ojha@oss.qualcomm.com>
 <20260518112949.ui2gfxvkjdmgc6ks@hu-mojha-hyd.qualcomm.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20260518112949.ui2gfxvkjdmgc6ks@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/26 2:29 PM, Mukesh Ojha wrote:
> Hi Georgi,
> 
> On Mon, Apr 27, 2026 at 11:52:55PM +0530, Mukesh Ojha wrote:
>> Add the Qualcomm Hawi SoC compatible string for the CPU bandwidth
>> monitor and there is single instance present globally to monitor
>> the traffic from CPU to LLCC.
>>
>> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> index ce79521bb1ef..82b1d94d3010 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> @@ -26,6 +26,7 @@ properties:
>>         - items:
>>             - enum:
>>                 - qcom,glymur-cpu-bwmon
>> +              - qcom,hawi-cpu-bwmon
>>                 - qcom,kaanapali-cpu-bwmon
>>                 - qcom,qcm2290-cpu-bwmon
>>                 - qcom,qcs615-cpu-bwmon
>> -- 
>> 2.53.0
>>
> 
> I am hoping, you would be picking this., let me know.

Yes, i applied it.

Thanks,
Georgi
