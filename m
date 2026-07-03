Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA53D810D
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085170; cv=pass; b=qDowUGfBAzcuAC2fxXMP/SCMu5dHta5wZH/kYNot7ekgm2cWB9SVkQu4A38UiycYMtPDSd3Q+ngxycZNcnj8Xy/qzd8sCH2NtMFUYlj4r8j+CBZ3DUK+jF0DW2DF4W463UQ0xlzJ0zHAvzGl0ztCw8TP5BA2DXQEHOGmvSRpMF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085170; c=relaxed/simple;
	bh=P4zhLhFMp7O4gmnRm5uDgMPugvo8rGAGH9W/oNg9Rsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q95s6ja7ZB8SGSx92IAmZQ8IxUr0zeVNHdIV+2huIhAVXRm8XmS2g2E8VPLHNHtbANJnQZXyHzm8JNaeu0Xwby6HpgdyGaXV0EwwFsMCQej15prXiGMziEN1/XUudZeOwJWF6C7p0gOaLwL/KgALhI3Ebe/yurFeYqsngxAsvNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KJrt8HfN; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KJrt8HfN"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66628618509so777625d50.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 06:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783085167; cv=none;
        d=google.com; s=arc-20260327;
        b=FiJPtDWeGW9nSdncG4oaZZRR3bb34HnVjRr1PYgyCmw7L1DXrVg34BNUdVictbKBwo
         BTacLOeqH1t38X8T7iikI16roBBnLXaZZm0lxgcEMYuzc5QcYM6SodNWZJyHfu6oeLUP
         1Th7jGqxwTLGwcEvqV5ex9RbPnsjus3VV2I5jnzY0qzoW7lFQIsN9yGQEvy132nmuXzO
         QccjIuGnYOmQyd4GD50UWxr8LYxQLszjK7Zl1jBQT1PXkhECa0EYy89aD57NQs8X7qJL
         v/ShuspQ43cvv6YAiOhAJVU3enQCu/XuDC04vbLw3pNhXK7jDSJC0IOhq3+bNf9GjKgS
         7SHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P4zhLhFMp7O4gmnRm5uDgMPugvo8rGAGH9W/oNg9Rsc=;
        fh=q4skgrFBozPaH+UQplmMZZRdQs4jmOIjxaiHenfIWEI=;
        b=PJ6pvAF8UlYmrZavDzPQ++SaA+TDlj2CnVZrtsP9xOcaa8ORwkv2IIED8KPM9opHGW
         aac8Aw0SIFDwXSPmgMn+I/9vi+pAc3Uz5/Li1hJ2OW8bVuBb7eiXU7al2ZNV5wrNl64P
         Q/ZxQzKSQq/qIoO40rgFDsl1thAaKOFkJhrRN9tKgo2A7nndXFrcnjIgUSNUXWjvExFz
         ruTTylueP2c52hNKjeAcW4N8eYBF1sp7nkzDj6qAXxK8hTczc4276ko6e2/ZoZ6AgDE+
         2AgW+xX59fDXH+k+ADCj4zsNkYZ4n/3j7pVfN5oY12Sdloi1l3/QIqg/VqDu2gm3QlGS
         GoAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783085167; x=1783689967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4zhLhFMp7O4gmnRm5uDgMPugvo8rGAGH9W/oNg9Rsc=;
        b=KJrt8HfNHAIjRwl1rngsaRwQF/9FG/CBUQfLIs6l/S0TOIfaVompOtGsf8X3bPYz2D
         RpHkamXeIR2v+GJi9wvXvM4EG3fqa1ExPuTLfmCtACLkWQ1SQRgq8Jnf8+Y6no5X9ShD
         3ZnIRWkysCQxSmaWU1XoTY7M6QhPv0auFgUNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783085167; x=1783689967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P4zhLhFMp7O4gmnRm5uDgMPugvo8rGAGH9W/oNg9Rsc=;
        b=MphX6EL7gEXBSEBMwRPng9DwLKP3V+Y1fi+h4GhdIY1meNa2wUJSEenVVpmH+RXVjG
         5uq2BMiV7qDz7xSDJTQLIckPd43OnTpCQzMlfx0tdIoFj3OLCmq6a8AggXTGBwAHw5WN
         X8YPHZakBrSIdC7yQR/+OMVcGVVD4V/LPs5pLkCu5j6E7O+XLsNQcfGlbBX3Cyle/wWG
         ed2QI3RnOZyiowzBHP+UzT0WXP/f+4iiiaztJ2GbF4UEyh5Eq+FxYSkV96ca2oEkB0nN
         2nDVbnuO2nNyZUqdokV4QvH61tJeeQnsFGbrb4buGwiwx6JlWKrN79SoiLwhKm8FbOIX
         WMOg==
X-Forwarded-Encrypted: i=1; AHgh+RqGPRhX3WKVeNEFGVlE/cRIBQUQ0NDXXQpav4qT0VtFtBbgzk4fnCRTgYDR8HOxKNgjna6SsGRRgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtWaKYz1P/6quaHjAskewlZYvaQoEh44TRPLWQCPD+IbEexKS/
	KshXvjYwjIqng/aC+a0/+hdQiM5wfF10/kL0jVx61Wz8bOL/6gI3CveJTabCS0pbGVAaZdFAd/9
	hYjLhu5rM47Q2NmkcBIQ2RtBsJK+Tl3utLZ5dsd+t
X-Gm-Gg: AfdE7cnLLxRMw2PClhSlzdhhfx9Q67ml3sotYa5ezgCoyMMTjosyaeEC++Iep7QB+Ot
	gFnkVsPkPafbgVQCPTLfUIgfhfX5ffTaL6lqASwLw1QYLR7cMELB3VxM2huaP7SVkOakfqoSMAd
	eH+haxn4p2tL4wnwyX+NdHhg3tVlJCeb/DbfMWgoKPrdQA8QHNRVvcuNEWHIouucc0bq9csJHA9
	jSdG9eiVxBKuZs32CMkDzoz9daceCmvN/Z49TZ7E6x7RscYvP7EIuq5RG/VR3JYVhbu1evDMD0k
	ij9yUDc1Jkmm+tlqSH9wskIAnf8d780RkyfT6Q==
X-Received: by 2002:a05:690e:480f:b0:664:fc22:36cd with SMTP id
 956f58d0204a3-66521ad34dcmr7426372d50.43.1783085167252; Fri, 03 Jul 2026
 06:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-6-wenst@chromium.org>
 <akeyxn390mVmYo83@ashevche-desk.local>
In-Reply-To: <akeyxn390mVmYo83@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 3 Jul 2026 21:25:56 +0800
X-Gm-Features: AVVi8CePOG6OpnrlSpGFhkpL2GOtwCFUk_NB8IIc5qFTOLO5i-BW3OK69XKCfdo
Message-ID: <CAGXv+5G3ETTGbgjWJCbQjn9yvRamx4GHPxjWPgmy_aXWUxm0iQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] usb: hub: Associate port@ fwnode with USB port device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 9:02=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 07:03:06PM +0800, Chen-Yu Tsai wrote:
> > When a USB hub port is connected to a connector in a firmware node
> > graph, the port itself has a node in the graph.
> >
> > Associate the port's firmware node with the USB port's device,
> > usb_port::dev. This is used in later changes for the M.2 slot power
> > sequencing provider to match against the requesting port.
> >
> > To avoid potential conflicts with ACPI firmware nodes and then causing
> > power management issues, only assign the firmware node if the hub's
> > firmware node is not an ACPI firmware node.
>
> Now I'm more confident that it does not mess up with ACPI case.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you and Bartosz for the reviews.

FTR Sashiko pointed out that this is likely leaking a fwnode reference.
I will add a fwnode_handle_put() call to usb_hub_remove_port_device()
in the next version.


ChenYu
