Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2635F5ED
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102551; cv=pass; b=fsfATfSwHN/NstRwC9z7ik0ItbQrxVJjYBwHKLQqwFDWToipfEuLjLJoYpHt5vLRjR6TDm1cuBoNtRx1ZMMhEt1VEowr1NGJqgXX0W+h+iJUaDhRW8UoSYaRlWZ92CTG4MQ9MKpaPGCsWaJONaKmCE9S7+Y5C3toAvT4tJVhfoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102551; c=relaxed/simple;
	bh=KonotXRwXiSLQlw6vlTzZA1LY9JAAKMhrEBp5NWp/aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATWs72BFtJRvajskDehFoeByW0Js4UeV4G/kLHAbWXKL2AI6bClfGrhFrPCYaA4e1SVvtFA6TxCJ5xa19uVlrSUpSMbIQG1qxXxeZnGyAqqTeyWHQqSzo05Tb1Bv2j1eD4kJAN4JXpwRvb0TxsFrWRADrMXGL88aViGe7g5vPkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wams1Oh/; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wams1Oh/"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81f36179dd5so45857197b3.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 04:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786102549; cv=none;
        d=google.com; s=arc-20260327;
        b=kQ67tO7ZjaKDzWa/xSpfsBk9oWsyo7ScEHevf5FkwTDrKBt+1a4uV5VSzDgJrsXGey
         eUgdRSP7LuG4q4DsZjHRM7WDU7wuZw8WHNhHpTlTOTPKii4eJX8QW/SpzcXHPpdtZogv
         NMxvnR5Tc0hh/AlNVkxIzK2WZ8qmhH0ewD5tG/u+Jc2lOFNlCRnzHiZTs5uuOMVy8VIm
         RIUuzg8l4RjodHWe1SCnZgOkEhuai7Eaefo5VQU4exZCfBS/1PHjtQqebbzmMow67M6r
         so7fqis2XVpnIODwhPCUvKhrF0K0yBUWWKarkDb1l4wPgKzkyHm21Qnc6j1qpPZU1FxO
         YjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NFbpeccrBLnPNDngnsLUG5X8Bi2l3FjgVOiCpFS3kpA=;
        fh=gTMk58RtMZKySOp37u/W/SOLQxMXayzbRh9pn7G/JZ0=;
        b=orQGEMUYnx/e/XBDZ+plte3PARK5wLDknxWm2w8xv4XEuNuiUsyGOOok5ifwv1WH19
         KNEL1ivlltStiF+ufp1j1Q/biR6/b3kC/bC4AtU2xSgnecfkwjg9C9I7OOugl/GZKLhe
         8kL5SjQqfHOeJGoWpi8h3VVRPVPyDfB8fJVW4UtW3lT0Pi/RtqILOM6FketWAoykEs2S
         eLnN0O6+67/RiCl5uzcI4SjCR18f238RjxWhUb6MNRO3xhRmvCxYIjwE/J4pOsqf7cL/
         xpygHG+rvaTBLmTTy37JZmXwSmf1vAkNGHYYzPFdAVdgHWr3Kph/hXCh0YGNrB8fghB9
         OxiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786102549; x=1786707349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NFbpeccrBLnPNDngnsLUG5X8Bi2l3FjgVOiCpFS3kpA=;
        b=Wams1Oh/sdlQCLJF7zuuMpiyqTXMwx/PwEXGY2kKv8Gumn2dkAL0h/hsk8c2iMXVZN
         82uhxWRw2OmssiEQnYlzPNtTSr+kr89gkEGbU/J4guliIpYBVut+dTDOdS4uXtUpRkxS
         Kf3S731iKJ2a006dJjzxuRmf6X29qiKs0RBY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786102549; x=1786707349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NFbpeccrBLnPNDngnsLUG5X8Bi2l3FjgVOiCpFS3kpA=;
        b=hCej8LxmjbBwe4qH+zy/nOPuIYTmcFMnHg8WCoIPk7KHzTVBrKmMZeF/2aoPaHx6Mk
         5NUUs+aczdrzo4P5vM2cM+I4rl5bAoIw0Sov6VViT7yaI/9lran0Brgfy3rPkngXlG/O
         x3m4uJ48YR1xVdVlOSrLMyGXMSEpKjyE6N6AhUUhnnrRlIIt/DGIM4v7cWD9G354qMZG
         OR5bV2dMUEOWGhB20seXiU4jmxJjNJfCU71ZafK0vkRacqAgF0VVvLNgHw20KVLa7DgL
         FBPMHwVv4xyHXTOXvezzxlqXhlzj67JOPlUmNlADQtYkilWr1o/5kjbOozBjcNMZAW6e
         T7jg==
X-Forwarded-Encrypted: i=1; AHgh+RpS8GWNoyt1cf62fXe8ly6RDzByxC69MInnkBi03JBZO/yy6EgBoQPHFPOYq77SuphnO4qj3mhY2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTSZ6R4MVwpY1eY+BL+gw2M4LFdewwIET0dtoE/fNLiHsg6lUB
	Bs7fuVAscTvISoDO5gfOhG6ji4LsryuvkCfywls0ETenq/6cD6MS6VdfjFTK35YPGh9sE4LIYwA
	aYWr77veNZbtlmBPYjsQdVZMkimVwL4PerDW8Tr3q
X-Gm-Gg: AR+sD10AEh8bEtm/Q7genQKJUNG24IXZu3R06gPJ6r9L4eVnDyB+bj7ccV5C0INWh22
	o1o3Xx3/V7jdpSBJ8EYH5322OHt5RtEPpEXNvkKCpwU9jkr9Uz49k5hDswu3XItWrA0CyL8jllO
	KPEpK9KFqQ5TYWutxA95w+c83OPn9Pae6V6SD0QQmz6raNXdcXy3MxgAWjTflMPV8XBxqCCt9pZ
	ke4up0mLxvbKPVjsrRqjnxy3ZEN2ze3kbmFb0mJa34UgrdSVoGRBHtun+7iVvbdP0q/WayeDzEZ
	1ikbbwzCOTScUc47Qp2elwTLnhWyw6AmwVbvLrmjIOFOom/1rfCcEUXQSpaTScASttZEXPIkmSB
	n/hSUh9idLw==
X-Received: by 2002:a05:690c:480b:b0:81c:872a:5152 with SMTP id
 00721157ae682-82022510fcbmr127613327b3.30.1786102543795; Fri, 07 Aug 2026
 04:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724084328.3943997-1-wenst@chromium.org>
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 7 Aug 2026 19:35:32 +0800
X-Gm-Features: AUfX_mzUutrA5-Q9ACqE0pQ_D7Us70orWiV3KcyO1fjFDW5_he5R56G8cIzEovo
Message-ID: <CAGXv+5ETE2WAA8jwnQKSe69aR=qrqKnALuiSM12X_ZwFouxdRA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] arm64: mediatek: Add M.2 E-key slot on Chromebooks
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani,

On Fri, Jul 24, 2026 at 4:44=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Hi everyone,
>
> This is v7 of my attempt at integrating the power sequencing API into
> the USB core to support the USB connection on M.2 E-key slots. M.2
> E-key was enabled in v7.1-rc1 with just PCIe and UART supported [1].
> Hopefully this is the last revision. However the pwrseq patches haven't
> been reviewed yet, and the fwnode patches need a review from the fwnode
> owners.
>

[...]

> Patch 12 adds matching pwrseq consumer by "port@" node to the M.2 slot
> driver. This is only used for the USB target, but there is no attempt
> to differentiate the connection type. The driver simply tries matching
> the "port@" node first, then falling back to the port parent or device's
> node.
>
> Patch 13 reworks the power sequencing targets for the E-key connector in
> the pcie-m2 driver to add targets for USB and SDIO. The former is used
> later on in this series.
>
> Patch 14 splits the Bluetooth power sequencing unit so that the USB and
> serdev consumers can separately toggle the actual state of W_DISABLE#2.
> This patch is purposefully not squashed into the previous one to provide
> a clear target for discussions.

[...]

>   power: sequencing: pcie-m2: support matching on remote "port" node
>   power: sequencing: pcie-m2: Add usb and sdio targets for E-key
>     connector
>   power: sequencing: pcie-m2: Split Bluetooth unit based on interface

Could you take a look at the pcie-m2 patches? These are the only ones
that haven't been reviewed.


Thanks
ChenYu
