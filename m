Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CA4D90BE
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818536; cv=none; b=C52yK48S4dN6FfgHWN/hbzFj1/SfG8KhoDmOjKlzg/h4vssgBSNnypu5cTsDX0M9sWFoRM08IdZJg9VjanEJfh2qhG51GvYQ5ppxSTJT7I1oKM75tW39bqUTaOXDikA0LldSBf5sKvJTAes0c0q9w3Of3EdpY7kx+eoRWd37auA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818536; c=relaxed/simple;
	bh=EQdUQvusOqORqVPitxb5aYrrrz1LANYLu9+5DdjbeDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmBgjNht43A3Nq8P4nvL9D4BSkl69oDp43cks0lMNrsDEQqjVTZahq3FDRoNFr519oRjKf0iZR4n4Zx+aQy6u7fGwPtbalnorZRwChu4dALMgx0LcWgSxHp5DkZps1NDYqv+P4beO62mp8ALUe4JxrrjAeamH5IXyOfOPGrPpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGs5kwfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGs5kwfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC951F00A3D
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784818533;
	bh=RKW+bY83iLgWrrjjjtpXbyUmlIMOaHV4BT1iaU1BDXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DGs5kwfZLhiOYgpjOprYybiI8qgKQRSmEGuuPzNwMspAY5ztFgfrdmvBqZ3o2+Q1k
	 oZOOiAKqWIe6ySSqiLfgTUeMSyvywmIg9GK9aSfDtwSN19uN6evWLAPAr/3eOUH1Nm
	 FMTeRityy3nqO8bufinPbraP8+rKK1fN70d/Xlo9qu1kW5sRQvh9zE89I6s+2Sp34O
	 C9hB7ROZOR9qgRgQjVIB4YBZYJBuxMOZTVObIY4I8lgY+Xmztm8pny7jp/JrocQfAr
	 CzSFtU7ntQE5VZG0nkcc4y7FxdfcWjGfFXJmiRW87t3lCm2lBB0qXZi8geZl7T5SEU
	 Nsu+b/yrbNsmQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeba09900bso537753e87.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 07:55:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp38LdL7kGf7qdmgj/1eq+K2sdwdhU1rHkAzGCENhVAxrPphI1HacsVto85XbQUxtyqRG9vMHI+8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdG92awE0ePGyW/dby6/oqv1/KXUD6OF5WKJCTqKe4HDVIwep/
	Hrq+9SqBo23/71uGhmZVkijAL+/wvxOodqJdolAWUxkhv+FH6G4gTw7QDOVg/MdZWeIItCbl4eH
	IBd5RaiOMUgmkbskTZ/9GngIKuNbwiqw=
X-Received: by 2002:a05:6512:3e01:b0:5ae:ba28:a56e with SMTP id
 2adb3069b0e04-5b2b2f699d3mr744788e87.35.1784818524344; Thu, 23 Jul 2026
 07:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721151358.4185467-1-include@grrlz.net> <20260721151358.4185467-4-include@grrlz.net>
 <CAJZ5v0jN0QQordGJ+7EyO42Zwidok0j+TKZLCmRhU8CFeRHMuQ@mail.gmail.com> <22B60EFE-21BC-4E2F-9542-93D9FC2AAAB1@grrlz.net>
In-Reply-To: <22B60EFE-21BC-4E2F-9542-93D9FC2AAAB1@grrlz.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 16:55:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-=5fmRLrJJg=HBvnEew+LhPN4gV1OJJhDLS4tW49Dnw@mail.gmail.com>
X-Gm-Features: AUfX_myV-VkIp-3jogtf0h-QTI2t0T8bRDZ3RDC_uMg3EjmH6muADU6ZHdlMIf4
Message-ID: <CAJZ5v0g-=5fmRLrJJg=HBvnEew+LhPN4gV1OJJhDLS4tW49Dnw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PM: hibernate: log the task that initiated the
 power down
To: Bradley Morgan <include@grrlz.net>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, akpm@linux-foundation.org, baoquan.he@linux.dev, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	lenb@kernel.org, pavel@kernel.org, kees@kernel.org, tony.luck@intel.com, 
	gpiccoli@igalia.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:46=E2=80=AFPM Bradley Morgan <include@grrlz.net> =
wrote:
>
> On July 23, 2026 2:55:41 PM GMT+01:00, "Rafael J. Wysocki (Intel)"
> <rafael@kernel.org> wrote:
> >On Tue, Jul 21, 2026 at 5:14=E2=80=AFPM Bradley Morgan <include@grrlz.ne=
t> wrote:
> >>
> >> Give the hibernation power down the same treatment as the reboot
> >> syscall commands.
> >
> >Why?
>
> 1: Andrew suggested it [1]
> 2: because going down for hibernation is the same as "Wait, who the hell =
took the box down?!"

No, it is not the same unless the system doesn't resume.

> >
> >> hibernate() runs in the context of the task that
> >> asked for it, whether through the reboot syscall or a write to
> >
> >It doesn't use the reboot syscall.
>
> Hmmm.... I may embarrass myself here, but it *could* (wink)
>
> See kernel/reboot.c:
>
> #ifdef CONFIG_HIBERNATION
>         case LINUX_REBOOT_CMD_SW_SUSPEND:
>                 ret =3D hibernate();
>                 break;
> #endif

Ah, I'm wondering if anyone actually uses this, but fair enough.

> >> /sys/power/disk,
>
> I'm wrong: /sys/power/state
>
>  so when power_down() runs current is still the
> >> initiating task.
> >>
> >> Log it once the image has been written and the machine is committed
> >> to going down:
> >>
> >>   reboot: initiated by systemd-sleep[812]
> >>   reboot: Power down
> >>
> >> The line comes from kernel/reboot.c so it keeps the "reboot:" prefix
> >> and sits right next to the final "Restarting system", "Power down"
> >> or "System halted" line, same as a plain reboot.
> >>
> >> The one exception is platform mode rolling back on a pending wakeup
> >> event after the line has been printed. The existing "Wakeup event
> >> detected during hibernation, rolling back." line follows immediately
> >> in that case, so the log stays real about what happened.
> >
> >(a) Why is this information in the log useful?
>
> when the box just randomly goes down, some people prefer to know
> "And what process did this? Or what did this?", say
>
> "Was it systemd-sleep? Or some random power daemon?? Or some stray
> reboot(SW_SUSPEND)??"
>
> Userspace logging can't really do this...

But it doesn't really go down in the case of hibernation.  It's more
like suspend in that respect.

> There is software out there which can do this, but it's not the greatest.
> [2]
>
> Hence, this series!
>
> >(b) Do you realize that it only appears in the log when hibernation
> >fails or it may appear on a serial console or similar?
>
> yeah. The image is written when the line prints, so after a successful
> hibernate and resume dmesg won't have it.
>
> Thats exactly the
> same visibility as the final "Power down" / "Restarting system"  line it
> sits next to
>
> Well, if you want it, please say.
>
>
> [1]:
> https://lore.kernel.org/all/20260719231540.455bd5c3eac842686c05bd7f@linux=
-foundation.org/
>
> [2]: https://docs.memfault.com/docs/linux/reboot-reason-tracking
>
>
> (oh and btw, if you don't buy in, it's ok, just say.. any questions, ask)
> :)

Yeah, I'm not convinced.
