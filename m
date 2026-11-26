Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657439;
	b=x4nJY1eW8RCU/J4Yqgt0BoS8+EaKZb1uRzkourGQLSVTVlKp4nBiIsELoZtrG47dzhi3
	 LOg8efgrbxPby5E+zRNYYJr3MqStE3C6m4priZu+iKkjaCCJsgU7WE3SJGuXx1aopSxjE
	 Ilu1sqZU5pwOtDWM7I45IHTIaRM4TqVhBAoV/mNIxbyu3S/jeycaLklGCyv0Ttlq2xMAT
	 fTgsqG1fNH1Bc4F+7svvda5JzhnfHVJ4t8TCfXfADUy5NZbzuGRJYoZdh6AlcvvPD07jo
	 J8vkapxv3BGuHwHVIdQm2enSRy0pJf6sTrmSi5r45lcE6iLdcaQtT7srLUgTLCWXVUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=AFisO35luVz7D0pUNKhFDLCSWhonN1igyPUQPBbXnsM=;
	b=2ynphNjeSisKbGtd2lu+ZFRsahhlpUzFuCOlbAhyuVDOPKphq8VuuWK70kvZEKPAQi0v
	 cWe2R1+e/xGLdejPyvzCxo11t/iU5Q0DLAjD9ee2NHC+P2DTUxBRt+lY0/zSxkq391qM9
	 0nhN5eqJ364Nup8thicbDFFXngeYC616shPM2voElIq4pFsh/fYbMOpO6ddm5JTgEvVXP
	 VEdW8bvZwk0Vssvp7LcJAxekUHKliL5gnvgwP39O4o1PSpFd0CQPhVhv0x9UnWdtCIajI
	 CFRmUDEJybKwBrIKYMz0f0v0++UX6ImTRHBSOWIWQ6hdMMiyLF7fU1T6Lany/5u92hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eRN7qQVO;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D455606A326
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 01:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D455606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eRN7qQVO
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b4cd193b50so1623030a91.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 17:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795657439; x=1796262239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AFisO35luVz7D0pUNKhFDLCSWhonN1igyPUQPBbXnsM=;
        b=eRN7qQVORSDCVNdsgm80z08DkKkg6Npk+fCoNTifgrLbl3zEKGsPojrJXZz8ulNal1
         ARa2Bxxc5TVZ0X+kSajFHETUNUA5vMscp8JxWt3qzacnalj+nt2EelkcWTIq6iYrZK0m
         LxXetnJxmmKDujQfUCzhf9MorzKosrZTYaF/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795657439; x=1796262239;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AFisO35luVz7D0pUNKhFDLCSWhonN1igyPUQPBbXnsM=;
        b=nCx5pUfQKfaXGmT32nr8OZF4cL4IDBTNzJAyRsfM6ihavHFvt0iGcWx70HT4/aSggk
         MpotyxXThaF6RAOExvRQffSbvOsmI/zHjMKI4SVbRWdSRiR8nLxnoqXpOnBJv2CHo226
         poDRQWwON1NIJopuj9U+uBqqkc5GMhyPnZQtnXJwNeJCMxQmZzuh1MQHmtzWRrPiObsK
         f50P6kKCxLF8Iv80BMMQWoTz045c14pcVOPWLryRjsPTWVI9qNUfMKyMayZzxWjj+wDs
         cKtvHCI4RnRRsEi7JyI/gQvCAjhcJdeGiPVxALZS1UU84ua7KrbNC9TXA9OBkyQ9s1nV
         akSQ==
X-Gm-Message-State: APuU4Z9hHyf4ftExzxbK/G5IJU0pPDnp7Qm/rcFTvAuKMlHn6iH2UlTS
	UJQ529nhmsdo1ulN0lllURbnXD2it/kriCTCLOylSEjgupHbnp0KTQ0q4kwUI/WUpx0gM7iKmc4
	F+lI=
X-Gm-Gg: AZFdTZdzGuv8HdLUFZuRkvDA9096g/dU/v8CiMqnukib/f0LVP8Lcf/TlSZDyLDr/y+
	wMyQ3cXTTM0vlIHu1hVIy7H7viaDcF77BqAvNDtxBlIdWkx51/+MMnl/23zmeN7aRK3V65CBACH
	x9mKOGP8wYBn4W3WjpSQwl9M70UA2t2A/1Xw3pHk0ITkOcpWGt+NG1CAVhoJw8XbHE0Oj2QBh6E
	2jUY6SduW6Oa75DP0Qiu40X9LGlEr/26BOEdhBclq4EjzDv1OCZN73z4Vbuc/mFqRvF4PqmmlGh
	0Kr2xFJL+7pADWsq56TaTRfCpmGy0I7yRrgQe01jq1opPVNm6Dup/Zrg7C19PmBDSLj15GoRlIj
	lFR9fYnZ28a2NIxBJ5TEPQow93GuGtEIyeedqWyw/ro4HDT/x5tl4ALNhdnr+IhDpa2lz1vSEEu
	gIiNpSWgi0XJ4IVlprsfX3IM2bJTIZtQZr+zJ+SySgF8SH6jH2L4f6wYq2HRb3OL6/KnOiVkadT
	DpyysJ+EZUHJCRUU2MtG/mRSLuVgzGFwbGYr5SpobF1zihjFrerVG6NfgJSnZfqcybirmvMbdnK
	ZY5q9rNbUTNPmr4cTRG8RmHCmaUYEQzdI/uyKhAALDfWHh0gBm4iNQ26Ox5FLHeou+FT
X-Received: by 2002:a17:90b:4483:b0:3ac:bc3d:6fe8 with SMTP id 98e67ed59e1d1-3b41c92f8f9mr17541539a91.34.1795657438637;
        Wed, 25 Nov 2026 17:43:58 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:dda6:7575:bbfe:db80])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b405ec698dsm32577442a91.14.2026.11.25.17.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:43:58 -0800 (PST)
Date: Wed, 25 Nov 2026 17:43:55 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: Re: [PATCH v2 1/4] PM: runtime: Add memory barrier before reading
 last_busy
Message-ID: <aweO20KV0XzcPBeF@google.com>
References: <4779892.LvFx2qVVIh@rafael.j.wysocki>
 <14142601.uLZWGnKmhe@rafael.j.wysocki>
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
In-Reply-To: <14142601.uLZWGnKmhe@rafael.j.wysocki>

On Tue, Nov 24, 2026 at 04:31:51PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The users of pm_runtime_put_sync_autosuspend() and
> pm_runtime_put_autosuspend() can expect that the autosuspend delay of
> the device will be respected after calling one of them because they
> both invoke pm_runtime_mark_last_busy() upfront.  However, that may not
> happen due to a leftover autosuspend timer running when the last_busy
> update takes place, in which case rpm_suspend() triggered by the timer
> may run in parallel with the lockless last_busy update.
> 
> Namely, the last_busy access in pm_runtime_autosuspend_expiration()
> called by rpm_suspend() may be reordered before the initial read of the
> device's runtime PM usage counter in rpm_suspend(), and if last_busy
> gets updated between those two reads, the update will be missed and the
> device may be suspended right away.
> 
> To prevent that from occurring, add a read memory barrier before the
> last_busy read in pm_runtime_autosuspend_expiration() along with a
> comment explaining the reason for adding it.
> 
> Fixes: b3db492e8335 ("PM: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()")
> Fixes: e24e0630b5ba ("PM: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If you're into this sort of thing:

Reported-by: Brian Norris <briannorris@chromium.org>
Closes: https://lore.kernel.org/all/awC0tcqgq2KvCyxO@google.com/

and

Reviewed-by: Brian Norris <briannorris@chromium.org>

> ---
> 
> New patch in v2, based on
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=26236a3e8803f7e1ace104020d7f006edb220116
> 
> ---
>  drivers/base/power/runtime.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 0b15c718c1bb..c295acf6a718 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -186,6 +186,13 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  	if (autosuspend_delay < 0)
>  		return 0;
>  
> +	/*
> +	 * Prevent last_busy updates occurring before the rpm_drop_usage_count()
> +	 * invocations in __pm_runtime_idle() and __pm_runtime_suspend() from
> +	 * being missed if the last_busy access below gets reordered before the
> +	 * initial usage counter check in rpm_suspend().

super-nit / feel free to ignore: it's a bit odd to write this comment
covering super-precise details of function calls, and then immediately
rewrite it in patch 2.

I think it might make for a better long-lasting comment if we just write
in terms of "last_busy update" and "lockless usage-count decrement".
Then we don't have to update it every time these things move around and
get patched.

Sample:

	/*
	 * Ensure ordering between the initial usage counter check in
	 * rpm_suspend() and this last_busy access, to avoid missing
	 * any last_busy update performed before the last lockless usage
	 * count decrement.
	 */


But again, that's a bit nitpicky.

I'll try to look at the rest next week.

Thanks,
Brian

> +	 */
> +	smp_rmb();
>  	expires  = READ_ONCE(dev->power.last_busy);
>  	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
>  	if (expires > ktime_get_mono_fast_ns())
> -- 
> 2.51.0
> 
> 
> 
> 
