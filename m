Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58372332610;
	Wed, 12 Aug 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541142; cv=none; b=kTRSt5WED7T1q7B7L+lItX+BsepZhVEgOXnYvcKfuTvHfv3hBoRQKRv9gq692AahYDGM+mpK6AQM8IDAdRfm0LyJRMgWZC+Srf865iVX92xdzP8cfmCfxtikoA68P83yMYalNmV0q1psbHJ/GQmtaF+DY5pKtzdb+uEd2DSeWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541142; c=relaxed/simple;
	bh=iMMr7BVoCnAiNC4c+t+ovPY0rzFvelMbWGxbDS8xn8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/qKDbXRyN2xVDL7WEXsxTEAIDz/yKPBtHTO8CZmpezo3VT4JDS4ru058OUhvyClhhjCgl/6ccI+YbluiVQbUcQDylA4gffdchTGgFMjcU1+lCH93Woo66bAEnGf1rSVHKPzSVsBfFYsoyycjA7MyF1vFogswutJwF507A+bs6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkyjbaKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkyjbaKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8BF1F000E9;
	Wed, 12 Aug 2026 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786541141;
	bh=XdWKg3Z14pzkjiIKFnBBxrtOl91QbWJYbzd6e96ktA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JkyjbaKQcvZkv8h6FOccIz/vgPW5PWA50Jru9v74xeCJrCWHuwDvkzSZtawDpWsTl
	 fa3pz2SueGRrasjvZ9rsaVVRPEALCEqUOP6/s1zeKosF6z4kxae8rUOA/AgT5SbqEz
	 gDPizQVq14lxbVrg9YUbSX6to0qe9QtIbnquZ1XUYh50+qlQlcPCybCohbTHrG0n37
	 myvuGH2exrgu00cOgcLjIpKmR2DJl8SgB6sLo25rrDEKpOKQSZhppe997YixQRgviL
	 /2ic0KDVFJ0kQeSEAvXDk3IfI3Dm5UdHJdc+WoV53B853PuyKftMqNl660d1ruqgJB
	 ZBlLKEUkXXSBg==
Date: Wed, 12 Aug 2026 14:25:31 +0100
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, mfd@lists.linux.dev,
	Srinivas Kandagatla <srini@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Subject: Re: [PATCH v24 08/12] mfd: psci-mfd: Add psci-reboot-mode child cell
Message-ID: <20260812132531.GS1072730@google.com>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-8-889281373870@oss.qualcomm.com>
 <20260812081856.GF1072730@google.com>
 <CAMRc=Me7Nua8xgKA43rCH9SV2DQoCyAuOqb+KNDTuPxv_H5y9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Me7Nua8xgKA43rCH9SV2DQoCyAuOqb+KNDTuPxv_H5y9A@mail.gmail.com>

On Wed, 12 Aug 2026, Bartosz Golaszewski wrote:

> On Wed, 12 Aug 2026 10:18:56 +0200, Lee Jones <lee@kernel.org> said:
> > On Mon, 03 Aug 2026, Shivendra Pratap wrote:
> >
> >> The PSCI "reboot-mode" node does not define a compatible because it is a
> >> configuration of boot-states provided by the underlying firmware. With
> >> the new firmware-node based cells in mfd-core, this node can now be
> >> exposed as a proper child cell.
> >>
> >> Add the psci-reboot-mode child cell to the psci-mfd driver with a
> >> named_fwnode. Add psci-cpuidle-domain cell first to isolate it from
> >> reboot-mode failures.
> >>
> >> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> >> ---
> 
> ...
> 
> >> +	if (ret) {
> >> +		if (ret == -ENOMEM)
> >> +			goto out;
> >> +		dev_warn(&pdev->dev, "reboot-mode child cell failed to add: %d\n", ret);
> >
> > Okay Yoda, but why is this okay?
> >
> 
> Hi Lee,
> 
> I'd like to call you out on this because making snarky comments on a non-native
> English speaker's syntax is really not OK. Please don't do this. As a native
> speaker you could have just proposed a better sounding version.

It wasn't supposed to be offensive, it just made me chuckle.

I unreservedly apologise if any offence or ill-feeling that may have occurred.

-- 
Lee Jones
