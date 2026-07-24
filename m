Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DE3C4168;
	Fri, 24 Jul 2026 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882464; cv=none; b=KPvxCHWu32KNj55EL0oZIuqlEawMc8RzOkuHIDWdqHCkO2gyGOTCuSUONn38nfcCz1zw7MnkosP2nXmCn+6l/HESS5c8AApYaAlN0b/Wx1npwSMK/y6B8RBS1m2DzDlaee6G0WRoLu1XBGvNDdxQq62onDo+XABIufCRhK+RRe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882464; c=relaxed/simple;
	bh=SvMzeAwJTE6fPLMF5CkgneblrV+nlHOgOG0wtEO8E7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz5RGQXBk0Xo89qfB9tIx58imgBGoGp7lHB8Z6aCeHTS8ZKRIUzPuS4p/I5UcevE8t3EKzkyCXett5c6ALIN9xME/mxgWnoyZruCHFiqC0lJO21jk3Xge+03AdqGAhZ6rJW67NCjATt4sXPyI5UEMhlJ1iNIxytzqyIFhQWMEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViZwD3+k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViZwD3+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE961F000E9;
	Fri, 24 Jul 2026 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784882462;
	bh=nfHLq2po8UI/y28qstFvUK43HAU86pkJ/YHd7F60yAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ViZwD3+kuJ69SGRGL+83J9kVDA3tz0DMI2DievgGbJvH1/EUkk8zG4wTrsDk3avPB
	 NMf9Y0eeb42glJQXjXoJkS9vOsaF0KFrWrfiQQspYJ2r0xfA+my7j+M32kGSvFl0+n
	 t9gDvintI0Apxmzu4XuYkF2OnKtEWIVpCUJjOhB4e0FYubhDRctVJPxN/KknFDNzkX
	 RlQz/jLO7YUBcqaltEbtncM5Ui66zI0MVu500Hty4NChP+KW53aBWCNcRNG8kA64PG
	 9SR3I2rmAKTwGWlrDG7XNl6sTM8TPnAXovSVidTer0WtzMtKtz18GaLUkSzxBgizG9
	 8b9M5QxQp9kTg==
Date: Fri, 24 Jul 2026 09:40:56 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Amir Vajid <amir.vajid@oss.qualcomm.com>,
	Ramakrishna Gottimukkula <ramakrishna.gottimukkula@oss.qualcomm.com>,
	Jia Yang <jia.yang@oss.qualcomm.com>
Subject: Re: [PATCH RFC 00/10] firmware: arm_scmi: vendors: Qualcomm Generic
 Vendor Extensions
Message-ID: <20260724-space-magpie-of-promise-b71ead@sudeepholla>
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>

On Fri, Jul 24, 2026 at 12:48:05PM +0530, Pragnesh Papaniya wrote:

[...]

> 
> Changes in v8:

Yet the patches are labelled as if they are RFC and/or v1, so it gets really
hard to track.

-- 
Regards,
Sudeep
