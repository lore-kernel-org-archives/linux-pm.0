Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF543B4B5;
	Mon, 17 Aug 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979668; cv=none; b=no+6oo23Uhk1mTig64mEgVCwPCEl22rXYqdH0LPtXs1X2c6etTlQ81lC+2tQfxlqSGb2DDBPkac+GF8VFfRnhUT1/GvM48bGoPxvU+EYYsOY+4IlsuTIVyggzo29tb3ioTfyTf5XnBNhj8zaHR2d/Zh+sZ9/NDlg1ut2xGYDiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979668; c=relaxed/simple;
	bh=1z105iIZ8VI0R+psTUUd3kO1ynRbgbdFNgPw34X7ZfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqJ36lBJtauNWEWGgMNON1x84p/2ZU2OHBiS8S2khoCwzNkkjwK83S7PVDaGZLmdQaZw2offeYeUaZ+JW6bop8WEGaTHicIGOK7A1D/ZGwvyaiWlpEkSdOz72Ssuag23yFzBDeB6fAG/RHrM2V1tzQupHJK6XeSv7xYjAR15QRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOKdsEBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOKdsEBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0029D1F000E9;
	Mon, 17 Aug 2026 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786979666;
	bh=nkK55auWwn9VFLsei6e7YzHGhJL1QZe3JhbvIISaRPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UOKdsEBeMZZ6U3bGU2drJ8nbgt95yhXOtKqrXHG7WhnHOdTFQr3Fku53K5OYpAidV
	 4/1vBZB0qMycJbpHDd5hqUG/nNO0W2KQaeMJTmwAfjxogTbjGt/xyGoPVjInkfGrW2
	 QxZjIsmYqmMq4T52MjSQt5LJANPgKBMTqjPg4XmWGy17EFV4kAsQEkf1MQqgS3Oi7D
	 8+ngKvCL3lUilZPRnB1eaEbjXFZmcW9584AlE2/JIHH7NZwf0z6LTZMJWAx75Jouh7
	 AX2AyiN9wiClalhpVERr3mIS1yzKymn3iSjJxfGsNsSBMRR2Ovj0SYvNMVaG+S4a7C
	 KqTOoxWNLQx5w==
Message-ID: <75eca5af-017e-4e6a-9e22-1e395be6e45a@kernel.org>
Date: Mon, 17 Aug 2026 17:14:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: power: bq27xxx: document bq27z746
To: Henrik Grimler <Henrik.Grimler@axis.com>
Cc: Kernel <Kernel@axis.com>, Alexander Svarvare
 <Alexander.Svarvare@axis.com>,
 "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
 "afd@ti.com" <afd@ti.com>, "dmurphy@ti.com" <dmurphy@ti.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "pali@kernel.org" <pali@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "chris@lapa.com.au" <chris@lapa.com.au>, "sre@kernel.org" <sre@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
 <20260811-bq27z746-v1-1-3a4fa38205cc@axis.com>
 <20260817-talented-brave-clam-f5e6e6@quoll>
 <bbd0548a01d7020947f025f0632a0994f4acd77d.camel@axis.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <bbd0548a01d7020947f025f0632a0994f4acd77d.camel@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/08/2026 17:00, Henrik Grimler wrote:
> Hi Krzysztof, 
> 
> Thanks for the comment!
> 
> On Mon, 2026-08-17 at 09:50 +0200, Krzysztof Kozlowski wrote:
>> On Tue, Aug 11, 2026 at 01:47:43PM +0200, Henrik Grimler wrote:
>>> Add compatible for Texas Instruments bq27z746 fuel gauge, which is
>>> similar to its sibling bqz27561, but with more protection
>>> functionality.
>>
>> "More" means superset? Driver code says it is compatible, so this has to
>> be explained 
> 
> I will update the commit message to explain the differences. Main
> difference is that bq27z746 has integrated protection logic, and can
> control external MOSFETs to stop charging/discharging if an issue is
> detected (like overcurrent or overvoltage), or to keep the rest of the
> system fully powered off in shipping mode. bq27z561 does not have such
> protection circuitry, so best it can do if it detects issues is to send
> an interrupt to some other component.
> 
> The standard register map is almost identical between the devices.
> bq27z561 has 6 extra registers at the end that bq27z746 lacks though,
> which I missed when comparing the TRMs the first time (so bq27z561 map
> is a superset of bq27z746's). Neither of these extra registers are
> supported/handled by the Linux driver through. I will update all the
> commit messages for v2 to clarify.
> 
> There are also additional "ManufacturerAccess" registers where there
> are some more differences between bq27z561 and bq27z746 mostly related
> to the above mentioned MOSFET control, but the current Linux driver
> does not read or handle any "ManufacturerAccess" register. One of my
> colleagues has sent a patch to add support for reading PROP_MODEL_NAME
> from these additional registers for bq27z561 though [1]. This model
> name register is the same for bq27z561 and bq27z746.
> 
> In summary the chips have differences, but I expect it will be fine for
> the driver to use same regs and props for bq27z746 and bq27z561.

Well, superset is exactly what compatibility is about.

Best regards,
Krzysztof
