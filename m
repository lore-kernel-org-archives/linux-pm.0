Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293001;
	b=cOYuBSOhbx0Stv3YnGpHdi1nEPregVqXIgHb2RO25Eh0sWC48T4wz8JCqlhSB2HIXCSy
	 sN3AMmPeYsvdE3tgq/CqO2jWJd6twx9EJwOV0XZNfbK3Gp9/kcw7EX73MmzFwAQmGnbGz
	 xv5OuH63IbC92vHL67n/pj055E3W933dvChrwTpfxGqU0Iz2PWMCK+et1EeM2x5KKv+Q8
	 iLz//JCdUqxKnmtgS+fKH7i8ophszLnsCmDVZVAozCJ8bAwTKGm6mI9k5rgmF4ffRnkzm
	 vDqkAfxWa7jmy36R/w7+/1rE0U6Gf7W8SV4GvcalLTw1YdU5I0guIapR2bZ8viAoXrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293001;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8w3CmoJyPr2BoTXS04qkem+74x63nGIjZeZRqj3Yy9c=;
	b=iFvzvrpT80LVBoGWKHISFlOpJoOnA/15nvOFtqeBiDIs3LVfTFI8OMS2RoTm1tb+bs5R
	 jdv2+w7zTBBAtBA8nZimwx5IcvdSmtOCZjsAZ5xF4hPoCElSooJ+KEthORhnNwjeJHmt7
	 o8McSnPVdXBXl5DPLJk8MeAC5aFKLYuF+r5ZNKZ79ZjLooRCFWBNxSVTij+oa+OxUhGBV
	 nv01tPIULgzd8KMaHBJsvOBvZzqLSgNk5muBV0a7cs3eLSMKNcztgF0aFGLxz1ID18c8Z
	 ytx1KBB+GxI1Ah29K8+HhnydBB2M2FSCwqPkhKrtnYbxQ7mCi4Z4kVRE++cHPEvJvGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QJDG9PK/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35198606A320;
	Sat, 21 Nov 2026 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJDG9PK/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273C31F000C6;
	Sat, 21 Nov 2026 20:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795293000;
	bh=8w3CmoJyPr2BoTXS04qkem+74x63nGIjZeZRqj3Yy9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QJDG9PK/u0CJzdH9whCG8QCLfaDnGo/xSx4YgLzGxm/Pc9wcFakN1j5fYgbsTHd5X
	 6x25+Hqkcyj1jkq/krL2F2mdwNWssf8Dpox3IHDbtYPRzBKbR2C2f+y99BGerYRzB7
	 3t6PCW+nrc43NqqvJ7A1JevwWybQSRQ6PZGu4A3JT9Kv4aqQxLhWHv1aXihofl1qRk
	 bXQDX6TlnCxC+wlf4YU2NHWz5lO5B6v2MkseJxM0Fh74GIX7RPCC6rFlUyaNvIAXOh
	 rxaNPfwBHvqiyk1HBk9SQXwJnWntsJlg0GMj2av4fK/goKTUChJ8CAIw/QipRzqe7g
	 I/3OwmccvT5Gw==
Date: Sat, 21 Nov 2026 20:29:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Amit
 Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Kamal Wadhwa
 <kamal.wadhwa@oss.qualcomm.com>, Anjelique Melendez
 <anjelique.melendez@oss.qualcomm.com>, Manaf Meethalavalappu Pallikunhi
 <manaf.pallikunhi@oss.qualcomm.com>, Priyansh Jain
 <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/7] iio: adc: qcom-spmi-adc5-gen3: Add support for
 QCOM PMIC5 Gen4 ADC
Message-ID: <20261121202950.7dc141dd@jic23-hlaptop>
In-Reply-To: <awAdgHggEZtBnyYK@ashevche-desk.local>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
	<20261120-pmic5_gen4_adc-v2-3-94d0e1fd6847@oss.qualcomm.com>
	<awAdgHggEZtBnyYK@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 12:14:24 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 20, 2026 at 02:49:43PM +0530, Jishnu Prakash wrote:
> > PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
> > for improved performance, mostly at the hardware level.
> > 
> > One significant software change is that ratiometric conversion resolution
> > has been increased from 14 bits to 16 bits, so the maximum value of
> > these measurements needs to be updated for Gen4. Add a new scaling
> > function for thermistor channels which use this type of conversion.
> > 
> > It is possible that the master PMIC has ADC of one generation and it needs
> > to communicate with another PMIC with ADC of a different generation. For
> > example, on SM8750, PMK8550 is the master PMIC with Gen3 ADC and it
> > communicates with PMIH0108, which has Gen4 ADC. Add a new DT property
> > "qcom,adc5-gen4" to distinguish Gen4 channels under a Gen3 master, to
> > ensure that their conversions are handled correctly.
> > 
> > In the latest PMIC arbiter version (v8), there can be up to 4 buses
> > under the PMIC arbiter and 32 PMICs under each bus. In order to
> > support communication between ADC on the master PMIC and ADCs on any
> > of the other PMICs, a field of width 2 bits is added for bus index
> > and the bits for SID are extended from 4 to 5 bits, in the SID
> > register. Add support for this.  
> 
> ...
> 
> > -	/* Write SID */
> > -	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->sid);
> > +	/* Write SID and bus_id*/  
> 
> Missed space.
> 
> > +	buf[0] = FIELD_PREP(ADC5_GEN4_BUS_INDEX_MASK, prop->bus_index) |
> > +		 FIELD_PREP(ADC5_GEN4_SID_MASK, prop->sid);  
> 
> ...
> 
> > -static const struct adc5_data adc5_gen3_data_pmic = {
> > -	.full_scale_code_volt = 0x70e4,
> > -	.adc_chans = adc5_gen3_chans_pmic,
> > -	.info = &adc5_gen3_info,
> > -	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
> > -			   { 85, 340, 1360 },
> > -	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> > -			   { 15, 100, 200, 300,
> > -			     400, 500, 600, 700,
> > -			     1000, 2000, 4000, 8000,
> > -			     16000, 32000, 64000, 128000 },
> > -};  
> 
> Seems like this is existing piece and you moved it up. Please, split that part
> to a separate prerequisite patch.
> 
> ...
> 
> > +static int qcom_adc5_gen4_scale_hw_calib_therm(
> > +				const struct u32_fract *prescale,
> > +				const struct adc5_data *data,
> > +				u16 adc_code, int *result_mdec)  
> 
> Even if the rest of the file uses this ugly indentation, correct it for a new code.
> Not a problem if lines will be a bit longer.
> 
> > +{
> > +	s64 resistance = adc_code;
> > +	int ret, result;
> > +
> > +	if (adc_code >= RATIO_MAX_ADC5_GEN4)
> > +		return -EINVAL;
> > +
> > +	/* (ADC code * R_PULLUP (100Kohm)) / (full_scale_code - ADC code)*/  
> 
> Again, missing space.
> 
> > +	resistance *= R_PU_100K;
> > +	resistance = div64_s64(resistance, RATIO_MAX_ADC5_GEN4 - adc_code);  
> 
> I would put it like this
> 
> 	resistance = div64_s64(adc_code * R_PU_100K, RATIO_MAX_ADC5_GEN4 - adc_code);
> 
Good.

> OR this
> 
> 	resistance =
> 		div64_s64(adc_code * R_PU_100K, RATIO_MAX_ADC5_GEN4 - adc_code);
> 
> (but it still uses two lines, so I find the previous one slightly better).
Not good.

1st one!  The second option triggers my ugly detector.
This is definitely a place where slightly long lines make nicer looking
code.


> 
> > +	ret = qcom_vadc_map_voltage_temp(adcmap7_100k, ARRAY_SIZE(adcmap7_100k),
> > +					 resistance, &result);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*result_mdec = result;
> > +
> > +	return 0;
> > +}  
> 

