Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094661;
	b=NZLmYCX21++XauCJoVw0AcODviGJlzKwiJp6txO3rfNNkHs3dhSkmlJuuRW93T6iiIRI
	 HC9MG6RFffDcV5EdNCdsexPC+Z3Sj0BYMAXEzIdNZOrcMuGK7x8fqZgKxlypfZB6X3dfj
	 fAwN3t5cM/rHN1pvlL1nh5IOHjB9gmgfxK4IlT6ZtBYNaWh19aE0vTLPKDwa1QXNQZFKh
	 oK3lfBPwFQe+w8yPlW6guJd0/ntzGTZ9Bhe5n9AvItwlRxsH2UAtEsofYSpAfAWc6WkUp
	 oPsU9QLkh0A31VXNRPWOoHoKTgrJckZWdse/W2JzH4ncW3Lr04PMxVHDGTH49ZDrZJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094661;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=49MXG4kv3lK+l8TGKUFr5JiNaIZtWL4bQluuDxfCTNE=;
	b=1dcbUc3aH9AjHyBO+c9RwZU9v+wpSSxX+Ekwl/VJve7drWmvJOFg7oGydJyrkvm1vqD6
	 kwMzE0k+vrksyLtL9luH1qh8MhprpV7Gs3Ck0Z9QaJkBbzb/3/R9lVu/0sGkaDnapofIl
	 ON9ddJUhB2izGx1RAw5Th8sT6sXBDRDsNNRz3hn4VViPXFrHox2UUB+wDixqY22FzzjHv
	 aMtfArx4cktMxXccu/UXiPzJ/lRqZlbK+MD3a2NBEqyPmRMcMlG3s58KEGb/SSg2cv5rL
	 suJL/THxzoDUYSouGF/KnvJfDY1McS7z/+q3/CGfAEwuZNL317KTLfiL/qjoDvo1oeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aXGjh6m+;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC9B606A32A;
	Thu, 19 Nov 2026 13:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC9B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aXGjh6m+
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 974F31575;
	Thu, 19 Nov 2026 05:24:16 -0800 (PST)
Received: from [10.0.130.226] (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDFD03F882;
	Thu, 19 Nov 2026 05:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795094659; bh=kJKgHp7VmNtPFPHhYpWJxcKNQdysDbAOyglG+ckQCco=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aXGjh6m+/E0xguYMQmzIHSxFUsN6R/gXMroHEjMTcN3r1EVDio1UJtzwBmewPsoFv
	 6RF5Mt6EHIVZxHbpdQ6zWViow8f5sQ5auceQ6JiT/d4h0bGBP1hF19gwqS3D9Y7IgS
	 lJ6B5H/0sCg0mRCD81wFalyEodUuozhJJ9+BW7EE=
Message-ID: <a1c4e409-2d73-4689-b136-41825ee2b61b@arm.com>
Date: Thu, 19 Nov 2026 13:24:15 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: samsung: acpm-tmu: Fix spurious CPU throttling
To: Tudor Ambarus <tudor.ambarus@linaro.org>, bzolnier@gmail.com,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: krzk@kernel.org, rafael@kernel.org, lukasz.luba@arm.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, Juan Yescas <jyescas@google.com>
References: <20261117083442.830549-1-christian.loehle@arm.com>
 <3ea5d94b-6913-4534-816a-3935c689225b@linaro.org>
 <56a7a762-7667-4186-973c-ca0fcb399ecc@arm.com>
 <b2b0ddc6-964f-4d8d-86d4-a0bc24d9022e@arm.com>
 <4d51fe5f-d233-44d4-a50e-ef168b6f0402@linaro.org>
 <2cc6efc8-db35-4b40-ab71-815f08ed9dc9@linaro.org>
From: Christian Loehle <christian.loehle@arm.com>
Content-Language: en-US
In-Reply-To: <2cc6efc8-db35-4b40-ab71-815f08ed9dc9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 14:01, Tudor Ambarus wrote:
> 
> 
> On 11/18/26 3:28 PM, Tudor Ambarus wrote:
>> Would something along the lines work?
> 
> Thinking more about it, caching the window instead of the raw
> thresholds is simpler and closer to your v1, as inten derives from
> low/high anyway. Maybe this:
> 
> diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
> index 7c30401f8fc7..8422a7c970e7 100644
> --- a/drivers/thermal/samsung/acpm-tmu.c
> +++ b/drivers/thermal/samsung/acpm-tmu.c
> @@ -39,6 +39,10 @@
>  
>  #define GS101_REG_INTPEND(i)		((i) * 0x50 + 0xf8)
>  
> +#define ACPM_TMU_NUM_THRESHOLDS		8
> +/* Threshold 7 throttles the CPUs in hardware, regardless of the INTEN mask. */
> +#define ACPM_TMU_HW_TRIP_THRESHOLD	7
> +
>  enum {
>  	P0_INTPEND,
>  	P1_INTPEND,
> @@ -70,6 +74,9 @@ struct acpm_tmu_sensor {
>  	struct acpm_tmu_priv *priv;
>  	struct mutex lock; /* protects sensor state */
>  	enum thermal_device_mode mode;
> +	/* Last programmed window, protected by the thermal zone lock */
> +	int low;
> +	int high;
>  	bool enabled;
>  };
>  
> @@ -228,7 +235,8 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  }
>  
>  static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
> -				      u8 thresholds[2], u8 inten)
> +				      u8 thresholds[ACPM_TMU_NUM_THRESHOLDS],
> +				      u8 inten)
>  {
>  	struct acpm_tmu_priv *priv = sensor->priv;
>  	struct acpm_handle *handle = priv->handle;
> @@ -249,7 +257,7 @@ static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
>  	}
>  
>  	ret = ops->set_threshold(handle, mbox_chan_id, acpm_sensor_id,
> -				 thresholds, 2);
> +				 thresholds, ACPM_TMU_NUM_THRESHOLDS);
>  	if (!ret) {
>  		ret = ops->set_interrupt_enable(handle, mbox_chan_id,
>  						acpm_sensor_id, inten);
> @@ -267,12 +275,22 @@ static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
>  	return ret;
>  }
>  
> -static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
> +static int acpm_tmu_get_crit_temp(struct thermal_trip *trip, void *arg)
>  {
> -	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
> -	struct acpm_tmu_priv *priv = sensor->priv;
> -	struct device *dev = priv->dev;
> -	u8 thresholds[2] = {};
> +	int *temp = arg;
> +
> +	if (trip->type == THERMAL_TRIP_CRITICAL &&
> +	    trip->temperature != THERMAL_TEMP_INVALID)
> +		*temp = min(*temp, trip->temperature);
> +
> +	return 0;
> +}
> +
> +static int acpm_tmu_program_thresholds(struct acpm_tmu_sensor *sensor,
> +				       int low, int high, int crit)
> +{
> +	struct device *dev = sensor->priv->dev;
> +	u8 thresholds[ACPM_TMU_NUM_THRESHOLDS] = {};
>  	u8 inten = 0;
>  	int ret;
>  
> @@ -288,17 +306,61 @@ static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
>  		inten |= BIT(1);
>  	}
>  
> +	/*
> +	 * The firmware programs all thresholds at once. Set the hardware trip
> +	 * to the critical trip temperature, so that it never fires below the
> +	 * point where the thermal core shuts the system down.
> +	 */
> +	thresholds[ACPM_TMU_HW_TRIP_THRESHOLD] =
> +		clamp_val(crit / MILLIDEGREE_PER_DEGREE, 0, 255);
> +
>  	ret = pm_runtime_resume_and_get(dev);
>  	if (ret)
>  		return ret;
>  
>  	ret = acpm_tmu_update_thresholds(sensor, thresholds, inten);
> +	if (!ret) {
> +		sensor->low = low;
> +		sensor->high = high;
> +	}
>  
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
>  
> +static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
> +{
> +	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
> +	int crit = INT_MAX;
> +
> +	/*
> +	 * Use the lowest critical trip temperature. If the zone has no
> +	 * critical trip, crit stays INT_MAX and is clamped to the highest
> +	 * threshold value.
> +	 */
> +	for_each_thermal_trip(tz, acpm_tmu_get_crit_temp, &crit);
> +
> +	return acpm_tmu_program_thresholds(sensor, low, high, crit);
> +}
> +
> +static int acpm_tmu_set_trip_temp(struct thermal_zone_device *tz,
> +				  const struct thermal_trip *trip, int temp)
> +{
> +	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
> +
> +	if (trip->type != THERMAL_TRIP_CRITICAL)
> +		return 0;
> +
> +	/*
> +	 * The thermal core skips .set_trips() when the low/high window does
> +	 * not change, so update the hardware trip threshold here, keeping the
> +	 * last programmed window.
> +	 */
> +	return acpm_tmu_program_thresholds(sensor, sensor->low, sensor->high,
> +					   temp);
> +}
> +
>  static int acpm_tmu_change_mode(struct thermal_zone_device *tz,
>  				enum thermal_device_mode mode)
>  {
> @@ -329,6 +391,7 @@ static const struct thermal_zone_device_ops acpm_tmu_sensor_ops = {
>  	.change_mode = acpm_tmu_change_mode,
>  	.get_temp = acpm_tmu_get_temp,
>  	.set_trips = acpm_tmu_set_trips,
> +	.set_trip_temp = acpm_tmu_set_trip_temp,
>  };
>  
>  static bool acpm_tmu_clear_pending_irq(struct acpm_tmu_sensor *sensor)
> @@ -479,6 +542,8 @@ static int acpm_tmu_probe(struct platform_device *pdev)
>  		mutex_init(&sensor->lock);
>  		sensor->group = &data->sensor_groups[i];
>  		sensor->priv = priv;
> +		sensor->low = -INT_MAX;
> +		sensor->high = INT_MAX;
>  
>  		tzd = devm_thermal_of_zone_register(dev, i, sensor,
>  						    &acpm_tmu_sensor_ops);
> 

Yup something along those lines would work with some minor fixes if we wanna
handle program failures and restore/undo partials.

The alternative is of course to just hardcode slot 7, downstream uses 115C
as a default value (supplied by DT trip point 'hot'). Or do that as a fix and
then follow-up with a proper wire-up? What do you prefer?
