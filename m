Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984254;
	b=OxGodu7eUGCC9SUox2uAEyq2HFJ7I/me0nCE4lrtf+ZpceoCP3/LIQ5MVLY/B9n0A4es
	 3zKLef9Pds561N1rUmjTwdLwOACGIZx80ADgsGyBeS6YmpMfJFICBE4RkJR9vxlDUDwDv
	 wuvr2LvL2IkOy7gZSeURHhT4AggAj5czXmrdQTVYnIPY/INx2mK/q/RuQp8yRuL353wAs
	 U/RhUxW7c9rCecA+IbxYSyiy4lKr4W9hDRTE4INiHerIsBAPUR2ipCqh6erc3f+AbgUA4
	 5hDkxfbUfNen/9OSSCCuUHQULv5/qs/j88si6bmG3xqydq6tYVoIBzUKcNm9bZtvxsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lDNPLrUxmcTvaWMZDOjinxQGN0Dfd4EyRHpy4Hl3zVo=;
	b=giG0CwcrJQK3CLC9w/CYekRYewlTDe05ixa5j1zQR8M8lWbcODC8Zu3Gs91u0+59kQNf
	 IKd2Hb05r/tnE82YMdXX9eA9VyAaeLv9wAld4gQCbdH8W5Xd9vkm4KF9USgwOMHSQjj+Q
	 LukNm7CHYjo+EIAsqLoUSzJjNFgi4xEERhuPrZwfsLydss3K4JZszLfQxeIsrvlCJINxT
	 X9Dz/YETIXNMhaRNGT2EpBil8q+Ab8/9gDxUvcGAVAQyO+1DDtqodKzzTZvJGkLg3/O8o
	 fzfOQYbn7aEdoxDFJ8j1hZ51bkEU4772QalJ1tMUt2w1m+OrRCWFa7cJKadidO9JPow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=PnqUyDmb;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8AE606A330
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 16:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C8AE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=PnqUyDmb
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-945ae2daa3eso104385585a.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793984253; x=1794589053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lDNPLrUxmcTvaWMZDOjinxQGN0Dfd4EyRHpy4Hl3zVo=;
        b=PnqUyDmbSF/8EnyTWFR9n1rvvdxESU+6agagd1Enyc34S0Q8aRHkPVhpVq32QzRuzf
         9Pqet5STTZeB1IzwOV9cN+KV3bgNrjlbWSLEq+hx6MsuAvBS72ent386MT2JICZ93BXv
         3I0WucUvAcjxPHULMUXQCY70qshvXBNOpRXuDYWUJskv0Ibjtr+aBqngXz3KshNH6x2M
         xeMcAhzgNSy2zs8Gos1w2y+DL4ORNR6oGOof47yK64gyCU6Rp37cxUhyV+paCSwlhtSp
         UYnFGnZdPzsy1HUnhQf2JZ47trTK7R8NrtPh1xmxrHIvCqgDM/458emTvm6KAt3V3Q/y
         l47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793984253; x=1794589053;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lDNPLrUxmcTvaWMZDOjinxQGN0Dfd4EyRHpy4Hl3zVo=;
        b=bnVcF0Irx3t3T+NAYTXkqBqQUtuwVBUwlUTH1aTNBYJG3ql8IOGCus93MQdb58G771
         nck4kTeytExtDZAgzlQsAxdFi17jW6KoWJXya2F7RF7Ojv5CfHQoGXLAlXNoqSpnwAP/
         qCwUF5NI4nrIuIvo34WVcAPxTodZarrvt6TrWhnjp7uaeZNOxPqyEm4CIZl2mVkrmxii
         G52nM/6YMCsZ3LzT1GMHEC868QMd5eO2IuNNrw8HXsLWXRG7OpUEsSpFOsNmU7FLO2j1
         W90OTtf/opaLhwDZQKhsg28wuWxYq0sqbqOm0BaugKsLG10Fu9ANr+jxZm5xA3A54ffE
         jSPg==
X-Gm-Message-State: APuU4Z9k/Lw2O198pgQRZUXubOj/uwjZOgLKAxJzUIit8vmV1PA9LhRN
	0yjzMlHb8l0l54kKYyVBrziK0avonnKIdOrHbpqpxotV2vIEcU71ENsNb99oICpSNTFmS85ZN7y
	wHbwRMeC4
X-Gm-Gg: AYBFou3tOZaoWs7taj6wv1i+KkW6KPdKjwz84LlsH5uqL9rCUXslU7arWN5w8HqE0sW
	X6h9Tx5Wej/4B/ll3Opr6/d69R28+M9OSfmoo/AAxdcrAwo2bmlxBavCVSRawWY39LhY4DDkBpO
	KYmQ15YlU9wavR2J8KS1/m+B/sH+wpV7Vtow/tri503UwsSZtAHv8AaaVCVaa2JY6xKxmIHYybI
	V+DCbKYXah/N56ClOYDnsIqh+6b6RnTuhgV5+AqUZJiR2iwZ68fNkSgRdhpVOLu4V7eFop07a+G
	TW0ci43lmpAS/Q2JKl6C47U/n1YbZexkJt2Es2yeRz2LRiRvyPsGeYy+x+6GVAs9PoViRPfGUal
	W5sSiD8CFgHjtgqdQty5B/EpUmLITeMC0nN54lsYSIHerRV9aSRkvzp5A/tWxHmdXcs4AQoxZzU
	GEcuDTkzgXOynzpWB653pxvxZ4PnSzRkUT4QDIX8ENVdYQRw+46uczUh/wWxx70GslsLZySu1Tn
	j2yUWw3cr1dhYNkiDFGtzkpLEbzMhHIjMKOab1S3N3MyAh/ZOBFX/a5Qv/scr35KT0Vc7CZvx9R
	OZjVsHF5I3m/pvpnfCbU03RCKiKQ
X-Received: by 2002:a05:620a:84c9:b0:93e:c12c:f142 with SMTP id af79cd13be357-945f356285fmr466963085a.76.1793984253353;
        Fri, 06 Nov 2026 08:57:33 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5c10084sm179741185a.36.2026.11.06.08.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:57:32 -0800 (PST)
Date: Fri, 6 Nov 2026 11:57:29 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: Re: [PATCH v1] PM: runtime: Update last_busy in rpm_resume() for
 active devices
Message-ID: <c44be544-e365-4ef7-9165-243cce708d55@rowland.harvard.edu>
References: <13032301.O9o76ZdvQC@rafael.j.wysocki>
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
In-Reply-To: <13032301.O9o76ZdvQC@rafael.j.wysocki>

On Fri, Nov 06, 2026 at 12:31:41PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Setting an autosuspend delay for a device can be expected to cause a
> runtime suspend of the device after calling, say, pm_runtime_put() to
> be deferred, so the time between the last successful attempt to resume
> the device and its subsequent suspend is at least equal to the
> autosuspend delay.
> 
> However, that expectation is only met after the device has been actually
> resumed in rpm_resume() by invoking its runtime resume callback.  If the
> runtime PM status of the device is already "active" when rpm_resume()
> runs for it, the device's last_busy timestamp is not updated which may
> allow a subsequent pm_runtime_put() invocation (or similar) to suspend
> it right away.
> 
> This is arguably inconsistent and confusing, so make rpm_resume() also
> update the device's last_busy timestamp when it finds that the device is
> already "active" and it is about to return 1 early.
> 
> Fixes: 56f487c78015 ("PM / Runtime: Update last_busy in rpm_resume")
> Link: https://lore.kernel.org/linux-pm/CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com/
> Reported-by: Brian Norris <briannorris@chromium.org>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/base/power/runtime.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -819,6 +819,12 @@ static int rpm_resume(struct device *dev
>  		pm_runtime_deactivate_timer(dev);
>  
>  	if (dev->power.runtime_status == RPM_ACTIVE) {
> +		/*
> +		 * The attempt to resume the device means that it is needed for
> +		 * something, so update its last_busy timestamp as in the case
> +		 * in which it actually resumes below.
> +		 */
> +		pm_runtime_mark_last_busy(dev);
>  		retval = 1;
>  		goto out;
>  	}
