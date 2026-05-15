Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F7842EECB;
	Fri, 15 May 2026 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835919; cv=none; b=uGdJ+mBTYoFsL8fobZz3/MCx+l94OEwG6HCC00+gb/RWOqAUq0+Wj2Nznr6GRe+Q20R9jJBjYmnTnZnqAjRETDcg61vf2Zt12lyXb1hR1Cv1qJYpeHIVpzZTLvAY4jwpVCeW8nrIkQ8JOtpUqyNj9XL3WIV0Kxbp5x9ByWMP0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835919; c=relaxed/simple;
	bh=VhEicRlMGtAxi84+7aRzrOdl65IYWc39h+MlbwpsgyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8WfdEr0mxVDMpFCJvY9d/X0sZMA3LsPttZBduhffAw2BtyxSd9V9AMly80e5cWkY4MTxORuRWxUOfPmD9Nhc90QICueJClsBHRHAz3xjq2o2Rr0H5CUc6Ewk7o7j5gDpClOK1HNNM/4QGM2kyu7BpjHByLiKxqDRyH+1EXr2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz8RiG6M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz8RiG6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3C5C2BCB0;
	Fri, 15 May 2026 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778835919;
	bh=VhEicRlMGtAxi84+7aRzrOdl65IYWc39h+MlbwpsgyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mz8RiG6MWE1K2cXAsl9A3PilAfmaqcx0jggD4GcV7yN04GpzJ2c4AxOUpsUjRJ94D
	 TzSAQc/pXKvrllEa5eUImkeX4zvBHhx1qc16a+27L4NB1roVeh8XOWgzYnC3zsLlv8
	 XuEXp4hnhEDZxGNgA65jSKQ/UoDAoVlb7RqstBfVWgiTWPGgK07zluzIch1on/H54L
	 apa9DMN/qPoD3fAzD9kWU6y1ASZ7u12YDW1ponjbWOQjoLz9iPecNX8t5MNFYZSj7K
	 HrNz5mvqUIxU3ySfenM0sS70AGdiitZZF5p7p3bT3m9DPrtm/haXquFFZngLHY116t
	 mYrYY2pmEAdMA==
Date: Fri, 15 May 2026 11:05:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Document the Shikra
 Temperature Sensor
Message-ID: <20260515-vague-squirrel-of-memory-16d170@quoll>
References: <20260513-tsens_binding-v1-1-1780c6a6caf2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-tsens_binding-v1-1-1780c6a6caf2@oss.qualcomm.com>

On Wed, May 13, 2026 at 01:00:58PM +0530, Gaurav Kohli wrote:
> Document the Temperature Sensor (TSENS) on the Shikra SoC.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

