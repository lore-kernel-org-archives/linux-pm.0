Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2982FFF9D
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803982; cv=none; b=Xxgt3GIOHsBADjwJttMQ97Ka3PbaC/ufBZmM7BRTiZw0xJSVhFJf5+RKEn9LUWcinWxy/lNhF52o6PfriGDlG+xHq0Rh92/0v7gzJ8FjqXo9LQy37Ax3DCRGBqXnkpgi6Hrn7NKhnAy0Lg+DLpH0Wnl6bS1jHEpJTGKQsu+Ut68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803982; c=relaxed/simple;
	bh=1nuGL5zzw0zKNjB/h9iN2OowlI7SEPx+4e4uFF+OfJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+WoB0HQQHYt+pfSczBhoHVH7Ypn5pdY94cNtU+h40bBenWXdgDPNo9gkzJIJxmZ8o8ZMxeoHUpoDkyFtyqW22Kbu2tSDDBCe1jm8I2Zrr6xXb1lvGDo3/7xsySXmvgxKHO/AeBmTOuuRk8uZ0ZrNFilbfWbe9Pu2xun90OO/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOkFqN3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOkFqN3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222D0C2BC86
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772803982;
	bh=1nuGL5zzw0zKNjB/h9iN2OowlI7SEPx+4e4uFF+OfJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZOkFqN3rpM5FnQzuj/wxXFi57BTVISDoLMfjaJj58zDSCpJXEZYyWDen1ceKY1QGK
	 Msd2uF0kfk4ECoZ9TJrO/sKOCT11Tbu1dpp/HC7ox1qtuPQZ3uar7ATaWy4xt+CwcS
	 0+4oRzooeVmFpY9SaEXVJigmuuLdBrvLp8/z4aavzNEs9Lh15R49xh1xi4h/M/+x2J
	 unruUlkS+Yxb8evZPRyaZrcpnS3UOtb74sI22OdpcBx1GcGySdfbW9a7cnPaAWTqvK
	 ktPPomfr2hpGBQrmorFCtHqqLIcwG4N+vGLkebfAJkNuZEUBhaNc5fJmzuvgpvLc7J
	 AhaFAtdoAFX4A==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so2930345e87.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 05:33:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8yrsAlXnmzzU9gEWh0lXZh/8d1rt8/MXn1V4axmfYPS5xuULE57WLTBxwJlhAB3C2zly8J3iZlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUq0tCWIAbhKSNf0atwM0h2GhadHAKsWbDvzZUoWbfyIWYu7t
	b8E0rlcXQq0LwxnVQQzYl9pI6hJNHvmz6py4WGhTAL4S5wQycTLf2Yi07oT1PyZF+vxPtqTyDQ0
	sxFXYQEhZ4/Ge3IdGFFgpVuEhidSJK96k0LSrBo7CmQ==
X-Received: by 2002:a05:6512:3048:b0:5a1:1d47:76fa with SMTP id
 2adb3069b0e04-5a13caae7c0mr631136e87.9.1772803980252; Fri, 06 Mar 2026
 05:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
 <20260304-arm-psci-system_reset2-vendor-reboots-v20-6-cf7d346b8372@oss.qualcomm.com>
 <CAMRc=MewwLTsaHCOR2iVYZRM6kWptQfZuTe=2i_pfpTwjFKEpQ@mail.gmail.com> <1f75b250-c3b5-45da-bc82-aeadf44dfea4@oss.qualcomm.com>
In-Reply-To: <1f75b250-c3b5-45da-bc82-aeadf44dfea4@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 6 Mar 2026 14:32:46 +0100
X-Gmail-Original-Message-ID: <CAMRc=McUdboG0ziWmUf+h9mUiuGesaFk2v27z_Opbw-AF33C0g@mail.gmail.com>
X-Gm-Features: AaiRm50duFLHMSGqN_XTEZwDEkS1OZDEz-KXG7iHPD2r1Opb3JkLo4OLChEHr30
Message-ID: <CAMRc=McUdboG0ziWmUf+h9mUiuGesaFk2v27z_Opbw-AF33C0g@mail.gmail.com>
Subject: Re: [PATCH v20 06/10] power: reset: Add psci-reboot-mode driver
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, John Stultz <john.stultz@linaro.org>, 
	Moritz Fischer <moritz.fischer@ettus.com>, Sudeep Holla <sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 6:07=E2=80=AFPM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> >
> > You should pass the address of this function in faux_device_ops instead=
 of
> > calling it directly.
>
> In last patch, we were using a probe function. As faux_device_create,
> calls the probe from its internal operations, "of_node" can only be
> assigned from inside of faux device probe.
>
> As our primary requirement is to assign reboot-mode of_node to the faux
> device, thought to make it this way. (As we did not want to assign it
> inside the faux device probe).
>

TBH This sounds like a limitation of the faux device API. I'll Cc you
on a patch proposing to extend it with the ability of using a firmware
node to describe the device. If it works for you, you can integrate it
into your series and use it.

Bart
