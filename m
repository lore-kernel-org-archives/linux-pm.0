Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978A44063E
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770491; cv=none; b=dJte28QQbJJJTrBQLyvTe22oogBU+Nx+fjm1XJlHuxuLYDfCgxWpiXirSbIMTjbSpkHUJdYWrdhEM3JOhcPA/66Ss/w7/wMWkUuDOjMaAvkf4/DzYNHc+kLnaBTwA8pSshWIfr/JTuTTIGAyhxhZHHfaZwdeIwJM+oV3bHTuDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770491; c=relaxed/simple;
	bh=A6UKEG9tjljy5BO29IM2NVDCr1jF0sWllS0wIOUNkIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ2IofeNz3BTvJdayuaiY/xs0gv07JwLHI+BbK+t6BqkRBGf38mdSRIQInF7tSReRX9YL1q0IR/CuDU5XRCZGKH2rOL/Kd3hrKvEc2JGpSu5RD/5qecReDAfWYpUBg2mo5nCam3ZoNqfFOR41OXuYa+5SANzVijDAZbeAoK8zTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSb8yF1c; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSb8yF1c"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso2168981a12.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788770488; x=1789375288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gD95xacnSwO5QNP7UhKSOo6QX3f1oTJ0b9N0SjSezHA=;
        b=MSb8yF1cqkrIM/JKPG4bMygRmz7myz0SeiknyjQ6IllPJXpYyVDCxrp9sM6XI39yFN
         VbNmEm1Kd5kWHIs4dJy1UIaOKtdoM9X6DPnUfdyYGpisjwqYStXVkx9+/NYM5il5nEMX
         DUoYDtU1E5k/GWEadmtd84BT995w821gEkLX1BJYr1FM4sJMDAVz8AJfXX+8fIe2nl4g
         Ny9OIgkVAnNT+/s7iZrOdHlX/p84Zto8+/7T0sTvuOBLm3BevWKlXfiN5fPRUdvnyoYM
         FwORJ2hncBcOzyeaPekAKIOGBu2C4j50O+3vKi4aZqb5YTVtcbPf8yc55YAXXrXS1b1O
         Ni9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788770488; x=1789375288;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gD95xacnSwO5QNP7UhKSOo6QX3f1oTJ0b9N0SjSezHA=;
        b=dXqmUWZ3lnViM5+XBzB5pyzS3/LRIBNPx4vJq1Db7sOX5wH6PSzYJbd195xHOfmpow
         aA3WL4Kt5uYZwWgVkYIrO8kcN7RqlbVRUeDLWeLhkElCvU3uaIGrpyGiSPe9CU91IJzA
         /1fqk2fY2A1Qn7p5uhZl7HGAqcdVEdRWnK0cJW0vYy4bU2FYtVgmQSZIf8Z5cVVMO7X+
         KWllkw3hNxIqRLbRvPWAC/JYUWBhRm07KbQuQ/sr/cI6h5w+Rv3GC8SWhNni0nQ/Go1a
         +2tzEAcLQMeQTTG/sILxgeCdrOX7sHh9OrB5oItM1FUmOrtuIX+cxq+6HtOAqze+xRNT
         /j4w==
X-Forwarded-Encrypted: i=1; AKwUvBwcebCcPlOZvRjjawLAsMBKzyvpxEwEtj4ury5hM4gnYij6Ei0SWLuHwjFe2EwxPtjP8ppPwbMEbw==@vger.kernel.org
X-Gm-Message-State: AFuF++lkQcBp5jFBnuG3IAUe6FqrIHlllWM+CdoXW1f1vxhykH3SUoHH
	LfvA035Q1oaoIx2C6Bi5pLHRQJ5JW1uPJ6TVWH6vdTZHEkiTFa+M1hwE
X-Gm-Gg: AYBFou0OejoHAys9vwCBdmd0b3NwdzOHPFdtt/9ezqDS/DcWaYvHxKB1vEaCxYJOx13
	GIwFWhMpEhuGD3vTZ6uzD5BOhkrcENkroVmHcGMBMWvXfw6FqFQY5HP8QzP66RBMOOPOmZ2m+Wb
	zgH3FlR8mHH2oZAYnNYjPbrcgKhCOiNvnvsWPT6YchPyUFBVRZRx9IrnAKKLTCJHOlLXD/wcSyE
	Z7NZP1grpD53CGmCl80cqOwVxVBfFnHc/57Xu/qbpGEBHcrdJzVU8fsuwugtwBzWm6xAv8H/R2t
	Age+QI/UXOSlQr0nkymsX/XTkVM8Uq2lrhVvj/orSlZQiFAPxSYO28ABUTGqjSC37ofMLDwZ5an
	KxX90yFOeHsWg2ODbqqhMB/lgHI0eJjX3+nJtvk8BESQsRO++O/8l2vcExagzbHzg+jfKvWQUQq
	lRaSyY/iBNRG9pVQH7p+8PnDhFiArSsRneiziJv9rgyrByIB9QNmEOb49gA/BfMPV/uho8y18+M
	OE+BWcktEhmeP9koGNhJ1aA
X-Received: by 2002:a17:90b:510c:b0:398:9be6:f999 with SMTP id 98e67ed59e1d1-39b262e27a9mr35876536a91.24.1788770488465;
        Mon, 07 Sep 2026 01:41:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:e8d1:b40d:5214:17c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c39227sm25947600a91.9.2026.09.07.01.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:41:28 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:41:25 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Add kernel-doc for devm_of_icc_get(),
 icc_enable() and icc_disable()
Message-ID: <ap54tQSLFZs4N_KU@google.com>
References: <20260907020504.24783-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907020504.24783-1-kmehltretter@gmail.com>

Hi Karl,

On Mon, Sep 07, 2026 at 04:05:04AM +0200, Karl Mehltretter wrote:
> Documentation/driver-api/interconnect.rst lists devm_of_icc_get(),
> icc_enable() and icc_disable() in its kernel-doc directive for
> drivers/interconnect/core.c, but none of the three functions has a
> kernel-doc comment. The directive silently produces nothing for them, so
> the consumer API section of the rendered documentation never shows
> them.
> 
> Add kernel-doc comments in the style of the neighbouring functions.
> 
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/interconnect/core.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 4aa991a54101..6f854375201d 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -423,6 +423,17 @@ static void devm_icc_release(struct device *dev, void *res)
>  	icc_put(*(struct icc_path **)res);
>  }
>  
> +/**
> + * devm_of_icc_get() - get a path handle from a DT node based on name
> + * @dev: device pointer for the consumer device
> + * @name: interconnect path name
> + *
> + * This function is the resource managed version of of_icc_get(). The path
> + * is released with icc_put() automatically when @dev is unbound.
> + *
> + * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
> + * when the API is disabled or the "interconnects" DT property is missing.
> + */
>  struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
>  {
>  	struct icc_path **ptr, *path;
> @@ -786,12 +797,32 @@ static int __icc_enable(struct icc_path *path, bool enable)
>  			  path->reqs[0].peak_bw);
>  }
>  
> +/**
> + * icc_enable() - enable a path
> + * @path: reference to the path returned by icc_get()

Since a path can also be obtained from other functions like
of_icc_get() or of_icc_get_by_index(), maybe it would be better to
describe it simply as:

* @path: interconnect path

This would also keep it consistent with neighboring functions such as
icc_set_bw() and icc_get_name().


> + *
> + * Mark all requests on the path as enabled and reapply the bandwidth that
> + * was last set with icc_set_bw(). A NULL @path is ignored.

Since __icc_enable() explicitly returns 0 when path is NULL, it might
be a bit clearer to mention the return value explicitly, e.g.:

Passing a NULL @path is a no-op and returns 0.

Regards,
Kuan-Wei

> + *
> + * Return: 0 on success, or an appropriate error code otherwise.
> + */
>  int icc_enable(struct icc_path *path)
>  {
>  	return __icc_enable(path, true);
>  }
>  EXPORT_SYMBOL_GPL(icc_enable);
>  
> +/**
> + * icc_disable() - disable a path
> + * @path: reference to the path returned by icc_get()
> + *
> + * Mark all requests on the path as disabled, so that they no longer count
> + * towards the aggregated bandwidth, and reapply the constraints. The
> + * requested bandwidth is kept and restored by icc_enable(). A NULL @path is
> + * ignored.
> + *
> + * Return: 0 on success, or an appropriate error code otherwise.
> + */
>  int icc_disable(struct icc_path *path)
>  {
>  	return __icc_enable(path, false);
> -- 
> 2.53.0
> 
> 
