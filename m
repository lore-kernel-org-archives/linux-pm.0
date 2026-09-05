Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B83603EF
	for <linux-pm@vger.kernel.org>; Sat,  5 Sep 2026 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602319; cv=none; b=NnxdlRY+5IhmWn7FTbODHP2DbhwMKjMe/oVy6ClrqQI1ZjA3AZGJQaXWIFRtYjFiRwYNYx9YU6qY7IAJ5CqmoqBN7QsixxPavoUFo3Wsi47SoeDd3Me/xUGJjXzqj3yyYFGY2pjs68Cd+j7/iczIc7BsHpV0yS/akNjxlMXIam8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602319; c=relaxed/simple;
	bh=TPh+2S4EjKCMHY3hnA1MkQOSVSa14YnYfoTQlZcQt2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWsjgUKYS9cTPHFCEIY7BtQbleoKqAB9wb1BrjjFy1Zd4fzs/THXiwJgwy+D01EjoxiyWqnCVTRpQz1dx1uB7hfg7IcIvMiVTRT8JH1yKYeAbTwtZHCUfoXn+7D7t0oyqu+t0Es2cdgLo9VUmPIf6YgMasFVBQDKU5hoWhpon2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrInLqgZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrInLqgZ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so24857635e9.3
        for <linux-pm@vger.kernel.org>; Sat, 05 Sep 2026 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788602316; x=1789207116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LRvfrJeL7Y7uiXmrE76Xnc9F45gApWlV6DJkXBriHZU=;
        b=MrInLqgZZ2G0DU323P7nuVaEaiSPB7ygZirYEOcWRj6wZ9IUJTHHak5z8WiD/8QnNI
         V+WYl1caKgROyCWZlCJvDCgyy9fgRtMNQG185gHoWGmRWeoyIuLhYMhIJAltuIEufuZC
         RBDeAgEAIQDNdAEnd1PIiW1GUFuXVLMw2OoV+qPLaFNdkEbOqOsZO7xW1H/ZBSK6gGSz
         cPyD2Gz2bZCo7D/EtKkpleaPEyyjOUjnia/FBwik0WE1g65XRVA2DsScmI2FkSJEFptS
         26FU3WS5miDLXGU3QGoUMGSiOFhRvp8mAOfXiYZqZOJTRkwhPH5C7CEbtncjFkt0mfur
         wA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788602316; x=1789207116;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRvfrJeL7Y7uiXmrE76Xnc9F45gApWlV6DJkXBriHZU=;
        b=gt2H4OlMTVZtiUwQBcQGcgrsY3esfbpHsZksH4S2PF6eCe8ukhLbPlZW086Gf6D07p
         5ycPYw3Sm0GYXmjy5lO3+215bXLg+c8IvqCtEvbU1RgPWi0DrdcFW5aZY7A9EfeT7mu/
         HFgdXzojMeprpaklifGEIUmndreFXAnyqbPhlWJxhzhLafVu+sJHKjjj8UK05dtbhbbO
         isJ4/AXqC1QPhW0JHoar5xElwGKHF6hQV5hH83OIeokEB+YEurs8C3UdZsNhePiY15Xt
         797IA4ZniWX/0LG6oElQEER6VwwJV02cL2Rz/Pt1cF1TDcLLTDlmCCiqd/CLMW78Jzt6
         kbrw==
X-Gm-Message-State: AFuF++mQocsVH7Mq6k9/0O5FgN4n9iMW5tblhhy9r55f5wfc6qMm1p+8
	61UR/IJz8EEhZhVKc9Vq2I4JCb31LBvnFmqw9z8qWnJIhTpubkP3A1Ol
X-Gm-Gg: AYBFou17im8POYksSMbBrR+UR10PT62ddnJLEWFKWgnpZgm4ZZb2vNZW692VynSLsKS
	sM6CX5u/q7WCMQBooKeaTzgz2+m9TEYTh0Ff0kL0DOsYkOOBFpTufqgSp6t7uG0Fwl0hoTkcpq2
	TBCT8OdRNL6EEwXEeOdnqa0+M+sIvekBP6uLk5y00UbrcjaZ1vpYdqq4tkPPJzCwywV5MJqz6aH
	mfXYtltwdcKjue5+dEqUNBpK1tw790HuIHNfyI7icJ5fgwA7jn6xcphVNOyckkqA9Yl/jH6xux2
	DBKN769lg93zchwX/Cbbm/5578v/PciXEz3pyAtknV3deIMOT/TFJLUla8EgEwTN19tcrfJ/vWz
	VnnGc1OvA1fcaWn0i7AdahqJ2BHWKMCCtLay6+WpY/aiAlNyy7PyMoJ3ImJAFo4/T9HI2KyOrrQ
	9SVo30+gyLmIbEVyjYUwfgWx5msKiU8jlvw9SBN7sh/m9buQZaEnIg0prx2DyoZEJtegeuoGRb6
	Z41NEvq5fMJ29OEj6rSjsHQw7M=
X-Received: by 2002:a05:600c:8b6b:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49cf826be5bmr111021015e9.12.1788602316474;
        Sat, 05 Sep 2026 02:58:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6158e9sm220352435e9.12.2026.09.05.02.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:58:36 -0700 (PDT)
Date: Sat, 5 Sep 2026 10:58:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v1 1/1] thermal: sysfs: switch to use scnprintf() to
 suppress truncation warning
Message-ID: <20260905105832.12192997@pumpkin>
In-Reply-To: <20260817103324.1020212-1-andriy.shevchenko@linux.intel.com>
References: <20260817103324.1020212-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 12:33:24 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Switch the sysfs code to use scnprintf() to avoid warnings about potential
> truncation of the names of the sysfs attributes.

It has to be a 'bug' that 'format overflow' warnings are generated for
snprintf() but not for scnprintf().
They really shouldn't behave differently.

I did some tests a while back and the warning goes away if you do
'some things' with the result (like comparing against the buffer size),
but even explicitly ignoring it with a (void) cast isn't enough.

Using OPTIMIZER_HIDE_VAR() (or an _VAL variant) on the buffer size does
stop the error, but I expect gcc to start checking sizeof(buf) as well.
So both arguments might need hiding to get the warning ignored.

David

> We can't increase the buffer
> size because the size is the part of an ABI for some reason. Note, with
> the current size of buffer the affected attributes have a room for up to
> 1000 names, which ought to be enough for all cases. There is no functional
> change, as the same limitation was implied before.
> 
> Fixes: c56f5c0342df ("Thermal: Make Thermal trip points writeable")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index b44abfc997ed..44bd7c50e4ac 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -400,8 +400,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz)
>  		struct thermal_trip_attrs *trip_attrs = &td->trip_attrs;
>  
>  		/* create trip type attribute */
> -		snprintf(trip_attrs->type.name, THERMAL_NAME_LENGTH,
> -			 "trip_point_%d_type", i);
> +		scnprintf(trip_attrs->type.name, sizeof(trip_attrs->type.name),
> +			  "trip_point_%d_type", i);
>  
>  		sysfs_attr_init(&trip_attrs->type.attr.attr);
>  		trip_attrs->type.attr.attr.name = trip_attrs->type.name;
> @@ -410,8 +410,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz)
>  		attrs[i] = &trip_attrs->type.attr.attr;
>  
>  		/* create trip temp attribute */
> -		snprintf(trip_attrs->temp.name, THERMAL_NAME_LENGTH,
> -			 "trip_point_%d_temp", i);
> +		scnprintf(trip_attrs->temp.name, sizeof(trip_attrs->temp.name),
> +			  "trip_point_%d_temp", i);
>  
>  		sysfs_attr_init(&trip_attrs->temp.attr.attr);
>  		trip_attrs->temp.attr.attr.name = trip_attrs->temp.name;
> @@ -423,8 +423,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz)
>  		}
>  		attrs[i + tz->num_trips] = &trip_attrs->temp.attr.attr;
>  
> -		snprintf(trip_attrs->hyst.name, THERMAL_NAME_LENGTH,
> -			 "trip_point_%d_hyst", i);
> +		scnprintf(trip_attrs->hyst.name, sizeof(trip_attrs->hyst.name),
> +			  "trip_point_%d_hyst", i);
>  
>  		sysfs_attr_init(&trip_attrs->hyst.attr.attr);
>  		trip_attrs->hyst.attr.attr.name = trip_attrs->hyst.name;

