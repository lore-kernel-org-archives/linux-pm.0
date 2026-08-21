Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CAF3998AF;
	Fri, 21 Aug 2026 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355017; cv=none; b=lYtPHvdSBerJy1lXQ4sJ3PI3+Why03QR9NoOpFNhoFPCoZi6hEPEjB4ba8uoqA1Zu/tecubCvvAwsqICmGpntiCzAKj0MyRAdsvRhGnj60H9Zz+bo5z2ZKOdA6fI2mG6bntJtFg19bBXTkH6FOLdXBt9SL8pd5GfE4PJwb2HW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355017; c=relaxed/simple;
	bh=MdK9rRHNyWJYLFRZyYYiCTN2IYQprF7r183bLLMS4j8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvrf6oaq8Ee4Imo2FQZXOXA3t80FUWya3CxAt9ccJxsKVOfKWRc2IUv3NqjGGnz5IhSwxZzQzEbAyEhTf/dnyqMi7mFiQotx2+adm650zuvJfrsY+p3/g9Ncc3PKZ8r53obXTjJycBAOfleXS9Ri+BDXYgAipv3EyDVkvgDlSL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo+ZWh2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo+ZWh2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C6C1F000E9;
	Fri, 21 Aug 2026 23:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355015;
	bh=Ibh9L+fRKuXLx86P55NwGkzi3Fg5cFtJydY7cjyAm4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jo+ZWh2IV9lEA2k8h5u9hhVtzVtqeQMYpiAwi0wYMxp9rY8L5Zm1ua8zPZU6/AfJd
	 U5y5D+P05QhZHqjBUPUSIWd0K5UWiVwOE/6GjJSC7zNEF4lfD9n3I8ikLLTtyxQoOn
	 +Q6+WHXCBSaqZ2hzn85nku/MM+T7cLQtKVk8j79hdKDKOFDVkdZLn9hk5FUH32AxE7
	 1I3BaJUWZqublQzewv/De7vZ8c6QLKgdIgITgA6sSpPUyFS9N+xRPcbJb7yiCK8FDm
	 UMfkpQAOu/RjFiLRXwEKB+QRX+scE2lOrdhPSIAo7Q0FelLBYFFxNbdlLqNH0uYaaC
	 gQmfSVGVsY2kQ==
Date: Sat, 22 Aug 2026 00:30:08 +0100
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
Subject: Re: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
Message-ID: <20260822003008.0d13144d@jic23-huawei>
In-Reply-To: <04990044-45b3-45ca-9e39-925d5bbe62e2@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
	<20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
	<20260803011400.1fb6c93a@jic23-huawei>
	<a98d90bd-aa9d-4af3-aa54-3a34300070d4@oss.qualcomm.com>
	<20260807001822.31f7c137@jic23-huawei>
	<f2b2f590-de3e-4f10-b883-92845f59412d@oss.qualcomm.com>
	<20260815030830.24fc732f@jic23-huawei>
	<04990044-45b3-45ca-9e39-925d5bbe62e2@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 10:24:39 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 8/15/2026 7:38 AM, Jonathan Cameron wrote:
> > On Fri, 7 Aug 2026 13:37:02 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> >> Hi Jonathan,
> >>
> >> On 8/7/2026 4:48 AM, Jonathan Cameron wrote:  
> >>> On Thu, 6 Aug 2026 16:22:16 +0530
> >>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >>>     
> >>>> Hi Jonathan,
> >>>>
> >>>> On 8/3/2026 5:44 AM, Jonathan Cameron wrote:    
> >>>>> On Fri, 31 Jul 2026 23:36:15 +0530
> >>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >>>>>       
> >>>>>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
> >>>>>> for improved performance, mostly at the hardware level.
> >>>>>>
> >>>>>> One significant software change is that ratiometric conversion resolution
> >>>>>> has been increased from 14 bits to 16 bits, so the maximum value of
> >>>>>> these measurements needs to be updated for Gen4. Add a new scaling
> >>>>>> function for thermistor channels which use this type of conversion.
> >>>>>>
> >>>>>> In the latest PMIC arbiter version (v8), there can be up to 4 buses
> >>>>>> under the PMIC arbiter and 32 PMICs under each bus. In order to
> >>>>>> support communication between ADC on the master PMIC and ADCs on any
> >>>>>> of the other PMICs, a field of width 2 bits is added for bus index
> >>>>>> and the bits for SID are extended from 4 to 5 bits, in the SID
> >>>>>> register. Add support for this.
> >>>>>>
> >>>>>> In addition, it is possible that the master PMIC has ADC of one generation
> >>>>>> and it needs to communicate with another PMIC with ADC of a different
> >>>>>> generation.      
> >>>>>
> >>>>> "Possible" sounds a bit hypothetical.  Can we state this actually happens
> >>>>> on some devices?      
> >>>>
> >>>> Considering existing upstream platforms, this is applicable for SM8750. I'll
> >>>> mention this in the next version of the series.    
> >>>
> >>> What happens on that platform today?  Wrong values?  Should this be treated
> >>> as a fix rather than a feature?     
> >>
> >> There is no issue on that platform right now as ADC channels needing this
> >> support are not added yet. SM8750 board files only include pmk8550.dtsi, which
> >> has the top-level Gen3 ADC peripheral and some ADC channels on the same PMIC.
> >> Gen4 support would be needed only when PMIH0108 ADC channels are added.  
> > 
> > I guess chances of anyone running an older kernel that the device tree on
> > that device is low as other critical stuff won't be supported?
> > 
> > If there is something easy to point to for that, add a note to the patch
> > description as it justifies this not being a fix.
> >   
> 
> Sorry, I did not fully understand your concern here. Are you asking if
> SM8750 runs on any older kernels and the lack of Gen4 ADC support may be an
> issue there?
> This would not happen - let me try explaining with some more details.
> 
> DT support for SM8750 has been present since kernel version 6.14. At that
> time, it included pmk8550.dtsi, but this file did not have an ADC peripheral
> at the time.
> 
> The Gen3 ADC peripheral was added in pmk8550.dtsi very recently in this series
> from Neil Armstrong: https://lore.kernel.org/all/20260721-topic-sm8x50-adc5-gen3-v6-0-a507f4a1e537@linaro.org/,
> and I see this series is present only in linux-next right now.
> 
> With this change applied, the ADC peripheral with 3 channels of
> PMK8550 alone (which is Gen3) would appear for SM8750. This
> would work as its functionality is fully supported by the existing
> Gen3 driver.
> 
> Gen4 support is needed only when we add full ADC support for SM8750,
> meaning when we add channels under all its other PMICs (PMIH0108
> specifically as it's Gen4.).
> 
> Would it work if I mention in the commit message that SM8750, added from
> kernel 6.14 without ADC support initially, would need this mixed-generation
> support, but only once we add the full ADC support (for all its PMICs)?

In the ideal world we would assume no coupling between device tree seen
on a board and the kernel with which a device tree was pushed out.  For
many devices the delivery path is independent.

As such we might well see a dt with the new property and a kernel that
predates it's introduction.  If there is another reason such a kernel
will simply not boot on that board, then that would be a valid argument
why we can skip striving for the ideal.  Similarly if the driver
would not bind for some other reason.  If either of those is the case then
add a comment to the patch to say so.

Otherwise, I'd like to see the extra property dt patch (arguably a fix
but not critical to mark it as such) + a patch for the driver support
for the new property (also arguably a fix).

That would cover the older driver and decision on whether to backport
that could then be made (or left to downstream users).

On top of that then build the new compatible support.

Superficially this looks to me like a bit of minor patch reorg so
I think it is worth doing even if we don't expect to ever run into the
theoretical problems form a miss match!

Thanks

Jonathan

> 
> Thanks,
> Jishnu
> 
> 
> > Thanks,
> > 
> > Jonathan  
> 

