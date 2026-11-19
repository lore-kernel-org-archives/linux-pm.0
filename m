Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087123;
	b=t4SFqKTYnx6JKcGbZhuV7mFc2Io2ICdxyZtah31YcvL7YJr5bzttVrAcnDmSwiyM5Tc9
	 RUczto90xnmWPl9gXD1dhjOMbakgsQv75Kk49qBrI3tMclHLReLE6cU5O+EcVn1TckQWZ
	 Wser9STU+FUsD4R60ry3+O+Q7H83hDQ7RTb3IgAgpMT1PizLFrg3eHym/xT31BURhbQc7
	 xvEFSKHXSSX8d+LouEf7G2+rDoWczpFPG5e8Ykj7AJ1H5peidNPXRg4X5zJFl/CwdwCEv
	 RPM9+BoAp2hztsBugqGUTFyqCLxd9DiZEcf4p23MN1WwmkF4X9cITQHbixs04fvg67w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=VrCvkLrp/royT60LvX87nJ6hEmqSNe0EsAi3XYZ2mds=;
	b=ogX7dz4noOZuX7+4wKuVxYh9FofbNAiBdABdi/eu2MHDhkOrIj7o0kwF5ez0hHaReGf0
	 hE+jLZQ4L/Rn+ekJhqQIRWGGqmc7fcRzq8YMuQcEsZWJeM4bisMoTJ6dTkM80AAhG3GeL
	 +0X4grX5eSiXOk2sop6JAkij4h9PrkYrxar7luJiLF7YX/A6xE8clX9TmWD+zXhmrw5au
	 Pw/yzZm83kN1pcFt1y9G7syLI6u7rSCyJ1MmK6Kc4GwAWmxqiloi3jHCYiwhKypDIEb6y
	 t1TVmZCi4F0st82qItkKon255lyYfRWJbAaevw+tRehbqBUj9TEumBwjSGaYXn2Rkpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yw1+nWQX;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4ECF7606A320
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ECF7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yw1+nWQX
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-381f65e4e4bso3274797eec.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 03:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795087122; x=1795691922; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VrCvkLrp/royT60LvX87nJ6hEmqSNe0EsAi3XYZ2mds=;
        b=Yw1+nWQX/9MPwkAQh8pdVQIdLTe/NkpdOgbv+Hll9VJQoYPfSURkPu2iscTiJkjEct
         TpTa0Ptw3z8VupAMDUdwL6ygvS39Yn5ve7hKPF5Q+B6+04VKOjLIBq2KKBqXfwRYy3Iw
         +oLKJ9tvXlfNyk14X22x8S0UMhzanidJDLQ0Z6Ryh/Ui9a5UeTGY1JBG0OUmc5jU4f6G
         LTZyf0htrPp8Pm953jpotEQR13HKi5NqC3e5weOdI7242gW20nnr2gOVHO27wxi9SGrn
         3aOQs5KKbKsmT895tbtxnO8OJwW/pe7+sbIkHUKTC3BG1sfiQhXBSOqXfHJSWTizaMQG
         ZrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795087122; x=1795691922;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrCvkLrp/royT60LvX87nJ6hEmqSNe0EsAi3XYZ2mds=;
        b=m+GtH8VCt/SgC3rOEOlym0/tQQSVYbKb3osYm7ChCoQOyw1iv4S65KnOMCO3xU2jpY
         NRsqUli5VRFsVjkiZZiXRDYgXP/9VI5go6lWaYiJ3i/hYkTc2xzB4w7OObHb0rUKM8GI
         Gs7bBvWK3TFD1yuoESuQjw7s69bi489edM7bLMnYFsRP7dQdf1cgYrtbJJilriGg6Tsy
         vZvDQ6JRT0ilFAjlJ8Nx4JyxgPlYD02ay8o3OH9s4tNBlSnT245FEmGVEigR21zhlq55
         l2yEhrhvj8sjpweDsLdfpp5l2Z0DarLl5tARPq2hs7K4Vt5iu1OChKF0Wh+iMSV1418r
         4kqQ==
X-Forwarded-Encrypted: i=1; AL+hErGMArhbUqa5CD5s5mpO4ej8yzMo/eRj6CJ7rXH60q9Ht+XlTDsXWVzp/WS0njiks9KC4B85AiX/2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z83Eidxq37Z0Xb5VI4XPaKRBm2CLpxot/NPWApA3D/lPYh0qKxM
	UphRE8Gw7BUFLTS2k6cV/KxYI9f8HBkUOhbCHn1kKgICqXzP/CiH2M4P
X-Gm-Gg: AZFdTZdqYY3iZetAXSObq5qPujVmhpyE6YahLxO8uqDx5wUBAa3j59FUh7GtAO+mm8K
	/ds1tlgjHzg2tFkwNucBD11OTzh3L6g0iW+DgfFEtRuM+87h4K+fR/Wf+/bqJakFuiRBRV0E1mw
	ESt6nSVyTWpMDRpAH9QYuQzD7BZvHF3zjE9aXAN/v5e5t4n/zuIrk6niNs9u7pWcbL59uXjsn77
	5ujPj8lJtZYNi/wWNk2iV+Cmq8B/89ff/9PMTsDknCSMS6f/dJU45dm/VHKbdqKtX/LYwosoZ/i
	Z3EpiEYOgVA0xsAHTwnWr28A7raPNLuA7KlMLyT0warn6Gm1We4pCGNar2JySjkpAKkbFCDkecr
	gIuQfZSY/JpYQCnD6xMtymWyhzAYafg5KlWXdkEBajm+33D5VEL+A1EGZD/DZtCcA4oq4bo5EMj
	GOsFKgmIrO+N3W2fMPkSpJu0KhblMJxlTMi9eEMxTPX7cxk6k46vd3M8/FA2jYAwJsWit57cbZm
	56o6e85jR8b5BUnD2YOjHn4QuVCgmL/Vk70N5UtvNliW8DUP+p6PcrVhiC1hVq0shR8eOQWFgnm
	OSsXvucdYvR715kFUeC8M0cHBV+yCf71zfsZjDrJsXtykAo0wg6L3OVm8kWG3eiR5iz8we/TfWZ
	YnsC9faV/7q2VK9tHvNCEkM6y
X-Received: by 2002:a05:7300:b2a8:b0:375:e4de:96d3 with SMTP id 5a478bee46e88-3828171b0afmr5821926eec.31.1795087122102;
        Thu, 19 Nov 2026 03:18:42 -0800 (PST)
Received: from [127.0.1.1] ([74.176.208.23])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-382a6304efbsm27440350eec.7.2026.11.19.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 03:18:41 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Niklas Söderlund <niklas.soderlund@ragnatech.se>
Cc: Rafael J. Wysocki <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] thermal/drivers/rcar_thermal: disable the work before
 masking the interrupt
Date: Thu, 19 Nov 2026 19:18:35 +0800
Message-ID: <179508711555.3615492.10674834361832600268@gmail.com>
In-Reply-To: <20261119062203.GC2300348@ragnatech.se>
References: <20261118072321.1259639-1-shunsheng1218@gmail.com>
 <20261119022903.1493494-1-shunsheng1218@gmail.com>
 <20261119062203.GC2300348@ragnatech.se>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Niklas,

thanks for the review.  The code changes you asked for are in my tree, and I
would like to check the testing question with you before posting a v3.

The delayed work is now disabled before the interrupt source is masked, so
the handler cannot queue new work after the cancellation, and a work that is
already running cannot re-enable the source behind the mask.  The shared
interrupt is unregistered with devm_free_irq() rather than waited for with
synchronize_irq(): the line stays registered for its other users, and they
can raise it again after synchronize_irq() returns.  The RCAR_THERMAL_MAX_IRQ
comment, the loop variable and the two comments in rcar_thermal_remove() are
as you suggested, and the shutdown flag is gone.

On testing: there is no R-Car hardware here, so what I have is a controlled
ordering test on a KASAN kernel, 17 checks, all passing.  It uses the real
delayed work, workqueue, wait and signal machinery and a simulated interrupt
line shared by two handlers.  It shows that a work queued after
cancel_delayed_work_sync() still runs while the same queue attempt after
disable_delayed_work_sync() is rejected, that a running work undoes a mask
written before the cancellation, and that after synchronize_irq() another
user of the line can invoke our handler again while devm_free_irq() ends
that.

What the test does not do is run rcar_thermal's own ->remove().  It
re-implements the removal ordering, because exercising the driver would need
a real platform device, MMIO and a thermal zone, so the behaviour of the
interrupt status registers on real hardware remains unverified.

I can send the v3 with these changes if that is useful; if you would rather
see a different shape for the removal sequence, I will rework that first.

Thanks,
Yaohan
