Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794151222;
	b=Wou9xWzr6eIHk24kmlf+MIND2MODL7lXB5J9N+gSgNPifGmzXgH6585M9sihVu+uNWnS
	 LTV4U4Jbjy73bbgMPTLPrzvRPeHFVPfl5jjWhSHsfVAJ9SWeIZdoXSfdeP2CojVNuimv4
	 RITZQlcPUYm08veDILEBVWD/JToPzPZc4c87JIk9pG75Fx9+KSZs4Ogu+gN/imjsetcHf
	 WSkhErP06tPPo7TBMJvz/KPoenQ/7XxwUSblQrhOSrXSAJh38it9wmo85zib/Be4PqFb3
	 6LH1taf7LPnQx6kf7+NnpCsC8MFbGerZUIVKehio5Aimik1xJqVnywGyFSgGxaYc2EA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794151222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qOxe9JDMzQ5KOLpQ10yhevscBcuPccI/BjPAJmf1lEk=;
	b=B/NP6TpRpwvpj3dI6ulWoK/AJnNYP9tXCoElXL2kxLxye0LiZQJzDCtID2ar3XOobguF
	 zZubuySIE6rz3WnlMeMSocAI4xqV70iXSw+dVyGoNgVGBgraBLVY0usBr9F8iNHgn7R5v
	 qLEaI1/0W1dfVlKww8T4VpoCNQdB99Aa0c2n3lRSyfDJDUht0zFNhgWNvnf3mDbdszpLU
	 GigITBzZheLj75Op+5UlZQLXEyO+3Fwo1Ge2vsGBxD3Y044QV8Lfcrfyaa/DgiWwjXwxk
	 iEl+e75gROSgxYL1VLduIaxC6d6AklU2JbwuuixlXKGSWZBoGZvXOhams70N/hXMpCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jv3fxMaU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E4606A31C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 15:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E05E4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jv3fxMaU
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-372bdb942dbso207871eec.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 07:20:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794151221; cv=none;
        d=google.com; s=arc-20260327;
        b=cjKdGAxW+s7VCGDU8kvFDh1H3IMYVoswa3PELP5E37cKuQEOubSmIChqsxEx5wCdN/
         VlQEUZNCDgNC/GZ2GORROeR8D/L8s2jeaaBEUiBYC3oH3zKR7rHBL0cKRH7Wz/ieoT6W
         TnXoXxRNx3jViFb9jT7L/uCzD6D45qgrtuvfbbb63smMwQLEXXjOPS86mbuB/Qz8+iI6
         FWQuT3uPKJqyp4B4BVx+L+zDezmCTuqKuSxAUUqHVMSiWvNB3DnMyD3U3w8ncLqxzx9/
         nkXPd3efhtLIpWrVr7OFEYtMf+EqLb3wPEDcrtixu3R0GoctR/OlR2xkWvz6uiHUmv1A
         Fc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qOxe9JDMzQ5KOLpQ10yhevscBcuPccI/BjPAJmf1lEk=;
        fh=1Jl+RTykuOkbkx7Gv5wUKnlO0iaSX6PW3CvBez5BXDo=;
        b=DqVqePgdkTuB0LOxGt3bGJuQeH1jhgO3iKbs/HgmJRSSf2T3KC1c7eFsBPcEYubutA
         FRFFH2WebD0UmXNv0zpTwfLOp8969atemeeRwXVeN1e/s4Q8jYpveH7vMSIwjcyQtIfE
         T0VWbJSv/aUJhOAUnxoaTbVviWRPnvgkorGXMp7dmZfa8OzDaOqLhRTpTPQ9n+EQoKJ9
         XJr54e7gkFgWCpXudcvbFqh+FhXp4a2d/6zEUOZO180b9CxB8LnuUPOD4gVQF5UjluQb
         i2748YgzCCEvzro5Q9LEs9R2dlAXVjDlKXECo9W3hnTIXce1YwXnGTD/k055ZbEWq2eb
         MnWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794151221; x=1794756021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qOxe9JDMzQ5KOLpQ10yhevscBcuPccI/BjPAJmf1lEk=;
        b=jv3fxMaUWjQVJskOqgtmEZPK5JGekoGIYVJiAw9rzX88q/A2V/a86yiORf8MCpBMJl
         KUZyKXiq+QuGLJGeWbsJOAse8G2odRZgc1cxeFRnABTlJFNnVnonR1npCbDBdh0WDRd5
         qmJwPkOmueRkREE+6oGA8n86H56nQQXqkRGbUHzktv8ClLKby71HCTWcMM2fWdD6C80f
         pZxzIX9YOsECxMfsb0KZfmTdWIwGgb9PhyaCGkMglxqwgvzuzNZHzXd0UevfnB49HT2j
         1MHjZQ2Kvu8x3Mt0+Jd4y5Lj/uX2z+tgzPjazamTh82kaKu9iQTVdLVTFw3yhhfwPeqc
         XZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794151221; x=1794756021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOxe9JDMzQ5KOLpQ10yhevscBcuPccI/BjPAJmf1lEk=;
        b=F7gb+C5FdvNAkte0Yhav2+1zj+WMhjsNC5+x0N31sQng01k8ekU+T3JqGy0LEpCm9l
         lL78etPbE6pXRg8Pz+mtFId360XPHnNKgsiemjurA8XefuAjEVZy5k4hY8VAx/nvlnCY
         ksvs+aOXzRh+oQ3bWyAxjy9g5etv4ypny//VYlZdJTzrDOUQ2Itm9l3PEe4eMOsCd2Zo
         WNOuyzVXSheCvQyI8FJpkDQYnl33705aGgxV4LcBpEPLZ0xKMsOdHSuK/nEZ1+4aYI9N
         wybLKd3iNvpHqJIv/hHVsq4Covvn/JE7e9CgUoeXqnQTS8LQFt759gpsYlVOtqIsCDOV
         dEuw==
X-Forwarded-Encrypted: i=1; AL+hErGLe94u33es5nqfSeCe2d/q7vNvjsPyvAOazXIhMKH8muWG4dNBWgpJ/udYmEhGHQyMOsozsyTXfA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+AmSGnhu7v0yLwi14cQig8hmzOPWV/vEpHUHTN+pJoKTrEOBky
	smXpNVuL8yERE2CEvzXUNRmvaVNhysJHAmfzyjSDCxZCK1CK+Xk4DIgU5UYp4+OXjRF/P01XVBN
	Zz1fZYHKK5mTk4DArJX7K/bO4Ith/L3c=
X-Gm-Gg: AYBFou3IJa1d2X0S5hd6f88nXff+bRhB+HvaZHbtJtFus5n1jYOicVWa8AE+xZEggtJ
	9x/JslirbFUytgY1QBZGYABdsFQpAeZfi58nczCaMyaPN3R0MyT/co/LzOWK+MM38o4bcvm5AQK
	JckQnVaM7Oroy5w17gP4vNMh7tscE+BpeR6wJZHpp2NSwjNnGXDvUrxXnm+bK0bEyxULFrmyJO+
	+/dF08s8GRj4MjplMJlxJyUDYvGE1FjlLv6biGsJr802Mxg611HQe56KDgUjeivK7utPBZWcXIH
	v/udTB67aGy6joLSUk4pVPYYo9j/0P8T4Cr3Uz+lamACyP98gFkTZWX0gR2Fx046BGrS5fQ8W+b
	UQWcTY+7XUTosJnF2gOk9Zvz5llXCRegiLBJCMw+CcXmwPq07QFVqxJhRonsqsejUrleU+6MGPD
	HjcD0Oy7xRWS1P66xpuaLhB+qBjuTEopdbTEArKreK8458EKdR9mk=
X-Received: by 2002:a05:693c:400b:b0:36c:ec0:23ef with SMTP id
 5a478bee46e88-37256befee8mr3287444eec.16.1794151220960; Sun, 08 Nov 2026
 07:20:20 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108144548.190622-1-huggek@klattorp.se> <3cd1da5d-8888-4127-b406-a1ed35454e77@klattorp.se>
In-Reply-To: <3cd1da5d-8888-4127-b406-a1ed35454e77@klattorp.se>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 8 Nov 2026 17:20:09 +0200
X-Gm-Features: AclHuK-5Ll5NaqunHkPsbBiIe692J-yHEwC2l_OQ_mvftK0D4AH9nvuhP5G7uGM
Message-ID: <CAPVz0n0KjpfuNNG=r-Zgf6gNX68UnvUARQm4KUS5FNGH439F0w@mail.gmail.com>
Subject: Re: [PATCH 0/3] power: supply: max17040: report charging status from
 a gpio-charger
To: Hugo Karlsson <huggek@klattorp.se>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, matheus@castello.eng.br, 
	me@iskren.info, krzk@kernel.org, m.szyprowski@samsung.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 8 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:09=
 Hugo Karlsson <huggek@klattorp.se> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Adding the other MAX17040 reviewers, LKML, and Svyatoslav as the
> author of the commit in the Fixes: tag, whom I missed when sending.
> Sorry for the noise.
>

I do not see your patches on https://lore.kernel.org/lkml/

> //Hugo
>
> On 08/11/2026 15:45, Hugo Karlsson wrote:
> > Hi,
> >
> > I work on OpenFlight [1], an open-source golf launch monitor built on a
> > Raspberry Pi 5 with a Geekworm X1202 UPS board. The board pairs a
> > MAX1704x fuel gauge at I2C address 0x36 with a GPIO that is high while
> > input power is present.
> >
> > With the gauge and a gpio-charger described in DT and linked by
> > power-supplies, the battery still always reports status "Unknown", and
> > capacity reads above 100 when the cell is full (103 here). Desktop
> > battery indicators then show the wrong state, so we have been shipping
> > a patched taskbar plugin to work around it.
> >
> > Patch 1 passes the device fwnode to the power supply core. Without it,
> > power-supplies is never parsed, so the supplier status lookup added in
> > commit f4b782af61ae never finds a supplier.
> >
> > Patch 2 covers suppliers that only report "online", such as a
> > gpio-charger without a charge-status GPIO: the status is derived from
> > power_supply_am_i_supplied(), and the battery now sends a change event
> > when its supplier changes.
> >
> > Patch 3 clamps the reported capacity to 100.
> >
> > The series is based on for-next. I tested it on a Raspberry Pi 5 with a=
n
> > X1202, on rpi-6.18.y (6.18.50), where max17040_battery.c only differs
> > in the style of the i2c_device_id table:
> >
> >    stock driver:          status Unknown, capacity 103
> >    on mains at 100 %:     Full, capacity 100
> >    unplugged:             Discharging
> >    plugged in at 98 %:    Charging
> >
> > The battery's uevent follows the charger's within 1 ms.
> >
> > Related changes for the same boards, for context:
> >    - Raspberry Pi overlay that links the gauge to the charger [2]
> >    - Raspberry Pi OS taskbar battery plugin reading capacity [3]
> >
> > The patches and changelogs were written with Claude Code
> > (claude-opus-5-5) from my description of the problem. I reviewed them
> > and did the hardware testing above.
> >
> > [1] https://github.com/open-flight/openflight
> > [2] https://github.com/raspberrypi/linux/pull/7744
> > [3] https://github.com/raspberrypi-ui/pplug-batt/pull/17
> >
> > Thanks,
> > Hugo
> >
> > Hugo Karlsson (3):
> >    power: supply: max17040: pass the device fwnode to the power supply
> >      core
> >    power: supply: max17040: derive status from an online supplier
> >    power: supply: max17040: clamp the reported capacity to 100 %
> >
> >   drivers/power/supply/max17040_battery.c | 28 +++++++++++++++++++++++-=
-
> >   1 file changed, 26 insertions(+), 2 deletions(-)
> >
