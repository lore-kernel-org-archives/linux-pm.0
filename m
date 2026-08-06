Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D6270552;
	Thu,  6 Aug 2026 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058313; cv=none; b=i5LE2AqbeP4mA28tK8VTNptn4vzkuG1BVeN3yxdxjHH+wJjol59RGNVVdmk6U82G+QLLEytaHpHgR6RKewuFMsHb86bfZHt8UvgmKD2BDvZIEU2QZ3ayqN0sbn3BggYaeMs+//WPvbgyjVGa5ABL7xoQJPvyGhArHeMrDAxTWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058313; c=relaxed/simple;
	bh=i+nWvwN4DAqRS3zJb3JcjJIqvyB+vgXInNvi000M08A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=De/CkF/WLBtehne+nm29D3CurXcYRInvCTYEfHiDV+dqyZ2DXgJvXD168ppASr1oVI3iWp+WEBqMdpdHBrgv/v94ncO4d0KuXgiPPUiQ3LyfHmZ3MZBF+0GIhdjOkbaPo0gAG0MzSIBwT5IcojvGZ99+BzHVu9ZPMQJYnelMHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTuL8GQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTuL8GQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD73C1F000E9;
	Thu,  6 Aug 2026 23:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786058312;
	bh=wj891lSkf1SbhMF9hHkTqNbiH9O10btAEC7aqlA3NE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kTuL8GQOGf1XdLtElxa8DVv4Qs8f9i5ZNmRkYtPi2O2AmsPjWkBddPzC7ozSe5/rL
	 ydPdvArOo0A6Qp12SFNac8y+ztLnlKdpRNSLzUUNN488BkTdOFbbv5X83REupE9adG
	 LtQFRjlrvGtX2E7E7sb3A9+8VGzxECJxLu/QB46mQriKDC0ExfiQqFPdGwi+t4XsHd
	 IA9kZl2bRunRISlqXtJIm9lK4zeQGhh7rcN4bwYhmLbXRFf7gX5AEo8v36PX3NA/48
	 uec23vthklaT/rnETbF0VqfrLwrAPbB7rJrKDaQuhHItaosW44zOZK3Oum3zdXqnZl
	 tb7U9JiHigk4w==
Date: Fri, 7 Aug 2026 00:18:22 +0100
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
Message-ID: <20260807001822.31f7c137@jic23-huawei>
In-Reply-To: <a98d90bd-aa9d-4af3-aa54-3a34300070d4@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
	<20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
	<20260803011400.1fb6c93a@jic23-huawei>
	<a98d90bd-aa9d-4af3-aa54-3a34300070d4@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 16:22:16 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 8/3/2026 5:44 AM, Jonathan Cameron wrote:
> > On Fri, 31 Jul 2026 23:36:15 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> >> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
> >> for improved performance, mostly at the hardware level.
> >>
> >> One significant software change is that ratiometric conversion resolution
> >> has been increased from 14 bits to 16 bits, so the maximum value of
> >> these measurements needs to be updated for Gen4. Add a new scaling
> >> function for thermistor channels which use this type of conversion.
> >>
> >> In the latest PMIC arbiter version (v8), there can be up to 4 buses
> >> under the PMIC arbiter and 32 PMICs under each bus. In order to
> >> support communication between ADC on the master PMIC and ADCs on any
> >> of the other PMICs, a field of width 2 bits is added for bus index
> >> and the bits for SID are extended from 4 to 5 bits, in the SID
> >> register. Add support for this.
> >>
> >> In addition, it is possible that the master PMIC has ADC of one generation
> >> and it needs to communicate with another PMIC with ADC of a different
> >> generation.  
> > 
> > "Possible" sounds a bit hypothetical.  Can we state this actually happens
> > on some devices?  
> 
> Considering existing upstream platforms, this is applicable for SM8750. I'll
> mention this in the next version of the series.

What happens on that platform today?  Wrong values?  Should this be treated
as a fix rather than a feature? 


> >> -static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
> >> +static int adc5_gen3_read_voltage_data(struct adc5_chip *adc,
> >> +				       struct adc5_channel_common_prop *prop,
> >> +				       u16 *data)
> >>  {
> >>  	u8 rslt[2];
> >>  	int ret;
> >> @@ -99,8 +101,10 @@ static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
> >>  	*data = get_unaligned_le16(rslt);
> >>  
> >>  	if (*data == ADC5_USR_DATA_CHECK) {  
> > This feels backwards.   We first check for the top bit being
> > set then check whether we care if it is set or not.  I think
> > checking if we should look at it first makes more sense.  Also
> > shorter max line length:
> > 
> > 	if (!(prop->generation == ADC5_GEN4 && prop->cal_method == ADC5_RATIOMETRIC_CAL)) {
> > 		if (*data == ADC5_USR_DATA_CHECK) {
> > 	...	  
> 
> I thought it was more efficient to have the check like this because
> there may be several channels satisfying the longer if() check for Gen4
> ratiometric channels, but the chance of *data being exactly equal to
> the error value ADC5_USR_DATA_CHECK is lower generally. So if I reverse
> the checks as you suggested, the outer if() check would pass for every
> read done on a channel which is not both Gen4 and ratiometric, which
> seems inefficient for an error check.
> 
> What do you think, should I make any changes here?

Efficiency here is going to be hard to judge without guessing how good
the prefetchers are and to me this doesn't smell like a performance
critical path.   I'd go for clarity of code and check only
for the invalid value after you've established it might actually be
invalid. So change it.

Thanks,

Jonathan
