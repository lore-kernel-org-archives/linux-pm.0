Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F883DF018;
	Tue, 24 Mar 2026 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346471; cv=none; b=f6LyN48HwGl108jAXYd7tCnFiLcxZL9E71Liw/Jx5opKFjvjySJaqrUyHgulgEuvex90lVial+ytX9eEIKdQYwo+EBkMee6tpMOAX4idywQ/jr8K2Bi2qgapE1Vq1VOe1Zp7DSuhPIpR/GDY/H33OaqRi+L0+kydQC0YzXcyg+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346471; c=relaxed/simple;
	bh=6RobQ/t7aqOfdNVZFPi981wKZ2V6PDKds3DAR08YH+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJSQUTKG/qTr0810KK4LBvR+NZePAR3URWzdT8oXiUuFa6qSf8FX8cMgnPCieOJ3wBS1J1wjuzXD56bBfmMWdu7cZmh/E1hEO1fN8buOqpXaMiFQ5YrouaoNdERcsYm4rdFJL6k21Swj5QXXjR4/Red1NOZlZIBnA+mHo1hzfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXf6CsO3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXf6CsO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20DFC2BCB2;
	Tue, 24 Mar 2026 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774346471;
	bh=6RobQ/t7aqOfdNVZFPi981wKZ2V6PDKds3DAR08YH+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AXf6CsO35okX6Yk5koeapw9oYHjFuJ7aJ3tEnSwwODkzBl+3Uxg2zV51gkW7D8OBf
	 sE+SKbQHDPmOktruAofANWqCwTqES977D2cwjN0Gcw5RludWsH9ZFs/3xpUeAPCNV2
	 i5AVVUFkWk9c24zFk9WyxjdM7A9uyjDYWCKZRDEecPqCUt/btIg5Lcaks6jbf+GKR0
	 abE0QK9OJDe+lhRn8EhoXlKQRwhIWwdy1qLASH3DXSskGqqhmAKEBa76pZj5J4bXBh
	 BNONF98x5F6OlgFp3SpgrS9oFcRYN84n4u8yX0WxJHU8zetg7bJybuLrdPW0t1YJFw
	 h8bMXyGdzrVEw==
Message-ID: <5a9f84fe-5827-48e7-8e4e-699cf8ae4776@kernel.org>
Date: Tue, 24 Mar 2026 11:01:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: st: spear: fix dtbs warning on spear
 thermal sensor
To: Daniel Baluta <daniel.baluta@nxp.com>,
 Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 vireshk@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
References: <20260323133814.14152-1-krishnagopi487@gmail.com>
 <20260323133814.14152-3-krishnagopi487@gmail.com>
 <20260324-smoky-radical-hyrax-1274a9@quoll>
 <cd3400ce-295e-450f-b650-6715142ccbde@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <cd3400ce-295e-450f-b650-6715142ccbde@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/03/2026 11:00, Daniel Baluta wrote:
> On 3/24/26 11:26, Krzysztof Kozlowski wrote:
>> On Mon, Mar 23, 2026 at 07:08:09PM +0530, Gopi Krishna Menon wrote:
>>> Running DTBS checks on st/spear1340-evb.dtb results in the following
>>> warning:
>>>
>>> thermal@e07008c4 (st,thermal-spear1340): Unevaluated properties are not allowed ('thermal_flags' was unexpected)
>>>   from schema $id: http://devicetree.org/schemas/thermal/st,thermal-spear1340.yaml
>> How is it possible if there is no such file?
>>
>> Did you just add new warning in patch #1 and then claim in patch #2 that
>> you fix it?
>>
>> You completely miss the point why this change is needed: how could the
>> DTS work before? It could not. And that should be your justification for
>> the patch, with explanation why it could not work.
> 
> Correct me if I'm wrong but I think there was a hidden bug here 
> 
> drivers/thermal/spear_thermal.c:spear_thermal_probe:
> 
>       if (!np || !of_property_read_u32(np, "st,thermal-flags", &val)) {
> »       »       dev_err(&pdev->dev, "Failed: DT Pdata not passed\n");                                                                                                                         
> »       »       return -EINVAL;
> »       }
> 
> So, the driver was checking for the correct property as pointed by 

Yes

> 
> bindings/thermal/spear-thermal.txt but the dts was using the wrong

No, DTS had two properties - correct one and incorrect.

> 
> property name: arch/arm/boot/dts/st/spear13xx.dtsi » » » thermal@e07008c4 { » » » » compatible = "st,thermal-spear1340"; » » » » reg = <0xe07008c4 0x4>; » » » » thermal_flags = <0x7000>; » » » }; And because this check is wrong:
> 
>       if (!np || !of_property_read_u32(np, "st,thermal-flags", &val)) {
> 
> people really didn't notice it.
> 
> The check should be:
> 
>       if (!np || of_property_read_u32(np, "st,thermal-flags", &val)) {
> »       »       dev_err(&pdev->dev, "Failed: DT Pdata not passed\n");                                                                                                                         
> »       »       return -EINVAL;
> »       }
> 
> So, this actual patch has uncovered a bug! 

Yes. Driver also has bug, so probably was never working. The point is
whatever commit is doing, the dtbs_check warning is not the
justification, because it was introduced by this patchset.

Best regards,
Krzysztof
