Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12241A900;
	Thu,  6 Aug 2026 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058058; cv=none; b=girfBI3NbC/2tTVJSPA1FoLbzYURGqn4WHez6+bRTYrGeJaONQGk5RmPrGUuByrNV9EI2VOXSM6qYq3nox8nTQspmoSSpu4tmMc4dvSOwDCbMXuhlBMSzxN3HZkZL6HikV3FOwzU0UjwJUdBxxr7vuYwqRItEHOUF25xUXleh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058058; c=relaxed/simple;
	bh=S58XBp6CgG55cDr5siPSfHS+brVFmFzjNnKLPmjLufw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEoTgePORjkDEuBpk9xIJ3tL1EMF/NEQ6znrMJ8V12wnRc1TH7YQEc+iaGpDe1Khz13aiIHgVk3R7MPZHWaguenUFGhcjxqGR4E0DEIJe1kWNZ1nWI/sdSauM0PIJJJiJmnAEf6ctxs1d7RTNVzZJz2dZ9fsPX6q8DCV+VbbyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUoQDNgs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUoQDNgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E81E1F00A3D;
	Thu,  6 Aug 2026 23:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786058056;
	bh=R6tlUTvCGRlJ2FeynitfLk6pTOF3tpwEhQMLaAXg5to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kUoQDNgse+jy7PUDlzeVlwKNUBC/MPwtT1uTaozv4nazlhDPN48I9G9sRn6xBL5PH
	 9M9gsys2eje4UAqCzX1e22qOJTz6HSBP9Z9UeOWfzDavtXIAsNI9qioPEhcKdK42ae
	 8QONljr+/IDE9BTZJ5Vz0ARAUlC2e+dDQfhlTMr54cau5Jqitb5DR/32MOA0jOiYPA
	 /I43uVMM0XhyPvirrcS5a29QYucwlw/Q7AHtGaRwjluJXghNDZABkBUnCiXMmGbYmF
	 ACr1P4zncHC+CXglSCEJGL1AiHQpLJPxVdUbs6ugw/ydPFa1YdaNQeJyD+f3aMhYWV
	 xQf8BqdzlJ9xg==
Date: Fri, 7 Aug 2026 00:14:12 +0100
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
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen4 ADC
Message-ID: <20260807001412.673b1bf1@jic23-huawei>
In-Reply-To: <bc1096de-94c8-4713-88cb-5b9e96b5419b@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
	<20260731-pmic5_gen4_adc-v1-1-9c49b2eea6f9@oss.qualcomm.com>
	<20260803004940.0277c0ac@jic23-huawei>
	<bc1096de-94c8-4713-88cb-5b9e96b5419b@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 16:22:02 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 8/3/2026 5:19 AM, Jonathan Cameron wrote:
> > On Fri, 31 Jul 2026 23:36:14 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> >> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made for
> >> improved performance, mostly at the hardware level. The main differences are
> >> increased ratiometric conversion resolution (from 14 bits to 16 bits) and
> >> increased bit field width for PMIC SID (to allow communication with an
> >> increased number of PMICs, supported on latest SoCs).  
> > 
> > Hi Jishnu,
> > 
> > The mixed case is enough of a surprise (to me least) that I'd expect
> > there to either be more discussion here or for it to be handled first
> > as a dt binding patch to allow for v4 channels on v3 hardware.
> >   
> 
> If I understand your comment correctly, you mean I should either add a
> description of the mixed cases in the commit message, or split the
> patch - one patch to add the new compatible and one to add the new
> channel properties ?

Hi Jishnu,
> 

Yes. I was indeed not very clear!  That was exactly what I meant.

> I think it's slightly better to add details in the commit message
> and keep the changes in a single patch. What do you think ?

My preference would be split patches so the discussion is extra clear,
but I'm not that bothered if dt maintainers don't mind them being combined.

Jonathan

> 
> Thanks,
> Jishnu
> 
> 
> > That would provide a place for a description of why that is necessary and
> > then the following gen4 dt-bindings patch with gen3 channels would seem
> > like a natural extension.
> > 
> > Other than that this seems fine to me.
> > 
> > Jonathan
> >   
> >>
> >> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> >> ---
> >>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml      | 47 +++++++++++++++++++++-
> >>  1 file changed, 46 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml  

