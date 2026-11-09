Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.231.106.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214392;
	b=teKQorEbQJbQFmPpFbhgOnGdk6bqSvtOodvOvvAFxg2Flc/SYiivcisSeubFyRqfodiI
	 eG+WWRd+Izwx8cJyYrxWec994FE1ytHyQMEsTXLamYUm83Xuve03M01dTpo1V8HBOy7A/
	 kFWaIuIillh94oXlD11b2jJHpn7GVmoThnIDXROSo9f6O+GSn1XUno2X4W53or2HjyHAd
	 Rlqio5IGviHAjhUuku1ehuQOVzMrvfH1g9Q6vxiknATnkfm7nnnC8UGvajsSesGTEU1jL
	 zagHPwe5EQmu9BCuzFUTbsZChfDOmKW1ntEl33qqRgmtP9G7a89XNz5IQ3LfI7RVxhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214392;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZKf2DBGb+N2gDS9fHvgM+A7zfG0IQY/8ss3YlANSh/w=;
	b=OclcIS0oaVJ4XXMCBDnh4z47+UnTuVipM8R6Ne/Q9sQSFpsLTv9qMKbtbLngiBVjIHda
	 FliE5Pc0WLMT0UMRnQGejUNxueNeWe5+4ErlqlSSFD++somA5/knrkjHoez5C+YmZB2D0
	 O3G4CQvuB1DnoB8lhQlfRiwnjiqjgBlTXjyu/nSzCdIdV5kLhnP03rlv9YwKwPqPUkxSo
	 UCxpxEakd71EMPvx+6AR7YvpD2IeO9dwKEOWqVNAkVNvVFa5wslUR8ax2TXR1ZzRJ7lpb
	 AymsBXHjrHZ5/ieyGIOTiLq5N0hpmhaD+NNhx/51suI7w1bD1h07TbxEXrAUN9lNNxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=klattorp.se;
	spf=pass smtp.mailfrom=klattorp.se;
	dkim=pass header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=PdC0AioF;
	arc=none smtp.remote-ip=94.231.106.230
Received: from smtp-out2.simply.com (smtp-out2.simply.com [94.231.106.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A560735C9;
	Mon,  9 Nov 2026 08:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 474A560735C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klattorp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klattorp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=PdC0AioF
Received: from [192.168.1.45] (81-228-203-110-no2102.tbcn.telia.com [81.228.203.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4jNNpq3fWTz1DQqk;
	Mon,  9 Nov 2026 09:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klattorp.se; s=simplycom2;
	t=1794214387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKf2DBGb+N2gDS9fHvgM+A7zfG0IQY/8ss3YlANSh/w=;
	b=PdC0AioF2fohvlmAvsbaoBURs17nOU1vxanKjwgtkWcobgVFm6x7MOVxvAdN3+JzEghKYx
	orHPk3FzHn6QApUr3wRDspdeQjEV6Tsl/muUd/i/rrCZ56wAkG1oaBTYOZEADyGwrSFlrZ
	09wZqCS0emuOKp/tHOVlTIGLHKrfAMm/CuGG8gVXDwbk483k/mZ1iVtHHQxIXctnXBn/6r
	IYl1TJYraVxwiPLvE/PQ0Lcd2lJKdm+hqYrwFYvIaKIIShC5CfjftXC/t5Jm7j9Ph1edZu
	HG9BmIfjYEuKQCw0c3G2uZQOKbluYHOBg+9RvgSVzC598VX+IiayqDTm6NsSew==
Message-ID: <b7672bea-edea-40e2-a4b9-b06d026265a1@klattorp.se>
Date: Mon, 9 Nov 2026 09:53:06 +0100
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
Subject: Re: [RESEND PATCH 1/3] power: supply: max17040: pass the device
 fwnode to the power supply core
To: Krzysztof Kozlowski <krzk@kernel.org>, sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 matheus@castello.eng.br, me@iskren.info, m.szyprowski@samsung.com,
 clamor95@gmail.com, sebastian.reichel@collabora.com
References: <20261108154241.198160-1-huggek@klattorp.se>
 <20261108154241.198160-2-huggek@klattorp.se>
 <3b4d9f8a-2b5b-49c6-a2fa-666548029975@kernel.org>
Content-Language: en-US, sv-SE
From: Hugo Karlsson <huggek@klattorp.se>
In-Reply-To: <3b4d9f8a-2b5b-49c6-a2fa-666548029975@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 > Please run scripts/checkpatch.pl on the patches and fix reported
 > warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
 > patches and (probably) fix more warnings.

Thanks, sorry in regards to that. I ran both, the only findings are
for the "Assisted-by: " line, which checkpatch does not recognise
("Non-standard signature" and "Unrecognized email address"); --strict
reports no checks on the code itself

It seems it was removed in 1e035297ffda at the 13 October as Sebasation 
could just drop it on the applied series, but that´s maybe something I 
need to do myself and send a patch v2? Or is that just cosmetic?


Hugo

On 09/11/2026 08:30, Krzysztof Kozlowski wrote:
> On 08/11/2026 16:42, Hugo Karlsson wrote:
>> Since commit f4b782af61ae ("power: max17040: pass status property from
>> supplier") the driver forwards POWER_SUPPLY_PROP_STATUS to its supplier,
>> and the DT binding documents a power-supplies property for naming that
>> supplier. The driver never passes its device node to
>> devm_power_supply_register(), however, so the power supply core cannot
>> parse power-supplies and the battery never gets a supplier from
>> firmware. The status lookup then always returns -ENODEV and userspace
>> sees POWER_SUPPLY_STATUS_UNKNOWN.
>>
>> Set psy_cfg.fwnode the way max17042_battery and cw2015_battery already
>> do.
>>
>> Fixes: f4b782af61ae ("power: max17040: pass status property from supplier")
>> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> If you are resending, then at least you could run checkpatch.
>
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
>
> Best regards,
> Krzysztof
