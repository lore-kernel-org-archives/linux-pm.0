Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890B199FB0
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351850; cv=none; b=oO8kEz44IOOh94qI+361SEw7iAQpVFaJzZbDcq0VjatFt0BQiU2d5f8mjCVoadYYvpzENwx83soXZ2EmREkriJpKsWaHKr2ejFODugD+ffgPguAdApr86S89TSNObTvaGGD2fT1pYJ9peb2BZRRofhajG4M1HYroIX9T+Ig6DTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351850; c=relaxed/simple;
	bh=s0mbgR1B/3e3hk97RKicR6EngEFS8QxUOV6OgZeuQt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgpUw+skBOSrIlZBXLQ4Y2ngobwJUGeopEZCYgA1yaVLsgLaT4by//3AN3YpoF4HVc21GC7xcxyUvvhRnn0SewYK/ueuOShuKNvfGOcH1OM+gSfSdNtxJV8q2r6VOnZ8RIWWwUV/3W0KSxH9Q5jUpK8qVD89sbfbad8Va0Nt5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b3ATPNuF; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b3ATPNuF"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-96723c7151eso566167241.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787351847; x=1787956647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ibjvuzdx+Tl1DxNX7IbQEnv5VU652wCRXclJCpK/iM4=;
        b=b3ATPNuFhZulHF8Ak/CH25/bEuczjB/oXXm0V/nhJLwB/CdQLBViMDK9JwbU1vcN5f
         DeuoKmJhWGvTMJmTPGudmYHXpbMfUEJiOo+OyLv0YNorCl3TVHluj0QmsYNM+ctyB4kH
         0DNdTREnvo5A6yjspWqgNH+1j21CFyughKbOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787351847; x=1787956647;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ibjvuzdx+Tl1DxNX7IbQEnv5VU652wCRXclJCpK/iM4=;
        b=VuOWsgdUHBXwE1R+DWs6u7NkTEfwLU55xNlxdki+c42EiaPQcHL+WJftHmol8+lANl
         M/aN8R/vZ8JQZpeaohnLcZwMNZvPnDAiwQXPe9YTIUF6GQZ59GCuR/aX24F6Sxob/iGk
         BYFge8WZ97eQ5hQt1MkVu0wHC2oGf6vhgnJ2A3cKxQIPVlVHAv5LmkBrFPB0hwNqO1Y7
         xqMOohIEk5e5s1D8nJnWoGIss5kBejhoF1VcRN0y3LbTqHaAzQM53iMGxR47R3iUiXTL
         VF4pOZWvL6DywmUuY6ZJOnPOe04stZWlD4gc7hOGTBFd2uJeXmeUHuOKCE3R/Z6jIErq
         EGrg==
X-Forwarded-Encrypted: i=1; AHgh+RoHg+/4ljYNVgaOiHTStQfq5paQWegViXB0C35wBOxozFjHGWojAfHk9acI4I9C5/JZapnJCacqXw==@vger.kernel.org
X-Gm-Message-State: AFuF++m0Mm/zjYivRVygErUm1rv0IVTp4iTVboU+nvoKIyT1UoelKOlR
	fK/w+mrYL6zH882CnxKZ+Dj/FQWoXTRlSpfRUS5AFBolA4249dBlzHmPP7Ftsa+HJ/qY8zB7j99
	990k=
X-Gm-Gg: AR+sD13+GbTjUHjannp+MRl4qrjXvI7wvp1LuULdGbsTAXCbqpzxtZVKh5WERpw7f9w
	BL3IB+G3Lyn4qfaXPuqN/BKdnxdE0QINqJTIZdU9VH6tYZm8oyy8CRTYFtdESL+5Ft1JR/L5pqc
	ve+jV+URMouwaYY/om35giDV+7w2bIlL7fI6lPpo42tPLXqIgId2H58BbixvKBug9GPc7xoJdP5
	6h5yukxzvg6wNmrvRcg+UesfowWHYWEt4SaX7M3ab8C1BnrApr6H6WQ/oymBkMwebNQMo0VXcVy
	1SdyL3LFAxdQtkyPn/w4LjiYAVn8I9qjj+kOcU4RxUZ+URjFK2XQWWxfYAt4mmn0GafbHQcEA5r
	N7/KIGmq9Oq3+FRX17UZLvSqh/rkLQcPR8Jm9PKs4ZZdZNJY0dX+ZKShwLDnN0OvRveRBWAz4dn
	t5EUfw260fBnil8WZmnKQ53My857FFBrmQuBCFlMGLSYIfAbRT5zpHRIwT1eJb6aZlvl+OJ+pIG
	dBwMvjcixFe4RCJ5ZryIFLlYvYayyyi
X-Received: by 2002:a05:6102:14a4:b0:77b:a40d:920 with SMTP id ada2fe7eead31-77bd33928e4mr680428137.13.1787351847444;
        Fri, 21 Aug 2026 15:37:27 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-777daea8e4bsm10395468137.2.2026.08.21.15.37.25
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 15:37:25 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-96723c7151eso566156241.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:37:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqMjLFCFm7OuPCilhYSV8bOEhQxtblGky7dIrtfHC7mRmpMEZmL7dvsvR6LFnfmGyYZZyRAWVWipA==@vger.kernel.org
X-Received: by 2002:a05:6102:5124:b0:77a:d089:3de7 with SMTP id
 ada2fe7eead31-77bd0ac29aemr671472137.4.1787351844660; Fri, 21 Aug 2026
 15:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821170648.3097673-1-mrungta@google.com>
In-Reply-To: <20260821170648.3097673-1-mrungta@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 21 Aug 2026 15:37:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UDw4WEGAjr4eY2qoPVbs9h9J1SJU88OjHgTnqXUSwotw@mail.gmail.com>
X-Gm-Features: AcwNN1WGrJG5_bxCdBWoSfRR0lNfg_tXwcq51fkh5y5rtpDnrxN0Z4zNEa69sjQ
Message-ID: <CAD=FV=UDw4WEGAjr4eY2qoPVbs9h9J1SJU88OjHgTnqXUSwotw@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Add DPM watchdog to late/early/noirq phases
To: Mayank Rungta <mrungta@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 21, 2026 at 10:06=E2=80=AFAM Mayank Rungta <mrungta@google.com>=
 wrote:
>
> Extend the DPM watchdog to wrap device_suspend_late, device_suspend_noirq=
,
> device_resume_early, and device_resume_noirq callbacks. If a driver hangs
> during these transitions, the watchdog will fire and dump a stack trace
> to help identify the offending driver.
>
> To prevent false-positive timeouts, the watchdog is set only after
> waiting for subordinate (during suspend) and superior (during resume)
> devices.
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
> Testing:
> - Tested on an ARM64 SoC (Pixel platform running a 6.18-based kernel with
>   DPM watchdog enabled; Android 6.18 kernel has latest DPM changes
>   backported).
>
>  drivers/base/power/main.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

I reviewed this patch for Mayank before he sent it. It seems correct /
useful to me, so I'm happy with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
