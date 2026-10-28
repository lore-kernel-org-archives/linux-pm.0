Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210653;
	b=2ebDM5W7qdmNsTjvuIbGZ1gy0Yl7vbw4+vUpv3WRr407CYvDgFUyYhgostnt7kOalvr2
	 kOFXDFSdRLR2CVl+U8Qp4i8ameVWWR7SKtYtpqjbtEseCn2FLM127QTog0cP5Eh2dnqco
	 +MefYmKqkCIMHiXk92Cw5Glb8DuaFzTVO2zvl6KnRCDrQbxfdwqDH7LHV1O1S8BwSN/0G
	 vXWg8Z6PNTVnzimY+vA+qmRJT5/6GXAMIDsw6n9C0Yac2kZ8MK1qZ/6vIARIWLSDfPWS0
	 9ZXEmNnERKcTejGaYKh7HdwHdbD18ZPkBMdMpRJnGhHnWVk9UbZ4Q5IC8WRB3H7/9kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210653;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=IEcR6csv+GD6Loykfvb6QXrxb41fqL5AqQSNpEHC0SA=;
	b=axDBqxouk/RQg4/N98b4EG37o3Jbh45BStBv9FQUD6we9BO6qzViJJQKFWK/VsEctxrM
	 yexuRXDuVtFHdborIFMwxB4MVtpa4dDFaMycPjsiig1LBoxTHGhTra/twcyeQQvQD5UQU
	 Qn8MuzFZMlaKiPUthIpjBwfHo7LDmBi3g1kX7o4NZohMIvQSYjJkVVUDNs1HFnW/uCRIM
	 rfawws0MFxfKYgQZ4nFU9BaRYgOQzUvOq85+6eHPrRfYKwIHl4gXmMzwZfhJxFOvlV9v8
	 pjEnTp6vCR9xILCAoY54uk4hWaPfIfq/Zjg7PlBNl1b5ZSOLZ03/jgxgD5vvMKVN/BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3tw3e+F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AFE606A31E;
	Wed, 28 Oct 2026 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3tw3e+F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109E01F01828;
	Wed, 28 Oct 2026 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210652;
	bh=IEcR6csv+GD6Loykfvb6QXrxb41fqL5AqQSNpEHC0SA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=S3tw3e+F/XRCnU3B/USOk+IsCGaMHI9ZPiavFUhulwwLpuJUDiSRp0Vh0fnSkFbF1
	 BUDzcaplG3zYZExpPt2w8N0EL9LvWZH+BHk15c9K9DP/YrjfV32rg1ATiBAWThk7ic
	 MvtuvlvqML7rIwxuItj5F8x2dfEBE504m22Yar5z8dp70ZDYB0kjI231sdCPB6A4Mm
	 F8fRN2UiAvED4jA8fnsyafhwK+qbT5Y1IYhRtmNHX/JQNbu+SOks1DdOlFEdL3bNLp
	 6W6eX5cj6Gui34aPFdp08tMruyqiXK2G8W46BSsqDWKua6yJ7OSRrfw5wul1jXUOy8
	 Lp7AKkMR3Dkjg==
Message-ID: <b710b5f3-8464-4096-b645-11769e10c685@kernel.org>
Date: Wed, 28 Oct 2026 19:04:06 +0100
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
Subject: Re: [PATCH] dt-bindings: thermal: Drop thermal zone node name length
 limit
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Conor Dooley <conor+dt@kernel.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20261026094956.2323036-1-daniel.lezcano@oss.qualcomm.com>
 <20261028-worthy-prudent-cuckoo-d5ed97@quoll>
 <f054a608-730f-4415-87ef-510523a50ac5@oss.qualcomm.com>
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
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGPBBMBCgA5AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJp2mE8AAoJEBuTQ307QWKbeaIP
 /ihHTkTW4KsN/DQ945JJbyu5tI0J80Wue7QyyLPglyKfhgb5cLLNPpOC8cCIJsc7+W3i2P38
 s2c1cOH6CYGE7E9ur3Vfme8NW2S2I/Z8VC7bZnzyS23wT17LrsdS/qCpx4o8U+pt/xdXDKph
 EGRYrIEmMpUWvyYzyYKGIe25FtaayIIKpq8eZYyFcp2f/sG5IkOW5uZzHPMPdcm87jU7fyuQ
 rAU2vx9r+ulUfQ/q9Z2roC/ode3l7t2pN7BCBCsUDp6JCrUyZrtT1e7EbA0ZRP3aOBNk2P2E
 DQOgJGjGdO5Yx2Y9LFtltu6JbsBJHi1syGRX3AtQYOMc4Y1WGoeZJmMlvKj2ZqqXNkcWi2DS
 IQEWB0uW6CqFsBBIMGDa+6OzdaVO/uAVXWDWml02Men3CILdI1MbVjoh8ECqYUY7OQ+JJvNN
 vnliuq5WM3Ghd3jg/LZZrxXjdIginRHFQCjIJYLKpLZWm1/iDFedcfzqRNYmTtqscdCNHW41
 oT3Z7BmO9xwdjuwBS6nmS6JJwkbf5Ot2QR4pB/DRU7ZwjT1qHe+9r9gF32wXVQatHNGK/VVu
 sfwOnkdxCWkp/qb2gdQRmZh+SedStWshigH6sNfuHBloF/q+hjMRc8b2m326OZdrbSHwY1Sz
 vti8Hn7n8NjdHO9LKB7BIdjkA9DA5WsqOuVCzsFNBFVDXDQBEADNkrQYSREUL4D3Gws46JEo
 Z9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLueMNsWLJBv
 BaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6eiOMheesVS
 5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wAGldWsRxb
 f3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA6z6lBZn0
 WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9YegxWKvX
 XHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt91pFzBSO
 IpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gUBLHFTg2h
 YnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/JoFzZ4B0
 p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu4vXVFBYI
 GmpyNPYzRm0QPwARAQABwsF2BBgBCgAgAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmna
 YUkACgkQG5NDfTtBYptX+BAApg32CkxwNucNEi8WfWA8oKkW0y8YDuY6ORMo9FWNGiT/OTy0
 vyJrLocrpn86zwfjVp+eCrssPYh8eqJfnWqmYv6ACQtHPYzPZQ3mSo8H97Z01oUxITzCxpXm
 ZkLgPIqtDPcC2E3dPM/fVxcyowM8XsaMA9wcsaUYrta8toOq2b9tKcjleKMfMrm0gQ9u7wUc
 QbLkwj6TCLOwucb07GXzLTNF9PZmaDUpKAZjMjmrW+le+SFvQbhamx0rxLWPR0NWntXpbCn+
 +ACch03p/JyTBVktxFsFyCt7pTPE1kEaeuXBTe/a2D9iQvRxRW19LvuO2e59/u1wYUiH/orz
 wbIC2S4dBsPAPihL3ztOU1yE86GPyQtSE0kU+/7snnLt4QGi6PChf3t5gnNjAzjUUovO8rgI
 c+5yN5heq5loYHgK6OQ9OlHzsPHO9e9MOQcKlFycs1pyijFGzDwdNUm/SchK8iWT2QApTx4A
 K9bCVaboTA2T77QYkRcRJYSsO1alGX0ome/hMLD1daXlkrNUp1HWa3K4iytLRXjCSIorWiGs
 n+q3krnpXu3TFkA8qtOFZMdnIiFuiq1yLT8hptsV5xh1TA2nsVvSYiaCr3q4s4BKjS/KrLDb
 qoxzw8ISjdUp4pA85vb6YLCmb39NgidD+7PmAr65lBNveIFynTgsja1rRQ4=
In-Reply-To: <f054a608-730f-4415-87ef-510523a50ac5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2026 17:07, Daniel Lezcano wrote:
> On 10/28/26 14:00, Krzysztof Kozlowski wrote:
>> On Mon, Oct 26, 2026 at 10:49:56AM +0100, Daniel Lezcano wrote:
>>> Device Tree bindings describe hardware and must remain OS-agnostic.
>>
>> DTS describes hardware. Bindings describe the ABI between hardware and
>> software, so if SW requires something regarding the DTS, should be
>> placed in the binding as well, IMO.
> That's odd, if the Linux kernel changes the thermal zone name length to 
> something else, then that impacts the bindings, no ?
> 
> I don't see a good reason why the node name must be limited by Linux.

I provided the reason. Why aren't we/you removing all the device subnode
namings coming from of_get_child_by_name() usage? That's purely a Linux
requirement, no?

Best regards,
Krzysztof
