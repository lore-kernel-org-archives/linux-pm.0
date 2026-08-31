Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920D3313293
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156296; cv=none; b=bVzOrsufGf0bbEBhCjtodeVIEoXe4diPlx1CWBmNWJmMzOMAfx5nSmveZtT8LAMjmrpf916u+Ultj2JmxW6rj1YRNBQcA22OFqPFXB8URXyxz9ta/KcMl5MtKTBmLX6W/KHE06Xa+RGMBXxnuIVCVxqhkJ847aN47xAtFPGIhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156296; c=relaxed/simple;
	bh=5cyvu/196NUJ+2V0psX9wZ9QOGyNYgCM/yD+0cVP05U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1cnZv7OPkVVx29FvGs64xeqhXQfzawOn/szF8tCTyg9qhukTPvbxhVSgAFdzx/J5ifBWxBzMJkUvGv/wRaeZnsYQjRy/mu2YhLT+NIMkKFyh7aMGqi24RzUGLKWd7ngABe1qjpOmK8CWF0RkhPK/k9oEsbeeKbAIUQkT4k05lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LXsqiBii; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXsqiBii"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so3193565a91.3
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 23:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788156294; x=1788761094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0PJ2y/FfJS/eSstN+8fj99mvu+UkmdEPeEPTUdQQoxo=;
        b=LXsqiBiisdP49HQeTm2gbM6aguyg860Y1iH+4pxr1vNtsYgocw+MTOZbinR7Fq9wxg
         hcuSsCwFTpNaVk+iXobSpUlwPi96FMpqrd8BLTmJ/kWfH47XK6O4rASIjcFdnkkO/xww
         UzQO7jU3TC6c2fw7TPKIFbx5PqJ1ZQxc96uWpSBYSz6E4JV6kxtk2Rynms/AUpR99Xa7
         NRa5wTcFef2me4bIUG/pa9QZKvqqHi4b7Xsbz1hwV2Jyrmh3QTLYPBo2IQuT2BKuHlQN
         2ac93bs+66AjNkRHsJg6ozEaajNlib6QZ58+g65XbnXFKOdapZOeLm85RI4Ntf+QVSMo
         ui5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788156294; x=1788761094;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0PJ2y/FfJS/eSstN+8fj99mvu+UkmdEPeEPTUdQQoxo=;
        b=BI4v8Mum0Hxcy/3+XobMpZxu+v/Y+U7IU6ZoNsEFRs/79SeXDRJZMeh4Aqg99S41xD
         DG2VpWA3k40AxYnPGAkSegpF+aXYZJQUppsFIKDr/I3/1hk0GB9Bav+q3rou5MH80dZj
         W5NoqbrQRUNRIh0B2LKzgiOzM3G54ohrFIaQS8iMP7oBFN+U+JT2afz74wUMh7oFOmGr
         Yzhr5mhVdn1JIxGp6BIPoMZwNtzFYHT8iTQsJNvdnFa+hzGmCEPaAQJreiAfMmB0kgzF
         o8FGNaCQwS1UwJgEgMwztKVAtsvEuIsleczEjC4hYrcKCcc1FHzCKrLhIkc9D9eLxizB
         dJOg==
X-Forwarded-Encrypted: i=1; AKwUvBz/dEps6LlNYBXsvwHzsU9t8yxdg13BeSyzkvjsdSCwvMjf9lzGUmqdGD3FQhRkDrf09nBOFwJB9A==@vger.kernel.org
X-Gm-Message-State: AFuF++lUOeC4O0YEdbOF5MdcbFq/teVAwL3NLA+6XJMReRWegn4cD4Jp
	OEnxemrXs/zleempG0RMuiFJG2/jbCpDddPeqyv7sIw9z495qMmfrBS8iqhzvQToOTg=
X-Gm-Gg: AYBFou3BcvIg1+KcCMrkQiirJfd4XB73+aVN2tNvUwwWthrWlQtn/pj18+/XvNprsYy
	RqCn6n5f0e7SRioGqCfPTvROmmZmOmnQxDbEstzGHYQU1pu7gErDDTnjJml6tep+ygMbIIKk5wn
	Oyu7ojINGpP0yt7k1bHoG2OZnME6BURWIE+VXYYTbc/Bp5C2+d7DgI3rwtXn0n3u9H51Ps71ylf
	e3h88clephkdoeWOs+C3xQg3gkYahq0CLT7fA6MD4ERJ/AKaMpmL8s67Mnb1UfNzEjx6tS6S4jR
	fTjcqL9mm+UTXlwkTZSxVAqwt7cLVyNUvSuwBzPr59ewh57cqUeiJMQkuLzaZuFY93zckNSgJFc
	X/tE5uv2YqNKS523v7Rsky5fgMp0nt6RvPfBp8i9zXSliMdOrxktA/hcsHEuZxoYKYdzeNZ909G
	mvAtBGfOnwe5g2dfLkUcOoJ0zWpSXGheasweWCX8VUh+tMqcKq6GdveGsScpy/eYE=
X-Received: by 2002:a17:90b:1d05:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-396d0ff519cmr37395830a91.14.1788156293562;
        Sun, 30 Aug 2026 23:04:53 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e41837c6sm22805738c88.11.2026.08.30.23.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:04:52 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:34:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eli Gurvitz <egurvitz@nvidia.com>
Subject: Re: [PATCH] OPP: of: Fix potential multiplication overflow when
 calculating freq
Message-ID: <apUZgrCjLxN-T031@vireshk-B250M-D3H>
References: <20260826131957.1063765-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826131957.1063765-1-colin.i.king@gmail.com>

On 26-08-26, 14:19, Colin Ian King wrote:
> The multiplication be32_to_cpup(val++) * 1000 is performed using 32 bit
> unsigned integers and hence uses a 32 bit multiplication; this will
> overflow if be32_to_cpup(val++) is greater than 4294967 (which is
> very unlikely at present). The result is assigned to an unsigned long
> (which is a 64 bit value on 64 bit systems), so fix this potential
> overflow by casting the first operand of the multiplication to
> an unsigned int.
> 
> Fixes: b496dfbc94ab ("PM / OPP: Initialize OPP table from device tree")
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/opp/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
