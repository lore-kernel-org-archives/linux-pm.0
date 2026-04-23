Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47B3E6DC4
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947652; cv=none; b=T4Jhf6KzliQIy5I0xUJVr7SCduNreQhMy7Oio3TI3xtoIsyfhwyNk0oGk/W0j/bqSn48ojigHvnZLUTNahlabq/bvzb/6l9nJ4mky2hX3kEuBJvQGRYpDUt5D0+ZM+WwzOpasbgw3DCsn6tUx7Y6AVfl2x16VOjvf0ADqY6MVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947652; c=relaxed/simple;
	bh=SHt8/jDSXolzcD5Ycs/HtVeMQJoHpcSGMEeHPCWu22c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIJA0WwSpmfj0XF/ulMLz6jIJ3R/WitgkjH3p3CCI8lh1q51L8TgfL4stPchPcsIGfwcT+3IYnZV6B68Mb/dDrUvyVJc+xogzpt9y+r/T9BHPEboOJiCtfIYFW31o9tVNH22hyco2hS8G+8uO1iLs8DBOwbDiXoEgRs5kJqaWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OyuRrHlB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyuRrHlB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso68553175e9.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776947649; x=1777552449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHt8/jDSXolzcD5Ycs/HtVeMQJoHpcSGMEeHPCWu22c=;
        b=OyuRrHlBpR0TcLjq11DTQNVtYQFiAa0ENCTgMudk1mmQm9bi3GjK0R+oqirFvaux56
         tiRflDIWvLlzZ0z0VxddZifTV8BBSsdBZDJ83frSosJnARIDfSQvBCWqcDIk/20KWfF8
         RLnCxbLa42aWvpoN3X5VBE8QCtyZUTqn5uHDT74lEb83MawzycdF5ewTBOMq8jM/GmZ9
         EGnQyJAsjGh4MX4X2Nf+i2LlYrrwenkMWqPKmxB/1LtLVIpImd5HAvjizdmNEMlc3NMT
         weIWR5WCAM4x+JDd3XhJW3AZ+3PILhr8/095YeW4587nwhr6XPNaIspj7jKjrWLB/rUc
         8QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947649; x=1777552449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHt8/jDSXolzcD5Ycs/HtVeMQJoHpcSGMEeHPCWu22c=;
        b=qAhcofDNkxTfakoMvIZz8xeihC0tcMOO3FcyYzoP7GNA0yDUfcywrluKn/jIMdJPvA
         EnYDkN+LiDNG0lVCWrijzI94Gyp67HQAQj3t7dn7pmJXJQV3mwScksciXl1Q91pvC53s
         htWo2z6uPbCFbM5xMfyw/AM4HGFjoBDMMgYTnNj/gxdTffD9Zcpig9GsIcDQlC4XISe3
         jLjLKwF8MhossVxtcucjP1iWrWZU1ihS0VlV1c6F0gAahDoFVWTd93O04hHOhvQd+Ng9
         Ohvcn6xRSfQ9xrYQb7cRkUqWNOyl3kLUeOuoxsGSN7xNx9PXH0gBWTPg59zcrVr8ans2
         D58Q==
X-Forwarded-Encrypted: i=1; AFNElJ8H3mZsngrsyXhL33A4iuHc7hVFBKhJOdMWTiKtEtrjfRoWgXBk6EFaw4Cc2ZOQzdx7LvGZChzImg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLGHXMkxBOdvjSzUnDJntPZTJS3l02/CtC+YWbOQ570ccNunR
	K/3iHCPuv7z79eA3u9XwXT8FEL283jGhBK33ekIjEv0PomJ08fZdp1TZyLjypEC0W/s=
X-Gm-Gg: AeBDieuAcjeB0sPkxP16rTpO/19SA5HZwR+UF7X7tapxUt+xgZAKRanP3YEHuuyvg5a
	SqQjt7xX7KYil/1H82u0b2jcJKfGFMBhgWDy577Pgi7ZjGn8LJ766Tgoy4x1f+vsuwnnOeU6f6i
	r59xQyavX/VBJQpdhUTkrAQHVsLNwrSxiSbPtMbw7LmwKRRgUHnpnEzh4ad2fngDzqWVfI00egJ
	nKASF+FRi656RL7FGARBsQ/1e0jVon5JS4vFezJlX1IPxId8pIWAR63nLWdAg3K+F60J2t08QWR
	6Shxw5zXLCea9r4OMrgvxOZLXUBhJnMgEOOYVPqaEhQjQlK2rCMobzvT+gI+YzbgSs3T5b/OJs6
	sydRb36HjugDIBaqcg3/lSRxeJM/Sw0djmp6rPIR4I78Cgx+e8ucqXehLurnL9PUnxrvlybDF0x
	Kh59rJ5xnKaY/+xPfZ4aVQpqIA+yHYVaG0c8Os5wang2E=
X-Received: by 2002:a05:600c:3483:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488fb77d343mr363286325e9.18.1776947649347;
        Thu, 23 Apr 2026 05:34:09 -0700 (PDT)
Received: from [10.11.12.108] ([86.127.43.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c773fsm588535385e9.12.2026.04.23.05.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 05:34:09 -0700 (PDT)
Message-ID: <b85c3dc6-46a7-4d08-8008-a8334262f4a1@linaro.org>
Date: Thu, 23 Apr 2026 15:34:04 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] thermal: samsung: Add support for Google GS101
 TMU
To: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 linux-clk@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Sashiko identified few bugs in the existing upstream acpm code.
And two bugs for the current proposal. Preparing v4 where I
squash all.

Thanks,
ta
