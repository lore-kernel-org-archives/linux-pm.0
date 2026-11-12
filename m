Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475984;
	b=r1lw/wVDPyv042+p+gvuauz9TskR08DkR9LBJO0rYmBT7z9fxRDDstghMIA4mxF3EbOM
	 oSyAFKcxjdnWC5QjkbX6WEVI30S/m4AuTeJHOMecleAs1H0V49kKGoWtROf6FQ7kNz0NA
	 AhmoDmJlxAPCRq6hk98Mf3q6721JYuord6+6xkrPqsOFAPaKQBR2ipinAiduhDwlhjdBQ
	 CddIjDzmYzJc0ODEFl5CupNHbzPi5HtBKjsM1u/1cXNNT8CtwRmE7KGBBBrQFulGdL5iH
	 ZPcqA/YQe+2wQShbisGDxA/v/ashYL95iCXDD32xo/mEqpwUYHTBGt2vSO/xw7I4Ueg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475984;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jnzr15QD+tJBeXzKgcGnqHoGqOduvA9S3WgQRBozxH8=;
	b=X9EU8sH2tRLAc6hA4cLIWg9DM3KOXUfPRh90XL5eaoNivjG+AiU+16H1Cd1BtKLLHI53
	 AWG9JFZaAJaXBsjCPKw5+nX80h2i1ZFvz/e2Zi4bE06SDuNIy7EYcx0G7Xf1glL5I3ris
	 ENEBzgpdy77k8XeE9kru8sS1tsWU8MKD6+EjrK7sVmMOEhjlIRScrmoiQKgdjYDSx9R4d
	 QJc4IaTjVDzoyMeCsCAfKnXMAwdxiY0D3ookYWZdOj+p1fKSjjCIeQBPolkYxpIO5FYe7
	 wsPUGc8KJhOdEZ1XUtypLCd2omUgRDf9N03gd4oxX1NdekxOP3XlSM/Hg2/PdO/S/7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5j+wwXF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82D606A32E;
	Thu, 12 Nov 2026 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5j+wwXF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4311F00A05;
	Thu, 12 Nov 2026 09:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794475984;
	bh=jnzr15QD+tJBeXzKgcGnqHoGqOduvA9S3WgQRBozxH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R5j+wwXF6pxh6my/nS2TUy+RaRN/63e/mW0WQir+0wbxcAU7oGlmH+pWaHXoa9gU+
	 OGUIgQ2k/cEIw/DcN4rPCLpmjnnXSVVCvyRRvDtJXhGZ6wm3gI0huRr4VUWQ2RjBUR
	 GFMcl0uUOFmU+QGRun35q1unBHxOSs82iSU/KPdGiBk5isY+13Su/8b2ErghhBd1AM
	 ftHc24ulpQc6Wn+rFtdDcIGa3kQDb6iPnKWRPqQjx3pORULigJ3Er5Mz96f46O8hUP
	 4WvIaG6B5gDGXES1VTt6zEm9pQmZ4cV7ZE3lZmyi0smDgZY2TtAYycEy/msbqpdB/D
	 bJJL1hyJp5aFg==
Message-ID: <ed3c4e4b-7c6a-46ea-b07c-ba7ce6214830@kernel.org>
Date: Thu, 12 Nov 2026 10:32:56 +0100
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
Subject: Re: [PATCH 05/11] dt-bindings: clock: qcom: ipq5332-gcc: Describe
 clock inputs per compatible
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-5-d242e3d49648@oss.qualcomm.com>
 <62a5fabc-3a06-42fa-9c6b-6504650e712b@kernel.org>
 <7bcffc7c-5dda-4ead-a053-7eb4980e43a4@oss.qualcomm.com>
 <bec2bee4-dd38-4846-91d7-006fe38fc9da@kernel.org>
 <af43c724-89b9-456d-a5da-0d8ba46a9b8d@oss.qualcomm.com>
 <e8dadc91-226d-4b05-8de1-4b22318fc7ea@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <e8dadc91-226d-4b05-8de1-4b22318fc7ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/11/2026 10:12, Kathiravan Thirumoorthy wrote:
> 
> On 9/25/2026 12:09 PM, Kathiravan Thirumoorthy wrote:
>>
>> On 9/24/2026 4:28 PM, Krzysztof Kozlowski wrote:
>>> On 24/09/2026 11:15, Kathiravan Thirumoorthy wrote:
>>>> On 9/23/2026 2:17 PM, Krzysztof Kozlowski wrote:
>>>>> On 21/09/2026 08:19, Kathiravan Thirumoorthy wrote:
>>>>>> The IPQ5332 and IPQ5424 GCC blocks use different clock input 
>>>>>> orderings.
>>>>>> Document the clock inputs in compatible-specific schema 
>>>>>> constraints instead
>>>>>> of using a common clock description.
>>>>>>
>>>>>> Also add the 375 MHz PPE clock generated by the CMN PLL to the 
>>>>>> IPQ5424
>>>>>> clock input list.
>>>>>>
>>>>>> This keeps the binding aligned with the clock ordering used by the
>>>>>> existing DTS and GCC driver implementations.
>>>>>>
>>>>>> Signed-off-by: Kathiravan Thirumoorthy 
>>>>>> <kathiravan.thirumoorthy@oss.qualcomm.com>
>>>>>> ---
>>>>>>    .../bindings/clock/qcom,ipq5332-gcc.yaml           | 26 
>>>>>> +++++++++++++---------
>>>>>>    1 file changed, 16 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git 
>>>>>> a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml 
>>>>>> b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>>>>>> index 1230183fc0a9..fb39dffca988 100644
>>>>>> --- a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>>>>>> @@ -25,14 +25,7 @@ properties:
>>>>>>         clocks:
>>>>>>        minItems: 5
>>>>>> -    items:
>>>>>> -      - description: Board XO clock source
>>>>>> -      - description: Sleep clock source
>>>>>> -      - description: PCIE 2lane PHY pipe clock source
>>>>>> -      - description: PCIE 2lane x1 PHY pipe clock source (For 
>>>>>> second lane)
>>>>>> -      - description: USB PCIE wrapper pipe clock source
>>>>>> -      - description: PCIE 2-lane PHY2 pipe clock source
>>>>>> -      - description: PCIE 2-lane PHY3 pipe clock source
>>>>> You are changing the order which is ABI break. Describe the actual
>>>>> problem to justify such change. Are you saying this was broken since
>>>>> beginning or what exactly is not working here? The driver was added by
>>>>> Qualcomm in 2024, so how did it even work? It's not some 10 yo legacy
>>>>> where we did some mistakes in binding while converting from TXT.
>>>>>
>>>>> Also, I do not get why the list cannot be shared.
>>>> When the bindings was posted, list is combined for both IPQ5332 and
>>>> IPQ5424. But the driver wasn't updated and it was following the below
>>>> order, so was DTS, which is not compatible the DT binding description.
>>>>
>>>> enum {
>>>>           DT_XO,
>>>>           DT_SLEEP_CLK,
>>>>           DT_PCIE30_PHY0_PIPE_CLK,
>>>>           DT_PCIE30_PHY1_PIPE_CLK,
>>>>           DT_PCIE30_PHY2_PIPE_CLK,
>>>>           DT_PCIE30_PHY3_PIPE_CLK,
>>>>           DT_USB_PCIE_WRAPPER_PIPE_CLK,
>>>>           DT_CMN_PLL_NSS_375M_CLK,
>>>> };
>>>>
>>>> So I'm splitting the description between IPQ5332 and IPQ5424 to 
>>>> matching
>>>> with the DTS and the driver description.
>>> So we asked back in 2024 to have the common part of the list. I even did
>>> the effort to dig it:
>>>
>>> https://lore.kernel.org/all/ruti7hmkxkayzmqfbme6rw6j2vbhlx4ul4ptcckwamcpd4cyfx@owufhxwpvlcj/ 
>>>
>>>
>>> Authors implemented it partially, broken drivers. Now you basically
>>> revert what we asked, which is BTW logical option. It's logical and
>>> reasonable, but leaves bitter feeling.
>>>
>>> I have feeling there is no accountability and no responsibility of the
>>> IPQ at all.
>>>
>>> No, that's not going to work. You cannot come 1.5 year later and revert
>>> what reviewer asked you, even if issue was just by mistake in the first
>>> place. And you should not even try to do that.
>>
>> I understand the concern, and I agree this should have been caught much
>> earlier.
>>
>> I only discovered the mismatch while working on the IPQ5424 clock
>> additions. My intent here is resolve the inconsistency that currently
>> exists between the binding and implementation.
>>
>>>
>>> NAK
>>
>> I'm happy to explore an alternative approach if updating the binding is
>> not considered acceptable.
> 
> Krzysztof, I understand the frustration behind this, and we will make 
> sure issues like this are caught earlier going forward.
> 
> Could you please advise us on the acceptable way forward for this series?
> 

Unfortunately I don't know what to advise. I cannot Ack it, because
people look at history commits, take them out of context and use as
arguments in discussion ("oh look, here you acked such change, so I can
do the same").

Maintainer's feedback was basically only partially implemented and now
you want to revert that part which was implemented, basically opening
the gate to allow such patterns in the future. I don't know how you are
going to guarantee such issues will not happen in the future, so I guess
you need to live with broken platform. Please align with Qualcomm SoC
maintainers on this, because I will not ack it.

Best regards,
Krzysztof
