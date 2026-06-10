Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D013B71D3
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082039; cv=pass; b=XEXNxLkURaATor5r/JKNstYvpqL6ANp6EVcyJNU+U5nyhhaq6L0ASM/XZPi4pdlcduNtP2McC1+5Pw1FDtQvF/rnB99sAXy1hZMOLQF6geJhXmlRouGAHyOAtfVXjOWS1PwpT1hblo4ErvdQP2O6KZ6rlrDpuDaGYuzmjbTqGPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082039; c=relaxed/simple;
	bh=nrbLcQyisI1OEjYF2JehulwALSIbAajyo9F3M0zxr/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8SIXHwsWQ0yX2GZlW3obm0T1QCGwexqvzoVVYMFzAu5k5jf6bKMm3Zlr1cfrd5Rc/kAHePXEIGAEaYWtnlo0QABr1UqoOX0m4Shrb65yUoIcXqgUb1ROixx3X6cpC4MyQZTrEDXOLz4jMZzma+Q4W7eKUp3lbaoS+1KvHi2/ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JM47VE+p; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JM47VE+p"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7f4f1c27e61so2593747b3.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 02:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781082036; cv=none;
        d=google.com; s=arc-20240605;
        b=VWSDJIUlt8pUFU5tmGOmESoV6W+5XQfAujdGabbZpybVF9LYhXU+1itMz+NrEawMNe
         HVrTLG++KWy1hkr7qBJQQHkiLs7w2oLcSm/npx1AiA9SgATrl9ZNHQl9EgI7DeYBz2rN
         nX0i9IZ+rXbonzjNh8s7teKDv8PyRJubsO3P8LcEg++rG/dX2F/QyZ1mwL0dhW0EnXfL
         VKNMGmDk6iTtxDT74B9EHE4lObwHNfxZVAAsBepW25o7xpSMAsVsMDFGjyImjcTjiY1G
         h8n9nszQInoCG7Q4HSZzxdozgUEp76Zr5T69wHDs5MQUCNk2elf8xCcFpPaaNyFwSe6t
         gbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nrbLcQyisI1OEjYF2JehulwALSIbAajyo9F3M0zxr/E=;
        fh=7KcbfK53VRjUPWItsce/iuJpk4vdt/8htYxEQRWo9uc=;
        b=icnm3Dq65j5JE0h7gvku/4MB7ZahWKSu/mSYrYkJd1xlTNPNmp+IcCZ/3Hff+YEQhP
         Oszg+LS0TT9qTvq+PewQEtEwSTTdrQdd+O3fPp81VXoUOVoTzA9pOWEBRFHcnKmUMNqp
         pXxbm+v2b+PeFFy3I2GrCDSdD15J6oWAMWJmomTlT6TC1wGNRZLOWKSQzXIn+NO4Mtcu
         UppgsR4S+Gs/VJrYRVwKEUbFh4JddlLq1tCrwLdFQhTX4TowFTxbx1TiyIWJtxXbyrO9
         tySjZ/JKOg1sjMvWKIGa1bO3RGAEWdRGKAPe1hoyYdwNEA3U9vHz56VyWk0GAxGmKQiS
         /3AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781082036; x=1781686836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrbLcQyisI1OEjYF2JehulwALSIbAajyo9F3M0zxr/E=;
        b=JM47VE+pTX3gw4C4IqeUOn4nmEfUkqj3BhcRsWStNB9h52+gjMyxIOyNf+XNwWLpDQ
         xnNwnQd1g/rPNmVO3tuZgcCTJynAXUyqk9C8DfRAiAp7lNy1zplysRts1mKBSDBlynrZ
         a/E0E2SfUIldDcKVi275zb6qjrMEdjHrbWEac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082036; x=1781686836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nrbLcQyisI1OEjYF2JehulwALSIbAajyo9F3M0zxr/E=;
        b=ffTVmMrBv/wIeZsZ2GUCjDxRfmFwQuTWMq1EP39TyQx1GHatGs6l0sSbpdhwOWeXKa
         Th6FruJ4kQZqFN6QqglFqiLogwAaKWG3GarSUIP5khFh9aBgsleA3isrZJiOBGf9TvkZ
         2vqpfLvI9hJ6k3Qt/jydn411356dIK+Al1VMsHMxqkSr53PmOy7e/9/1UD8TpMHmb6p8
         2zRA041NMHMniuLkYwFvc90iEI4x+UUGDkLlE1AALI2vgVlnPq2YnTfg7I4yUicm8obV
         VTYvAKRtyvcprOKQG74jtqKcf3FC8l+uD0BYJCwDLDE7d/L+bgnolYnuDl+GAn4RhXlc
         HQ2A==
X-Forwarded-Encrypted: i=1; AFNElJ/YhvDn9wapEP9JJMUdAdxxCm9NpOK+3sKMUZYJUasIujH2HTqVD9oCiFmIkU4mn2bHV8SazV1OYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXEwDn7kd+ZCVSj/4fsmxnc5+PBX8bnEzgTXorBKNIJllIqDYu
	Pj2mCL7IA6XkCto25t55DsWQR0OVRxiVqIzGpWUnm76ARQkCx/LNX2YsWvla8ohYMxb04Pl3hpk
	2N94/NsTaE+/R+BOejcGpIVc6/ahxSpfN/Rk+eIoP
X-Gm-Gg: Acq92OGKinJGJDg0Swswbw8bsjZAOE+1UnWehX6iPIvBAWmRLqn5S1X61k3+BRL0yGu
	E08KrIczYkWA3WNB9/JXcv6pWzDdfrVyvlcKIkLzXUeMOFhOnfR/s61l+HIKMHZIpjVLjp2LbSy
	JCsgU4wYwyYSt+AIrT8Yfp9zO2Pe2aoDulT+Ls/qBoU23x7A9lidY/qmkwgZ6G+t7FEbCRoWts0
	HM5T/YlVIbANYEfQkhWxaiwa5FtEkbgJRzsdREqPE5DUtNFQZ9bMgCV0i6EdyAUA4Y1/JNfJM/s
	yCw5maKYIVbou0QW7TY/dAUQHDLW7w==
X-Received: by 2002:a05:690c:6c08:b0:7bd:8d1e:39fb with SMTP id
 00721157ae682-7ed0a4ed459mr225795957b3.7.1781082036496; Wed, 10 Jun 2026
 02:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-4-wenst@chromium.org>
In-Reply-To: <20260610084053.2059858-4-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 10 Jun 2026 18:00:24 +0900
X-Gm-Features: AVVi8CflqNzYUTj7jVe9ENVhBouReNOK4zYnRNLDpQhNXfjJp66LGpOOH45Xjpg
Message-ID: <CAGXv+5ENxq3B63M-HnW95we+2r+WLfCLm5TZ820zWiC8FSakSg@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] power: sequencing: Change CONFIG_POWER_SEQUENCING
 to bool
To: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 5:41=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> USB support, including the core and hub driver, is bool, no modules. To
> be able to use the power sequencing API in the USB core, the former must
> also be bool to avoid the latter being built as a module.
>
> Change CONFIG_POWER_SEQUENCING to bool.

As Sashiko pointed out, CONFIG_USB is tristate. I was looking at the
wrong symbol. Please ignore this patch.


ChenYu
