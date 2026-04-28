Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2334A79D
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361938; cv=none; b=EYgf8Cyr6RO+YJu0I/e90icF/cayiAg4zIEWbT5wePVCCv1yZVWFxHusWfi0FRdxOo+0YmgK5MWGKWyadvomJhY9jLqH73aUihbdY5h2NTXfLU8lFskoH069S/7CadKUYYWLADAm7rRHvM9WByJwF8LUbTeXC+AMUNySYt8VamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361938; c=relaxed/simple;
	bh=M8+6UnX+4lN+I7hSH5w2HlitnXoe39zLUp85i19lW4k=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpCt/9rR/lPdb72C+/ry92vxt7tzW9YruSZsTdXtdzeXPxQ32kTkbhbkyEp6hc2OifAXHgGPv5mn91OcYuQnkmC2N0Gk95PNH26WHgoW58zXIRFv+8FjnJUJn2gonXOeRlEGccwChOa3hhaECYDGPABOAVeArHOD/G8aqxpGTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exdndTXl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exdndTXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3623C2BCB8
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 07:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777361937;
	bh=M8+6UnX+4lN+I7hSH5w2HlitnXoe39zLUp85i19lW4k=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=exdndTXlRxThyJGPMZoGsrhIEXUARtyMvIjuf8op8WGky70Fh1CYQMazkjhVRT8Mh
	 wfx5U+58ChM4CAl1f/qOYKYgrHhAtnnMOvXqLIzDxW534t1c5vFoCjVwOmEwg2Wa8D
	 yW7geuXxgP/f9U2CiRDbXT+9WLp8ITQKYRubNXdx1DdRouyx7Xck4x1RCoU+Yc3R/a
	 EKukhLU4h9yNp4cu6QO68X4VOFvzQtojmKBsxMiE3LCL8owm6/PfgfAqg/lVN3VyTn
	 v6puGg+NRDEE/X4FaEAfmuLzBFLIvVLd/vEeni0dgKX8zPpsO1imHMsX+8no+Yj7XJ
	 1DhvG2hQOD+LA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a2c9c5ff87so11540639e87.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 00:38:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YycnWnZyigcVreGa1hC/GRolQxM0cwIukNcrm3DqEXDJjD5k1+S
	3UNYbveBuFBL5uXsAy18mHHRIFxJEzdp/sXz9jFpKJU915IkyZkXdcLeYZFNFKbMycJR29LVfPQ
	DWlDipGUWqA5h3AoNtJxoJH2fX1fjpNKwW4VSQc8Ofg==
X-Received: by 2002:a05:6512:3f12:b0:5a4:17a6:9780 with SMTP id
 2adb3069b0e04-5a74660a971mr759395e87.14.1777361936359; Tue, 28 Apr 2026
 00:38:56 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 00:38:55 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 00:38:54 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-2-dcf937775e73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-2-dcf937775e73@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 00:38:54 -0700
X-Gmail-Original-Message-ID: <CAMRc=MevqR=ST_-WO_CAUc7stKmQU=_Qp7BTrewzvg40x=JiLw@mail.gmail.com>
X-Gm-Features: AVHnY4IrhreEwlQ0Dtd2BuvGIlLYNK7-acJ0gJkWUG1j_5wLe4XWVKLYqD4Vmhg
Message-ID: <CAMRc=MevqR=ST_-WO_CAUc7stKmQU=_Qp7BTrewzvg40x=JiLw@mail.gmail.com>
Subject: Re: [PATCH v21 02/13] power: reset: reboot-mode: Add support for 64
 bit magic
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
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
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 19:34:42 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> Current reboot-mode supports a single 32-bit argument for any
> supported mode. Some reboot-mode based drivers may require
> passing two independent 32-bit arguments during a reboot
> sequence, for uses-cases, where a mode requires an additional
> argument. Such drivers may not be able to use the reboot-mode
> driver. For example, ARM PSCI vendor-specific resets, need two
> arguments for its operation =E2=80=93 reset_type and cookie, to complete
> the reset operation. If a driver wants to implement this
> firmware-based reset, it cannot use reboot-mode framework.
>
> Introduce 64-bit magic values in reboot-mode driver to
> accommodate up-to two 32-bit arguments in below format.
> |    Higher 32 bit  |   Lower 32 bit    |
> |	 arg2	    | 	    arg1	|
>
> Update current reboot-mode drivers for 64-bit magic.
>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
