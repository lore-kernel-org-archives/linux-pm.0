Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B137C0F8;
	Mon,  4 May 2026 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890240; cv=none; b=RxZ/eQWFnUJ/WsbuNjE5NPUC/+Xmqn5yWbxbdrrP1tYhoWc6MdO3Xeov4rDcNB93IZCn1TOxUG+nSCiEmvWu2jP2A0LMJs1clKP616QPhO8ScT70RLkMy/4EpylDkIlG5QJWE1Hgk4W6P8G/Xixo90jUIZcjQUTMMn7H2QzA7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890240; c=relaxed/simple;
	bh=6Ng2Zne27LVJNgvePPSbhkne5F13R3qY1FwN+vKtImI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3rS9eKJFYg2kqKCC6pMlJFSBj2kz/onPV8O5e0D47XlGXNH6gRZ/SXG86VjXRZY8J7tDUHTIyYJT1CIsMC0ch+98xNzIC95sO0NbdIMK7ZF/REFrd2+ihIQj+9nAVu1qrQ+BZjs8/EBFhGqJ2SD/xGD47r3OyOJpbOPyNLqClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwhAr4hx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwhAr4hx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102BDC2BCB8;
	Mon,  4 May 2026 10:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777890239;
	bh=6Ng2Zne27LVJNgvePPSbhkne5F13R3qY1FwN+vKtImI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwhAr4hxvPby0L2pam9+9ZHFKLOpkCgZctBmJwe/B26J+4URkVUdA1Amx9HqPwHaK
	 SA9ygFkeK57fUYRQG6HsOAQJoQn79AkqYkgv92iYJ3Ag5C2jko8MoBAMVNMHU97ch7
	 eVlY5vl+mRVDPBuAnHlaKYA5ttmS4HyNeyGbMvpc7zyitrgthTZvgazGaGsZtgXkTC
	 cTGQWTogmuqGDKH+j7B7sdjEvDo/Xgbx2C7Tf33wcsTnU1cRjT3DA/+7WH6uHLBKz9
	 D8A5qjZjuUWSxkO0IxUPmO0+XbuO79jxwoxVSNe6qBBke23s3umE84lJKgmen2HEX6
	 URw98xHi9pAjg==
Date: Mon, 4 May 2026 12:23:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: qcom-hw: Document Shikra
 CPUFREQ Hardware
Message-ID: <20260504-fuzzy-wapiti-of-ampleness-d8bc13@quoll>
References: <20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com>
 <20260501-shikra-cpufreq-scaling-v1-1-c78b95f53b91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501-shikra-cpufreq-scaling-v1-1-c78b95f53b91@oss.qualcomm.com>

On Fri, May 01, 2026 at 12:45:44PM +0530, Imran Shaik wrote:
> The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
> but supports only up to 12 frequency lookup table (LUT) entries. Introduce
> qcom,cpufreq-epss-lite to represent this constrained EPSS variant.

The entire point of having a generic compatible is that it MUST match
all devices. If it does not, then it is pointless to push that generic
compatible.

I am speaking about qcom,cpufreq-epss.

That's nothing new, I was arguing about it already, but now you have
confirmation of the mess introduced by generic compatibles. Solution is
not to add more generic compatibles, because what will be next?
qcom,cpufreq-epss-lighter?
qcom,cpufreq-epss-more-lite?
qcom,cpufreq-epss-high?

Same was here:
https://lore.kernel.org/all/20240828203721.2751904-17-quic_nkela@quicinc.com/

So that's second time I object and do object for every new instance. No
to generic compatibles, they are proven to be wrong at least for
Qualcomm.

Best regards,
Krzysztof

