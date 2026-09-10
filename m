Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080851E452
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059748; cv=none; b=SWDAMYnPe32NPQLaEg0k7qsWPWZnJcmS4aCTG0ZL8RrKojLgRqdNurjMbhMew99LmAtj7uogPkhmblsg1Mj0JJQBtZQYXfF8g53WH784+FrruPEiEl2pRBgt7X5u0JDhRdDOOEoGk8LFDHp9Zy3uqDaklNNLoMas7yAiJXbROZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059748; c=relaxed/simple;
	bh=Sq+3ZPDvtDiwDZEiPtzE5bg4NQcIOhzYCUKUumcK7+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KO+2PFefLHnsnkAv7vudan3Zgv/4NFy1nR4ytT1X/M0tcVQ8sJWQQFEA3wVvgGU0X45KkgQHgHbTLAkzMM8WgShl/8oRko05C9GVepGPzOM1D9KrwqUbInb55CBHxeI5bsTaoBuAkhmaTJJmMZ9hOQW3esWEDogtqgpHPqwwT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bQFvE7Uz; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bQFvE7Uz"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a309f92daaso59935911fa.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789059727; x=1789664527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u+7YvFjPPo9k/FqxxQZH7F6PYUlcKWqkhxEgYotuD+A=;
        b=bQFvE7UzvMwuB1I/cVlI9zCVrj1IiEkIEUyEUbXQStrMFw4o5G6LL5M3K+b3450w3Y
         qyEbVBepqrtfXT1rvTq1yddI6QtJ1en0tIiTdVk7Jzuf/KY5Spgipzp7azQPX7ltl0sx
         bWgGvkPLaOQmju7PFTQo5tquqycUPUj5w+pPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059727; x=1789664527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u+7YvFjPPo9k/FqxxQZH7F6PYUlcKWqkhxEgYotuD+A=;
        b=Qynxk2/CxrJcY7eYcFGaj1jfDDz3x564NeGDNwVVcDNdnAfNXFvCzu58/FM+PcVbzr
         eXWrnEQDxiMQR88aGf6oluNTI9QWBVcvfQT+sJFQpSCnV0esNhaXGSbtsMgpVOHVevST
         fSAhgRMzumjANhj7oHwFltqZ7rLypmBkrKslzlnzl9v431LFZdZmN72RAle3hCa/CWxR
         USZrd//Xv80tvLz4sUZHx+K6cYWK+i+++AUbu3D/nqWgCDufbvUSGDbPFzjSYp/h17UG
         CewbYQkv3c8tk6qG8WbkIbNrzb0Cdn4eM9dGHDzvlgOPkupKy4bCCcnMRXrnWPuu73NL
         1LWg==
X-Forwarded-Encrypted: i=1; AKwUvBwDeMVi2v/meptZt720O+idD1xkdwDeKQyhikHsEviZ6MHh9rkFgd0UMvgLCqvBkBSqizXJB84Rfg==@vger.kernel.org
X-Gm-Message-State: AFuF++kWEBo6tGdDp5W2n7b5YWjbRL4UwSmhpg7+BbG+J6gTkp28+CQZ
	0ooWDVnk4C2FXquQ0GySSXZrNKrnFQS734JUc78cPH1H8dTxMaZ2LCrdL7gq0DGT2iklKJsdvD4
	FvxkQng==
X-Gm-Gg: AYBFou1IWaj24++hS0vOmHCgMjPy20jgMZvYt4h4sIb9Go7PHrEmgzaZQGCtTxo5NEY
	SeOprJrgHIUKTh5oGzE7cwMgJEyTgcjK6xWnKsLHnX0hYxB6yW+FE5LM5Mc915hZz3t33fNva1q
	zP1+GQ5FSiO4ORugkq2ATm2QjQYOiJIO8I+PWQXIy+7xCbcbKPkYEmKIabVHvo+C7OWqDzNn5af
	s+yTo+C+Lb7HxBFdZAWHRS4SMdy/v9rDYxvcHODFyh9h80N0/801/66JZv548HXUKz6C+dfltBh
	qRznIDzDOoUC3qLfJzdtyc1tQAJfeBTYtGLuKQBf99oAFfCdBXgShuOxvgARkhok+lEsz+ueevM
	FoMmTkKDE/ruTZGkfoKGxcHUQkIDEa3vT5auzb0G8Th35gAJ3auSzh3CatVBAbncUj+B+eG0eZn
	W3J5uXAiQTjxzXCxFuQ0UR/5lWHh4rTwFrK9AhNWths/djroI4D0VnLjb/OE5M5a9C0dxOdRcoR
	2wH9ym7rLo9dO4BpNff4iJoP4v3yJptw0C2mjm6hsiqh6EN
X-Received: by 2002:a05:6512:108b:b0:5b6:bea:f097 with SMTP id 2adb3069b0e04-5b8a02838c2mr88237e87.14.1789059727275;
        Thu, 10 Sep 2026 10:02:07 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a047aa1dsm14426e87.75.2026.09.10.10.01.54
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 10:01:59 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-486e835acacso267750f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 10:01:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx9D7zVJo/thHs26i2iLkhVRuoMxP6/ApvbwySyh7EpwIC+V/ZDxFmOdv9YvlmFbWpo9kG+GDy4BA==@vger.kernel.org
X-Received: by 2002:a05:6000:658:b0:484:4817:85db with SMTP id
 ffacd0b85a97d-485872b5c09mr38411439f8f.14.1789059713626; Thu, 10 Sep 2026
 10:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909224818.2177311-1-mrungta@google.com>
In-Reply-To: <20260909224818.2177311-1-mrungta@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Sep 2026 10:01:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WFBmq3kniULxcXNsKgY-Zrb82JfaX5uRWVewQi_tJyJw@mail.gmail.com>
X-Gm-Features: AcwNN1Xl_nzhNtJWsI6953UZiPelgeSEkWzryufpn6N_ETw7Yj-N-KcRVJNqhak
Message-ID: <CAD=FV=WFBmq3kniULxcXNsKgY-Zrb82JfaX5uRWVewQi_tJyJw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: Add DPM watchdog to prepare/late/early/noirq/complete
 phases
To: Mayank Rungta <mrungta@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 9, 2026 at 3:48=E2=80=AFPM Mayank Rungta <mrungta@google.com> w=
rote:
>
> Extend the DPM watchdog to wrap device_prepare, device_suspend_late,
> device_suspend_noirq, device_resume_noirq, device_resume_early, and
> device_complete callbacks. If a driver hangs during these transitions,
> the watchdog will fire and dump a stack trace to help identify the
> offending driver.
>
> To prevent false-positive timeouts, the watchdog is set only after
> waiting for subordinate (during suspend) and superior (during resume)
> devices. With this change, DPM watchdog coverage is extended across all
> phases of system sleep transitions.
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
> v2:
>  - Extend DPM watchdog to device_prepare and device_complete callbacks.
>  - Update commit subject and description to reflect coverage across all
>    system sleep phases.
> v1:
>  - Initial version adding DPM watchdog to late/early/noirq phases.
>
> Testing:
>  - Tested on an ARM64 SoC (Pixel platform running a 6.18-based kernel wit=
h
>    DPM watchdog enabled; Android 6.18 kernel has latest DPM changes
>    backported).
>  - Verified hang simulation in device_prepare and device_complete
>    triggers DPM watchdog panic and stack trace as expected.
>
>  drivers/base/power/main.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)

Thanks! I guess you dropped my (and Tzung-Bi's) Reviewed-by tags
because of the minor changes between v1 and v2? They look right to me,
so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
