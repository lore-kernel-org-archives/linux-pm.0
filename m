Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA741C312
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825743; cv=none; b=A1VPLWQE4N5xjr6bscAb5wp+xxwcFexR2WmsFAOSsr2Qo5D4aZovXZ4kBgxJ07rXvzW99n86iCh0shJlbD523eieUVql7Yk9rS0f6aNYDXYsKz9MNEfa7yqHT8jXoLcokgjZXmEHiiMoAK6wRUD04PPbeWv6lbCo0CIx79wAsVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825743; c=relaxed/simple;
	bh=Yu5mqQ8nw8gfVDomx+A+E2dr0aoWMwEfUHHcXE5j1Sc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQyTJDW3Wptnz7oJyKMmULUnS8zNcBHtMZCN/Sjwkx1kPHDg8/0pmM6MR8S6HJ6RS/42mWXGTY9xIvIKvVJ8PtswZKoh23/oL5pq1WFYYtQ4RX1ULz3txgMJwdDcxO+2LqAjhX4GrSpa0AcqlAvwO1t4o4wr2iHVEkICQi1lnhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3iwES12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3iwES12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8131F00AC4
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825740;
	bh=siJF0S+CSX6SKMbF6lhMt/C1v2E/StqLW87OFuT5mug=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=F3iwES12zER0i81/2NMtABU7zrTqL4TKx2cZUTm/v2TeQRy1CfP7kHBRH6cHz49Wl
	 RJ1JW9A2Skgmb9dTIcCCyQh6C1DNwFDhrXfchvkmp4GrC8LQ++VkFJnqhDMYCbtUtl
	 4Vg0G3QFf25X7xnQRhstpZa0iIC7smC2iN2KaRpHAUXmkcVwsqV81tOBtFhSFXPIex
	 esSaiw8hPZjYzdrETojWRvoLheQXFZfgcawxD5XCycu6ixqXf/vTCuVrYXIMYfWHHK
	 h8JLEFO/R0lpZffXy0p0WwgFlYuPMNX5XRlG/oUhaROQuxTwADcIS8mJtHKiIKEwhR
	 8feBVjbj4d7cQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aebf9a509eso501125e87.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 06:22:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Robi62TLbAl59dkfSRGVs3ABvxscYAUpVy5nMhK6Ri/26xUmAc7aUcITb6hk3JiRncJEgNWmljb+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFyHKfJpYNNCRs4iB0UDDlvlW4HTqrn2kfN3XeslE9RcmJlVo
	Y+pARngtv2rdjfr9vmhSNDT2aViSkeKOwucSpt4zFO+tmAExnzYmE0QjSPGsI4h60KsQ5obhjnN
	Wd7ZV2bs3dZqZxOH87KaNsqzCZJ56XNrmssiIJaGqDw==
X-Received: by 2002:a05:6512:8041:b0:5ad:4f1c:8e50 with SMTP id
 2adb3069b0e04-5aebdba2f7fmr745427e87.37.1782825738263; Tue, 30 Jun 2026
 06:22:18 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 09:22:16 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 09:22:16 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <263f58b418a27a2339fc2478f93234e0208b0ad9.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
	 <20260629-pdev-fwnode-ref-v2-2-8abe2513f96e@oss.qualcomm.com> <263f58b418a27a2339fc2478f93234e0208b0ad9.camel@mailbox.org>
Date: Tue, 30 Jun 2026 09:22:16 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdQURjypSn+QjSDJfEiOMC8bbEZmZLgjpt=EquAM1Q1pw@mail.gmail.com>
X-Gm-Features: AVVi8CeQXBZd5M2B6MhLUb095jshYyZGAJu3z11iktq0q6r491Qj_z_hr6U3W70
Message-ID: <CAMRc=MdQURjypSn+QjSDJfEiOMC8bbEZmZLgjpt=EquAM1Q1pw@mail.gmail.com>
Subject: Re: [PATCH v2 02/19] driver core: platform: provide platform_device_set_of_node()
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jun 2026 13:37:54 +0200, Manuel Ebner <manuelebner@mailbox.org> said:
> On Mon, 2026-06-29 at 11:12 +0200, Bartosz Golaszewski wrote:
>> [...]
>>
>> +/**
>> + * platform_device_set_of_node - assign an OF node to device
>> + * @pdev: platform device to add the node for
>> + * @np: new device node
>> + *
>> + * Assign an OF node to this platform device. Internally keep track of the
>> + * reference count. Devices created with platform_device_alloc() must use this
>> + * function instead of assigning the node manually.
>
> Doesn't it make sense to add a remark to the kernel doc of platform_device_alloc()?
>
> Thanks
>  Manuel
>
>>  [...]
>

Sure, will do in the next iteration.

Bart
