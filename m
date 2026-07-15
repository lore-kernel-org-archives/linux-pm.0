Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40B420499
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121024; cv=none; b=ZqpjNZqVpfgPsUDNLBH6/rYy4Pl3RQKEE7eWL9gfZtP7VG5ZyYR86MpHXTJb8MHbHNFQooI//R1FHG/PIrQik1DmsTIba+CJgu/dT4jLBT7NB9h+9GKkM1wxh/Vbpa2lmA9o2C5WDEpbTGP5KAlWHqFMcflv1fG9lwSwcV9pE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121024; c=relaxed/simple;
	bh=HDpvp8vnAzoZQLx8FKACNiz9sLgSiXd+woO3izJE9Kg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ejalf/pT5g+kOCzocUNTSped/F6Wun8s7LgdquW5LnBs/0UNUiiuHqQ+XC8o1taD6PyhJcdoN4tRh5w76c1OrEio3mqx1cGxptfyZbvSWa121JJi+8c9FDgX3KptvdZN5z2fhU2NCMgqJSXnAHl1eK0vYQlgywxA5UYflovOoX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTM3Ff/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTM3Ff/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14AB1F00ADE
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784121022;
	bh=HDpvp8vnAzoZQLx8FKACNiz9sLgSiXd+woO3izJE9Kg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=UTM3Ff/Xjfkc1w+y5Rc4E23kuZYtpT6J1qO39PbniNPQT1veAV/ch628jHHSoAc+H
	 UAoDbTsRGXLa40jN8Ur3skgvbIyziZGBxBvtZskuUwvhFYFFXK5HyAHrr+SoNyZbip
	 XEK9Yzh2X3pFzSek30zbJ8Ugq9u+8valytG86OO4Vbx3sUQRPBA491ZdgXcjcJ7Bmi
	 GEW31/+w7OC71rjSKOeMsvcT8Vpr50p9xQ9XyxGRHFOkv7F8umSXWPbwmI0AXXjJrF
	 aYNMEWXtCkwv1R+47Cxs+T/mjcGLt9Kp5EeHocbT2uzWtPwhNrl00Cqu7lKkr5gOLO
	 /Ghz4UbdRekfA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39d4c864bfbso23390281fa.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 06:10:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YyRISqQenozkqINUeA0+xlNjwMdgnEl8oj3sznR0pnpbOrvKwyy
	Vxc/YJh/uEOUPcHUj5/fts/nYS7JiQtdw2jJgFJkgBzNgX8+/27lW6bI+DHvS+bMQg1AzOMQCAW
	oW6pViiljlGn1rowZBjrjJFW3tDv2oMG4Ll6hKaA4zw==
X-Received: by 2002:a2e:a994:0:b0:39c:650c:454e with SMTP id
 38308e7fff4ca-39caa80368dmr38788201fa.13.1784121021501; Wed, 15 Jul 2026
 06:10:21 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 13:10:18 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 13:10:18 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-7-e7453c548c21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-7-e7453c548c21@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 13:10:18 +0000
X-Gmail-Original-Message-ID: <CAMRc=MdBC98zwc3jQwXgxMTEp_yBvjtU9cNQeRaTSsbZody3Zg@mail.gmail.com>
X-Gm-Features: AUfX_mwKvQxfwhOc8sChG6IUYiOddNnheWaj2Ma61SgPXzcEOXNcrLK8YSHAqsk
Message-ID: <CAMRc=MdBC98zwc3jQwXgxMTEp_yBvjtU9cNQeRaTSsbZody3Zg@mail.gmail.com>
Subject: Re: [PATCH v23 07/13] power: reset: Add psci-reboot-mode driver
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, mfd@lists.linux.dev, 
	Srinivas Kandagatla <srini@kernel.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jul 2026 19:16:35 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> PSCI supports different types of resets like SYSTEM_RESET, SYSTEM_RESET2
> ARCH WARM reset and SYSTEM_RESET2 vendor-specific resets. Currently
> there is no common driver that handles all supported psci resets at one
> place. Additionally, there is no common mechanism to issue the supported
> psci resets from userspace.
>
> Add a psci-reboot-mode driver, and define two types of PSCI resets,
> predefined-resets and vendor-specific resets. Predefined-resets are
> defined by psci driver and vendor-specific resets are defined by SoC
> vendors, under the psci:reboot-mode node of SoC device tree.
>
> Register the driver with the reboot-mode framework to interface these
> resets to userspace. When userspace initiates a supported command, pass
> the reset arguments to the PSCI driver to enable command-based reset.
>
> This change allows userspace to issue supported PSCI reset commands
> using the standard reboot system calls while enabling SoC vendors to
> define their specific resets for PSCI.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
