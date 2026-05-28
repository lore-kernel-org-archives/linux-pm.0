Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88637C0E4
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957607; cv=pass; b=XVW9yNBF2d5UtkXoGQMdFWY7TNcyUEhtUIqPuLQC+R7evM9/pvWj1NrJgFwIL5A16+yXAAaYkEdnis5woTGRQXISmmTEkCkFhAsJ7Q/6OFeeU7mv9csHUrWcni5cYDoAmwxi8h1pyp8mx89hOxW9u6owJ2wBL8GeZ62eSYgP1rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957607; c=relaxed/simple;
	bh=bMVYCHW2rA/kKGjqYMY6NUZrWJ1hytGHa1uCrkcH62k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZA3YbBb6i3xttIKNWa7hvbNfrfSjm4bfv6LvMg+KG6PFbym1BbBEjH+I+uyld6kTeO+lErv5RjVWuXfaekDxpCxoNVvTCiuNBG89cdKD5wmkUR9gFTkEd8MEaAiz84elQg1SSbOP81vd69c0KlbIxP0jFSleTPflkX8mFj9E9XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cXGfUXPo; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cXGfUXPo"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso7297208e87.3
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 01:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779957604; cv=none;
        d=google.com; s=arc-20240605;
        b=kiADKmPMozHBpJQNnCZ9xPjHohplpz/aPRc120it7sEV4E4WEU5AgGWmhInZe6zpHO
         3JOObccXUbWoOh5iUWbi05gqh4UVYfK60bwhedA1nsj/dxfYWgbqqSqn3kvQzTCNA8uy
         jcuDX2PBMizRB8Di2JDt9g4whjbR1HfZ6NRTW5uW0p5Mf6GB8N68NU9IO1mw3krzJLqV
         ICPXvN3sEobLuitPVZDN6V5qoWSHWe+rdjEE3Qvi/9Wp01LuzNuuiXWldDLXE8jbIq3L
         oZ6IEziP9CoDD7HoxHvxFK68Qe/+KNRCChvYvJsZUuS/wLYQpSoJ7gm80HtPR5yfo///
         OyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I3ozGp08XBKPc3Oc1CPTjccxZqkmofz+VaCJR4hZhDE=;
        fh=tE78veDpgVwRCxrmZR+2CQCPmU4rxlkoew36BgU+aw8=;
        b=H0BSZID46XctSV9HcB9AXuddZrq0bMguIN1FH9Sdlnm7FsgIGwi4Ex/HBFkGpZ7FzM
         9a9kK+XrEsYMcwr0KO+HUktWCBy+18NHZ7WLfrETN9nNLRCS3aOKiAhnnxVw66WUvxEd
         mnGhNGKKaMeWNQXpHGCif7KsPBVOMd2vY1l4OCvOBYi2wOTz82b7km/8bH19vHlm2eCb
         3Tk+HW7S7udvbHowqXQynaRYS9KP4EGA8XgfirG/74POjJj1+0gWuT1qfloq9qIGabdQ
         AqiK7bqwzdxhdoBmowqbnm/4SFfC0r67qhfquvW9CokfaZvyDlRO1/n39mB1g5zQZxtF
         HQFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779957604; x=1780562404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3ozGp08XBKPc3Oc1CPTjccxZqkmofz+VaCJR4hZhDE=;
        b=cXGfUXPor2b1Nakp3P0r8YwatpnWa5ja4K3M7lsC9HsERO15z7WxUBx5Tl63C3srvd
         8HUB3N66ZWmcqB/PENV3t4Oq/7gXoxnmeh5XuomDFMRcaBf8A7qUCuISyS2w3VmIidCS
         9tB9VkPhpYvwAyC6eS40t+Cz6X0BEaNsYSqOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779957604; x=1780562404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3ozGp08XBKPc3Oc1CPTjccxZqkmofz+VaCJR4hZhDE=;
        b=PIo1OLyhbWpvu2Q6PXox9YLDRChpqxpHL1iHY2ELKJpU0TsWQilpQlujo6j3XcTKUH
         hUBLcmgVekU8kRbLNVq0efhVPlcbPDoLisWiy91eEa+I2fofxW3X9dGQ33DpEEI2sn9+
         E3Ca0QvmCEWk/NONhF91yHnhCFi9VhidjRpOyICPQHW6GyDoknu99k1L76QHfWJNy0fl
         eiMtVZUAEicay7cN68sQYX1iy3A9OIiGXeaDfBqAczfso4x2lUtLvym/DN1VsTuAL8fy
         6KitDHsD3q4cthZyCWJSVwP15mIjd21vUDLcPXjKZvjVl0V9ieglaLc7jIdaZ9KoZHc1
         k4QQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OP5xoVPhL6HHuSCihwwcpepgvS3ruY1coDL59j1Z+kWJBeR/JvYHXW9ZBZ8MV15nPRgGa6x5dQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8q6cqEhjpKPODr5eAtP8q5CKtLPMLgisW+TPx7Rz09IZZRl7
	sKbBxqHFhzDeJDpvPvXtR9YV1Y/GjxfWgJpbyaBvCutYfqOhpSZHZm6CzS0LDdhGGfZt1SqkrL5
	+VTA4kBh5mQQluFWwAuhNjmM2SgETSaBuqmmMb1DZ
X-Gm-Gg: Acq92OGDXUTM244xUXXm0gseaDwAOZnTz6sQYBZVVmt1tDc9kgH6nZGVqMksQD/nidU
	B7U5pr0aPxO/5goM8EP/wzUBuxxhoOCnAt7SLJrb6mgui2IkaicciLaPfQJ3zByu+oRVBzhPU6N
	o5k0eQNoIBEDo07E2m4xw9SIrsQ3Uu13PAKCPGoFVKSpeEEaW0GT4PqL4Or99MTdwTiPFSy/iN/
	UyrxD0nC6y+fjJIrrpjZ3tUFNJ03M0FeQEkdEG9XU8/RR+Xs2nlg9SdupWNlkBL1kZ36Vh7Nk1C
	01WUmQLRxqrFdY7bGnHaZLgWGfxA
X-Received: by 2002:a05:6512:3ca9:b0:5a8:afc8:c37 with SMTP id
 2adb3069b0e04-5aa32369fccmr7817435e87.4.1779957603539; Thu, 28 May 2026
 01:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515090149.3169406-1-wenst@chromium.org> <CAMRc=MdnjRRMVzxPkkrPhQ4dz7rsK8-HKUp9cQ0z11apL3escQ@mail.gmail.com>
 <CAGXv+5HC3dqgcE3KnKzakHHWFHB6m_X42orOkNUvZvp=SL_O8g@mail.gmail.com>
 <CAMRc=Med-_0GSYzoFBRiwFzBCK0DZqJD8_SEBxi+zwR20GS-HA@mail.gmail.com>
 <CAGXv+5GbW0bx3nKdZt2+tHuHyQ-J-1-Z79nMzHAwjmEPGKT02A@mail.gmail.com>
 <2026052710-flagship-unsmooth-ce82@gregkh> <CAMRc=Me=ujnscSOKhHDLz+ccMDyLyCfZnpqobF2BJ4YowgXB5A@mail.gmail.com>
In-Reply-To: <CAMRc=Me=ujnscSOKhHDLz+ccMDyLyCfZnpqobF2BJ4YowgXB5A@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 28 May 2026 10:39:52 +0200
X-Gm-Features: AVHnY4ImlKiDtiu3PtJAJE_NOkB4Apdo_R0OjsOkU3xKzZOWZm2qt_u0g9B3V2M
Message-ID: <CAGXv+5HKxhfZuAHTZECsVFp4S9yTN2rXW_Nps2TcoV=r9KgfEQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] arm64: mediatek: Add M.2 E-key slot on Chromebooks
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 10:36=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Wed, 27 May 2026 19:41:30 +0200, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> said:
> > On Wed, May 27, 2026 at 06:21:00PM +0200, Chen-Yu Tsai wrote:
>
> ...
>
> >>
> >> However this seems to completely decouple the power sequencing from th=
e
> >> USB core. Take the USB A connector for example, it was recently added =
to
> >> the onboard USB devices driver. However the connector has a device nod=
e
> >> that is not a child node of any USB host controller or hub; it is conn=
ected
> >> through OF graph. At the same time, since it typically sits at the top
> >> level of the device tree, a platform device is directly created and th=
e
> >> driver subsequently binds to that device. This is totally different fr=
om
> >> how the hub and other directly connected onboard USB devices work. In
> >> the onboard device case, the device node is a child node of the USB hu=
b
> >> or controller, and the corresponding platform device only gets created
> >> when the USB hub driver probes, thereby sort of tying it into the USB
> >> device topology.
> >
> > Hm, did we mess this up?  If so, we can always change it if you think
> > this should be done differently.
> >
> > Hubs should be dealing with the power issues for their ports, so maybe
> > rethinking this might be wise.  I'm just loath to add hardware-specific
> > hacks to the hub common code for obvious reasons.  Anything we can do t=
o
> > pull it out to a separate driver is best so it doesn't affect the 99% o=
f
> > the users that don't have that crazy hardware :)
> >
>
> IIUC what we discussed with Chen-Yu yesterday, the only thing that needs =
to be
> done in the USB hub driver is attaching the port firmware nodes (if prese=
nt) to
> the port devices we instantiate. The rest can be handled elsewhere.
>
> Chen-Yu: correct me if I'm wrong.

The above, plus adding pwrseq_get(), pwrseq_power_on(), pwrseq_power_off()
calls to the appropriate places in the hub driver.


ChenYu
