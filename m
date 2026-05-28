Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8C37BE86
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957371; cv=none; b=q/RMaf7OtI9y29/9tObMwr/Kuuj2JKMxDokb3RpxIbZKOQpleF2WOlh7Eb9Tegx/6dTfZGU9xJewrjfN6CEm47Yd5sEhXcePUt4LRg9HpHn3Xg9BNgwCX0OvyPSoH2gucbdA0rs/V/PWLHQFX2bdgXEn0GQVBJL3O0Uz9mwAqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957371; c=relaxed/simple;
	bh=9UNntRspjFE8WX/VC4OD1Dp4xpuokktTA18B+ogWTro=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2OJoU37RERh/GNDkT9qXRHRKuKKviP5Dsdjg4NNQwiZ0ox8yQCvjmhl4WJatBGco2ncEf8pzAz0BdPPTQxFMpcJGFePjUrz7FnwKWHmz5FRdbKVScordD2VyTRSYQDUFAtZU91oVNx9titSzo0wVr2QOr2yB6fzX7R05KkkOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bogar9Ex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bogar9Ex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78BC1F000E9
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779957369;
	bh=Jhtv5gfHMhMDDRGWAxzr1d+I0IvsgpMKf5TSuP9K5us=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=bogar9Exs5K+rTPzTuj1fvzC2NqfrSdE4RGxu9ZPDn0C113RVX9p0ZPb/Zze1O2wF
	 ao3AuYri6FrmkumuRByNi/Sh9gU+ffApfop/KlghoXfhlBqC+FC6ynuTlI4owKEXhw
	 dOAn2ony6NT/lHWwdFXtI5ENtnUUVj/UKintWORRy41BS5b+KrUQqWVI63Z3u52E+A
	 z3Rw60FBNpqcXOakSA0eOy8iPzbqO/5iY3I6zVuRUaV9qLJMIR7dNqvKzcYJaOuhkg
	 8+BcUGvKmL5dMomFKp/sQdtfO5uRsuUya0EymhDd118Hfrf1IOkJ2VS4cfeU6JVJpZ
	 8+R8JkkHbw0og==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a995ab70d1so14844577e87.3
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 01:36:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+D7FGbxjCFC0ZahuWaHmeL35Yf5tzMXl3totUgDOmaL7wrMeOb1GX5uFTdZ40j4xGTK9XrxnbzzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTxkb23/t5rEHxXTsDQzvSrzoefJoqXTXY79ju1wfRpi/BwbEl
	ZwrjsNTOgxcPBR5Da9cGZFStTT0SZHuKJIDimkzEBlwrbqKZ7W3fA57QQlsCHzRfIcAeu7bC0xh
	WB51r7n9u6+Utpm6noxUMlpRb/9K+x/+UaQqnTCB7hQ==
X-Received: by 2002:a05:6512:682:b0:5a4:301:b92 with SMTP id
 2adb3069b0e04-5aa323daee7mr6994841e87.33.1779957368708; Thu, 28 May 2026
 01:36:08 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 04:36:07 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 04:36:07 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <2026052710-flagship-unsmooth-ce82@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515090149.3169406-1-wenst@chromium.org> <CAMRc=MdnjRRMVzxPkkrPhQ4dz7rsK8-HKUp9cQ0z11apL3escQ@mail.gmail.com>
 <CAGXv+5HC3dqgcE3KnKzakHHWFHB6m_X42orOkNUvZvp=SL_O8g@mail.gmail.com>
 <CAMRc=Med-_0GSYzoFBRiwFzBCK0DZqJD8_SEBxi+zwR20GS-HA@mail.gmail.com>
 <CAGXv+5GbW0bx3nKdZt2+tHuHyQ-J-1-Z79nMzHAwjmEPGKT02A@mail.gmail.com> <2026052710-flagship-unsmooth-ce82@gregkh>
Date: Thu, 28 May 2026 04:36:07 -0400
X-Gmail-Original-Message-ID: <CAMRc=Me=ujnscSOKhHDLz+ccMDyLyCfZnpqobF2BJ4YowgXB5A@mail.gmail.com>
X-Gm-Features: AVHnY4LBp1nsLqjfLxLqbZp_YoBQEjH0FEHfrkmt_Ac8CfZjzB49fTtbI51YibQ
Message-ID: <CAMRc=Me=ujnscSOKhHDLz+ccMDyLyCfZnpqobF2BJ4YowgXB5A@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] arm64: mediatek: Add M.2 E-key slot on Chromebooks
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 May 2026 19:41:30 +0200, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> said:
> On Wed, May 27, 2026 at 06:21:00PM +0200, Chen-Yu Tsai wrote:

...

>>
>> However this seems to completely decouple the power sequencing from the
>> USB core. Take the USB A connector for example, it was recently added to
>> the onboard USB devices driver. However the connector has a device node
>> that is not a child node of any USB host controller or hub; it is connected
>> through OF graph. At the same time, since it typically sits at the top
>> level of the device tree, a platform device is directly created and the
>> driver subsequently binds to that device. This is totally different from
>> how the hub and other directly connected onboard USB devices work. In
>> the onboard device case, the device node is a child node of the USB hub
>> or controller, and the corresponding platform device only gets created
>> when the USB hub driver probes, thereby sort of tying it into the USB
>> device topology.
>
> Hm, did we mess this up?  If so, we can always change it if you think
> this should be done differently.
>
> Hubs should be dealing with the power issues for their ports, so maybe
> rethinking this might be wise.  I'm just loath to add hardware-specific
> hacks to the hub common code for obvious reasons.  Anything we can do to
> pull it out to a separate driver is best so it doesn't affect the 99% of
> the users that don't have that crazy hardware :)
>

IIUC what we discussed with Chen-Yu yesterday, the only thing that needs to be
done in the USB hub driver is attaching the port firmware nodes (if present) to
the port devices we instantiate. The rest can be handled elsewhere.

Chen-Yu: correct me if I'm wrong.

Bartosz
