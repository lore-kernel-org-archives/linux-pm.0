Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FAB370AE4
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790835084; cv=none; b=FRv3EgZxsm6AK23D219i9U7mLg70tjjfiAGnm4ln+Q6TILJrDA92b3GtBPsGwdsKGEIPcq0d1pvpRNbqzJDFc0eAskk037a32SuAWFF3VDs8qgxvwHGjdKvGLTEq5Pm6LkGl/Lc+a6Ririm8+UH+nWquNnwBKds9w4z/hFIEhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790835084; c=relaxed/simple;
	bh=V+7fq0aIITW4y/H2dS9YpjMAyw1V9R1Ey7YiRCW4oTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFcNyyZY46F0l1AWqGNW1Hrt7iiPYgNBl/2tn73GGe1c62njYxCDf/6D8THVQUklF3QZKhSDEJ9JKOKy0cOOnDUdYAay+AUdBtKltXtt572S6okQMpRiwQlpHGBQoz3HJbxjx1zhLjoEgasqrYiWcl/e4sAQOwdWUUm/0u5HDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kuylOZMb; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kuylOZMb"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e62211987so6154805eec.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 23:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790835081; x=1791439881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=APRwSvDbSgJ/cF1X+Olcbk7Y4gCP43eD+/63lefDSyc=;
        b=kuylOZMbaTm8sEDuXDeBrd9s52Wi2En15V1n3Y1jCs+Di4GvWbvL8VOsMqsid6+G15
         nNwixxKqaKFCmSfInCjuqQgqnvfNCeRWPHjQN0HTkJokQGXudpNSouUwUnC16l3sVIhv
         t72ZCqkWmoNZTvMP0pLoqPWWDYFFBdU9GTdfeZ4taf+TdbgaOIBGJxIAsSUY5epYZlgQ
         z4O9P1Qkg7XXblbZRgGbyAG12V/+PSZhhvkgsLbr2axQoRCyHlCEVtbvN4/+uj45a/xS
         iNJXRixPR7mH4Z9hbHW+WTX9nZbD5tYNThVRNR1ywKlc+jOnRvJ/MBJnZWcAs03U/0ae
         FGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790835081; x=1791439881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=APRwSvDbSgJ/cF1X+Olcbk7Y4gCP43eD+/63lefDSyc=;
        b=KVEl9yS2a33Xv3kNGyiMhlx85VFFylAcMwizbW9QxS6sTWRfl6soXFqx8GGQQmx/F2
         3DbGs4xl3j9xR6qPZSlXfg0bi1MW/FNCE//oX8dxC58ACGGusGwjwOWOsL82lVe7Ck2U
         axaGkfRX7dNcn5ZlzDPNLS7bqFQ6rgHOiWBsiDdx0tp3H2/DR8MzuI2MZfveEKkAK+1C
         KN4+MXKlKpKC6ts5Gz33rjV1Px5xD7QBCcD1JrrqJmLrYJjX6VwE7xm6ROJkuGkYOhL/
         crzhuMoOKaGw53H/4sgphouFU4KegElEST2N2nay+LKT39yVpaq0dvCLVDQvybItDU9z
         y22w==
X-Forwarded-Encrypted: i=1; AKwUvBw0oIYr4qZwVhgko3t6EkG5ZqgkwIZRcYHbfFbi0tYaptGYWsFmXJ8HFWdBHfjjW6XvFyppO3DCcQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2iSY1GdZvOlUEJBlWpsjCCj1s/G5QawS6I9nobJyAOifVtZqy
	1JYOh3Tbf/Nw6wCbgRcdnUu1EgJIWKi1iyQVN1/1SxMsEOmQvj+fhDhtS3E5lkszuoA=
X-Gm-Gg: AYBFou39nnNsUlTpq9KVcbke2RSXIcBnEgEUVzujwj//4rFOBY/50scU6YLC6LVcGLK
	eoWO7loi03Z90iWlVhcMKxGgsqiYva40Ko0EC2okNiFwcug7+S2AuNR7HjUBf3YTSr/EenHsWS0
	BE9wvg9S/rdb7nFXpYBoFIjPhZ8Ux5RzOjbNbeHQfVJEXESWglVvgUS6xgCf/Bq9NCltRg5NOk8
	aTtgdp2piCntxtq2WV0hIuSDykabjVe6IIv4bWHtvwYNVdfxGs0oIu7dPthzxAMyQBQXxbnuB6F
	cDNDBdAqyw7XGUQNpazEoXuEfjTljd2tMSSwjnREC/VCnbh0t9Ieh1Jg5Vrog4B6UNxB+EKZ0vm
	gsHNjuAF0Dyv7ZNFBQEajJXmRWaZ87XTFeT4v5+Fz4V575aWF2L3WaQcCpzCY/1TP8TKrM3fqzO
	dSURG/YDBPkpbJ/OUPHH8r0tOQ2w07sjY6s9McoDzdnUC4sXuuGliWEC7i+BbDz56XefetygTnG
	Q==
X-Received: by 2002:a05:7300:f408:b0:34c:b75a:ac21 with SMTP id 5a478bee46e88-34cdcabcc65mr4493118eec.35.1790835080766;
        Wed, 30 Sep 2026 23:11:20 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db5016caasm4237966eec.30.2026.09.30.23.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:11:19 -0700 (PDT)
Date: Thu, 1 Oct 2026 11:41:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
	Jordan Crouse <jordan@cosmicpenguin.net>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix the return value in dev_pm_opp_get_of_node()
 kernel-doc
Message-ID: <ar35hDWrzXcqdc45@vireshk-B250M-D3H>
References: <20260911221443.7139-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911221443.7139-1-kmehltretter@gmail.com>

On 12-09-26, 00:14, Karl Mehltretter wrote:
> dev_pm_opp_get_of_node() returns NULL when the OPP is invalid, but its
> kernel-doc says "else 0 on success", which was never true. Say NULL.
> 
> Fixes: e2f4b5f8dc59 ("PM / OPP: Implement dev_pm_opp_get_of_node()")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/opp/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 2f3bbde9a9e1742a2d6b40be91a65d8fa7365bf3..ea93800795783f0595483742c0c10de42b25518a 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1409,7 +1409,7 @@ bool dev_pm_opp_of_has_required_opp(struct device *dev)
>   * dev_pm_opp_get_of_node() - Gets the DT node corresponding to an opp
>   * @opp:	opp for which DT node has to be returned for
>   *
> - * Return: DT node corresponding to the opp, else 0 on success.
> + * Return: DT node corresponding to the opp, else NULL.
>   *
>   * The caller needs to put the node with of_node_put() after using it.
>   */

Applied. Thanks.

-- 
viresh
