Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECD385D84;
	Wed, 10 Jun 2026 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076706; cv=none; b=XPjqut4dvE2ZGtTg9RzNlxVZBgsUxJt6bPBQdbhQcjba4hdXRwZbyN7IpQWcusM1VsEQmjP2lX0UngsZkdTnIpCR+Dq8J7PQOdOjCEHNfgoY34dNoDxzLYX8fya3NH0KgnPgH7d7Eet/1BnFeIOIa5/dckrZv+90MGloZU13OMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076706; c=relaxed/simple;
	bh=fo9TZGYSBEGGFT3e1NEIlrHnQmmCB3sQiZwPhiML6Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7qCNc9AILPuv0fHrvO44RNcUEPtnaCJUkKpMSuG+RR9BY63IHcDt+5o3/+6aXIb4/+im7K5/bLHcEW/F+VmStdQerP9rhQtIdj2Coz3wda3FgXRmR1CJnFqQhG83efEah6WDc7cmYEbn5u5kscLZd4hee7fqVZgvUrHU1BOPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej0Ng4NR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej0Ng4NR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C18F1F00893;
	Wed, 10 Jun 2026 07:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781076705;
	bh=w5p/1S1/peXa1zTO5h+LSs5DmDWuM0Uhw5RdwnIRIcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ej0Ng4NRN268Bis9IV2k2oxmv3Dn+leTpn87/yNPiru/7+d7BGM5bkUn4zy9wxqPy
	 Sq2Gfa2bbneLUI8SEmHWTEWyYPiTBh79DG75qItozqL+wL/WCmlwgMOiKF9jGFXI8T
	 hpeG8A5uHUXCnXnCaCgTKy4mobEoa5lzIWRiV3LqojnFYkOweO4e6pgV6+s5aA5WWC
	 ssDie4PvJTLSpfgr42L9WH96BVl3aPnGnW1Oc79EJu+Fhmybre9/ATlFhS1y6lx46R
	 oRqS6QlqoC6rt99IK/IyK3AcAUMn2vi27qW5UYUtcUInOfO1O1BGrS6oRXMVfAvIZI
	 GR2M5HSQuj/Qw==
Date: Wed, 10 Jun 2026 09:31:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Amit Kucheria <amit.kucheria@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
Message-ID: <20260610-ocelot-of-stimulating-excellence-bcb0fe@quoll>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>

On Tue, Jun 09, 2026 at 03:52:56PM +0530, Gaurav Kohli wrote:
> Document Qualcomm PAS remoteproc thermal mitigation properties used for
> QMI-based throttling.
> 
> Add:
> - #cooling-cells (2 or 3)

Why 2 or 3?

> - tmd-names (thermal mitigation device names)

Why? And where is this generic property defined? You cannot just
sprinkle generic properties in random bindings.

Best regards,
Krzysztof

