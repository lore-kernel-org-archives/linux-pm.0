Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419862E091E;
	Sat, 15 Aug 2026 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786759728; cv=none; b=UBHgmvpN26SYncIOTkJujfFE+iBvNWg0l0DLJkpAYPa3maStTAwhYbpA81ycWwvio81tWib3X6IJNJ95uWBQ2rDWc5z/KalFi1YeYOMlM8Ixss9exm7oUb77Q/8Xe6q1yCgOnfTNz1+O+AC4iD0BRps6FeMi00/UissrKcw6TVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786759728; c=relaxed/simple;
	bh=Bl4LwM0dEqNG6qJH4IA86ALUUoPDlxv1r8xV9vctZKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyQkTIG3zr7lA4vRb57yBpPA/tmK8ogKhvDvXflA/PvhZI0W9rBNydGG/I6ldUgRL/MEghPfGiq29W38tzTfTOYDQK4SQpVknyx6tH2T6Kmgx96g08/xKQdW1npQq/u4xigVySmI/UUjVpDuY2a6SXl4ZLdD13xkv9U6ZQntIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCA4CC6x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCA4CC6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86951F000E9;
	Sat, 15 Aug 2026 02:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786759726;
	bh=2M0Py2ejEzcelIi0LkvASJfMo7MfTXozxCvzhn4HMeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RCA4CC6xcxNjLSo1ofVGT61LQzzmXSI0t+7oAGT0YsTY0o8h+NRcBwBvqDodE3e/o
	 iuN8hUPXL//P7HvHj2IlVYuUvEnhaMyTkJBBfNnSqVnrjbdzbWTXcK4UrfLz2zeAG4
	 JrQ3v7dyrBitHJvcidAblArYvMMJ7YSaxZk6fBnBfbUfmErHFZKMkuIUfJO4frUuaF
	 JNbAL8eqgHopKm7MBdQe58EnJyrxysVq8R/o5xchJoM3QK58hDdaOiVB6+3a8s5oR1
	 8vfFnSfCQYVRJHGXXoZ7LZ15OrQGCLWKvp56HN0vccXL1I3cT3P/xxENFj+5OJDLSi
	 H4PxswWhWDFoA==
Date: Sat, 15 Aug 2026 03:08:30 +0100
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
Message-ID: <20260815030830.24fc732f@jic23-huawei>
In-Reply-To: <f2b2f590-de3e-4f10-b883-92845f59412d@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
	<20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
	<20260803011400.1fb6c93a@jic23-huawei>
	<a98d90bd-aa9d-4af3-aa54-3a34300070d4@oss.qualcomm.com>
	<20260807001822.31f7c137@jic23-huawei>
	<f2b2f590-de3e-4f10-b883-92845f59412d@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 13:37:02 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 8/7/2026 4:48 AM, Jonathan Cameron wrote:
> > On Thu, 6 Aug 2026 16:22:16 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> >> Hi Jonathan,
> >>
> >> On 8/3/2026 5:44 AM, Jonathan Cameron wrote:  
> >>> On Fri, 31 Jul 2026 23:36:15 +0530
> >>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >>>     
> >>>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
> >>>> for improved performance, mostly at the hardware level.
> >>>>
> >>>> One significant software change is that ratiometric conversion resolution
> >>>> has been increased from 14 bits to 16 bits, so the maximum value of
> >>>> these measurements needs to be updated for Gen4. Add a new scaling
> >>>> function for thermistor channels which use this type of conversion.
> >>>>
> >>>> In the latest PMIC arbiter version (v8), there can be up to 4 buses
> >>>> under the PMIC arbiter and 32 PMICs under each bus. In order to
> >>>> support communication between ADC on the master PMIC and ADCs on any
> >>>> of the other PMICs, a field of width 2 bits is added for bus index
> >>>> and the bits for SID are extended from 4 to 5 bits, in the SID
> >>>> register. Add support for this.
> >>>>
> >>>> In addition, it is possible that the master PMIC has ADC of one generation
> >>>> and it needs to communicate with another PMIC with ADC of a different
> >>>> generation.    
> >>>
> >>> "Possible" sounds a bit hypothetical.  Can we state this actually happens
> >>> on some devices?    
> >>
> >> Considering existing upstream platforms, this is applicable for SM8750. I'll
> >> mention this in the next version of the series.  
> > 
> > What happens on that platform today?  Wrong values?  Should this be treated
> > as a fix rather than a feature?   
> 
> There is no issue on that platform right now as ADC channels needing this
> support are not added yet. SM8750 board files only include pmk8550.dtsi, which
> has the top-level Gen3 ADC peripheral and some ADC channels on the same PMIC.
> Gen4 support would be needed only when PMIH0108 ADC channels are added.

I guess chances of anyone running an older kernel that the device tree on
that device is low as other critical stuff won't be supported?

If there is something easy to point to for that, add a note to the patch
description as it justifies this not being a fix.

Thanks,

Jonathan
