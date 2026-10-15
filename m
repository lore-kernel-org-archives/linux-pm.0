Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61E45DF77
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089707; cv=pass; b=IBWnyfqltjqht1XQzyigMRRS7q7ZuATxDgS2Pkt3N7Sa+kSF0sxIRFKo/Plrn3BTnq6MhkVSLnAdS7PxP0SeGPfOue+4c79HMDMWLk/quWjPkQcG/zrxN6jmBrvmNLwYbT+ohs00xzeY+O9xS2whwMoSaqb2fz31bGSLrK2xgJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089707; c=relaxed/simple;
	bh=xauoRU92rayWXBiUnhY4lqEI/RzVYWTkJ5X0x3hjblE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQW1gZbISfsF+zlNuqZec9P57ZpOdUSIoJRA7SbmHsK2Z/z3SIKkzh8UP0P5bxBAlDo/4yn8oRlpilNGUUR6H1O/P6Vcc3eZcotm4HPcnDjU8Q8zKVEF2pFv/K5ljrcPxqwJOuhutzK2He3/Ic/YdfWWq/G/O1q/I0HhhLfRdj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+x9goKG; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+x9goKG"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35ef6b49813so2522407eec.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 11:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792089704; cv=none;
        d=google.com; s=arc-20260327;
        b=kf6kck9+l/LVLHfG9auxVaO+WlcLoJqx3q58j7r+tnQCzwm09kwyvONoBXXwT4x5Wy
         qKo/OWmyjcCJCQBMJRjUI7mRhmIG9Mj/pnwUvwaGE9TuR3I+4lL2rqRqP4iU+D1hEgep
         7cDl8zOFRa1h+ONehe6jcG2buepjdFv2LTUZcRGxr7VNTHn2AEIpsPaNF5xfi1UKnoW3
         K3o5Grl06+hYcF+YHqxFuMtEsPLf7dMRymDEnLKg7yMzbt8Id6/5sXPTD6NLa9bRKuKz
         NrKpVzwy9T1EPs3h3okBc2987XUQMdRoTmaJ/9wfHX8tMQKl4bEODFmGOJHUxrTqFrUy
         Dijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsIPZgYgrzIClGBhGTKauA1e1WQnsO82rJ+gDiB7nEg=;
        fh=7AVFD/pBaf2S4Clp1JfA61skvl3dlZqDeMdNP/ZVDNc=;
        b=KHRZJ1f8xiyvfPCm0ht1b9xOcPFPtLzzr+fct4tdRfw1NwLZdi16css2cpdAYuIPzp
         JoNPxHURnXLALQC7SpvXhk/4OOs0/QVeUbjQ7WuwjXDi2y7gsBTQScgC9xuifWNiINO0
         oD+yVuXuX62XCkaJFZUSr4p+huq1TxNIKVJWRZliwrjZC6ctfc36lKdEAx56IvQiZmxZ
         zG4/59VP6szvwOWj4gxeyscNrpqqoou6ikYp/yLpaYB7B70ZSGvXLrgk5BchdUSznV4R
         aobcpGgbFii4SDauKxRG1EC7IYWa7fXAaA/NUdThKgiHyVbmFgyhbQwbjr4EpAOkoi0q
         oFNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792089704; x=1792694504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rsIPZgYgrzIClGBhGTKauA1e1WQnsO82rJ+gDiB7nEg=;
        b=D+x9goKGpfvnl9hCynIoU/Y+0NFqZ7WirIuX6nMhBfHcDA2HUKIJVwq665QzT/6/Ap
         A/+Lm1PdYvR37sHqfiRmmbNUORvFIIqxOzbKh1NPcc9zHysO1RKfLlxwVDQoPLblq2BS
         oYRsCOP/iKDu9u7N4MRx1K2zgUKTkrr7oj0dHgtC76Dp+qycvi7ewwrGSe6r7RAsgwh4
         x15HDivoawBFaFdgcmvz5+L5fOTcV6n6Rxuq+wPN+O7o+0UuIiw5PyKLfWrUtlb0G9O8
         wIyrudOcUFKeZNt1XX0/P4qWEJm4QmV1xnN0lPQVDNi56AwZamHh+5OL5h8eaUxEhO/K
         EytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792089704; x=1792694504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsIPZgYgrzIClGBhGTKauA1e1WQnsO82rJ+gDiB7nEg=;
        b=MFankUK9u/pYykvwnJEOc/eN5xnW8vigQ5OBh0zt/vHeogaPeUmfgDJt45vJ2bQDWt
         doR6lnkCVdh77iy3S8vMy8sUxHxtUVmmBXirPBD+/N3EI8hn0c//RDzkK3xqxq/L1g2z
         s3v3vOj9+DKjM7iHDWlTl0WVt7b0ekHglSNzZJB1+3HSsPpUyFJxz15vN+k76GH3WtP5
         l52uQUs5uf+ITJLcW6M0rev8xJCToI4KTbCYfAsh/cAGnAgmcf3LSdj816ytwSQioQgd
         Ng6hITmTFxajMwasVOtOhGRxd0wTsXP5VahEKEfnc+CL/c8UK8SwUAsG4oO22CPZPAI4
         4xTg==
X-Forwarded-Encrypted: i=1; AKwUvByuo+8nnBk0+rqADEWFOBDFB8V6wwJUie9/1GOXbjcDncn/UVG+CyHcz0dWSwYgfAa3PrjunKkzAg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJaHKmkOVSgQtT8hDK66yxktwkevh5LXmKyKYjzcsszSRXJ7TLK
	cVsg5BSoQA9a7rKFVP4fQkelf+877qFCuw871UfW5oyxyi8HhKJnqRVe39SCzbm0fOJu23QBRFj
	otqPJtOcPnmU6sYADq/DoqbLranSotlEVZA==
X-Gm-Gg: AYBFou11IS83ezF0ndjB2tmkNZomhHP/5I0k3O6g7MDEIoUShrM6HUE8nY+na38nRGn
	UQ5fCzKbygHfDX23ytZQP+haGW/plAzQ4sYqxZu1gp7+VipZrmYw4BcbGch0ub61dkt4wnQ6Kpn
	ibiciFZQVyoMeWO5Qso1Agp4LbxhCf0jgQ+iBE/hZFpT7gsqxlbPbDQcRULIhF9uA0h64VDdcEI
	3Vl1cbdb95draOf2naZqJKsekvmodCHjob50ovMqGJvh2HKDWWr/GRsLS79a7Guqdd73pkwz2B9
	C3KTBnXL+d06HKCTbVoGuQt2i0NwmRQc6U5bXt1NpA9rVj2ytLhNo0rQtf6TglkmjjiwYdtIws+
	MEM0boFeWlzhR
X-Received: by 2002:a05:693c:2a12:b0:35d:2c2b:215a with SMTP id
 5a478bee46e88-35d2c2b2220mr10102451eec.35.1792089703889; Thu, 15 Oct 2026
 11:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013173504.451391-7-clamor95@gmail.com> <f26b6bba-2c2e-46b3-9350-0ba0785cf3ba@web.de>
In-Reply-To: <f26b6bba-2c2e-46b3-9350-0ba0785cf3ba@web.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 15 Oct 2026 21:41:31 +0300
X-Gm-Features: AclHuK-9dwgzuV_rOZ05ZsN-0-b2YgDg6QoraK02oNxRoGvJeYL0q4NRa-SbCE4
Message-ID: <CAPVz0n2ubBgOGO5q4ZBYkw-eDSuNh-MpdBk7uoWW69m2QduSgQ@mail.gmail.com>
Subject: Re: [PATCH v11 6/7] power: supply: Add driver for ASUS Transformer battery
To: Markus Elfring <Markus.Elfring@web.de>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	linux-pm@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Florian Krischer <florian.krischer@fkr.dev>, Ion Agorria <ion@agorria.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 15 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 21:0=
6 Markus Elfring <Markus.Elfring@web.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =E2=80=A6
> > +++ b/drivers/power/supply/asus-transformer-ec-battery.c
> > @@ -0,0 +1,289 @@
> =E2=80=A6
> > +static const unsigned int asus_ec_battery_prop_offs[] =3D {
> > +     [POWER_SUPPLY_PROP_STATUS] =3D 1,
> =E2=80=A6
> > +};
> > +
> > +static int asus_ec_battery_get_value(struct asus_ec_battery_data *priv=
,
> > +                                  enum power_supply_property psp)
> > +{
> > +     int ret, offs;
> =E2=80=A6
>
> The referenced array provides unsigned integers.
> Would you like to specify a more appropriate data type for the correspond=
ing variable?
>

This is a nitpick, it does not affect anything.

> Regards,
> Markus
