Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198E3E7BA6;
	Wed, 27 May 2026 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873620; cv=none; b=JnEbGZs8FfQEmPglTrHJHloyhXiYroxfmKGLMUm86RLBBQ8diGW7xI9h/wpWv0rIrDKazMbmEbKltRw/OP8oAglbqNMd6kD1V9NRIAvd5EFUUAWxN1/CHccsmb001xg+4HnPfsPf6CfhCJvxsVzKZYWSR6GEuUijJcpjAIXtQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873620; c=relaxed/simple;
	bh=6m7OGDlPMuvsQiJ8hveFktz8KcLIRgrwMqOMVjbCkro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pThL+87OYsoSe+CqooKp8mTHM74KXfdTPDFRKZK7EPmmGWGcgmvSuImU6b2priFCGqKivuB2Xm6UBoTayD+Cv5qmm7YtNqgBupBN/pK0TOygB2VU2kFomayzOSN/XgqsCV/HOlLjZhqRCUCdKu2Wc9x1CYfepKSnxBUiY8dSxhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL28ATp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL28ATp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8E81F000E9;
	Wed, 27 May 2026 09:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779873616;
	bh=c+2Jf/5YHovO3XbSQ9sVw9O47cO2wm87gZwcDX64Qgk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nL28ATp/xCIT33YKQsgoV8DpOWBJ2LGzPevUHP28e6KgSWUmDZEt9aWDS+vy7X5/g
	 K09aCRwDZ2F98dLeahKrl/4h4heWevB1Nx3WlzCAfQkutz9/jexPFfbo38PxiOzLN5
	 8z/t2YBGjgNadYhfCyCHndseyaqz+nfeNdYG5zlwWFPqCBrfo8gKAUsYcubbsbBRZa
	 8QHEU2Db7cPkSpLT88CwYjNam9EZ2WckSilbLDHtvsKhURMuvKlX3adDJ5x87MV+rS
	 BIbEIGdX9/Jez4apghxUPOJgLAk2Ol7RizNQmqsTzsMbPhCjRa2zuKARTfyCmwSybN
	 BkZt8qEFHtOUg==
Message-ID: <0c4fe9b9-3ec6-4988-b579-776cf37585ca@kernel.org>
Date: Wed, 27 May 2026 11:20:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: tegra: Document Nvidia Tegra
 modem pwrseq
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260523085102.51000-1-clamor95@gmail.com>
 <20260523085102.51000-2-clamor95@gmail.com>
 <CAMRc=MfXVwD2u0e115RapnyLzf5JRjWMs=2PSNzMnm0GDd7aaQ@mail.gmail.com>
 <CAPVz0n1G5Yu2X5f+=q90RAbnsWi9psMq-L5tWDMM4JRC4R_mPg@mail.gmail.com>
 <CAMRc=Me4G-YqKoFan3epofXk2OWzxY1iPE1mP=uwEjs9wgA6Cw@mail.gmail.com>
 <CAPVz0n2P-zB1_uetZN9pVcQChK+FkdQowbF4Z0YZOBQBsB76WQ@mail.gmail.com>
 <CAMRc=MfAAE4UtnW4S1=pY+2yvS6Hsd-U9+uveUFtPGoJPrv6aA@mail.gmail.com>
 <CAPVz0n2COsDL+fNBAuKr1ty_AVe9sK5yNJithkXex6GNa1T_Tw@mail.gmail.com>
 <CAMRc=Mc9g=yezRtAtRMzh7t-pSoyoKQEtxrb5U0oeFAbcjb6Ew@mail.gmail.com>
 <CAPVz0n3X8Gw2Yo9VgwhV0uAqvArGXbvmzw=cZVJw=4BEH_E7_w@mail.gmail.com>
 <CAMRc=Mf4W9hoP7FAbxQTNLaG3M9W+GmvQSMECbzzdQLU_+5D4A@mail.gmail.com>
 <80e102be-04c3-4591-8e75-ddf859d3a877@kernel.org>
 <CAPVz0n3_wueX1yeZ=MDfSMy3UaQa80-nGg1b7ZQuCTneOaQDkQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAPVz0n3_wueX1yeZ=MDfSMy3UaQa80-nGg1b7ZQuCTneOaQDkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/05/2026 11:06, Svyatoslav Ryhel wrote:
> ср, 27 трав. 2026 р. о 11:26 Krzysztof Kozlowski <krzk@kernel.org> пише:
>>
>> On 27/05/2026 09:55, Bartosz Golaszewski wrote:
>>> On Tue, 26 May 2026 15:41:58 +0200, Svyatoslav Ryhel <clamor95@gmail.com> said:
>>>> вт, 26 трав. 2026 р. о 16:14 Bartosz Golaszewski <brgl@kernel.org> пише:
>>>>>
>>>>> On Tue, May 26, 2026 at 2:55 PM Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>>>>>>
>>>>>>>>>
>>>>>>>>> The node attached to the pwrseq provider device should represent a real
>>>>>>>>> hardware component. Are the enable-gpios and power-supply lines connected
>>>>>>>>> to the modem package?
>>>>>>>>
>>>>>>>> Yes, enable-gpio is connected to the modem and signals that USB is set
>>>>>>>> and ready to work with the modem, while power-supply is an optional
>>>>>>>> supply connected to the modem's vbus input.
>>>>>>>>
>>>>>>>
>>>>>>> The modem is a hard-wired USB device? Do you implement it as a
>>>>>>> platform driver or a USB driver?
>>>>>>>
>>>>>>
>>>>>> It is not a traditional USB device. XMM6260 is an embedded modem used
>>>>>> in the Tegra phones, it is linked with the AP using USB line in HSIC
>>>>>> mode. The driver is implemented as a platform device since it does not
>>>>>> interacts with the exposed USB device directly, it just ensures that
>>>>>> USB device is properly configured and is ready for IPC.
>>>>>>
>>>>>>> Is there a connector of any kind that could be used as the HW
>>>>>>> component represented by the pwrseq device?
>>>>>>
>>>>>> I assume control over USB line is the HW base, but as I have said, I
>>>>>> can integrate binding in the modem node itself, and pwrseq can get all
>>>>>> it needs from the match. Pwrseq framework states "This framework is
>>>>>> designed to abstract complex power-up sequences that are shared
>>>>>> between multiple logical devices in the Linux kernel." it does not say
>>>>>> that it must represent some specific hardware.
>>>>>>
>>>>>
>>>>> No, not at all. We just can't make up any imaginary, logical "pwrseq"
>>>>> devices and describe them in DT bindings.
>>>>>
>>>>
>>>> Ye, ye, sure, pwrseq framework is quite flexible and I am not stating
>>>> this bindings is mandatory.
>>>>
>>>>>> Using pwrseq allows modem driver to be SoC independent since USB line
>>>>>> handling is moved into SoC specific power sequence, and this modem is
>>>>>> used in Exynos and OMAP too with similar setup but they all have
>>>>>> different USB controllers. Maybe you can point me where SoC specific
>>>>>> USB controller handling can be implemented?
>>>>>>
>>>>>
>>>>> I'm not sure I'm following. Can you atrephrase or point me where OMAP
>>>>> and Samsung implement it?
>>>>>
>>>>
>>>> They did not.
>>>>
>>>> The XMM6260 modem is used not only in the Tegra phones but in the OMAP
>>>> and Exynos based too. Replicant tried to implement support locally
>>>> with midas devices and they had some progress. From what I have seen
>>>> generic implementation I am proposing will work with any of those 3
>>>> SoCs maybe with some slight tweaks, only part that is totally
>>>> different and SoC specific is how USB controller used by the modem is
>>>> handled (well and IPC but that is out of scope of this patchset
>>>> anyway).
>>>>
>>>> Obviously, non of the 3 vendors have submitted any mainline patches,
>>>> everything is in the downstream forks. I have investigated a bit how
>>>> this modem works on my Tegra phone and re-implemented it to work with
>>>> mainline kernel (I don't have Exynos and OMAP devices to play with). I
>>>> have come up with generic platform driver which handles modem
>>>> configuration and a SoC specific part which performs USB controller
>>>> bind/probe when modem is ready to handle the USB. ATM this SoC
>>>> specific part is available and tested only for Tegra devices.
>>>>
>>>
>>> Are you familiar with the PCI pwrctrl code that lives under
>>> drivers/pci/pwrctrl/? It seems to be solving a somewhat similar issue for
>>> PCI devices that are hardwired and powered externally. Maybe you could use
>>> some of that code for your USB use-case?
>>
>>
>> I pointed to PCI already:
>> https://lore.kernel.org/lkml/20260518-mustard-rabbit-of-ecstasy-eed3b6@quoll/
>>
>> And emphasized to describe hardware, not drivers. This binding AGAIN
>> describes drivers, so we did not move forward at all.
>>
>>
>> Best regards,
>> Krzysztof
> 
> Krzysztof, why are you so mean? Yes, I misunderstood you and sent this

Just to recap:

https://lore.kernel.org/all/CAPVz0n09ZP1i2tasdTvnt8RvjhALvUYjv9u_EGRtnXPOYQtuqQ@mail.gmail.com/

And enormous discussion wasting our time here:
https://lore.kernel.org/all/CAPVz0n0u7uhL8_FQFiuB7DrnL++ecbaEKEoV7N2PgTVRBVECkw@mail.gmail.com/
because you were pushing your solution. I run out of spare time to
handle endless discussions with you because you reject standard comments
and expect long discussions with multiple justifications for standard
(and documented in writing bindings) DT rules.

So here I told you to do like USB and PCI. This patchset is nothing like
them.

Best regards,
Krzysztof
