Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9739281D;
	Fri, 19 Jun 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884028; cv=none; b=Sc1ooa6saxpnTUJZwXobDsMdkMtchiytqJnOlFR1XbW5jqltltFErlzueCVh2Xg7i+5Hu9nP6ecmgpqGj/uLWzgKkgvbOcgwL3nZTRKro3PI7ppDN2+8unPMEGDCJKTv8vbY23+8FlpNoPYsCkATC639y5AsJj7fSHydnP/Fz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884028; c=relaxed/simple;
	bh=PJQLTLFNyJTetmfIGrR4jo+BqWwhP5eythFoJzttaj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqEd6kI19+AJWQKNTRunw7mcz+HIWtw0Gdh8BjP2E1fiPwB3xmMF/3Ihmvm+byrS4rUhpFXW+PfEpTaaRKn+nBaTUs4dI3EMhlEvEn20z8gFK2w/HOqDHkExVKr9XwyBgWEPrFixjit18AE/eKaz1q8ThaonAMCv8Y7V2tC3vAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxNlqYdR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxNlqYdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE721F000E9;
	Fri, 19 Jun 2026 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781884027;
	bh=jwzW1YZuf6s0XgJIN78yCoG6M9J094IzLAb0cLlAQno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jxNlqYdRPylC2g7Igqwh+Q2DuBxkAUPv2MPJRAuOoGOM+AFwq1YBi/LhXFPhnATTn
	 1k7rsbW1i6dzTVtwsooWn6P/qd1HGvykH3Vr/4jZs/FXngf1JQWO00dET3HrZqbwNn
	 KU3s37Z0yU7mW4Z0JLqpd+Id0Exmi4zghbIadQqJWG0SwQ0MIJ7XEQk7zaZVn1VLJR
	 n/PEDLrAnpAdCDx4ldx4x90okkjxjsAqsKDX3nOfmSSENOpVDWXe4HkbDVKGILeE+g
	 bzDrvDcdOultCSo02l7oGeDqiWnA3nwl5nCzc+utCUo+T+MFszwdYqolfiBtPEbcfH
	 l9LjXQ65aLIJg==
Date: Fri, 19 Jun 2026 17:46:56 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Song Xue <quic_songxue@quicinc.com>,
	Sebastian Reichel <sre@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	John Stultz <john.stultz@linaro.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: Re: [PATCH v22 00/13] Implement PSCI reboot mode driver for PSCI
 resets
Message-ID: <ajVkcD3pPIRcEPks@lpieralisi>
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
 <0c6636b0-f6c7-49dc-b335-2b4fac16b848@oss.qualcomm.com>
 <f0336ce8-e5e0-4629-ac51-f3c42bf3d9a9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0336ce8-e5e0-4629-ac51-f3c42bf3d9a9@oss.qualcomm.com>

On Wed, Jun 17, 2026 at 10:30:21PM +0530, Shivendra Pratap wrote:
> 
> 
> On 29-05-2026 19:00, Shivendra Pratap wrote:
> > 
> > 
> > On 14-05-2026 19:55, Shivendra Pratap wrote:
> > > Userspace should be able to initiate device reboots using the various
> > > PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
> > > patch series introduces psci-reboot-mode driver that will induce
> > > command-based resets to psci driver for executing the device reset.
> > > 
> > > The PSCI system reset calls takes two arguments: reset_type and cookie.
> > > It defines predefined reset types, such as warm and cold reset, and
> > > vendor-specific reset types which are SoC vendor specific. To support
> > > these requirements, the reboot-mode framework is enhanced in two key
> > > ways:
> > 
> > Hi Lorenzo,
> > 
> > Can you please review the if its aligning towards the suggestion in v20?
> > 
> 
> Hi Lorenzo,
> 
> Was planning to address the mfd, and other comments, for re-post. Any
> feedbacks, that we should take care in next post?

I glanced over the code - it is better than it was but I could not find
time for a proper review. Go ahead and repost we will take it from there.

Apologies for the huge delay in reviewing it.

Thanks,
Lorenzo
