Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1A42EEDF
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518294; cv=none; b=M1uEOWVAaEQTgvru1r8sZSocaqwnHfUdImwe5nl9EhlhCo0IjmbJItp0JL4REkdtM13uuor36IsOLplJFxF5GPujvcCz0bxLLat+HC83jkqxY7H8EsWjVEPvAzP6BFmzP1XYsAEQKX77uqyXaWHupnk4ptcJuKLyhGS3v5F601M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518294; c=relaxed/simple;
	bh=sDOXYBEUZnUtmSTyT3uL3mtKxvhVKKfeSDiOOL5ymVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IThKPrpks9T7vH4epD+kWuGIFLHzKgL2SbaEjGDhAK+dThl8q8bp/sfnu7EsT0HRucDpn7JiYMj4L5SQfaYlhg2TvCxAEeOGao3CN+PhzlyidmXBhPF++RJUAZZoRi9/9glVtfCmkyNH6LNY8RoXq0Uv9do0iLCp5/IWbt6fIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3QdqWOg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3QdqWOg"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44a5174670eso2552995f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518291; x=1779123091; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sDOXYBEUZnUtmSTyT3uL3mtKxvhVKKfeSDiOOL5ymVk=;
        b=E3QdqWOg2BKPr/FYoDt8DAu09qtFo73BEYxpFCONlytSAqxTMuaFBd6ZamuHmVPd4V
         xCte/QzP4zzZ/J1F5lUbUm7OMA8ar8rnFU4jmjn++xfcR8irQMnyx+sH9FEvB2QQkr+8
         ygJQLzSn/YQyvAxDLWAwIzKY2RtPHyvku36JhQocReMCZTTD8xJhOmJ07Zehp1i22sSq
         tfbdlu/J85M2IOwUu7n/aLYexNrnFslNCuRtzZAmksAeNoNLRKY+yBbBX6N4TJIVw5EQ
         N/YK/Tm2JfjBvLI2JsqwD9vLhEhDjkA2gTDOarANEN8FGL0kMgZSQaDsDZNAUGBWc93O
         4/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518291; x=1779123091;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDOXYBEUZnUtmSTyT3uL3mtKxvhVKKfeSDiOOL5ymVk=;
        b=Z4uyyG4Up0zchoyA6tTjz606WyHCwXEzoCfW0z0GqRZ+olQayrnSYVHZR+nDmI+jG8
         aui0ONr7I9CQH04thEREDaiHXUio0ELUDrGl1WzF77pWHidzOQAKvVA7cG5hwdPWPP/T
         e+YKryi6qw1hNpwlTQebFQcY2hzyaTt6fkGCm/gtcwhbt/T79VROGZl4BYPZPgYStWax
         5o+cBogg9n0c0OnNVkLN9uq4Cf+2a2g+E/zg4hlRYSOtulLkio6DsmzP1ZOIV7uWDiCG
         QNEmAYA8vk0cpO2LQsojdFCH6367yJbLgoxQryV0r+u/vQuZRF3eqKQeSExBCL/45XVe
         5rUg==
X-Forwarded-Encrypted: i=1; AFNElJ/ztH3fHBfdHHe1r2Hur0Q5uNT72RhLeVgJsjfp4pl1zI5Pv73d8eNcIYxxB8GYSY3BDCCvw62kEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTh3TjRAg/HFWfwsfHz/JFpNxK93uEtA0j9oalkL/bdb+iuHuA
	EyNwKsQMEBXHbEaKiZQBSJwkStqOgPyh3Did2s5V8Pf+4nIRo7JoSV2y
X-Gm-Gg: Acq92OHAPKSQeWUPfyu82whiJkryk5CPc4w5XtdKQStVBcJ7D20QAjPx50FX4ZxmX/p
	NjJIjpOAy6JaKhI0ZM0Ci1/HagWQxWMKlscrP5ezvJOPNNQ/JzK9l4zoMWf2Iwb2n+V6nmwQ1Nt
	6x/MGwCsMic025TrXNyPvzxR9V6GOcJJkzueUP1uvcC0k5/h3x0n+7nQlWkyUnN6mg9iSyFbVmP
	JWKSz8c8uo3HeQDDqdVzCjHaRbLbUhdqLy47Jy5rKbdPq1B/k1K7i46B3urCpBkas7hfDA0eCyi
	9LauSBQK112eiK4yV3Pc/CmqhJSCz3T33PVvgo8CPa8L0xRfwrEa1wHv2OjKc+/G5W/RPNdJ1df
	4biurXx/Wj0Jrx9iyP6Bw7FcasZUMY/KNE/FwZF0YPn68qviLRwqigcdcu+fuxPHJRGnJAmiWtj
	kBRvH6wOYcSwNoggXhtNmQnBvnL6V3znTzf8lQLIW+HrFXci+uWggkbdXXZbk=
X-Received: by 2002:a05:600c:a08b:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-48e51f4119bmr388918855e9.21.1778518291069;
        Mon, 11 May 2026 09:51:31 -0700 (PDT)
Received: from vitor-nb.Home (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e62a2desm452865e9.9.2026.05.11.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:51:30 -0700 (PDT)
Message-ID: <becb54adc0bea88578c8fe4c7c1b7b68bf5cc6d4.camel@gmail.com>
Subject: Re: [PATCH] pmdomain: ti_sci: add wakeup constraint to parent
 devices of wakeup source
From: Vitor Soares <ivitro@gmail.com>
To: Kendall Willis <k-willis@ti.com>, Nishanth Menon <nm@ti.com>, Tero
 Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Ulf
 Hansson <ulfh@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole
 <d-gole@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	tomi.valkeinen@ideasonboard.com, sebin.francis@ti.com, devarsht@ti.com, 
	vigneshr@ti.com, vishalm@ti.com, vitor.soares@toradex.com
Date: Mon, 11 May 2026 17:51:29 +0100
In-Reply-To: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
References: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kendall,

On Wed, 2026-05-06 at 22:16 -0500, Kendall Willis wrote:
> Set wakeup constraint for any device in a wakeup path. All parent devices
> of a wakeup device should not be turned off during suspend. This ensures
> the wakeup device is kept on while the system is suspended.
>=20

Thanks for the patch.

I tested it on our Verdin AM62P. As expected, suspend now fails cleanly wit=
h "-
19" when an SDIO WiFi module is registered as a wakeup source, instead of
crashing on resume:

ti-sci 44043000.system-controller: PM: failed to suspend: error -19

I did not test the IO daisy chain wakeup path, since that is out of scope f=
or
this patch.

Best regards,
Vitor Soares


