Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755893BFE2D
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736116; cv=none; b=WbVHcUHjQ0Cbsge/tQlN97WKCvnyJlQSpwrMI/cS+8bz8lYNQjKDv36zUKwmpxgseiVNRNt2pbyBEDoSyY8dkhjJi5YZYNx6tKLKhC9rvNtJMfoAEWLjKiZtn9UqEmCLHhezPSADLZGxsxM1IqH5Wc/Pb3FekKaykXulUpSl4SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736116; c=relaxed/simple;
	bh=6TIJXa1d9VmQ8+mogtcwHUB/GvWxvRTY9afz2VGE/iw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I75lIGEmYeE61VvN+soBTYhh4/WYboATM9Vpbieh113UpRg0gu/MNJL9D4fCMW3tL7InIy0XSDDreV4c9LqD/+IUUhS/EcxgdXN34ZI+K50r90dUramsDwoh7sD9O1j3HrdaoaRKQbGxnYSzMrwPpCT3++F4bSlPprZAtJYlX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+BcLOOH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+BcLOOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F4D1F01566
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787736114;
	bh=6TIJXa1d9VmQ8+mogtcwHUB/GvWxvRTY9afz2VGE/iw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=f+BcLOOHGJEQ6aZY9edE5SsCjpF/djKYphOdB/pBw/Ownj32kwhB+zlxT+MqZ3Uhp
	 1PDFjCNKX/z6WQ/MTmOxvJOZPmo7EqVCs/CtaBA+Icv1rz0vkhRDhLfDD9PMRAnVNR
	 /8K7x6rxeJc4IvNR/nJQzc+ociFM24w8n1RwAVODHx61ShMMDFezQbf5qvqO2vNyd4
	 ZB5qruB5jl4D675KxKmKMdetuBBw023EWVPTXprXs68wfKCEcriDDrIJ6YNOYMGs1r
	 CFXghnqilvosvNSmw0ofZVcnfOPXmTbcaTBEezX15+9cK75rS0MbYROR+qLF6Fh/so
	 2Bd4ja2Z1bTaA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b29599b81cso671405e87.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 02:21:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqsTaMSMJymvj/1KTLpr4Fl+fVidRHP3V+ebezZGizKmX532Hb3PlnyBJ+tnz6hZagLd9jyQQhrOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++krOnmK8PRkHhjZyo/xFkxHuNGniKtraWx5JbMJbe918dq8PVEx
	71pAwdLvSbAe5A2867uBiqHhFvLD1ed1gfH8NC6Cp9Fnf7mOInjgV13nQLIwVlrecqph3heeOod
	MfpC8wgx/69nT6qbpM7A1t51pSVMCR5VycCjZ7fMRgA==
X-Received: by 2002:a05:6512:15a5:b0:5ae:bd4d:852 with SMTP id
 2adb3069b0e04-5b4a8fdaad9mr1365580e87.5.1787736112483; Wed, 26 Aug 2026
 02:21:52 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 02:21:50 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 02:21:50 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAPx+jO9QE_KG8BbfnMLTebDpGDj7OSpPDtgc9uTBGZCDJeLu_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-4-889281373870@oss.qualcomm.com>
 <CAPx+jO9QE_KG8BbfnMLTebDpGDj7OSpPDtgc9uTBGZCDJeLu_w@mail.gmail.com>
Date: Wed, 26 Aug 2026 02:21:50 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mezpj4A7o00C9hhs97kdA5Q+FZKTLRbDM+fR8qr0xCCqw@mail.gmail.com>
X-Gm-Features: AcwNN1UG2d08q4EIvyC0YkJPiMzqWtl7fkdThoOnIdB26AtC9kJnkfGwy6cY9KA
Message-ID: <CAMRc=Mezpj4A7o00C9hhs97kdA5Q+FZKTLRbDM+fR8qr0xCCqw@mail.gmail.com>
Subject: Re: [PATCH v24 04/12] mfd: psci-mfd: Add PSCI MFD driver for
 cpuidle-psci-domain cell
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, John Stultz <john.stultz@linaro.org>, 
	Moritz Fischer <moritz.fischer@ettus.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Aug 2026 14:59:49 +0200, Ulf Hansson
<ulf.hansson@oss.qualcomm.com> said:
> On Mon, Aug 3, 2026 at 11:45=E2=80=AFAM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>> PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
>> Currently, both the PSCI core driver and cpuidle-psci-domain bind
>> directly to the same PSCI node "arm,psci-1.0". Additional consumers, if
>> introduced, would also need to bind in the same way, leading to several
>> drivers attached to a single device node.
>>
>> Introduce a PSCI MFD driver that binds to "arm,psci-1.0" and registers
>> PSCI child cells. As the first user, register cpuidle-psci-domain as a
>> child cell.
>
> I don't think PSCI should be modeled as an MFD device with childrens.
>
> Instead, this looks rather like a better fit for the auxiliary
> bus/driver. Please consider using that instead.
>

Hi Uffe!

Since I was the one to suggest MFD - would you mind providing more argument=
s
in favor of your preferred option?

My reasoning for MFD was that it is indeed a device that provides multiple
functionalities, of which cpuidle is not really he main one even though it'=
s
currently the only driver binding to this node.

In any case, we'd need a "core" driver binding to the psci node and with
multiple auxiliary devices with their own drivers, we'd end up reimplementi=
ng
MFD.

Thanks,
Bartosz
