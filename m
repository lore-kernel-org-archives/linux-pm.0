Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAED1EEE6;
	Mon,  3 Aug 2026 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785716238; cv=none; b=X1is7NMHhsZPFUG4GYksrcS0hHYCfMbAQlUeDNU9tsVZLh1uEtJ+pXAh0FrL2+1Z1Su1pkUd0wD9SQILWYL/5s5N1i1EFi6YTu9qmDhgOZhU4jcTNi810zXxqSwgHqH85SMFhlqkeX2bEz3teEzEzvxHz7UE9R1zfC9nsPstQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785716238; c=relaxed/simple;
	bh=zqZ2fs7m/Tz1ydJA00KBhsxG+KBsxoQmZoI3sxqVaKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaZ4mRiYpV8aaCWpZu8PmGTOTyqWkouZrfGFR7tAhEmjagkJKfux5MWFBp/JS4qNLuAAylgw1IAbx6Wv+lqnbUj895B7LfbE4jVVTTmDiytKM2Oevk/mudPtezjRUFJipe5zJRFCnUsoOmPus/kAztyWJe9/7cAqrM1BI2WwDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzhiJooD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzhiJooD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CC61F000E9;
	Mon,  3 Aug 2026 00:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785716236;
	bh=4tAphpUQeptJfAgwWJJhc2WdckXIiF9VSpW/DzeoIdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TzhiJooDd8HqQhWSYaHGq55/Z9sd0a5yxN/Fw/+1FY0u486i3oT9O3fGtLNTzCyAu
	 Q0AQOIe9/Th42vJ/36G24FDahc+hJN7SdnU68h69s+NPd/JZMfGutwoxIOw7zQdPLT
	 kQNuXPS2a8B3mimyXvKhwiuf1D3j2hvO/V+Zhv9g3hOVoak5zfulRg6hJotm23HE07
	 2KMr/P6NBWpXG6LUKhti4Xbe90WOehv5x2fPXXsLFu7PHXsrAJF0DtT4sN897NfuKc
	 j5MBIBZDA0nqKxZaAATd+07UF1AYvFh9wH+HlaNY88Lbz8Vdg+3EUZMojmNIDVtkqm
	 kGMNG90WrHANg==
Date: Mon, 3 Aug 2026 01:17:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Kamal Wadhwa
 <kamal.wadhwa@oss.qualcomm.com>, Anjelique Melendez
 <anjelique.melendez@oss.qualcomm.com>, Manaf Meethalavalappu Pallikunhi
 <manaf.pallikunhi@oss.qualcomm.com>, Priyansh Jain
 <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH 3/7] thermal: qcom: qcom-spmi-adc-tm5-gen3: Add support
 for QCOM PMIC5 Gen4 ADC
Message-ID: <20260803011709.31cf83f2@jic23-huawei>
In-Reply-To: <20260731-pmic5_gen4_adc-v1-3-9c49b2eea6f9@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
	<20260731-pmic5_gen4_adc-v1-3-9c49b2eea6f9@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 23:36:16 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
> for improved performance, mostly at the hardware level.
> 
> One significant software change is that ratiometric conversion resolution
> has been increased from 14 bits to 16 bits. Add a reverse scaling function
> for Gen4 ADC thermistor channels.
> 
> In the latest PMIC arbiter version (v8), there can be up to 4 buses
> under the PMIC arbiter and 32 PMICs under each bus. In order to
> support communication between ADC on the master PMIC and ADCs on any
> of the other PMICs, a field of width 2 bits is added for bus index
> and the bits for SID are extended from 4 to 5 bits, in the SID
> register. Add support for this.
> 
> Co-developed-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Hi Jishnu, Anjelique

Code looks fine, but I just wanted to check.  What happens if
for some reason the patch before ends up in a tree and this one doesn't
Do we read the wrong temperatures given 'bus' isn't specified?

Jonathan

