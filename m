Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC901BD9CE
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775782903; cv=none; b=oUOJqftHqA/rZZNjB/rWk9G+sp8H9a85nbtpJ0sgGxYDXYcbK4mnHTvKStZIw3vGU+KeJ/a0jwDuEICD/ZpdOuu7qjeigAOWFXFiYbqLZBeQhhfEPlvne9Su37H3oVSW/jh5DHjQVjzUxOpv8B94hXMI8FYx4yVaBov73jAYgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775782903; c=relaxed/simple;
	bh=O1oqU5q5okVp6Eq7KhaJYRT8N5oZTYs7sw6L2W1OpmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prFQioooVuTuQhgUTxDVi5MbaYXU5Q6SRaAk7rE7tu40Fky5uV+Vcn2v+qGsgexXhMCHY5pk3WUwzeaZyjoiXlxFZaQ+23b/gZBd14+j6mDSkfGrMFP4LKkTt93rMkPH9zi8p997DKltYF0YHLtR4p6ITq3WboUE7DB7AMM9nmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=0zifnLjt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="0zifnLjt"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82418b0178cso774020b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 18:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775782901; x=1776387701; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CDukKgIxUDFhviJEhQQl8OKCJeL8VtYjziTmoESltr0=;
        b=0zifnLjt59ENXbULyxV2hfv8CI1gn3xLGicwajRFjCR0S4mubP1/RgLFNpsSVVMHOP
         6K1X0S4laaWRf0e/4nlJ0SbA5ivP8Wmox39Uc5ShzkRH13RO7GdLd3cgatQRZX/OzSbE
         lKQArwm9HLiAzVZ1m9emyVU6V+hrs98vWWJS0zVCyrSTc1QvrWfMPLm1YiHEcMH1UM+Y
         CtmhkV5oOLnxSMGv/WkaIK4MXUAHKzvV0phgjhTKe5TSq/qNR+iryIAj8e87xVQ/5Rsr
         /1RVQhtNHSAFEGDTSRth+TMY3B5KFT6EuskVNG7bAENnmYSqEN8XF4Ecy3Pc7dBiZQAf
         t4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775782901; x=1776387701;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDukKgIxUDFhviJEhQQl8OKCJeL8VtYjziTmoESltr0=;
        b=P8C29IqEn9w9s/6AQAbT5lgxzn8vtSkTajZwXQgZBiCknq4+rssvX6uvUeF9die90h
         TqAUOijhzBirKrSyXbfR8PuDXVi0gmmS+As3jJG3lwdZeXojCrsRp48jZoeyI1FJIWCE
         4XrSbyU2/ZH2AsgFAr3pwaMin+FhsuzXElIFMeagnn9WQWq/jVWGPXd3Y7wr6lyntjqX
         vGe/Hut4O47po2c/rn7sADfeTWEXazbcuFUDRY6q5nRFwY3sVjLCwb6716NFfelM02vm
         TN+CDkGcn8ntEdX+k7gDeza52ErKazlzyJt803SWrnJn3/abJOI83Og4FCSFZ/GSBmiL
         ZByQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWqFbVh00lehh4+T+8L63nnj455wKC/yxsqHTdEv/1/NUca6w2BivpspNlPX+tTCkJrtY7cUZscQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIwYomPMoDjNlkydRtD8mFB+5aIcKKxBcCKjrQNHmt3l4XRKm
	hZEtTLB714bO4/jE5dhgo0Oo7MwcqhbI3hDtS0SnQsPiltSeC9xK7SOtyTQlYkQIgDc=
X-Gm-Gg: AeBDieuo51BBLzxQjf4gPcnxMBw/fq42FwXK8pdeHtOFoPWJ+fiJKbURM5wxFgeLN59
	PPg5JsrkhdqRiDklkeJqKefj0f24bh33Jg/GbCsgkGTNRy3XnIjMTdKRCELOB0WEoaldqzIjCJr
	qVZALgXDSzDSgtp59f5sXRQHaSHZwo5dvrrOje7CJSkMvzSvk1Jq27B1CLOmRGVK9NpGqhwrpgw
	pHgvgaOxzYtvMcCVmZKWzMmw+AC+lXni8eWUkN8gk26mpNHqlpGLC2Cel+P/Rm/2G9AUqo+OE21
	2rPiCWFaZAwIP8GOO55Z/WNp7jtZGv5gjSjDZzrCotGC95pGSFhJwXR+lXvwDLt9qI/GG7d1qF+
	mxv+Btgc1guc2knqWahRQKIw4l7Ji6zdBchV/44sWKAzkzniZqWF0l/tBT3SWj99dIa/0wUsrWP
	q7htgdBxJt58Np7xw105c=
X-Received: by 2002:a05:6a00:1bcd:b0:82c:24d5:63e6 with SMTP id d2e1a72fcca58-82f0c169049mr1259317b3a.15.1775782900710;
        Thu, 09 Apr 2026 18:01:40 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30f5c3sm731115b3a.3.2026.04.09.18.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:01:40 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] pmdomain: arm_scmi: add support for domain hierarchies
In-Reply-To: <20260313120707.jhkyd772wzuwmlhd@lcpd911>
References: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
 <20260310-topic-lpm-pmdomain-child-ids-v1-3-5361687a18ff@baylibre.com>
 <20260313120707.jhkyd772wzuwmlhd@lcpd911>
Date: Thu, 09 Apr 2026 18:01:39 -0700
Message-ID: <7hwlyfr5l8.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dhruva Gole <d-gole@ti.com> writes:

> On Mar 10, 2026 at 17:19:25 -0700, Kevin Hilman (TI) wrote:
>> After primary SCMI pmdomain is created, use new of_genpd helper which
>> checks for child domain mappings defined in power-domains-child-ids.
>> 
>> Also remove any child domain mappings when SCMI domain is removed.
>> 
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>
> Again, since it worked fine on my AM62L,
> Tested-by: Dhruva Gole <d-gole@ti.com>

Thanks for testing & reviewing!

> But I had some thoughts further down...
>
>>  drivers/pmdomain/arm/scmi_pm_domain.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
>> index b5e2ffd5ea64..9d8faef44aa9 100644
>> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
>> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
>> @@ -114,6 +114,14 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
>>  
>>  	dev_set_drvdata(dev, scmi_pd_data);
>>  
>> +	/*
>> +	 * Parse (optional) power-domains-child-ids property to
>> +	 * establish parent-child relationships
>> +	 */
>> +	ret = of_genpd_add_child_ids(np, scmi_pd_data);
>> +	if (ret < 0 && ret != -ENOENT)
>> +		pr_err("Failed to parse power-domains-child-ids for %pOF: %d\n", np, ret);
>
> Nit: I think the style of this driver is to use dev_err than pr_err

Agreed.

> Also, maybe a dev_warn makes more sense since we're not even returning
> the error or doing anything different if we get certain error path.

OK.

> I am wondering if it makes sense to just abort the whole idea of
> creating power-domain child ids if anything goes wrong?
>
> Basically just of_genpd_remove_child_ids if we face a condition where we
> have different number of parents/ children or id > num etc...
>
> All are error cases where the system behaviour can go on to become very
> unpredictable if we end up making a false/ incomplete parent-child ID
> map.
>
> Thoughts?

I agree.  After thinking through some of Ulf's suggestions on the
different error handling ideas, I think this should really be "all or
nothing".  If we we cannot parse & add all the children in the list, we
should add none of them.  I think partial additions will be come
unwieldy to manage rather quickly, and require the pmdomain core to keep
state.

Kevin
