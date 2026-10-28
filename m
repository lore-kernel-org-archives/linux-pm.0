Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191522;
	b=1bF5yLdAs/fvIhhbbhoaRIacFL9xQOURZDLQpnorCSTfI43JKm1sw4IGGNyQgxmuaIvh
	 GBXI+7R3KAsyc+BsHWPjQeQ9yncOkGffufzVOfF8SJBQnfzjhBtrLwpMt8iFID/0OLxom
	 oFgNo1G0PnHy4FE4JGZ7hLMSxZx7/je1PL8HPsZzAELL/IlgmTr+1XngHyeWqYe1ccgwi
	 vvdiME3lL/Gqov+YkCPee9/IFl/v3VFA2sPJHftplM0nHTjmc5JBEJlpKY9yniV8lFRGc
	 5xWBsor05tKsnS+2iwczZPl0toIgDcPX4/7rEe3ZQQI0JEd0dfnDMCXLQ257htmlOuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QqTI4OK/fhuaR1GlqOO94iKxdKzeyM0Y5bQN/d17mzE=;
	b=TGp8paf7uiSbMchHinUvvEWa/SHhDGLL3Ul3kwd165LSaL+UPLOC82kObXbO8O+JJbTz
	 UFbmoEw7xd8zZ+Lw0UB1MO6ygOrh0QK+mUdHOhcNRuVhVK6E2MGLRi8y9sAAKwblSB5Nz
	 OnUq8ZDPhQkMnVvaSRI9OEybWRsY8piTZcvm0Va24qVaQfV8Hv3V559BJgaIM7HDCZwkA
	 1BFTHyxDJAiKLdgYmC8EzL3+1VnVA1gkdNCZ5KfGxFpbSbjwG9JncfxWpA94YHjzbnqPi
	 5AgNU/fE9KteI7jFyzC5P9FRHc+WFHQFFFQNlfIR0JSZ/b4qWb0eM41MaGzLsI5K80g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tuxon.dev;
	spf=pass smtp.mailfrom=tuxon.dev;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A383606A31E
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 12:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A383606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso9492755e9.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1793191520; x=1793796320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QqTI4OK/fhuaR1GlqOO94iKxdKzeyM0Y5bQN/d17mzE=;
        b=kSmYo2IApQsaZVeoI/lHS65DndOvyRY8lt50GRCZmz/jWWH8qe4s7wo/zr2/zMpq25
         +sjQr/YIemSHfu6uSz39sV8QOjFvoudUeuFCrPfNICLHczUoyPJM2MMP2ZzljZ7g4y9C
         e2zu+Bti1OHmJlatzf5eQK5sXxZ3i0qUYaH+sDqEm4IIQ4Nk+kHHbcDLgsKMAjNiyB+/
         XHCS25+GfCpZiPYLwRPoWKFHsIs3BMbU1i6dviNOqXSCye9VVbinYsSDEBX24Qp54NKy
         2ZE+Gf+jUmLFXKEj1XKHO4ETJGGRqh51DtS3Fk31LWhkvIQvA1aIATIPsXPkaoqVeUIU
         2+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191520; x=1793796320;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqTI4OK/fhuaR1GlqOO94iKxdKzeyM0Y5bQN/d17mzE=;
        b=UVtl2qZBfYER7/tQahlj7xoo22A2SJ46uG4XFSD/f+bLMPzurKUTaPSWPymwJOOWAi
         Hl6MInCpUaziF68EVqZy1Kr3TV6QZHlA7BJYSCSerhQQMpuSgHIJUOf5cQBep0DJBKN8
         WaoxXDI4qfh2E8QCA98XoiOMYLQme3OFVw9C/0cU0I4DzL5nXCIVtrUtfHgHTF5EI5fL
         br/WP2q+U+49mfTFUyXqfa2cronDCjA7j5MFoVSmYJonFbvDOLJwCsnNuubwM5q3pkz+
         qpJZwTxWdmJwF1Zzh+B40d7LNZc9Og8jybL9pg+tFY8QeLZtWeKc+Przf0RgJqIULdiO
         RoNg==
X-Forwarded-Encrypted: i=1; AKwUvBwmJBcnv5A264TvEsqpg+wbzwZ8/pYzcSCEH736ObBm5JCLbbBrCPHQqPhPsq2NQdOnHn+PcOVCFQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIlJKa07nHG9ahQV6C+2z4oOtWQZ9983BbwVE+jxTgqoVHWSlGe
	nFMgyQA2LIoK6/dK+EMuslA3Q6elf/Rg3kIcRL+3o6nVl5Q9R6hhSTy0HkcTHYIL1FQ=
X-Gm-Gg: AYBFou2ycScvx/UWYSYNV4GlZhCTJN3r1B7IrvZ7TEP9Ie9dSeXMvqv3PwPYVn6iVj5
	MZ3uX++64UEkaH4oHqDHdikxLAz0cmO2ODVr627wfL+vj2UOerM4iVEDIzZ5FHKdjLX29ZNSOG2
	tF5fSh9DLHIqqu4cNIpzhliabXcqgoUKpCAePHaT4ANc0O24KnpiheY1+KsAY2X8642xkQiRpGX
	1r8jfr8d8pPYsZoz+jm8x7xTSVbbGuEw9FBpQ3zwQKAANss8ZOhPMsc7gsCuam221mA/QVr/P7j
	cO/LxPaFOoJDj7SoKzlXkB0FWqSP4uhpQrWIBmGlkvtdF9L8ZkFsMNuDhuYYpnvn6hIPm3NDcEq
	4j3zdkCm92UqzOyb+Rb3HQ+UENP+060dk5xMDMYaFV8RdOlrl4KU3i7IbBwyj+ZjBMxcSofOMOk
	gkWkwzDOkdDjv+mZX0usa0uuuHcMCisFl8xnuGcdhBYowjuAprkKsc6/VIK681zocMqHkubr8ch
	ck7JoCu2nejnm5e1o914RDXHhBLpvrJIrZ4v6Kms172AjddhWiBv2VYO0Oly+PThu64Q4Daa+0O
	QIoWAoI8iFHaztGRlvWYrRFFGnnZZJY2US9okQ==
X-Received: by 2002:a05:600c:3510:b0:4a4:7a8d:c436 with SMTP id 5b1f17b1804b1-4a96667dd75mr44218195e9.11.1793191519063;
        Wed, 28 Oct 2026 05:45:19 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8d5sm29772912f8f.28.2026.10.28.05.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 05:45:17 -0700 (PDT)
Message-ID: <0602847f-4fef-49b6-a1eb-3240d7c1ecbc@tuxon.dev>
Date: Wed, 28 Oct 2026 14:45:15 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] watchdog: rzg2l_wdt: Power on the watchdog domain
 in the restart handler
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
 wim@linux-watchdog.org, linux@roeck-us.net, ulf.hansson@linaro.org,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241015164732.4085249-1-claudiu.beznea.uj@bp.renesas.com>
 <20241015164732.4085249-5-claudiu.beznea.uj@bp.renesas.com>
 <auC7FueGYTiLOpcX@black.igk.intel.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <auC7FueGYTiLOpcX@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/26 16:54, Andy Shevchenko wrote:
> On Tue, Oct 15, 2024 at 07:47:32PM +0300, Claudiu wrote:
>>
>> On RZ/G3S the watchdog can be part of a software-controlled PM domain. In
>> this case, the watchdog device need to be powered on in
>> struct watchdog_ops::restart API. This can be done though
>> pm_runtime_resume_and_get() API if the watchdog PM domain and watchdog
>> device are marked as IRQ safe. We mark the watchdog PM domain as IRQ safe
>> with GENPD_FLAG_IRQ_SAFE when the watchdog PM domain is registered and the
>> watchdog device though pm_runtime_irq_safe().
>>
>> Before commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
>> context'") pm_runtime_get_sync() was used in watchdog restart handler
>> (which is similar to pm_runtime_resume_and_get() except the later one
>> handles the runtime resume errors).
>>
>> Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
>> context'") dropped the pm_runtime_get_sync() and replaced it with
>> clk_prepare_enable() to avoid invalid wait context due to genpd_lock()
>> in genpd_runtime_resume() being called from atomic context. But
>> clk_prepare_enable() doesn't fit for this either (as reported by
>> Ulf Hansson) as clk_prepare() can also sleep (it just not throw invalid
>> wait context warning as it is not written for this).
> 
>> Because the watchdog device is marked now as IRQ safe (though this patch)
> 
> ...which is complete hack and has to be avoided.
> 
> Can it be solved differently?

Can't tell ATM. This solution was suggested by Ulf.

> (Note, OMAP, for example, got patches in the past
> and become pm_runtime_irq_safe()-free.)

I'll look through it.

Thank you,
Claudiu

> 
>> the irq_safe_dev_in_sleep_domain() call from genpd_runtime_resume() returns
>> 1 for devices not registering an IRQ safe PM domain for watchdog (as the
>> watchdog device is IRQ safe, PM domain is not and watchdog PM domain is
>> always-on), this being the case for RZ/G3S with old device trees and
>> the rest of the SoCs that use this driver, we can now drop also the
>> clk_prepare_enable() calls in restart handler and rely on
>> pm_runtime_resume_and_get().
> 
>> Thus, drop clk_prepare_enable() and use pm_runtime_resume_and_get() in
>> watchdog restart handler.
> 

