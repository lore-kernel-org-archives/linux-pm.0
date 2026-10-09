Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8DE3537D2;
	Fri,  9 Oct 2026 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528811; cv=none; b=mBjEg1ez9IK6g4Iey5emLd7B8Wwwsh4Rt/H/3gYdbkNdYie8wTGG7ZS/wqYT5+5InL+FXdl9UQ5CGRQS5IFt9cimyxjH90fqKkur6+l8j+1vKpvllwA+MFtzFN0qSURGiFtEAhTC4u5wb1xJ9jZEoIAbQ5vAcVrx7VSBSifDGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528811; c=relaxed/simple;
	bh=TF6GnToXoLBBTFqHdB7OCEka4zG8vEPbEoc8ux2XlD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iC3VXTTFL8ttxBLDCdyU9igFjWAaUpjIVq1GWUE2jQqSCuHaji7uHtVjQ051YYgdDnCqK0pgL/9CpoLnwrbF3WV6QOG/+YsnLlngDeLgOC/PwXniR5kuLbU3pXL01K/Q54HjffjqrbFjJEcpI0xN5CWUU48PwDZ1V/AJ/UCE1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsA7nHtl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsA7nHtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E34B1F000FF;
	Fri,  9 Oct 2026 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791528810;
	bh=8ZW60/51gHl6R6BZEMKR+YXq98dMzpk40zWpuDqBsxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UsA7nHtlHG63JM4b5FeBNBamuArLilgiweCQ08kXKkMO1qVFhIMJGsh8rU4Vnei00
	 SSPHEwX+MNClEt7P+4zBobmQcWaBfbnK7OkwxH6ath2b4IJLz9MMURHfW0Qf0+q5oC
	 BXWfmwgfzSmKhw8mtqwu99teEdz9q1mb6z8PeT/Xz547d+16BUcJgjU3nZ7b/qspQQ
	 +6qaUbJ2xh2uWYkQjTSchmvO+5y6aSqv1BkLkzQRsxQ6WyUUr8pVt5JeqS0Ucrf1PI
	 Ju3JoUGipOJuNrXs4hhmdZqfKNMGirwin5ktWCFboPf74StIatuP8I81VLgpGqs4ea
	 FO8nf88bCjPmw==
Date: Fri, 9 Oct 2026 08:53:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabricio Akio <fabricioakio@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Robin Snyders <robin@snyders.xyz>, 
	David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
	Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: qcom,pmi8998-charger:
 add chg-state-change
Message-ID: <20261009-winged-lion-from-asgard-acd5ce@quoll>
References: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
 <20261003-qcom-smbx-chg-state-change-v1-1-fffaef446932@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261003-qcom-smbx-chg-state-change-v1-1-fffaef446932@gmail.com>

On Sat, Oct 03, 2026 at 04:45:21PM -0300, Fabricio Akio wrote:
> The charger raises an interrupt when its charging state changes. Allow
> it as an optional fifth interrupt.
> 
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml       | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

