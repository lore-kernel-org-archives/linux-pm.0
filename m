Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com [63.250.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED411C3F0C;
	Sun,  7 Jun 2026 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780801203; cv=none; b=nBlVTj3L52tzYYWwFv7fyy3xhpoMddcew/biXIOenGToyTvnzaGOIIBfFs9GXPFQbSscMD+Hk53vNKvHCgQoyHnUGtIwyKhhmyBmrWncsGeTfQXmg0tj93vWdxwoQ1w3y6VvCL4ECrTmWxlBgKAjSSOP4F05uLZS5G9DzUwExRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780801203; c=relaxed/simple;
	bh=NSC79u38z0GPVegRPYTspOjbDAfIQEXU0zNa97d0pAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO+2nMx1LWZEN+50eDykYaMK/XPf8N/g7hiDHQ0P/KTNB0hoZbmN8ZNDsA5bXVSY2wTyq2aRdYwBjtgdf7O4SjDhKd9yaoZOdVX2G1Z8tS9DpuVBmkU+EvtCBYEoxPopEYryODBekhkbIfovujFF9yGMI3BYMF62OWsTOWVt98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=k5rUgcan; arc=none smtp.client-ip=63.250.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="k5rUgcan"
Received: from shakti (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gY08g44gHz8sXf;
	Sun, 07 Jun 2026 02:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1780800771;
	bh=uofA/QS58+GAv8IKLhmlOZyRwaQJVKh5/Oaj4ocL6vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5rUgcanIdgVGHeNwT4POY+3H9HLSo4XdDXIxzYgWX7vW0k0mUxwAQ7SYkYHWE/Fn
	 gNLcnerjAIrwOyEbssfCCUZ4hsFc+/oQsl5qvZJTTBX8JnFbFHUnmyKtrUEsX+2gfo
	 w4dgzTzcopv0U0DMc6U6uVi8ZJdsBlNV9kdjkKJfytVnPi1j9BzuAzo+1NRPR7jqsV
	 UbSgzptuFggHgsARrOg1ViLhv02Xj+McF+L+tq4FBOHfLmvvKW8bZ6OemI0V7PJid4
	 L2EC/XJPqj5Yxev354ZApPTz842znzeLDtPmTJyScKSbQ5zgjHt7NkRUVYq5XPsiyK
	 fYQ/ZB8p7QCVw==
Date: Sat, 6 Jun 2026 19:52:49 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] thermal: testing: Avoid NULL pointer dereference on
 missing arg
Message-ID: <aiTdAQ6uCuFenv7N@shakti>
Mail-Followup-To: Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
X-Envelope-From: linux@gurudas.dev

On Sun, Jun 07, 2026 at 12:04:18AM +0300, Ovidiu Panait wrote:
[...]
> To fix this, make arg an empty string instead of leaving it NULL when the
> separator is missing. sscanf() then fails correctly with -EINVAL on it.
[...]
> ---
>  drivers/thermal/testing/command.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/command.c
> index 1159ecea57e7..5513a26feed7 100644
> --- a/drivers/thermal/testing/command.c
> +++ b/drivers/thermal/testing/command.c
> @@ -150,6 +150,8 @@ static ssize_t tt_command_process(char *s)
>  	if (arg) {
>  		*arg = '\0';
>  		arg++;
> +	} else {
> +		arg = s + strlen(s);
>  	}

Here, `arg` is made to point to the NUL terminator of s. Couldn't this be simplified to:

	arg = "";

to make the intent clearer? Since `tt_command_exec()` takes in arg as `const char *`,
pointing `arg` to a string literal is fine.
