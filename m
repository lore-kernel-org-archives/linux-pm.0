Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DD9386C0F
	for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776282937; cv=none; b=F8boxYxchxu06PG93Po1a5BNbK7N9mTQNWKr0yD6+4OB1W2WIggN8pYPCGRbqnp7cWVpuJ0p8Ff0P0wzx7PUqk2hEgJBWiiIfJGzUo7oNLKINiQ1sRYVhGlVF40+siqiPvZuCUvN8wwl7jVuf5hoVJzQwiXAAvrwwCnwaP9b3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776282937; c=relaxed/simple;
	bh=RK4aNovGzgl+6i1bMhP05nXgdL/ainuyjUw+f45FZfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRNGAez7+iWkls1pOyDGyMfaRHGtmMcR4qKWldwlWAjdLVjGfLikCp0gwOeo7g++9wnNVgSYAu+rN7JaDKEnzqU5JclSVZ+AO02ZZ3LD0aeg5Vl+b3CCGPcMks8Eu7cH5LGbEbbZx1xp4iDiCv3TfPYypJJY9OtuAVpCucHuQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVlaS0M3; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVlaS0M3"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b6b0500e06so13705284eec.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776282935; x=1776887735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xCXSC3LdHtnumgqcxAzeG+LvUi6uSejrDQHQNNOcpY=;
        b=RVlaS0M3J4J6Qqz2/Q/r8xQJ84X4D5WLtewpbkpZp6kTZm/NyJCLHbibf9YqvB63+o
         dUe3lwoBj5C6GT0GJeqkZe1Y48c1ruiKccPd9lnV523vWgmfETXCXjijwU6DVoW9Kixj
         y2qJslklz9itmXDUQ5szWnR0kYwPdwYZN+Gl4LiAE5/dhvjgXPzkzN13I0N0cMfBzcwp
         t+ExQnxKKw000qfcDd8kMziNAAZNcCIV87QNVKPmEHh66QIzJ2KBYsYCoQrEesx+93Uf
         NKS3oPGJdNkTDmCgyTZN83DH6Klvv6kqpB60XzmBVYPJjAd9LDCxPn48L2aPDUIVoZtr
         AlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776282935; x=1776887735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xCXSC3LdHtnumgqcxAzeG+LvUi6uSejrDQHQNNOcpY=;
        b=i9zUdFuU7Dv1wLjCrAClgwEtqtfYtD/nRuFHi40IWQzsKR5O0eHUr38xFehHBLB+Uf
         4i3w4WqwwGW66+g+50TC1XC5fPk55u09NWXZWMAdPlnX/RZDOx8eVaQ0Ah1nku1dOdr0
         bFG7cA/83cW5bKWrCAa4J7/LUB5q5wV6qMIvzzCz5yYqljeFMD0G3m/jLw27QumQRp9R
         93bqGhufhczPuxd5X4olVV+Y2np6dVcAGM35hmKPOvCBiSEyx6GkYA2f7SkvxLwuX8ZV
         qpAiQ2vVqq27kw1rDymV3Hub85VkWhdryz4gBOpnZ6bWG4ia6KfHawxKCdPNC8/Tf5IQ
         uPUw==
X-Gm-Message-State: AOJu0YyxDp1BSzbwKbWkf2cUUUNo0EsskW/wdwh+U4vUGk0zoYdnp0qu
	X8gSUVbeuiUm1j63Fiwvf9aMMcUQecPkGXkUUY3zkQ1aEC4IAgHkSiyNmum/N5rqkg==
X-Gm-Gg: AeBDieuSey4s/lrpJbCm1K4JAONYUBSvbPaEFJFNum301qAgNrv1gulJcUc4hCBgZKE
	g3r34LcpsAM6PkLsQcoiy2i7roFwE4SRZuaag4Se65em1+3D3S0T3kQOUI6PrXnNmZyyZKx8O1w
	txyDz6EyQh58aX70wxV74Pc2esbDWnGfzbRIiO2mZtCUfQpYbGgU9/7TCsq6ujvQb5J+S895KmC
	mPIijwPsj3IaP4Ky1T1T42FdzgzeQJyrMc71UyEPgyCX9G2t96Jkq6ej8gH4Fjzi5vqZbn7PmiK
	Q85k0u+w7lo5wwZZfHYBh+NUTnK27WaTUBMlAviVYn/BLdAkyDKnMzYGxeH05UHqLFViSDNoT41
	26w9Wurue2sXh0WVGbeTU0WRmI3axdN3aqJJviTBLqBltP4geJMySAadfSYwcqpBbubnMdfepCd
	1TEmDVIKWIHwE5hRarYCjRGXTWiib7d+4lcwuYvEbkAIO23seL8zhE40xpT6WDzNnsLcKV0bscI
	5gmxVkAkA7Ci02OQXgdRBi2npo4EXnuNYRTruqYs/sF4uc=
X-Received: by 2002:a05:7301:fa04:b0:2c7:5a7b:e8c0 with SMTP id 5a478bee46e88-2d587a8c4fbmr13407199eec.12.1776282934839;
        Wed, 15 Apr 2026 12:55:34 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:6425:3216:15e7:2eac? ([2a00:79e0:2e7c:8:6425:3216:15e7:2eac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c016198sm4105009eec.1.2026.04.15.12.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 12:55:34 -0700 (PDT)
Message-ID: <21b76d80-80b6-4f80-b884-365f1d376bc7@google.com>
Date: Wed, 15 Apr 2026 12:55:31 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] power: supply: max77759: add charger driver
To: Dan Carpenter <error27@gmail.com>
Cc: linux-pm@vger.kernel.org
References: <adjNgZAaULzTBtJO@stanley.mountain>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <adjNgZAaULzTBtJO@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan,

Thanks for running the static checker.

On 4/10/26 3:14 AM, Dan Carpenter wrote:
> Hello Amit Sunil Dhamne,
>
> Commit 70d7dd27f6dc ("power: supply: max77759: add charger driver")
> from Mar 25, 2026 (linux-next), leads to the following Smatch static
> checker warning:
>
> 	drivers/power/supply/max77759_charger.c:117 get_online()
> 	info: return a literal instead of 'ret'
>
> drivers/power/supply/max77759_charger.c
>      97  static int charger_input_valid(struct max77759_charger *chg)
>      98  {
>      99          u32 val;
>     100          int ret;
>     101
>     102          ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT_OK, &val);
>     103          if (ret)
>     104                  return ret;
>     105
>     106          return (val & MAX77759_CHGR_REG_CHG_INT_CHG) &&
>     107                  (val & MAX77759_CHGR_REG_CHG_INT_CHGIN);
>     108  }
>     109
>     110  static int get_online(struct max77759_charger *chg)
>     111  {
>     112          u32 val;
>     113          int ret;
>     114
>     115          ret = charger_input_valid(chg);
>     116          if (ret <= 0)
>     117                  return ret;
>
> This needs some comments.  From the naming, we would assume

Sure, I can add a comment.


> charger_input_valid() returns true for valid and false for invalid.
>
> Based on reading the code get_online() return true/false as well
> but what does it mean?  false means offline and true means online?
> In which sense is this a get_ function?  I'm so confused.

You're correct, a value of 0 would mean offline, 1 would mean online and 
a failure to read the hardware register would cause it to return with 
the appropriate error code.

This is a get_ function because it is a internal helper function to get 
the "POWER_SUPPLY_PROP_ONLINE" property.


BR,

Amit

>
>     118
>     119          ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_02, &val);
>     120          if (ret)
>     121                  return ret;
>     122
>     123          guard(mutex)(&chg->lock);
>     124
>     125          return (val & MAX77759_CHGR_REG_CHG_DETAILS_02_CHGIN_STS) &&
>     126                  (chg->mode == MAX77759_CHGR_MODE_CHG_BUCK_ON);
>     127  }
>
> This email is a free service from the Smatch-CI project [smatch.sf.net].
>
> regards,
> dan carpenter
