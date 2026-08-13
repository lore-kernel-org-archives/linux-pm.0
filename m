Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2489F3E7159;
	Thu, 13 Aug 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613768; cv=none; b=Y2FCVEKp9CyJSeEbmVo2GPGGRn7wuGwQaNvaEIbLc9ZUna5BL1CEmoR6a9O+6Xi3wInOKJMHEwWZyDz7UryhosRZrsF0WUMU2cEACqIJbLu7zRK+Il9I2ptFWmxHU0+9f2+GbCEwVzmG4NtU4m2z4ULf3QgL5xR62yEyN4i+LMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613768; c=relaxed/simple;
	bh=U9axHHup7tPaHWqsI/3aC1QN8XFrQA+dSE2auz5iYtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUs5EsMYsB7hk4IfQO2NN+q7CEsa4qUlEzKRC5IsES8soCNsEM8ipTNKkPtvX0hfTN5RLzDXtMI1bPgMghWgGJXXdMtvFUE96ozNLzGit4jmDcuWD347B3ppF8nZLTYe+T9UZ/wm0WKeLuqKrGlLKe5b+zYXQKT15VVvm0DMxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOMuKMKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOMuKMKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8CD1F000E9;
	Thu, 13 Aug 2026 09:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786613759;
	bh=U9axHHup7tPaHWqsI/3aC1QN8XFrQA+dSE2auz5iYtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DOMuKMKIHhmbFhkltGGzLrwulEeiao/QoCMbwmYbbEf+RhGSYjhViV2uxTIgpcHeh
	 VIHMyzqibddFQvoOSEk8zAceKFsouCbeMQ2w7EENRzWIs4AKoRz8i/Ybqlhy5/UG6K
	 fpSwdl/aJOr6fRQ8hs0k4DUMnTn6OnArQu7VZOrKaT+r8o2P2c5zC24ANOS8YQEdgr
	 jfAb3rQaQnpaoMyevNSdubnywWT6HMEc6vMD3bzin8s2T4rVG9G4aT87q6x3CTw/OS
	 ApTZVTeNtZKc7e+2tKyZy4SASsY0h0sfYWXDea/MTBABAyl8yZriikx8hDgSFI+EQ3
	 i0LVZfHBPWQIQ==
Date: Thu, 13 Aug 2026 11:35:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 02/15] dt-bindings: power: rpmpd: Document Kuno RPMh
 power domains
Message-ID: <20260813-gainful-festive-goshawk-1be511@quoll>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-2-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-2-5e0ede4a0c72@oss.qualcomm.com>

On Sun, Aug 09, 2026 at 12:57:01PM +0530, Hardeep Sharma wrote:
> Document the qcom,kuno-rpmhpd compatible to enable DT validation for
> the Kuno SoC. The corresponding driver support is added in a subsequent

"DT validation" is irrelevant.

> patch in this series.

As well driver is. Look at other commits how this is written.

Best regards,
Krzysztof

