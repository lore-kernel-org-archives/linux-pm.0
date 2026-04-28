Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208933343B
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363391; cv=none; b=c1uT6uv6z0COHM0jXx9FHFcB8xvojE3Mgu4wZJ9a5WzbCnhGe05RepvqU1RlFozpWobhrTqFvujoqpndbkl5McRF8DbXpKpDBzl/4peL6w3Q9M/54TlPhhwByhzZcKktYO9N+J09FlTDXngtwEnfaAv0Uofkh0il0i021BtC36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363391; c=relaxed/simple;
	bh=gakvkReg0fVWUJryauTzFRkfayEeCg9clm8BNqJgejI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxFaOnKkrl3ZgYZp1e7ctbEZpNiZxdNXQkR3z9Mb1Wcq4l5V5RE2OIw6ehwz5QqCUliGOvigNefJQhoN2ZUehD4eBuOojKow5hgcAAjHC1OwU0RX+SGBXxitTMXasgZzsTSWsCixbxp7KKUC/sF1A2vSDLGeRkQUrrvadcSZT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCiU8DcV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCiU8DcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F34AC2BD01
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 08:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777363391;
	bh=gakvkReg0fVWUJryauTzFRkfayEeCg9clm8BNqJgejI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=gCiU8DcVwQEowwEAwYG3MsLXklegyS09HYA2QCs3e6rYJLLSuDu4SxCyVK/2W3YTQ
	 c4OVu/MwPcLnaGuDdakQNX9jF3K7FgFpCtLxeCgZnYxexquRWElzbN8IiTVf7h3/sH
	 TjWwKhJ/vwNqnh6wMoUt0GXPslR3z+122nus16tJ8Oq2oSQUCzPvY6MNSq66TFLH6w
	 BLy/DF4wCtHjzGSaqjiuGe9opjrUvHVnP2yqkgtQTkjWx8vCcSVtfqr6BHlCNqgF1X
	 Jruz9Ja+u7JLPvVfJwGOu45gIIwSAx7oq8uVWzzStz7fIu2YHagpL4xuwlYEGrDnKV
	 T06kp866Vry+Q==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e7d983f79so84817691fa.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 01:03:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YzsKOxGghiNJHAEwN1sysXNwS3bTSRxXUNywUKF6dTp0W4d4Et7
	GYbvFVRSZjV3C8+t7DCsW04CU8EmcruCJCaKMT9yux7r1dtM5hKE0RkZBeHFFD8dWrzSYihh3eH
	2nTKqyqj4VjwZacBZdpVUfeasaIvs0uagH7mSPc02dA==
X-Received: by 2002:a05:651c:b13:b0:38a:8199:1b60 with SMTP id
 38308e7fff4ca-39240e2f97fmr6452871fa.6.1777363389951; Tue, 28 Apr 2026
 01:03:09 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:03:06 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:03:06 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-8-dcf937775e73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-8-dcf937775e73@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 01:03:06 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mf+-04Zr7jjRoaxTzO3LKSMyQ7DzxJc=dHNSyThEUiq_Q@mail.gmail.com>
X-Gm-Features: AVHnY4KzpDYlkP_BmYQb8Tu_NftXGx0jC5UQCJ6_82FV8dMIjk5ibCMQsX_dXwo
Message-ID: <CAMRc=Mf+-04Zr7jjRoaxTzO3LKSMyQ7DzxJc=dHNSyThEUiq_Q@mail.gmail.com>
Subject: Re: [PATCH v21 08/13] mfd: core: Add firmware-node support to MFD cells
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, 
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

On Mon, 27 Apr 2026 19:34:48 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> MFD core has no way to register a child device using an explicit firmware
> node. This prevents drivers from registering child nodes when those nodes
> do not define a compatible string. One such example is the PSCI
> "reboot-mode" node, which omits a compatible string as it describes
> boot-states provided by the underlying firmware.
>
> Extend struct mfd_cell with an optional fwnode pointer and attach it to the
> child device during registration when no firmware node is already assigned.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

In the following patch you use this and violate the supposed constness of
MFD cells. This also mean you need to modify the mfd_cell at run-time. I would
prefer introducing a field in mfd_cell: bool use_parent_fwnode which would
indicate to MFD core that - in case no fwnode was assigned from other sources:
DT or software node - it should reuse the parent MFD device's node.

How about that?

Bart
