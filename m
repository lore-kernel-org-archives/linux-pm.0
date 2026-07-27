Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD273DAAB7;
	Mon, 27 Jul 2026 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134226; cv=none; b=FLF9wPr9a9UWjDtwTo1mu5Sg9mIemSCRCwT6RvwAhkOwTudb55FoZQ9EnfaQ5R3kVMUKw31+vj5Gn4VBI9TsWNk6nu2R8fuVE94L9dz6E86kPVMpJ+IXWXyCbuldabIMCkr5vJ1MT+WjRIj5hmq9lBmqb/DMq41yAa4az3i7jto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134226; c=relaxed/simple;
	bh=Br44rsqy8Y/vqkRJ4WB4yYMIyn7NXCz3AI17sUM7V0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tts9bSPYt1LsXPktJXBRkjVr5WexQqOVbwr9D40RX6+TS8qXAhVv5cQUi+5Go4Qa4n7H1c0obZPayNzwp7gHnLdKQEqIPEpViXhw0BLcqdyyuLyNwxniXOTHZhMO4Ow25lCEzk8KU5Uw7DY+1ZPu6kupf8KJEwVDQX8JbhBMuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3RS8IUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3RS8IUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAF01F000E9;
	Mon, 27 Jul 2026 06:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785134225;
	bh=fSvuWV/ybqtJ7ApEVWZLZWn5yuDbYL6SovRtcrTMX6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C3RS8IUdfYC4vvQZFPgXTN5C4gJz09jkQnXItOIYBoucK2McOmqNW5YiNIStL3mEV
	 Jrxf0ifuT4S+m0LR2l5RzJVzZTkoENpXaygI/vfTpq8b3o4kHHgRE7+xfeskDnrS8X
	 pawqW4DU2piDUXW79WJu51P9/dYB2tj+nrv4O1S9ig4ihskCvWLvWUup3aJinQeHc+
	 5XcmwiSjgDIv8xS1CZqe+GqnpzC/tkTiS9wt1UXgoZuZArNkrAKwdu4GjOhQP4407m
	 uixPmIVB6BIlRIZXRbihKMVPxdPfoOYk7dD1340a5SViN16mchHCuCwpnSpYzlwCpj
	 V1eaqSiiLQpcA==
Date: Mon, 27 Jul 2026 08:37:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Message-ID: <20260727-horned-seagull-of-tranquility-245f0a@quoll>
References: <20260724-b4-add_pwrkey_and_resin-v6-0-41acc214d93a@oss.qualcomm.com>
 <20260724-b4-add_pwrkey_and_resin-v6-1-41acc214d93a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724-b4-add_pwrkey_and_resin-v6-1-41acc214d93a@oss.qualcomm.com>

On Fri, Jul 24, 2026 at 03:44:11PM +0530, Rakesh Kota wrote:
> PMM8654AU is a distinct PMIC variant from PMM8650AU despite sharing the
> same PMIC subtype. PMM8654AU implements additional registers added to
> the "hlos" register address spaces, so add qcom,pmm8654au-pon as a
> fallback to qcom,pmk8350-pon to distinguish it from the baseline
> PMK8350 PON implementation.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

