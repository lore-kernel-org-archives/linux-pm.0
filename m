Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BA4BFE62
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994846; cv=pass; b=qAEOaCQJrUwTvxMywHIDv0ETht6vIFbuGVruA8JssGzmcWbwO6BgkUEa8z3YRPeIBAYFZaraPz8ekix5kVksQjJhSGPiIbrjzuy8ZVUSlniQCi4cmZcWERF6VX5PF7dPnJa5JJDZvLLFKErArD0VP2lY4ASPOwaQuMPPQ4HMo9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994846; c=relaxed/simple;
	bh=NXBFaKbrMXgpNZSE0VvaGOO+KxvWK2WriYgkvV9RiI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC8/tPMZtAlgdOS1IuOBpM6ZDkYF6O/EkoAurgHzkfAE7d67zOTr0TzLZObzlcxO7N6+3PzI3ncbVHe+L4alBzSu3o+gJASa01YsvR9iWcn/eb5YX4WQN+pl1jBMFixLiaQxP+lSSo8BAo35jaoDyOLZiOrelHbbiqLH3MKIemw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKSO7GuV; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKSO7GuV"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f4e596e393so6573147a34.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 16:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788994839; cv=none;
        d=google.com; s=arc-20260327;
        b=K1RoXaP8ns+5NGkk6l6rf9U3amalBzxkKUOstQxma7m1KOrIMk8gCX1r9YYEfWVDWK
         zBFL4wnXCdhBSk0zZehsQ+O95yvo5j4mevTCe+oThqsp459FEuZMgnhLgSEOMEHb5DQL
         OJvjdHnZG9G6E24kwqBTZp3zs1fqINFVni5aQxf0nH8g0/XuKGMR81dAtgt9ot71QvE0
         ZWeRxW0BWwgPaSaRWFhaJjVaZMN7m/bgJL36BR0Phr7/9Ryx6kDoMaJdlQdjeqFCPd9B
         p0HxL0umF3iYzwfqBu3cTEIe9dOHN6yCYQMBF7NID1iCFgPypPGP2830Y1qTQWYhXb9T
         47IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lAmP6gCex2m0d1z+kgD25ttLxjG8ayMhj2asunqw1YY=;
        fh=yPig1vN+Q35DbAyLLyXbEPrF3pMI769p7RpYCsWY1OM=;
        b=fVCiDqkI8dtZFEIAgWDH21bY6/Gb6YhorVLKn+KfnHApP1uF7y0Jp2jyP3yvU2gg43
         79RMquzUKTCFaWGyF/VvPexrosP5cFbxvWG1nKX3uixeyYLYw+LOWUuyuSTOc2hMo17x
         sMp9Beo06OhyYHFsvoZFOrslZmSdtpl2ff7u3/Wurw2YW3zxYFJYdvxZ27W5NNqqbrNt
         9sYhPG0b8p99+M/6ky9qrjR1S8py/Znw+G2DHdOqDPttuCIVrRKfx+6xA3HNL5aHZBmw
         5hbYbVqImQgDSN14Wp/9RlDL1O/A2dTKD28a+kvAkRde7ONHD+Y1yPCuvfQ9KDPk0CH3
         i5vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788994839; x=1789599639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lAmP6gCex2m0d1z+kgD25ttLxjG8ayMhj2asunqw1YY=;
        b=vKSO7GuVqvsPI6c+H+TCteHWCcZbZ01iNJESqb4t/z96PG80U1iNHZ54ltdHmGmJ+m
         i4gwUwoDb0F1caW3kIh/otsirHAYMompZ6SxUIoJwnfo1/X6GdLq7zsil0VsxL4uB/6T
         IK/+ktqfQHsS1h3sTvxhVr0pCdQOrh+UnFUZDkxxbx7Lo+ruXDQi2IA88tmSD/LkMEAf
         yEhqWzywwLyVY+9ImwPg2tCiivNFHddwdbFW4qUko3KlbDaaVrr7ddZsvkAhXvNRFNvT
         3YSbNFr7XcC7jJbYJnhLE6zG0lTCBsmvjjTeGmKn0qx6vuk6XSXIfHxXBkl7DnFIb4Sq
         G0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788994839; x=1789599639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lAmP6gCex2m0d1z+kgD25ttLxjG8ayMhj2asunqw1YY=;
        b=kxyh+t1kzPQmCb7eHVCPIKvCdX227DzEYnGuuyiRQ19YvxcQENER/HQnbgGh5wUVBR
         0il5vOz64TLlA2g9E0EXedAsRsd85YAaU3bZ8jy2Yp3yjRCq1vAdnw4FnPTgMmTOvmlM
         sW9OCUIl659BR0Vawfoe2sZTsGX+LHejETMLkiHLFZHvddCJ6jXeO28LP5HaMS8ByvHB
         B0neJR20m25/9CXRz45z8mKACv/IjOW4N8hra1FOdDvjro3Wvy6/LXKLyw55WxkZPQVc
         FxoEsws6cEwLL6u/rmkfmF8s3lbnIAqMpIwmikqTxFtEa3OssZgqJlSmYXvrlO8Z8kEd
         3OzA==
X-Forwarded-Encrypted: i=1; AKwUvBy4FLhqIQDHS7nm2OPVSS0+y+mfHydjwIszACdMEGeA40cXR1vq1UXoPzP3hRIOR+akvf5OI38hcA==@vger.kernel.org
X-Gm-Message-State: AFuF++mSmBtZUpi8FXJ1xULvqB/maHifc27sMGTxupPMVfSBqQhAvPLt
	cytj9gMoiPXxMFSekaCBq8Nm5TS//8Fo9qBD/Ih6e3dLYP2VgWSyB/+5jGRKRMvIfedSYIN+p5q
	8bFCMmgVmUjViLaWsxgoHnIlZG8L/L35hDZOlUJK4
X-Gm-Gg: AYBFou1tS7INpuo4yAAorHVa/l8+EuBZ8arZ73jdWf1yhZn6inPB8uflET124vIq9YF
	NVlcD+nEOwvCACFVv35RW5GMUJOmXKpsHtaPNO+A8evGBz8pEMNJ4IgvI6rZfPHQUTYbtBeiEBE
	19S+zmXXZ0olCiWYwM09Woy9dipTvGCHQO2TSWfKejGlFJfgAsYY7Xtis4pWpKXhD/hAUn7UJzw
	cDGwsZRO5d7/2QScGsziAitIRyjCITIu0mwHnfYToCNAm7y6s1zEQtd5r73s+Jgll4h01uT68+W
	Z3J1iLCNnIN1vVsKRtAp1RAoXOYmoTljBpnF6j6XdKAR80aqPEg1isE96dCVWwqEov3znH+9EZ7
	6Jc9VARUTeA==
X-Received: by 2002:a05:6830:2702:b0:7f4:effa:a5c4 with SMTP id
 46e09a7af769-7fa1dd9705fmr26393425a34.1.1788994838309; Wed, 09 Sep 2026
 16:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821170648.3097673-1-mrungta@google.com> <CAD=FV=UDw4WEGAjr4eY2qoPVbs9h9J1SJU88OjHgTnqXUSwotw@mail.gmail.com>
 <CAD=FV=WqPTXKB2NgPS2hS5_9tdQbUyfXHFOARrX3rjzFra1Z1w@mail.gmail.com>
In-Reply-To: <CAD=FV=WqPTXKB2NgPS2hS5_9tdQbUyfXHFOARrX3rjzFra1Z1w@mail.gmail.com>
From: Mayank Rungta <mrungta@google.com>
Date: Wed, 9 Sep 2026 16:00:26 -0700
X-Gm-Features: AcwNN1WuSbYGIO1o0g3lgIz8ZkkgMbP6sKFaSFThY6hnOo5VMDykb4EDJC3AP-w
Message-ID: <CABz7rdAzp3g=auu=2Fj96B_q2tq3A1vEps3CJv6EsnXgbrJLcQ@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Add DPM watchdog to late/early/noirq phases
To: Doug Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 2:15=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Fri, Aug 21, 2026 at 3:37=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Fri, Aug 21, 2026 at 10:06=E2=80=AFAM Mayank Rungta <mrungta@google.=
com> wrote:
> > >
> > > Extend the DPM watchdog to wrap device_suspend_late, device_suspend_n=
oirq,
> > > device_resume_early, and device_resume_noirq callbacks. If a driver h=
angs
> > > during these transitions, the watchdog will fire and dump a stack tra=
ce
> > > to help identify the offending driver.
> > >
> > > To prevent false-positive timeouts, the watchdog is set only after
> > > waiting for subordinate (during suspend) and superior (during resume)
> > > devices.
> > >
> > > Signed-off-by: Mayank Rungta <mrungta@google.com>
> > > ---
> > > Testing:
> > > - Tested on an ARM64 SoC (Pixel platform running a 6.18-based kernel =
with
> > >   DPM watchdog enabled; Android 6.18 kernel has latest DPM changes
> > >   backported).
> > >
> > >  drivers/base/power/main.c | 25 ++++++++++++++++++++++---
> > >  1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > I reviewed this patch for Mayank before he sent it. It seems correct /
> > useful to me, so I'm happy with:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Since I reviewed this patch, someone pointed out to me that we should
> probably also add the DPM watchdog to the "prepare" / "complete"
> stages too. I know those stages are used less-often, but it still
> seems like the DPM watchdog would be relevant there. Unless Rafael
> chimes in and says he disagrees or that he dislikes this patch in
> general, maybe you could post a v2 patch that adds that?
>
> Thanks!
>
> -Doug

Thanks Doug. I have posted v2 with prepare and complete support here:
https://lore.kernel.org/r/20260909224818.2177311-1-mrungta@google.com
