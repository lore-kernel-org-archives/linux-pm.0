Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.154.119.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343755;
	b=DU2qAF0G8BbEqoITnboQvZSZj5JB5/18L7VOr7wy7VHo/D7ixt1TgYAnWEHVRJ6V3Aqq
	 gRyBsQKfjtj3SjOvQvMlwhghse1U4WrcgXyVNp7aJa5jw5i6gaaoo6Z74DHwBplJT4GLl
	 bHlKziK2308bjn/0h8Nq/Elki0MSdonG0VKPsyzxGgdZgw76C4WNsfj2+nsqy49ebogDm
	 VABVYldRgiTp2HC5fKPPqpqU24pzOSeV9zPWNesKIsz3sRsdWExPt9T1nrsiUphLaXxbr
	 e5w0TLmkQB3OrMFuZh6AeT9IZAY8e2qeTD+U9IPKO3HKmkGpTZ5T8ea6UurZZfRLbrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343755;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=Bf/AaZlKXJsIZfpfcnPrYCQ8TrA8wpK1qNvneo+qbhA=;
	b=wvMcxkKj2SeVUqhoewku7ubUmoSi1xcjinl4RnMEep2r9HwmLB+qIOpvs4VVottk0QbH
	 ecV8KlXugSlde4rpB0fm2NLl5zYyDMIZPrGZoN/pzFrZC37zzle1jUpxz0C/kCb5Vg9ho
	 sTey5y1nbe0pDeQOiz9IbrxuJEYkcg9V0abat7a5FdoYbJYfJzjetfoUjsrx2GdC8Rgwf
	 8pPWY24/726Sw6H+rEffTtk4xMiiRFdVJrxwkEOr0kHDVPe/JXVjT3YZ5NfYEUwt0j74W
	 I6WqFrsFEzDTyCwsipZibXigwAzyDfYAooxvms8VyYyVllB2JjEVY87xrV6Ek6gfmPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aurel32.net;
	spf=pass smtp.mailfrom=aurel32.net;
	dkim=pass header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=pmYBiPny;
	arc=none smtp.remote-ip=195.154.119.183
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4130606A31C;
	Tue, 10 Nov 2026 20:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4130606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=pmYBiPny
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=Bf/AaZlKXJsIZfpfcnPrYCQ8TrA8wpK1qNvneo+qbhA=; b=pmYBiPnySBBL4gRZjkA7D5oEG4
	qsoLjT/oqrSpb2nB1K2BiwI7t+BYONzCkNvW/vYMaSImd9sOQHenUmUl4En53uLq8OhLPUfRFmWSK
	ZiBhdv8Ihhfe4SUK1fnnM4aXnxQWIltfmsqdgMkzFVufirT+q6Tk6DYT6K4QIqZ1O35exzSFfq+dJ
	iHhsnArmCOxOFTmplXA/boQc8H2a8T5+C4dTSCxPTcp7M8a7qYwfRnOT0wvIufmdXGVHTJI2lYsz/
	xaqYynG2gonG3JUWoCGzcJDqmHWPHjYrzAV+HVzCG4Lxw9g/OSxqgl8/iKFqeguAmrwPlWUpyxeis
	/Wvb8Oxw==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xQsm8-00000006IgS-0eMv;
	Tue, 10 Nov 2026 21:49:04 +0100
Date: Tue, 10 Nov 2026 21:49:02 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>,
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
	Alex Elder <elder@riscstar.com>
Subject: Re: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset in
 atomic context
Message-ID: <avODPs8yytWCMxn3@aurel32.net>
Mail-Followup-To: Anand Moon <linux.amoon@gmail.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>,
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
	Alex Elder <elder@riscstar.com>
References: <20261110061429.2036-1-linux.amoon@gmail.com>
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
In-Reply-To: <20261110061429.2036-1-linux.amoon@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

On 2026-11-10 11:44, Anand Moon wrote:
> The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
> to wait after triggering a bus reset request. However, this function can
> be invoked during atomic I2C transfers (such as power-off or restart
> handlers running in atomic notifier chains), where sleeping is illegal.
> 
> Replace the sleep operation with the driver's internal helper,
> spacemit_i2c_delay(), which conditionally uses udelay() when running in
> an atomic context, avoiding "scheduling while atomic" bugs.
> 
> Assisted-by: LLM
> Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Cc: Alex Elder <elder@riscstar.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/i2c/busses/i2c-k1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
> index ff32876e24d3..f4b21d7efaaf 100644
> --- a/drivers/i2c/busses/i2c-k1.c
> +++ b/drivers/i2c/busses/i2c-k1.c
> @@ -332,7 +332,7 @@ static void spacemit_i2c_conditionally_reset_bus(struct spacemit_i2c_dev *i2c)
>  		writel(FIELD_PREP(SPACEMIT_RCR_FIELD_RST_CYC, 1),
>  		       i2c->base + SPACEMIT_IRCR);
>  		writel(SPACEMIT_CR_RSTREQ, i2c->base + SPACEMIT_ICR);
> -		usleep_range(20, 30);
> +		spacemit_i2c_delay(i2c, 20);
>  	}
>  
>  	/* check sda again here */
> 
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
