Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583E347FE1
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456272; cv=none; b=L7LnJQMkCwtJu86es1bJuqNRGab3oKqPobebzLnuzEpL58IH57bkiyqqLdlJGr83qFQrOUYyLOyKmcsxw+y+w9IJ3kEqLQyfKj8yivuzCffCGKVXXdsJpke3FrJpVBGK6QJaRwvL0cWojp0XPoaDeLGCVwUphaHSF7W/Px/m+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456272; c=relaxed/simple;
	bh=xl75P3m2W4e1+CXN4v9hPNik1UQ7Md24Me8vwhtUHnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKI+97DqOJszImttWjMHxQGex2WSxsnYSDC5k7ivfZtPlaEspDcJQ6UWkZLiGML7ZduTA0H30vxZAzAlDcekWAuAKBlpwzHaS510X3ZxkiCNRKVmRNrMnGZY0Qkc1Ra/LDc6iF/4IdzdJXHa0paPdU5rlStMILU6JqBl8PFeZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1LsHEep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1LsHEep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7901C2BCC7
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777456271;
	bh=xl75P3m2W4e1+CXN4v9hPNik1UQ7Md24Me8vwhtUHnI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r1LsHEeptVM1+C5tb/F06/FEv+YdBnyquB99JAZrLKmItqwb7+lOoFfUrzYG3P2aZ
	 TaQKktyRsDc1TXy9LiocFB3U5YQYVd2dEesCp5M7GkvQCSfeVIJZ80oRtpq58ZSRbr
	 A/PMnsK5Y/PqwpN1k0aiWSdmIv3xtSmC8jkr5B3kJeVaWorsJ3dZqBeu7EBewryMEr
	 x5boLEYdBYJ1RAgegju5fNrYHLQiyYt//71nSkAfnP8MY8qvsJkZ8mPorObi711bJn
	 OMCK+5uRi+l/2+vHANE7hBCmOeABKcUiZJRPUEPB5jHN0qFdjZ4RZ8Q0GlyhuU4+YV
	 h8rV5BRs+RL+w==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a525aedb24so12351321e87.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 02:51:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YyxxauRgE0Tw7MGt7B1fGqgbmWfpCD2tuuaI5ObYdy4NycoCINB
	T7HVzwVmUoNsIhGgVHbG6I+tiIVe75wGUJflGIIxbHDzM6q00NAeUoWYt299et4gqenVd2t5/or
	dDQNVKweFd27T7ny/vi2ujsFu/1RM+5yHy8s97K+lag==
X-Received: by 2002:a05:6512:15a4:b0:5a2:c0d8:e634 with SMTP id
 2adb3069b0e04-5a746409fc9mr3018093e87.8.1777456270423; Wed, 29 Apr 2026
 02:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-8-dcf937775e73@oss.qualcomm.com>
 <CAMRc=Mf+-04Zr7jjRoaxTzO3LKSMyQ7DzxJc=dHNSyThEUiq_Q@mail.gmail.com>
 <c0677503-8073-4940-8eb0-c06b34f843d2@oss.qualcomm.com> <CAMRc=MdxpSXiqAn-8Az4ig4N8TFVdE9psacPVG9J9KehuFnbwA@mail.gmail.com>
 <d6112b9c-01ea-483c-98fe-b480e78872e5@oss.qualcomm.com> <ce92a493-5016-41a2-8337-d2227cdf760a@oss.qualcomm.com>
In-Reply-To: <ce92a493-5016-41a2-8337-d2227cdf760a@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 29 Apr 2026 11:50:58 +0200
X-Gmail-Original-Message-ID: <CAMRc=Md_OON4cAGcJ=jDu=VY_mw0qa8HPz4VCDxYLpr7JMxLRw@mail.gmail.com>
X-Gm-Features: AVHnY4LjKEpG9nYw8-Iw2BW7MqAsGu51jz6EVLHSjBeVIe-JDK-BL3dxnn93Q4c
Message-ID: <CAMRc=Md_OON4cAGcJ=jDu=VY_mw0qa8HPz4VCDxYLpr7JMxLRw@mail.gmail.com>
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
	Sudeep Holla <sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 11:46=E2=80=AFAM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> >>
> >> If set, it would be called from MFD core and would do the name lookup
> >> and return the fwnode which would then be assigned to the cell device?
> >
>
> Or should we just drop this patch for fwnode in mfd-core?
>
> Export a new call in reboot-mode framework as:
> reboot_mode_register_node(struct reboot_mode_driver *reboot,
>                    struct device_node *np / fwnode)
>
> Use the parent node in psci-reboot-mode and find reboot-mode and call
> reboot_mode_register_node?
>

No, I think the reboot-mode device (as pointed to by the dev field of
struct reboot_mode_driver) should be associated with the right fwnode
from the start so it should be handled in MFD core.

I'm of course open to other ideas on how to do it.

Bart
