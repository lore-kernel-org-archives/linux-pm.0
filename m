Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978184;
	b=WMrubjwDp7HKF9xv1o+3v/fgs4YPr2kjJHDJb/fsI3wbA3ghuQa29wFU5K4CO8yywhgh
	 pGxe/mn/C3ViYuChc5SDbdiq/DohAP0x1vIs+srXOD/wZfRwaqRA2VpF5bw9C9zeREegI
	 UpJTkY1ByBhiQjcIt7mdpTB70nTmsD24wnDJwORPXsIt7bVddOKVm059iGyXUvCj6lJpy
	 DW7nvZ1J3BDysAymGqgm9gSYxiWkAGGeJIpOBlOFnwZF8+1hrj/BKgC3P3x2HwtBaEsI3
	 IMpSzF7GiCjhOY3X8Pus6BfW2oBBYFGrK0v3UMlpWJsDh5R4lFPjR36bY9NQ5yUK2jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZBDIYs4Y0It7dcl6v419n3JeAweftEEfsMmrD17e+80=;
	b=RxW0KKZ0urHd+Hq6sdS26mhACCCt1XM3SpTlMpFL7vsq9Agv4KrOoPh3V9OibrojpLln
	 c+iUSEPKHIY9bqQkCYBRG85Mqnl2Q87S/4jkHL1daNU01HDO/+jYf8t6AjzejLa4QH/ZR
	 TgNVkBYpZ5QYQ7jRgDykDLVDRbdQy5mZIA/WDddmuGINZnDSTTs1tBnYCOT8kwXiOl+Iz
	 crXqLn6VOxZzMKE05+2kkA7yEPzK/h8p64GawoTZI3WC48u/k8zBFbu4bNXJvT6XzIjP2
	 XwmHsIRT1OcojYj/Y6M0jzuRMxme9+F/AvDRzKLDHSjMdMgJhioj/7OiYIFKRESu/BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxo8erlB;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95F606A330
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC95F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxo8erlB
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so5869285e9.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793978182; x=1794582982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZBDIYs4Y0It7dcl6v419n3JeAweftEEfsMmrD17e+80=;
        b=kxo8erlBylITXb38m1wEtnfEDV3x/yMaJ29j0q0YIFU/H5cyQrsqLj5K598Wy9weJQ
         A0DJbc4I/TN86jX1fGLlvJLWjkhURO4cOxuuAKH3apDJBtQTlXy2Qz4bO1avMzj8VPOf
         uUL7kHWf2fTP9uFyfKLeCspQFLGH1ANd+tisjKG+IgGewKu52tBELtyTjX66BlA+4FBj
         P4ys4PblaKABcVgEPv+IeHdWFIE/o3yZ0zqeQutuhpbbrCAV3N1kpXvFMBUL6v6aa0dT
         P0STpQnsN0JpWBIWLbxZUipI6nyhf6kzfxKIr0c7XQ0L7LcBGKJ1P3t8gjHWzHgYrEm/
         QYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978182; x=1794582982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBDIYs4Y0It7dcl6v419n3JeAweftEEfsMmrD17e+80=;
        b=NOYCCWjmKXx8yEBuKLIu+00+rIDIxO4JgjnyVM0c/1aQwlWS3TnNvkiD4kczliNy8X
         jZ9rCigkOB7S85kGetunOfzFBDLkztiiploaetJTOcjmH706BVVFDAP/pDaD1BfqvzK5
         SyeOeb76miL+QYlNqeNZw75pi11HFSMn4TbksXQYKhOn3cDiEUhxwNug6QpFMdf7nr2H
         3YMEswo8RGfDqK9JY+ycLKXmy343bTzl9mXn5ilz3g6PmV6hHrwRbYzc70B1mruNcxGG
         vb//AbMguHDJKjv/TQchQm7QlcvtBN2tb6VY/0o/b8kEvBGaYqj9da+UIk3jz1n3cCWK
         akLA==
X-Forwarded-Encrypted: i=1; AKwUvBwMHNFZqv/pQ1heuTAKSfWb/ciBuewOUL6S4liMNq8fIeg9cVQt92qLjcNtjSJhDTMf4yalDT41Lg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+mAJbVxVot693F687sRFf9F4nGu3BYHVCuD5SjrbaEyf2vStU8
	x/cKdhGTUbPKQF5HN/yZcRcZfS+WGwMzdSHfuKd/PrlArvoV52gcxoTQ
X-Gm-Gg: AYBFou0ts20ngM4LXAs9Mb9v/I0AiZbpkUSjKitnWr7THfBPqsA/rCGkRmBsiipjQz2
	BmBa3hDGSRZFxl72tpWT1PbxCaw51/UaNR8UIwHRxYVLnxCWW0tS7c+ebDfFCgcBiDOEacQmxSu
	rC9QzjjVYEjPphLshpV5SIAjyL0lL5AHo254II6mVqWcB4djShgI4XSEJcOej8qOoCHSg+q3Hv1
	NKU+cr9wRe0BS6Lr2lOnK5SWDClj5roIECoCKSJufRziIW29LHBnjFvItiNpXlFGCEivMRe0WKP
	mD7xFnT3Gl2Wlkj82tfq5bGM/wm+gKbzTl87y9CenB6SWaA86W+4Jv9OyoBdubCkhEYsSiMiY6D
	e1GlSKS1448m/IPvtwootrNKSsrlXykRVzRV+gEyTSjdajKlamblyzyiTnbZIz6zcDBNodqW0M3
	ihIwHj/DiYce1TdMGWOy72xvn8KQR8ape014fwixeANQ3ahiYN7ymfyfkYQvMA4wUOmOQphUXvj
	s6pevDjBZQtpL/FkjXYe8b1Jy8gwWtKDndBdFe5+Ju/5aydrRZRp0rxrGt3sRIPDAA00Vq1ugAa
	3jU6lo2Lulx/vvFWHZze/LZvpu1X/bYzZip3Fzs2g4ICgaLNYYdYQnvFErgBWjYg/80k7WcKYhL
	J8CkKM53/JmVvZCuVgP6R59aTEChk9KRoeskfOug81yvEJ3NPLBxVSLaJqPzY
X-Received: by 2002:a05:600c:8509:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4b6e091f195mr44253705e9.34.1793978182055;
        Fri, 06 Nov 2026 07:16:22 -0800 (PST)
Received: from Lord-Beerus.station ([93.146.104.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc6162sm4124688f8f.47.2026.11.06.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:16:21 -0800 (PST)
Date: Fri, 6 Nov 2026 16:16:19 +0100
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	luan.r@variscite.com, alifer.m@variscite.com,
	pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fugang Duan <fugang.duan@nxp.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 0/3] serial: Support driver-selected TTY wakeup
 defaults
Message-ID: <au3vQ7sSi6O3_hqv@Lord-Beerus.station>
References: <cover.1793719239.git.stefano.r@variscite.com>
 <au3diCrF5jPYH4Tu@hovoldconsulting.com>
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
In-Reply-To: <au3diCrF5jPYH4Tu@hovoldconsulting.com>

On Fri, Nov 06, 2026 at 03:00:40PM +0100, Johan Hovold wrote:
> On Tue, Nov 03, 2026 at 04:51:24PM +0100, Stefano Radaelli wrote:
> > The initial goal was to enable TTY wakeup by default on NXP LPUART ports
> > marked with wakeup-source, without requiring a userspace write. Instead
> > of keeping this entirely within fsl_lpuart, this series introduces a
> > common serial core mechanism that other UART drivers can also adopt.
> > 
> > The new tty_wakeup_default field in struct uart_port lets a driver request
> > wakeup to be enabled when its TTY device is registered. Each driver
> > decides whether to use it. This series adds wakeup-source to the LPUART
> > binding and makes fsl_lpuart the first user, setting the field from that
> > property. Other drivers retain their existing behavior, userspace can
> > still change power/wakeup, and serdev wakeup policy is unchanged.
> 
> This is a policy decision that should be left for userspace, not
> individual drivers. As documented in
> Documentation/driver-api/pm/devices.rst:
> 
> 	The initial value in the :file:`power/wakeup` file is "disabled"
> 	for the majority of devices; the major exceptions are power
> 	buttons, keyboards, and Ethernet adapters whose WoL
> 	(wake-on-LAN) feature has been set up with ethtool.
> 
> So no, this doesn't look like something we want. You should continue
> enabling wakeup from userspace on systems that need it instead.
> 
> Note that the "wakeup-source" devicetree attribute also describes
> capability, not policy:
> 
> 	Documentation/devicetree/bindings/power/wakeup-source.txt
> 
Hi Johan,

Understood, thanks for clarifying.
I incorrectly treated wakeup-source as a request to enable wakeup by default,
rather than as a capability description.
I will drop this series and keep wakeup enablement in userspace.

Thank you,
Best Regards,
Stefano
