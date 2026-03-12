Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B89282F37
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326938; cv=none; b=RWTFPjnWHsllhGAvpiny5+3H2TJ10Nz1rfStALUrnzQJw/H6wjKPWG5m+DlrzSV7kLEYiKWdIil7nlQUTvqmQyqeSysbf02zswJe1QiO51eYoyHv4GkE5E+x10+Mqe3RcUF9fuRaFUx4tKzmBovmk0e6fabAEueJSI+7C2R++qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326938; c=relaxed/simple;
	bh=66Z6HCxO6E854kVSB95egwA2uUuHPx4B+2qVW1T27DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joRA+jc+/fVgvT49z/vRzcXHNyLhCfzOuQtx6i+IAT5092pWtU5t73MRjq2MvLG4rA5saozwSAO0Ogi4dqt3YOFMgbphcDfz64yJmPj7zTze8kPEX0cRwtQ/rrGYgVRxamKFs4IAe28VlrQpsdKybXgsOf2qNj+X2/tl/cYHrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eqPtVu4t; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqPtVu4t"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-359fea895b5so638530a91.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773326936; x=1773931736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s54V69jsHrPZ/h6JYsO9MDhbnAAyAlArvioPqyrWcJs=;
        b=eqPtVu4t6AueXAoqz2YG1AiWdrTnwLrSAO4cGOV9eIekExZ0kCA34TaELvsjAnVwW7
         5enypKgWVBbhv84TAMTgPdAmlZmSRl85HxDgeKOJalQqbvFJ2aMwIN7HCeVkCCB/umUi
         BkPt51lol9+1J6/MjHO93TTBCdLnZ9LvMfjDph5zpLmBAbSwu5Th6LdpeWfzElLM711s
         LUUG/6dqCKv6fYl7JKiDd5E8FXFUNt3GSM191d4nKZL8kEYIJ+LapFXAc4UHbs+ZjO04
         EgQeFXlRlO9pVTKMF7WnXTEB72/x3Bqvx2kyselI9ZWimVd16k1d8iUokThKp6T3X3PI
         Irug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773326936; x=1773931736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s54V69jsHrPZ/h6JYsO9MDhbnAAyAlArvioPqyrWcJs=;
        b=DZ2cPZriRv/bjC5oBhahI3JmPEgZYW9Kk2pnhFc2WZbXi5wkC24jwh3H2ZX7IMdkjc
         hINW/Js2BaYe0ntHZwcPxv8WTo5qvV8Y4A7FpmR/XukDlrbydeB8CHVH2b1NJoNw45Sb
         vVlag7tPgFaL2uS0A7hXIrXm9nHL4F0a5ap0r12ytIUMnS/ZOiYfPKzEpk35KQu8UzjF
         P4xMliyFiMXFYLSkhTA0GRDMaYmHOkM2Hh3GCjmUP+53b0IwBQRiAMEz6sp5tnQP2FVt
         gZ0rLMGgj8HKRZmRG0aONAJBLOm2Ej9ioTRPe8mdwOxMZw3SCeRBE3HSs81ecgfaCM4r
         KRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL9db2y0KAt/eo2eGN9VbSG3J+phVhI6ms7w/d5JblAPov7blSq3cdwQb6oONeOeCGe+1V6Ut/Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCYRNdOvR2eGmgAivWbRlKQVpumNhORs+c0t/3lLEjcYZfG/Uu
	0WV84WQeDA+yKIYKLVAe4rbAxwKxhnCqYKekjGrNH9xGOgPYZPibyc1UI4n4o+oVSiA=
X-Gm-Gg: ATEYQzx2IwsV+fk/w6Codprgn1Ma61tslakfp78FH2JWBdWkRbw/s/KhLppns2C5K1V
	EKauHZfHCuK2AdujDzTtRGuRwpxuVNbwzzs6re7qnymOv1bf+A4C8weDAGyGiWvVSNjzKApUIsy
	2H4zmTqYh98JU5eMB/jnmR+HerY5zVWKIQLIxeH+nN9F8XCndJhAMZ7Ts2pwz2Z3ehCByCyotOP
	kVFftPr6tulyVNkG0nhCqy+cL9lAqHnE7Dbpp7Y5xwDt5Z/EpO36Q6Izro/A1bUhYN3NKvBkiLl
	BOhBeucrEZTyai8t45T1MM91qjhViB4LpL9RqNDEDS5hZXYeRHmXvPitY4/CDSOPRCDKZTPhnLE
	2yQfCSuqQZGFmy3J9RJlEYqacJGn41mH4w6lVR57oWZIfQmZ3gofzE972AaaGO+AJgdjtuOjnOS
	YP9unisVr7HQ3BHC76zmsrsAGscKvxotunpG8=
X-Received: by 2002:a17:90b:3890:b0:34c:9cf7:60a0 with SMTP id 98e67ed59e1d1-35a01284f82mr6124731a91.5.1773326935992;
        Thu, 12 Mar 2026 07:48:55 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm7405255a91.14.2026.03.12.07.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:48:55 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:18:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
Message-ID: <z33jb5vwatwba24f2ftz5zb75qzqv7h4tljq72bwbvgphuvuds@jtxtl7geedtb>
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
 <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com>
 <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
 <CAJZ5v0jvVNd3v_LcsM9Q2tZRavx0OQwZ-R4vWSzYr6edinRk4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jvVNd3v_LcsM9Q2tZRavx0OQwZ-R4vWSzYr6edinRk4A@mail.gmail.com>

On 12-03-26, 15:03, Rafael J. Wysocki wrote:
> So cs_dbs_update() does this:
> 
> if (requested_freq > policy->max || requested_freq < policy->min) {
>         requested_freq = policy->cur;
>         dbs_info->requested_freq = requested_freq;
> }
> 
> Why is it not sufficient?

Because requested_freq is within those limits, it was policy->cur
which wasn't within these limits, but that too came within that by the
time cs_dbs_update() gets called after the readjustment.

-- 
viresh
