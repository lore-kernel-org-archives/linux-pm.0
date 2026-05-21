Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7735975;
	Thu, 21 May 2026 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404195; cv=none; b=Zkb9X04DrkiuO9KPJCr53RnmH3XtS0MU2U+C21Cy9zYlwrybEMKQk9n3weh1PkE4UR0QLyUDMHdKizyBx9lK9sGh724ZAwz7iI3gGSJeMU+/I2XQP+rYwkLWeKBp9nBytXV8Od1Xrg7MdNTbJPxOrgfkzfaMCMvG60+yQ8UwYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404195; c=relaxed/simple;
	bh=bMZAJMrhnl5mtLM3XXeIQK/Kapd/yQRGPTj7JFVbg2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGTsVCUjeo0j7f8ohGeB2a0GZ/ckihha3652RQUqdh+2e0qcuGeOr2BpiATh4h+xIvF6zRobwBzy9FQ8RuAUUMnd3bWbQ+FZlMhc2gxAN0dBWltbtf7TarBCDZcFg6Fds+4t6BkiWqmg7pMlxRB5/nnq5gBk8czFusq9QCz87EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwHlTSwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwHlTSwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2081F000E9;
	Thu, 21 May 2026 22:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779404194;
	bh=7cg3PP8ir4Dvr0mIjKf6vyi330dA3SFiHExUj/R/Euc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TwHlTSwNc9VSV72PesrrH/8a3Q9VZZAvH0Oj8RNk3JnqzscjLlEfmiimuADYaTxSO
	 lTlPhKGW8Fi0qhvQBgXq7n/jxVza8NsgWdR0X8fgG0hUdXl/gpK9ii1P1DpVbQtAY2
	 M98jd/tvlmxRA4xaHvTcbALwNI2DkK8YNCIZhlhsuHgQ5ElKFS/Cg+zLDoqBDDvM2y
	 Os4dwt+SYb1CJZxS5nMqt7PnC9gT6qp2DxVFBtAl4ZRQiItgMTNit/est6lO4jNF5N
	 LqTHrsdLmvDJ3s4SF9C1M6jIVWFewzx/nRLcwNmHK7peV2O2IWvCfdaHmd5el04RLt
	 0/S9idqtE66og==
Date: Thu, 21 May 2026 17:56:29 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jishnu.prakash@oss.qualcomm.com, 
	kamal.wadhwa@oss.qualcomm.com
Subject: Re: [PATCH 0/2] qcom_battmgr: Add batteryless DC-adapter MAINS
 support
Message-ID: <ag-NLvh4ROgTCs_L@baldur>
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
 <56a54a34-1040-44ae-92e2-ce65a3d3acb5@oss.qualcomm.com>
 <20260519065938.4i5wot72pfxy4m3d@hu-kotarake-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519065938.4i5wot72pfxy4m3d@hu-kotarake-hyd.qualcomm.com>

On Tue, May 19, 2026 at 12:29:38PM +0530, Rakesh Kota wrote:
> On Mon, May 18, 2026 at 04:36:32PM +0200, Konrad Dybcio wrote:
> > On 5/18/26 3:49 PM, Rakesh Kota wrote:
> > > On batteryless boards powered by 12V DC adapters, registering the
> > > power supply as BATTERY causes userspace to incorrectly trigger
> > > battery power-saving sequences.
> > 
> > Does battman really offer no way of differentiating whether a battery
> > is *actually* present in such cases?
> >
> > What boards are affected?
> >
> Currently, batteryless support is only implemented for the
> qcs6490-rb3gen2(Kodiak) board.
> 

What do you mean?

Are you saying that the pmic_glink firmware in Kodiak has a one-off hack
that no other implementation of this firmware has?

My Lenovo IdeaCentre (hamoa) doesn't have battery, what should I do now?

Regards,
Bjorn

> regards
> Rakesh
> > Konrad
