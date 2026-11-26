Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708549;
	b=UCwcdhuM/uKtWalANfEyhZLQUNoAURM3p0MN1CesZq0fK1X4z7DZDT5bLzJUHZYWBas2
	 kRp4drBzxcXEAqX/Ua8NDCGPQgusxSHetc8qS2sTs5IFaCYzalg+6WYDdy5oAt56YuKu9
	 sG5Ih6MsUpJHRCSXwOh0pHY1dCGklqg/Icy+EpPcz/39b5jI4/kPOr7+6/xozn6eRmiMJ
	 zsTCAQqBibdmOePh9hPOn4beLHt3hNdo8oAtnO5rOdsf0slFThh3p2CF/RVzyhg2jpAA3
	 lkGtgKdHciWynQ32nktBvGggYywGoDyVWvGX9FXktVP1iCGYeuES1ZoA+oHvGzmwXFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=W7/uRx1XsGqE/NwPwsGs18nZC1l3GDgC+9VtG/a4oBI=;
	b=cAc+bHMgYa+gQwx9lvr41WtegTSLXOk0c4LN20kleqodZbE+4EmaAE/VGj9osqUz4nQB
	 QL9zgIGQIL1n1S25kDbKT2kzN9cCxA+j9wGE13vao+hZinXoizX3zTyjl+WVdJSd1/kV5
	 gdd8iN9XlV8awzAoBq5giGKRDpnmUp38/RhzWTUycUIRasR2Yt5lqR8+4edFKhKqF2oW4
	 MXBzPbyOUTqGcVrCdb8m5sjhmbMVcblql4P9SelAOEw+A8rxHDcHKuznYb1ZqYHovRFSI
	 jYvgZ7nv40CJYrnvEiyPuUbe/m2oLFvUJWzEQ2PzGqYCTZrWjxvfzQrC5RDBjzoi1PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="JXoM/IjI";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE966606A326
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 15:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE966606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JXoM/IjI
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so4249380f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795708547; x=1796313347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7/uRx1XsGqE/NwPwsGs18nZC1l3GDgC+9VtG/a4oBI=;
        b=JXoM/IjIkFTR0wTt95IwnzlhPZS5PjgTza4kU0lPa6VpqI9uVAw5IVoVEoOU1XsH6t
         az82g+pQrpJSHgegOzxa19pKFEluidDtgxAm3BzpnRUIbZnmt8QFztw6DVsJwYgdtstq
         XLRnnuNXnRRi+Nci3Zd5db/XOmPwrHzCK2tHmZz6HTCj4H8+Zbpuu+LlYjQLR/wye9Sz
         dgmi/SA8vRmQqqPk/xeOrcIotduAdtvn7yTWjR2Xsz+6J+FzKTMCseH75u/ZmyJ8zzt+
         UhV1sTO9XV774oldLn88JZyLsQP7M9fb4S8px4O6JT7SlSISQSZU+h51vprFmP2kbEy+
         WCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795708547; x=1796313347;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7/uRx1XsGqE/NwPwsGs18nZC1l3GDgC+9VtG/a4oBI=;
        b=Q4SLFlP/YGNKEWheSXD0zsw0+UuCww8PryfCsonyuVU25sH1ZGp6syv5jbxCgdpKPQ
         BwtGKamTOe7zbX7cgm6PojAlAaTisD4UgaOJ+MJg443ErV6u7+JyJQkMOKkq98v/MYzN
         ZSqfc7AT10hn7qKIS0ZhlxP5xYSeKOEymSX7pL0JoeWnTjKVmd2HStv1YZqaIFwpq/sg
         j6qrUxsH8pSTUXhsOvVxbc0MaYE8uIr6uUdrsBBtR4KKWslVTzWxT+m98VIJ1IgRcSOB
         jaat11O277U/LgqxOJwfrz9ctF3XRAO2mgV76wdIUS9eVotcusCgk99+IzGrRsS99Ae5
         rmWA==
X-Forwarded-Encrypted: i=1; AL+hErE/9BXTQocg3m9IAcPZybxp6Q1WOyQp5GV3N6Yns7v/5kxB0aspFsVUkZe+F8iK1bs1IPsZ6qk+Wg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Awi6mxDJRMbjn8G2ts/3DDxCdea+aq1KhjQvnHIVYit4qjBTR
	woa0F4YTyrPCzYlNZdZZFKH/n/WhGnteyPuXnDj7MplIha8ZKDDAuu9Vsi+z/+1cJso=
X-Gm-Gg: AZFdTZe0MCGzuhc2IzsCXbVpum73I8FOmPSnarrjzni/Lva9/F1wyBIkBk95LxYI3d7
	nhGXivDHpzd/2TQ0rqhYF6fhjHITsixv6PE5TEvYjlY+bxxSXYVZKHPYfEiY//247q1uSlcAaeX
	VTlUML0ffaRS9CXGGMARFbP5CKv/yLyRFrZt6M+3JzZkTuvUn4goyxWM6wRuumT7ToaT+SKlNmx
	mtn1FW7aP5JVALgZ675GIh643w4D2e6nQw4hJOFFeb1xmY/Afc8s1F/rbRzAYekGBylMn+hZox3
	l9nj4bhHmf3vqQqVMfv8k697QAu9nXFSHNJwYjiPp1V8fJtIHD98T9zGEIFHGP7/gb8QxFNlcg7
	Bqu0eTVHUX9xgfUumFLxgqO/8VxspVkkvFtEVUTK6RobHXFAjg5gurejCIbEWYgg8rUAa7UdgxH
	gqXZyz9Kr71rrnWMAR0emNQUtxYtv58+vJXBJIoL0kvF538sLfDf66jDzeNRAEykJswL8d1SaoH
	WudquRwTrwxA9pPgPoQDPKAShtyzbNWvN12X8gL/KKtRub3ePfk5kcHlAWWqHOdWubCzmRTsGmX
	/Ib5NLogVNfAZf4xgM2vnv93Wzfpna2PdT+gAVw=
X-Received: by 2002:a05:6000:2b92:b0:4a9:cbb5:803f with SMTP id ffacd0b85a97d-4abb400a6c6mr28239649f8f.37.1795708547139;
        Thu, 26 Nov 2026 07:55:47 -0800 (PST)
Received: from [10.11.12.111] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf6804sm40824853f8f.10.2026.11.26.07.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:55:46 -0800 (PST)
Message-ID: <e113453d-4ef2-447d-ab83-d5baadf2be4e@linaro.org>
Date: Thu, 26 Nov 2026 17:55:43 +0200
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
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU
 throttling
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: bzolnier@gmail.com, krzk@kernel.org, rafael@kernel.org,
 daniel.lezcano@kernel.org, lukasz.luba@arm.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Peter Griffin <peter.griffin@linaro.org>,
 Juan Yescas <jyescas@google.com>
References: <20261125173959.2198116-1-christian.loehle@arm.com>
 <CANgGJDp02H7-wLv6DoaPMeiy4UvDUC2nvSR=+mngEZ+Z4Hqgog@mail.gmail.com>
 <2162b02c-642a-446c-973e-ca80607da294@arm.com>
 <CANgGJDrnH7R9aTXhH-nj710OjwNcUTfpxE7eWGSP=9a3eoUnug@mail.gmail.com>
 <4adc1712-3608-4fd7-9eba-79b129c67b77@linaro.org>
 <DN586284T46G.271ABU0A683IZ@linaro.org>
 <e329ce21-5a24-4301-9328-917d0ae4fdb1@linaro.org>
 <DN58TGCM0EUJ.2DYM0M51C78MI@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DN58TGCM0EUJ.2DYM0M51C78MI@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/26 5:21 PM, Alexey Klimov wrote:
> Which returns wrongs frequency for the situation described in the commit
> message and in this discussion => doesn't work?

Yes, it seems linux can't see the hardware throttle. I need to study whether
there's a notification mechanism. On a first looks GS101 lacks it.
Let's keep the hot trip as a last-resort backstop, as downstream does.

Will try to ask around, maybe we find out what the firmware does. I'll add
the topic to my todo list, but it's not something that I'll get to soon.

Cheers,
ta
