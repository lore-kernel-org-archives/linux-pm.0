Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD04184;
	Thu, 13 Aug 2026 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584958; cv=none; b=eyW3qR/hX+n32WMEOCaXomBb7TvXJmmg5oRXgCNLrMLBweMwU+6FeziDdBTllLFX9511ARKFkrmsHa3vFQBsE3yO70WqHQisPVyJMwj65LpzL3zzs9j6LXy2Xl6/Yu2BCCncGbtoLWUAIwr0AO2wPO7UGicn42HTw/SPDG+gujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584958; c=relaxed/simple;
	bh=kEe5zES/rKF7Sczuc218gbRpYp8Z9mbZzJxVYxw2hE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/wBVxUf7kkFN6icLyZiTQ9eeTAxtrYJMykKa5VZ+Bm+QSLT/7CD8CuCZKDYAwkOzl2sG+VO1O3m7WEIQza3vlFTv55B7tlZ/LjotWYyUzDjtPwn7D2uqeZA28OMP8OGUCL8rLQjkpjuyEfJzIrKmbpNpFJ+1g6MTloCd1DOfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3bq754Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3bq754Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A64F1F000E9;
	Thu, 13 Aug 2026 01:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786584956;
	bh=YwEmikoW9GFQgnq5tJLdM51ZbVY05afrgsWGuSYfQww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i3bq754ZQN0dpzAEmOUYeFFb9OM2IfcrUsrPEI3SdUEDawL9ac/2cJsT25G/XBo7E
	 cps+H6sNQZiEsuyqMDs2Mx3YnKEZ0czsXA9RgwiAXfn4xheP+96tJydR7MFQXxfXbz
	 1yZCkk5fMSj0+AyTDMvQhgsyW9C5Xwu18jh/mT7eMEvwt9JiMrQRLOtPO+2xgD2YIu
	 EYZCh+iT7sZpYOLsfvE5xpCrDRaCxanHVk8FgLBG3PJ4E1Y4tpgV+5SMthqGieMqyi
	 Uao2ZVS9uM0HInwCdZQaw+FU44ULziaKsltt4LYzUpoX6EFTih93FuCkDVd0MFgejB
	 QNsWjrDcBhpZw==
Date: Thu, 13 Aug 2026 02:35:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Mark Brown <broonie@kernel.org>, Zhang
 Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH linux-next] thermal/drivers/qcom-spmi-mbg-tm: Add module
 namespace import for IIO_CONSUMER
Message-ID: <20260813023543.6936b188@jic23-huawei>
In-Reply-To: <20260812-qcom-spmi-mbg-tm-ns-modpost-error-v1-1-d849390d2714@kernel.org>
References: <20260812-qcom-spmi-mbg-tm-ns-modpost-error-v1-1-d849390d2714@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 18:17:22 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> Commit ebf1d03dab96 ("iio: inkern: Use namespaced exports") in the iio
> tree restricts certain exported core functions that a driver added in
> commit c3dce117333c ("thermal/drivers/qcom: Add support for Qualcomm MBG
> thermal monitoring") from the thermal tree uses, causing modpost to
> warn (or error without CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS):
> 
>   ERROR: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'devm_iio_channel_get' from namespace 'IIO_CONSUMER', but does not import it.
>   ERROR: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but does not import it.
> 
> Add the IIO_CONSUMER namespace import to clear up the error.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Ah. I'd forgotten we had the namespace addition earlier this cycle.
Too much going on at the moment :(

Sorry about that - I should have given you a heads up.  Another
win for linux-next testing things!

> ---
> I am not sure how this should be handled. As far as I can tell, there is
> no error if this patch is applied to the thermal tree directly but it
> would leave an "orphaned" module namespace import until the iio and
> thermal trees are combined, which may not be preferable. Otherwise, it
> would need to be applied to whatever merge happens second (hence
> including Mark and Jonathan in this conversation).

I did plan for this being a possible issue:

Ideal is merge 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git #iio-inkern-namespace-ib
to the thermal tree.  If I'd called that out originally (or a thermal
rebase is a possibility) it would be cleaner to do this before the
qcom patch adds another user then squash what you have here in the appropriate
patch.  Alternative is do it as a merge conflict resolution whilst merging
in that tree.  If the second, I'd also mention that in the thermal pull request to
Linus given it's a little unusual.

Jonathan

> ---
>  drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
> index 0492d5eeca01..a05bb444627a 100644
> --- a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
> @@ -254,3 +254,4 @@ module_platform_driver(mbg_tm_driver);
>  
>  MODULE_DESCRIPTION("PMIC MBG Temperature monitor driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_CONSUMER");
> 
> ---
> base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
> change-id: 20260812-qcom-spmi-mbg-tm-ns-modpost-error-fad8be2f985c
> 
> Best regards,
> --  
> Cheers,
> Nathan
> 

