Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203339B486
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619960; cv=none; b=pGItKCP8y1OCdzwTpSR8qCOmnoYW8x82DLU9h9BrjOjXkgAdiE7QvaxL2Pwg8uZ2ab9U4OPmwwai2Deg2lyVPSBVbK384hNatLCeBtOOrWX6IdxCZjdAYOh40KzB0VHiP5ROAPChSq2bpxwfTtE05RKsZBJQutg1iMJq8uYV6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619960; c=relaxed/simple;
	bh=8xzdYoi3gi518bjSufdEEG4WtJrX0WYlJOv7k2yVMAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rV/pTMW9VqDq7RRkTEl8cxqIPAkvNV0YSmHgppDeb+9Kva9hJ4xFRiepksnuVrLPk/BgW27oLeoOCJuGVXMKUUcdweMpkN/6U9/JHZpvr3CiStMVuctYtnUjIMDB6p/OUlvdS/o/6x5MTNAkfsedfXoJ7r3G1G30IgJG3JlKYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZKNTyI/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZKNTyI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969D8C2BCC9
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774619960;
	bh=8xzdYoi3gi518bjSufdEEG4WtJrX0WYlJOv7k2yVMAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NZKNTyI/kBAnIR0HZvkBqOTDvrCbjhLEUS/OH0E+5lR+Fw4M4UKzhS87SAxD944QF
	 Zls3jH8x6EPxptfI+8vWACCOiBccBJbkMTp7utd0irXgITCxyauMELtC+u1H2XVFzx
	 wB1SdRI0gvIsrprLra9WIPbabuHAuDsAGz0VmyOtipr7WtCysuTeWO/O13xKx77Lf7
	 W5FFA6bjO5D3X2oC9Kzmd8pnb1lYs8uGFOjfOYD3lsSAF92ep+YKUVfBNF77w544Te
	 cPtUZfoUuH3xkUKxCp5/RJQE43CzZXibvnaISxkT6ZxSe8HU6EOAfAiaRe3mOGMLjl
	 42Tu60owotsGQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a2ad56dbb2so464566e87.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 06:59:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUv08vVCfzgTQNqqO+qABDV14CWRJ3Vq7Z5G9Arch0YahbSaEmUELUQhRTL7BMJps/pdJ2N5I2Irg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyughV9YLSgd9YHDbeGWSMTUSFUgfR08zA0+A4OpdKGOpu3/CIp
	64LFyZBHjYXMh+akMSmYt4HV+BjbZnXzPJjuxHQLwvWJbt/G8KX7ZCLnDrIuPIcRmeoVGFilqLv
	G7fnd5GJ19Y3nDfDcRvuhtq0K+u4fFqZjS5b4hOlmfQ==
X-Received: by 2002:a05:6512:318f:b0:5a2:8450:edad with SMTP id
 2adb3069b0e04-5a2ab93f8b8mr904034e87.45.1774619958969; Fri, 27 Mar 2026
 06:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
 <20260304-arm-psci-system_reset2-vendor-reboots-v20-6-cf7d346b8372@oss.qualcomm.com>
 <acaMPgRALnoUIHMC@lpieralisi>
In-Reply-To: <acaMPgRALnoUIHMC@lpieralisi>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 27 Mar 2026 14:59:06 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfRWDava8jyT90ah1LBK3udAgcTCc7q-S_Kb4U3CR5smg@mail.gmail.com>
X-Gm-Features: AQROBzAnj1Wvu_HThCZA2lw78sbVKD9HXLQMgd3NlSn5WjYR9EmBsH-p5sQhJxg
Message-ID: <CAMRc=MfRWDava8jyT90ah1LBK3udAgcTCc7q-S_Kb4U3CR5smg@mail.gmail.com>
Subject: Re: [PATCH v20 06/10] power: reset: Add psci-reboot-mode driver
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, John Stultz <john.stultz@linaro.org>, 
	Moritz Fischer <moritz.fischer@ettus.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 2:55=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> > +
> > +static int __init psci_reboot_mode_init(void)
> > +{
> > +     struct device_node *psci_np;
> > +     struct faux_device *fdev;
> > +     struct device_node *np;
> > +     int ret;
> > +
> > +     psci_np =3D of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
> > +     if (!psci_np)
> > +             return -ENODEV;
> > +     /*
> > +      * Look for reboot-mode in the psci node. Even if the reboot-mode
> > +      * node is not defined in psci, continue to register with the
> > +      * reboot-mode driver and let the dev.ofnode be set as NULL.
> > +      */
> > +     np =3D of_find_node_by_name(psci_np, "reboot-mode");
> > +
> > +     fdev =3D faux_device_create("psci-reboot-mode", NULL, NULL);
>
> Same comment as Bartosz (have you picked up his work and working towards
> a solution) ?
>

Hi Lorenzo!

Yes, I suggested creating an MFD driver binding to the "arm,psci-1.0"
compatible node which will have two cells: one for the existing
cpuidle-domain functionality and a second for the new reboot-mode
driver. This way we'll simply add a platform device as Greg suggested.

Bart
