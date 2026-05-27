Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68D3E5A37
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872790; cv=pass; b=gUkJpwcpJvrqM+pBwpFG9LbHRI2ltp0coDvIntxjlWFVYLobQvYzMT/ruvkehyfp76ENfP2QJfbmwKWBpRVZarjnI7PR2p7iQ8G3JeFgrUcC6gtNhvpSKDnJarOL6ZhLHwnY3tMIDX6RHOLKHHdUywvun58NoU0YK8iw2NO2GbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872790; c=relaxed/simple;
	bh=p+/kFWOLyWmKqbjAczM5ITlN6oqto8291ZltJD09xlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWE5WNknQqD1fAgi2oWYq77pLTo2FccxeynBEm3FT+RmC+ZuaRGy07eECDMnPVf/lDeOwmMwuHIY8hEAE6lAr5aCmqPe/tTJhk/xiX21b7wW5fK7qGBVoaTDH5utX+VjlXHyNSM9UcXvgywSbLR8nVASCfv3jg46pPVeX4e65cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+UWUGxh; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+UWUGxh"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f30a4601bbso11726151eec.1
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 02:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779872785; cv=none;
        d=google.com; s=arc-20240605;
        b=CA+L1Fgq0vPn2uRmxIHQKux93hTVFeiO+ZVFimpol45qlPX8vOpHZ7i+SX+hCV86ef
         yY6xYZlva+Uy2WHlPN6hr/f6Nl4w0qQfAfsSE9l9o5ZKUKZ+/+8MrErcepRGrTUOZl07
         fxGWTP/9rtySvufb3uPXw+wIwiB+DkD75UDhMsRyJUEVefyK3likcPFjebrJGp2SmU2I
         08XGMOZYxynyoOYwbNuqLBkKmjPwv6HvgEFOfxqQe5OOxMYxBSufuOaI3wYFXA5zRXdH
         WhRKmsCvIzqoqyADzvpE3zo/rXuXR+bRXd+XAB3ZRpzawht720MZlhqiOEkMWJ/Nvthp
         lQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p+/kFWOLyWmKqbjAczM5ITlN6oqto8291ZltJD09xlA=;
        fh=iK+2rKlmKh1H8vUnLC0ZgewBMm98b+ZSNmLeNW4j68U=;
        b=hMazwEKvWEwOu/KnuOaxCsU7hnpny6y7Un8egcyQ5PNPAmnYO3boluc1hkry8CmWy2
         55t+wPLeNgfjOQ7Ma5YpW5QIefmftR+yQUB0ALMvJUTbX/0cFe/pR68ZNeTXiJtnF2+A
         pV80/gC1UCqHuVyYEnou7jfC1an5FqpiNlufMev+XHTiSZi5UslGQbNMRmO1DKnGJzbW
         dSKEDWD5I2wNh08v/+JkPil2pKs2eieJQuy0GhX9paACf1n1AW/jjm1pDocYTQedCMe3
         CMxuaULlQuFuHWg+MtCU5FCbE4tsaoADvlsS3nRP6tqvHA6dKHYiayQow+i2GqKlYFBb
         XvGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779872785; x=1780477585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+/kFWOLyWmKqbjAczM5ITlN6oqto8291ZltJD09xlA=;
        b=h+UWUGxh0kYAHpWEy7nVU8vcDKy0ydKpSThs3mT863TfrjbACeZIlnRh9v7/Vrnzkg
         +EZoRaO6boUS3IGXr1Y5NCzcPxR+jIHfRULc6FvR5If1EK1LL+seygWKdFyyb/dzGCDe
         aoY18jiIEldb/xyS0uacuTdQGw5tyyF3xEhsGTY/7mll5QwGCwaP+vrqO6FkWKz7O7/D
         cyQlOkx0Z0qDS2711jGRVzuDAFUZJbvEvUMz9eAkKFZnWwDL4N+pwFHbwE/4dOewv376
         sJmCHd61msFR1ttTbGU0tW3fdo57CErH2sRb5UOr/zk4mtTaO8WVQ5q4l5WXt2lUpRvw
         KrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872785; x=1780477585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+/kFWOLyWmKqbjAczM5ITlN6oqto8291ZltJD09xlA=;
        b=UQ4jzjRYo2p8XO/IyFH6pgb3w7PkMRMudOs6MKXLAdHo4YQd85jjekqHGNxQICTZvE
         caKZ34ab8zPZ3XcnXmmVACzg//GsDbUnDv90kxXiGgozq4iiCA+XEfDrC6PEtdCQ9lfO
         SvDxQkLfp1jXbuQAbOGvUKFiaflkXtwUE/DnOM2Bf5K8ysLrGZgXp+9LR6z5KNRLcy2Z
         k8sWe4nr+UHtQh22Y0L61fAiZQ1aDrnqrmbMpvTPRXwQbj5zOTb2myUsei+z2/KhDXyc
         M1j+YXex/5Z7POexCK5W/UHOBLaOB+Agv75/HgECALkrWr0iVIHvLXqsrFxGLiW5deGZ
         cR1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/dgpQzy5PcpWScTgKcudVJL50hTJyKKLcsnU1H4yEPN9ayrnqlQG22BDH1AH3pjXotw612qRXf1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvKpMmS+VjNVigoHU8dRKCTh+4apayCTVlATf7iAoo99BmFKn
	gTR/xVoAVmoWSId+HuBdad2Th5M9HcQI/N9k3fAyYqRSewnMkod7XGuLbPF+ksK1t7ZLH+dXeq/
	hK34lAD3OtqDGwTB/CwBUH1aq3RcVoLA=
X-Gm-Gg: Acq92OEtachaJ1elktIeRGu2vqhnqXhwobWGijv+wy6VbVc4N9HTMibqpg0Nv81qbmr
	H2HT2x8tYhD9NcAX4qxVDT+yc73vCY+cxr+nNCT1s5VX7aRiQs/Q1qjzTPn7G/jdCYCDoDYS3/V
	xQ+PGV5zHb9HW6dqVJ5TQmvgCzS4XGeLrFcV8kSwG5t7Ulctb87yckS0P5bk/CJzeMN/jyBBs2p
	oECxh58+pyvtIoKBVlKVY0FJs8Na6JUqNB0rka782YVp/+AwR2aX+U/OGFgrTelta+HVLU3yQjo
	TtVmmMEoT6fp8QFiATmJEdoEEPfJXA==
X-Received: by 2002:a05:7301:d09:b0:304:c520:4e14 with SMTP id
 5a478bee46e88-304c5204ff7mr447218eec.11.1779872784845; Wed, 27 May 2026
 02:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523085102.51000-1-clamor95@gmail.com> <20260523085102.51000-2-clamor95@gmail.com>
 <CAMRc=MfXVwD2u0e115RapnyLzf5JRjWMs=2PSNzMnm0GDd7aaQ@mail.gmail.com>
 <CAPVz0n1G5Yu2X5f+=q90RAbnsWi9psMq-L5tWDMM4JRC4R_mPg@mail.gmail.com>
 <CAMRc=Me4G-YqKoFan3epofXk2OWzxY1iPE1mP=uwEjs9wgA6Cw@mail.gmail.com>
 <CAPVz0n2P-zB1_uetZN9pVcQChK+FkdQowbF4Z0YZOBQBsB76WQ@mail.gmail.com>
 <CAMRc=MfAAE4UtnW4S1=pY+2yvS6Hsd-U9+uveUFtPGoJPrv6aA@mail.gmail.com>
 <CAPVz0n2COsDL+fNBAuKr1ty_AVe9sK5yNJithkXex6GNa1T_Tw@mail.gmail.com>
 <CAMRc=Mc9g=yezRtAtRMzh7t-pSoyoKQEtxrb5U0oeFAbcjb6Ew@mail.gmail.com>
 <CAPVz0n3X8Gw2Yo9VgwhV0uAqvArGXbvmzw=cZVJw=4BEH_E7_w@mail.gmail.com>
 <CAMRc=Mf4W9hoP7FAbxQTNLaG3M9W+GmvQSMECbzzdQLU_+5D4A@mail.gmail.com> <80e102be-04c3-4591-8e75-ddf859d3a877@kernel.org>
In-Reply-To: <80e102be-04c3-4591-8e75-ddf859d3a877@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 27 May 2026 12:06:11 +0300
X-Gm-Features: AVHnY4J3Jy-_XrXeMpEu14Bcvl0l7Ncolkrn3V5shE8v82ak866iK5z85dDWwpA
Message-ID: <CAPVz0n3_wueX1yeZ=MDfSMy3UaQa80-nGg1b7ZQuCTneOaQDkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: tegra: Document Nvidia Tegra
 modem pwrseq
To: Krzysztof Kozlowski <krzk@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 27 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:2=
6 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 27/05/2026 09:55, Bartosz Golaszewski wrote:
> > On Tue, 26 May 2026 15:41:58 +0200, Svyatoslav Ryhel <clamor95@gmail.co=
m> said:
> >> =D0=B2=D1=82, 26 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE=
 16:14 Bartosz Golaszewski <brgl@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>>
> >>> On Tue, May 26, 2026 at 2:55=E2=80=AFPM Svyatoslav Ryhel <clamor95@gm=
ail.com> wrote:
> >>>>
> >>>>>>>
> >>>>>>> The node attached to the pwrseq provider device should represent =
a real
> >>>>>>> hardware component. Are the enable-gpios and power-supply lines c=
onnected
> >>>>>>> to the modem package?
> >>>>>>
> >>>>>> Yes, enable-gpio is connected to the modem and signals that USB is=
 set
> >>>>>> and ready to work with the modem, while power-supply is an optiona=
l
> >>>>>> supply connected to the modem's vbus input.
> >>>>>>
> >>>>>
> >>>>> The modem is a hard-wired USB device? Do you implement it as a
> >>>>> platform driver or a USB driver?
> >>>>>
> >>>>
> >>>> It is not a traditional USB device. XMM6260 is an embedded modem use=
d
> >>>> in the Tegra phones, it is linked with the AP using USB line in HSIC
> >>>> mode. The driver is implemented as a platform device since it does n=
ot
> >>>> interacts with the exposed USB device directly, it just ensures that
> >>>> USB device is properly configured and is ready for IPC.
> >>>>
> >>>>> Is there a connector of any kind that could be used as the HW
> >>>>> component represented by the pwrseq device?
> >>>>
> >>>> I assume control over USB line is the HW base, but as I have said, I
> >>>> can integrate binding in the modem node itself, and pwrseq can get a=
ll
> >>>> it needs from the match. Pwrseq framework states "This framework is
> >>>> designed to abstract complex power-up sequences that are shared
> >>>> between multiple logical devices in the Linux kernel." it does not s=
ay
> >>>> that it must represent some specific hardware.
> >>>>
> >>>
> >>> No, not at all. We just can't make up any imaginary, logical "pwrseq"
> >>> devices and describe them in DT bindings.
> >>>
> >>
> >> Ye, ye, sure, pwrseq framework is quite flexible and I am not stating
> >> this bindings is mandatory.
> >>
> >>>> Using pwrseq allows modem driver to be SoC independent since USB lin=
e
> >>>> handling is moved into SoC specific power sequence, and this modem i=
s
> >>>> used in Exynos and OMAP too with similar setup but they all have
> >>>> different USB controllers. Maybe you can point me where SoC specific
> >>>> USB controller handling can be implemented?
> >>>>
> >>>
> >>> I'm not sure I'm following. Can you atrephrase or point me where OMAP
> >>> and Samsung implement it?
> >>>
> >>
> >> They did not.
> >>
> >> The XMM6260 modem is used not only in the Tegra phones but in the OMAP
> >> and Exynos based too. Replicant tried to implement support locally
> >> with midas devices and they had some progress. From what I have seen
> >> generic implementation I am proposing will work with any of those 3
> >> SoCs maybe with some slight tweaks, only part that is totally
> >> different and SoC specific is how USB controller used by the modem is
> >> handled (well and IPC but that is out of scope of this patchset
> >> anyway).
> >>
> >> Obviously, non of the 3 vendors have submitted any mainline patches,
> >> everything is in the downstream forks. I have investigated a bit how
> >> this modem works on my Tegra phone and re-implemented it to work with
> >> mainline kernel (I don't have Exynos and OMAP devices to play with). I
> >> have come up with generic platform driver which handles modem
> >> configuration and a SoC specific part which performs USB controller
> >> bind/probe when modem is ready to handle the USB. ATM this SoC
> >> specific part is available and tested only for Tegra devices.
> >>
> >
> > Are you familiar with the PCI pwrctrl code that lives under
> > drivers/pci/pwrctrl/? It seems to be solving a somewhat similar issue f=
or
> > PCI devices that are hardwired and powered externally. Maybe you could =
use
> > some of that code for your USB use-case?
>
>
> I pointed to PCI already:
> https://lore.kernel.org/lkml/20260518-mustard-rabbit-of-ecstasy-eed3b6@qu=
oll/
>
> And emphasized to describe hardware, not drivers. This binding AGAIN
> describes drivers, so we did not move forward at all.
>
>
> Best regards,
> Krzysztof

Krzysztof, why are you so mean? Yes, I misunderstood you and sent this
schema. However, I am not stating or arguing that it must be applied
or whatever. I am just looking for a proper solution to issue I am
currently facing.

Anyway. That does not matter, what matters is how to organize
everything I have regarding this modem into a logic set. This is why I
am looking for maintainer suggestions.

How I see it ATM:
- I will remove this schema entirely and add usb-gpio (trigger for
modem that USB is ready), vbus supply (yes, modem has this line too
you can check in the P895 schematic) and infineon,usb-bus which
represents HSIC connection to the modem to the modem schema itself.
Obviously, I will add detailed descriptions of each component.
- I will resent patch 2 of this pwrseq with the modem patchset to have
a bigger picture. Pwrseq will obtain needed data from the modem node
itself (Bartosz Golaszewski are you fine with this?)
- I will try to get control over Tegra USB controller in the pwrseq
without need in externally-controlled flag I have proposed for
chipidea driver. I hope my idea will work.

Will this be acceptable for both of you?
