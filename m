Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735022;
	b=R1dapT4hpGnKHwnEYZRucFE7cob2D9YRIuec96OsQNl6XaY52xB2zAJ9eteyWgWh4bpZ
	 HaHwe+QZPuo4/vUoCEYG1vWGd+FDg6v5JAhKvq4SIioMOHWytWVjgAvu5nCmNX4UNB16K
	 BkHvSN4saD3mrlMPmyYdUgB1eOoe0ifsPj+vwk+fvjeHa1Nlfkk4JxvyWEJ9slkWmoYDw
	 B1vssel4LtbAoeY8wVgKCta59GeE0imb3Db2trAJemeDHAH+oYMz1okDH54vkG62XILVr
	 vJ58LYXt6RZQWmMIEbS4TfRMOJalAwRf4NJxHWXMTwMobvTaEux42jNJK/7iIREhPow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pM+ObFq+7UvTBHo/IKaCGchHuKGnrduWJa929a2AGj4=;
	b=FwUuXyFJw/fvqMjwqYXKUFGB8WWujOodg04VTBO2pi03FeSGtP9jfyqN9mKNzEY2YcPf
	 ZMii+b20y7xwwYJzJ6whqMwpD8+72dnaIJwwFaFYGD+1Y/y2y8fpcJf5TjWarK+ICH39I
	 5Gj5nm1SQN79sCL4JnrSZ/SQbYAp0oZtV5+EJe2USW00eUmT4W/DEWf8rnAx1/LO49dZd
	 68ymzPvAQlIS8a8Pllv/m+v+hO/lQYbcfOP4Z6I4sxZELGYjTxS7YaD4/Ip8qjztYKeQz
	 y9toDA9U81NcK1R+Xp89C8lDS8fRR7KcBkFl/ZaMkliVrY7HoMq4ZtsFrWoCT78p7yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lbPap6xL;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A0B606A332
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 19:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6A0B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lbPap6xL
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14fc585291cso3687506c88.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793735021; x=1794339821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pM+ObFq+7UvTBHo/IKaCGchHuKGnrduWJa929a2AGj4=;
        b=lbPap6xLlqMk+JYnuSIyFjcRQFqANvPP5Qqin+Bz3DY7GsGTRk8PniDPJ15f+G5ilO
         r9FUH9gktdgCzOrQpBTRygzrW0nj0WmLAxNtcOyIHnDJx0oZzTd14VRe3a1Nni0MjvN0
         78W91quHXoMTrB33+q740l4pO9Al9IeFiNf8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735021; x=1794339821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pM+ObFq+7UvTBHo/IKaCGchHuKGnrduWJa929a2AGj4=;
        b=oR1vj1lLiG97H/c7SsMqGv269OeBcZyGrOmcGu8JSOKa6bF93LedzMG9tg+p2aW8O2
         btMrunPiW3At/bQrWDhIqMNzyFDzBevlXBDPYInCYCMUwDMHFZrZnepBBpuwKez8jDGH
         eumKjBjG/uZ3MRiBoRLmbAlDLECuyjiXkVtWfOdfcWBSFet0LTBSuAlxiMQ4JNgIP+bq
         Ndhi8RxTjKZsJU0CsClGeOu5GgeIFRcPHy5zPm8CPr0Pd63IpcQrO7jTBQK6PMNgtctQ
         FIIj+ouFGhEdBzlYMPoFz91GXMdJ9U6wwtSDZnCE9ix0AxmdmBez20IWEH1UumxV4XQd
         3FSg==
X-Forwarded-Encrypted: i=1; AKwUvBw+BXY/SVukmMIi3j3x/sT5otGDr/QzAk40Ok9EwNhC2zarm7M0zG8oaol+S8Xvri4b8RQp3Rg0Mg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ky3PA3FMITwaFlHjfU+8jeIcCl+nTnV9oYOGfL5sdLGZbhCXF
	JJFx/WtGbnhUyyRrlISMu18ihPo3uPqONTQq2aaptJy5l/vfe0r6pgrGBFVIdGEPlQ==
X-Gm-Gg: AYBFou3U8vw9rsJIFfwYeksdf1L4rzbl/McgXWsCMNY4R9h8hxm45+HXmy/U45HPL4j
	V/BATyLoSEFetGuOsvLAlTEc+Ik9KR8jRo0iOMsOaVsOBpN+O72JFDlBcFI3SRi+gzpd7vQKWY9
	5dY0kTXjTX/7V+yZxv9ls9JDq/LRYc6E+8M/1WiQWU84523Y+twqVyZ8RtubR89bAeIxlX4/uhs
	3W1M7YyNuTmgw2e6exCRd2552w01Higr1IAlntpACUN7Me52CdjDQAVwakcWYIJWbN2RAQZs665
	/7uAPfDhb9yWfy4cPmWtrCnCqvG6pAPsYRZRj/7lRbkfew3c/nMO4codoMVaSLi7ViyGYsI08qa
	XhD0f5wqNkBKVfIRL1/FDNdKnNzDsJcrYOgO0J2ygSgZ1uK7DMuB8k/K/8aMSMtyQctdvUyq9YB
	dfCw9QgA+orYsyxcTGVqTzI+Ki/sj4LBIM0Xol9pLYs/wYdF7imYyAPkDAXSp9zdY6UoY4sklGE
	oiXIeNtcBeVFmq3fPsXfW1i33LGYJeu15i7nTrob6kKskonoGK9xqSzsN5+S83R9ykWVW0zwd4Z
	Pe/SP6/CE1hHxaLOlK7c8TtC3DvGzZ6MTmIqTU5HhjoGvreQvwsu4+gfTr0rnuXqTTk=
X-Received: by 2002:a05:701b:418f:10b0:14a:8df8:56c5 with SMTP id a92af1059eb24-1ac5dd5a055mr21441051c88.26.1793735020817;
        Tue, 03 Nov 2026 11:43:40 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245c2c2ddsm985448c88.10.2026.11.03.11.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:43:40 -0800 (PST)
Date: Tue, 3 Nov 2026 11:43:38 -0800
From: Brian Norris <briannorris@chromium.org>
To: Stanley Jhu <stanleyjhu@google.com>
Cc: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Can Guo <can.guo@oss.qualcomm.com>,
	John Garry <john.garry@linux.dev>, linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Keep clock-gating hold on failed W-LUN
 runtime resume
Message-ID: <auo5ar8427cuH_nX@google.com>
References: <20261029040002.2100002-1-stanleyjhu@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029040002.2100002-1-stanleyjhu@google.com>

Hi Stanley,

I'm not extremely familiar with the UFS or block layers here, so I'm
just coming from a general driver + runtime PM perspective. That said, I
have some thoughts:

On Thu, Oct 29, 2026 at 03:08:30PM +0800, Stanley Jhu wrote:
> 1. __ufshcd_wl_suspend() takes one ufshcd_hold() reference and sets
>    hba->clk_gating.is_suspended while the UFS device W-LUN enters
>    RPM_SUSPENDED.
> 2. Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
>    suspend callback failures"), a failed runtime resume (for example
>    START STOP UNIT completing with an error) leaves the W-LUN in
>    RPM_SUSPENDED with power.runtime_error == 0, while
>    __ufshcd_wl_resume() already clears hba->clk_gating.is_suspended and
>    calls ufshcd_release().
> 3. The next W-LUN runtime resume runs __ufshcd_wl_resume() again without
>    an intervening suspend and calls ufshcd_release() a second time,
>    dropping a reference it does not own and underflowing
>    hba->clk_gating.active_reqs on UFSHCD_CAP_CLK_GATING hosts.

I _think_ this reasoning and patch all looks good, with one possible
exception: ufshcd has explicit recovery in ufshcd_recover_pm_error(),
which relies on checking power.runtime_error, and then explicitly
overrides the status to active to clear the error.

It seems to me like commit eef1d74bf88f might have subverted some of
that logic too, because resume failures will no longer latch a
runtime_error value, so that recovery function may not be doing
much/anything. Is that a problem too?

> Keep hba->clk_gating.is_suspended and the suspend hold across a failed
> W-LUN runtime resume, so the hold stays paired with the W-LUN
> RPM_SUSPENDED state and the next successful resume releases it.
> 
> Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
> Cc: stable@vger.kernel.org # v7.3+
> Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
> ---
>  drivers/ufs/core/ufshcd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index cc75384c6502..9be370cea52a 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -10626,8 +10626,14 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  out:
>  	if (ret)
>  		ufshcd_update_evt_hist(hba, UFS_EVT_WL_RES_ERR, (u32)ret);
> -	hba->clk_gating.is_suspended = false;
> -	ufshcd_release(hba);
> +	/*
> +	 * A failed runtime resume leaves the W-LUN RPM_SUSPENDED, so keep
> +	 * is_suspended and the suspend hold for the next resume.
> +	 */
> +	if (!ret || pm_op != UFS_RUNTIME_PM) {
> +		hba->clk_gating.is_suspended = false;
> +		ufshcd_release(hba);
> +	}

This looks right to me, as a non-expert in this code, and it may even
have been wrong before commit eef1d74bf88f.

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  	hba->pm_op_in_progress = false;
>  	return ret;
>  }
> -- 
> 2.56.0.313.g2479322e68-goog
> 
