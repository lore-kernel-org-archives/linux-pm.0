Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8332BE03C;
	Sat, 11 Jul 2026 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788491; cv=none; b=pw3j7OLW2iwo0kiVttVvv9ehkGn9doYCxATQCPA4+3/+v6omM0Wyfe812FeIkYDb6UoepShycFSt5O86ovkvzDyLuztgdxGL+ih9GUvsRFvS6g5FvNftIcpiPOgzGfipiHazXh0qzEn7+42YYmDGlBXNqME5b2vf3Z120eD+CEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788491; c=relaxed/simple;
	bh=Em3JnNWY5GBQln9wQgzU9rMIT3B+Um4B9ZchlZst4J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0+wuIhOSUwDaU6fjVJwc9qy9+UU++vkfj1kd3CRq7uCx6K2lj60f4EPRiU/bmbZO0dJGrnZgHfC4H6lUe0H+qlPOghCVysxaAUQFXy6l5LqDCo6gDlIwo4tlEHNonNK8cT+SI187txo3hziSNqaSY/UP7LjxHHsjPAXwfBj3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpIYMSbY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpIYMSbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08AC1F000E9;
	Sat, 11 Jul 2026 16:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783788490;
	bh=4uc7rJd18EDppqVGAeMwc5Uq93urxmdlU917bXG2fWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dpIYMSbYP6OhuuRrG/dJrwgysxLKciZh1wLRhYoxaTyrqDMeWSebky1ZYd+R2dlo/
	 F7voVVpVgaMld05AFvo6uFwfuRhEGp+EvrXvcM38WoXTMFyLzs1XxXPAbZA/ei3P14
	 rUL+OGYD33GwmLiZVMpNco74jRXSG+Z1em16DynzzYEp9as1YFeiNvjrA9hFmm6nrE
	 8h8YW0AMSfH21Ybjd+SmlNTRGUAnTWW3N3ZgNNCSk3v84ClbBsw8bVsfH7+ZMqURBT
	 mjzLaEQT69via6fIX+glg2Jx4TadOdYTywdcC6JZTSSvk/Hc8ajNezASyQj4ieOE+v
	 fhrc81t3pjyvQ==
Date: Sat, 11 Jul 2026 11:48:07 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/5] soc: qcom: Kconfig improvements
Message-ID: <alJyHU1C-kHzuC_p@baldur>
References: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
 <178378282267.119479.4576908957568734087.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178378282267.119479.4576908957568734087.b4-ty@kernel.org>

On Sat, Jul 11, 2026 at 10:13:46AM -0500, Bjorn Andersson wrote:
> 
> On Sat, 11 Jul 2026 15:25:00 +0200, Krzysztof Kozlowski wrote:
> > Merging
> > =======
> > Defconfig change (last commit) depends on earlier changes, thus that
> > patch could wait a cycle.
> > Alternatively, everything through Qualcomm SoC tree, but then please
> > keep these on a dedicated branch in case defconfig has to be shared
> > with soc tree to avoid conflicts.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [5/5] ARM: defconfig: qcom: Drop Qualcomm SoC drivers with defaults
>       commit: 86690b3fabd66970e43f1d1fd4a9ed641850b924

Sorry, I tried to unmerge this again, to avoid ordering issues between
Kconfig and defconfig, but failed. It's actually been backed out now.

Given other changes in drivers/soc/qcom/Kconfig, let's merge this last
change at a later time. 

Regards,
Bjorn

> 
> Best regards,
> -- 
> Bjorn Andersson <andersson@kernel.org>
