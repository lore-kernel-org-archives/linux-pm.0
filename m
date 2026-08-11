Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0FF40EB8E;
	Tue, 11 Aug 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455437; cv=pass; b=omGdYnld/n1hTVS+Qt/E+38OkPCvTK+4yYoq7zoyUVh6k0ne1yx2cPtKidW0SjBNtugcP2ULNw1AVHyswER5LBGWzG8NT4E5W3q22kK7MvRMhX9hePBurx/GYqr6QqIRwFZPTk+XGLFAOoLqdJkhZSPBchLme+B+N+/agq9T55U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455437; c=relaxed/simple;
	bh=o8Td7qe5QSTcG8fliRZI5vIFKNDTVQG7rM5ylLp5U/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/6lQEK94XM95qORlJHYn8YJF0xwD0Y6RPBn8U4l+FuLUIQCr1P5PFj6aOSE05xqD8NfYK6V8h2r6jCR2XgH6Zip4vVT5OCSF+dLieOXhZ7uyJ04Y7o9rXlki+7VZdxHC6FnjWDHY2h9f+3flsl0Yy9S17pFLfPeuGaf2TV/XmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Cr9DQ8Gp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Cr9DQ8Gp"
ARC-Seal: i=1; a=rsa-sha256; t=1786455402; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D0TPzENdxefpJxJwik7lnoq0yeCwSdF5CRbkNLU/9kVO68M/xJBBnR+p9MDSAhUYaZWUQt0eKf4Pc+NarqIUkZbp0Lx2RxXMKrRs2svSQ1cCfd2W/jldeItbf8k3CM6w7JaHHAqHlPHVD/FAHdrEmtaViu/LZiKOz563kAL+fCk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786455402; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G3NfUAs/yg6NvfYWRoM6IMaD7EPZVmGmM1y1VGAZJAo=; 
	b=Y81tdimYn9i5F6FdEo2COlkhmAxtcoFxv5ph5u3fAAmru9nyH4qCibBd6NBxHNru9Cb8Xhxnth9IxrkfhhXSgKtD4ZJ9UGUVx/mfVoUu2KH39G0Ttl01nS2NKaFNzN1DSaSe4+K6t9SRSu7Wf3RRqkc/FAMuJcnNDZ0trgfS+z4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786455402;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=G3NfUAs/yg6NvfYWRoM6IMaD7EPZVmGmM1y1VGAZJAo=;
	b=Cr9DQ8GppoI5XwYAXVTpgUoz6jD6ca3J5VOYTAd0ayPr7RAxxXWeOAn/lfVrLE9G
	ODgINZl1k1ipZrf/cC+C8OGNAhS/Jq5BeaWr3gRLOjcrDGbhXIPic+8Z2c9fznjen1H
	XdMB+4uzMhbBjsbw26IO5N+QHc10FjN3uMjVgT6o=
Received: by mx.zohomail.com with SMTPS id 1786455400413839.8405244833747;
	Tue, 11 Aug 2026 06:36:40 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ulf Hansson <ulfh@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Brian Masney <bmasney@redhat.com>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] pmdomain: mediatek: mfg: initialize prev_o in
 mtk_mfg_attach_dev()
Date: Tue, 11 Aug 2026 15:36:35 +0200
Message-ID: <uqYyyOonSY-BbJQAbP_FjQ@collabora.com>
In-Reply-To: <20260808150506.78534-1-kmehltretter@gmail.com>
References: <20260808150506.78534-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 8 August 2026 17:05:06 Central European Summer Time Karl Mehltretter wrote:
> mtk_mfg_attach_dev() reads prev_o on the first iteration of its loop,
> in "if (prev_o && prev_o->freq == o->freq)", before prev_o is assigned
> at the end of the loop body. On that first iteration, evaluating prev_o
> reads an indeterminate value. If it is non-NULL, the condition
> dereferences a stale or invalid pointer, potentially faulting or
> incorrectly skipping the first OPP.
> 
> Initialize prev_o to NULL. This matches the intent as well: there is no
> previous OPP to compare against on the first iteration.
> 
> Found with Clang's -Wconditional-uninitialized.
> 
> Fixes: f08e7a4e8d6ac ("pmdomain: mediatek: Add support for MFlexGraphics")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> index 53bdab66cf157..9a8a38d98cce7 100644
> --- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> +++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> @@ -657,7 +657,7 @@ static int mtk_mfg_attach_dev(struct generic_pm_domain *pd, struct device *dev)
>  	struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
>  	struct dev_pm_opp_data *so = mfg->stack_opps;
>  	struct dev_pm_opp_data *go = mfg->gpu_opps;
> -	struct dev_pm_opp_data *prev_o;
> +	struct dev_pm_opp_data *prev_o = NULL;
>  	struct dev_pm_opp_data *o;
>  	int i, ret;
>  
> 

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>



