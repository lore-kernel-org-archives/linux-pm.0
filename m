Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810797;
	b=FLeizUHhQ5VKO3EhorDRdGaJIANn5Fmej/7Npulnl6Buc3rQDRIZPx1u+GwZTRUWdasi
	 7kBod/FEQbImQNQtUQRCUdOWvguyWTrsdm6BtLpZU+MWNFupwVUac4RK4lz+m4b2OqfiD
	 GnZhomUBQhj8A5YSwtaGazmffJKCl5R0mBEmtjkn/Ptz6lXpfYKLldiVf21UjQptpbKBX
	 ArkswQbS4GqjeyihcuiKLWQ8hpSvwcZrYK5e2ewnGEhivBpir2IW208cOqia+iVBxeP+n
	 9181Ys8XVQmZD5liB22y/QObZWdiu/YGttD4a76uB3+7+3X4/Uz0aAbWyn/o81m58sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eAaKlrwhgxVSTJYKvS+Mu/JmjMNNY3TaQOKNMaH3oHI=;
	b=j64hWqrEEj2OjqVc33rtVCJqU6Ma3INasBaSzALk3wYAsWVPpybLZ7Nb9ofCWmqRF9hT
	 gGEDmUK+czv9F+yFxf5vl4XUPtnJ+u98O7phraYvGhu1I5D/Dx1PeVdUOZqIEMS7YJvlX
	 hBmcVY4hCNuIxojUfBVxq8WhHZYGad3SeTH+UnhX7x9nKU5GxYv2XeByvv9C2Bv3orx3D
	 KDXC997R0aHiU8yaRdjURVGxTmC7yJi6XloFkHsK+vPHFUBE3Kyxl8pNQ9qThxzmGtgUG
	 vOqmTBdgNq5Y5vBoE16qQ4OILiOaY21MDrfLoiWXAMHET5UIX1kCumubaaNR7tA9QCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JV7jvcyh;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67492606A336
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 16:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67492606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JV7jvcyh
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b1ce85287aso835598c88.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793810796; x=1794415596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eAaKlrwhgxVSTJYKvS+Mu/JmjMNNY3TaQOKNMaH3oHI=;
        b=JV7jvcyhDzFZgOzyiXMsrrE96csI3o5reJpHhY1rZC3R+/mUnsqjvCmXEjOL3OVxrJ
         JkdmZ7gnsvz/rc1SGznFGm489hIxWfufBaTe+g/2UZU6OFp6XAoftty8q01wNHobQd8X
         wch1oNFN1YQPF6MTpQuBWXmoCzX1jPassCZJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810796; x=1794415596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAaKlrwhgxVSTJYKvS+Mu/JmjMNNY3TaQOKNMaH3oHI=;
        b=wXClzPBQVZk4D1p7G7UHDzsuyMiEbKGABhSwNxEEPF2vJr0qLxBNKxov8bNkejQTBZ
         eO2QGqdtGrKXmHjFhcq4ziHf2dI3s4L44/x6EKHoMvxTx04pJ0usFLY7opRuMh1Rv0lP
         /Op0YSDg+O1blB7CG6jYbhGZ2w6QyjuLZKCZjuWAP7SEy6p7tA+cINylcD2zWJXhzAnG
         mCZaPScVgwB9Hu1NQ20RiAtz+t3RrA2M/zfDcLpNZJqdw9haYnIu/4+IWWzjEe1NiYXT
         ykyEqocdHE69hSEJF6tPnnaQYeqXaUclz0awpYjR0jq6lAMsQqVSR0cv86gfuF2VI1ou
         A9jw==
X-Forwarded-Encrypted: i=1; AKwUvBxMsH2kd/y5Y3hlwTNSfLs6dcXRZI+p/gxsMe/n8Q/ZjI70UAMRdU7aIzkVgVGHNdPUc+d/2tEtwg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8EMP7SatJSNDlugNbBHOKCLe21+NEFhRsKY+RmlpUbIhIAhlJ2
	QhKIOjsdDKjDLM2W8HZg3r4tXb+3qlt1lRRjTJ2lykwoCpl0maydg6Jbo6am0TRyfQ==
X-Gm-Gg: AYBFou2M6T4IuL/qhIX3jUM/+kz1Bc3E05Hjri+8LMXY0/9yxMEv6JlswLAQMcEVqc7
	R/4kn4WzFXHxwLyUPf5C13x9rdxRNaf8f2RAtxassoI37mt1EQSP+oYrzQkK7zV72At9Ika4sdV
	8ppLsyhIR+z29pOCX8skfNjszjaEylVMmVmu1TLB9DOr1/eXEKo78Mfw57kfucwjKOcT2wZ/e4H
	O1IvbJpHb19TMYIwAvS0i+YpR3Dcn0479XVdlQEKtW4wluM6AWFLYqDoUwMDKjzY8JG/IgUB3n7
	x/b0N9cwrjVj24JOKlXdyIUJl2033ufVoJfYtuD05upuNpJ6kjM602QPEAcUR9aRwEBk6ZZB/yR
	kRMz7pk1Vf6PkUVXGnxatpzcOBQBtZd3gIu4WOTHZMG8UnerlnfCnDgLIV90GE5cfV9tzWcyY0D
	tDPGYoxgWLmWdre5yv2rQn/W6EU3xs/oQZdNon7bVnATr7pQzXlGQ6R4amwvUPGLX+MMDTk6Ns2
	GZ8/peFRqLGj/tIEoAkvYfvVgJBbqVEFs75Pl6khKQXicWEXvuD0L7SmbIEEncfIa+nZK50s/q1
	4yva1z3f1VlJ0p9fmSrG/XA2R4qOx2IUsGJc0WABp1z/6J/UcF28fW16rd0dRfpAx18=
X-Received: by 2002:a05:701b:42c3:20b0:1b2:366a:e7d1 with SMTP id a92af1059eb24-1b2366ae854mr11976510c88.32.1793810795926;
        Wed, 04 Nov 2026 08:46:35 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245c2de58sm8522268c88.12.2026.11.04.08.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:46:35 -0800 (PST)
Date: Wed, 4 Nov 2026 08:46:33 -0800
From: Brian Norris <briannorris@chromium.org>
To: Stanley Jhu <stanleyjhu@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: runtime: Update runtime_pm.rst for non-fatal
 resume errors
Message-ID: <authaS5a_NrY-NLd@google.com>
References: <20261104151651.3035537-1-stanleyjhu@google.com>
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
In-Reply-To: <20261104151651.3035537-1-stanleyjhu@google.com>

On Wed, Nov 04, 2026 at 11:16:51PM +0800, Stanley Jhu wrote:
> Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
> suspend callback failures"), rpm_callback() no longer sets
> dev->power.runtime_error when ->runtime_resume() returns an error.
> However, Documentation/power/runtime_pm.rst still states in both the
> resume callback rules and the ->runtime_idle() comparison that the PM
> core treats ->runtime_resume() errors as fatal device errors and blocks
> runtime PM helper functions until the status is manually reset.
> 
> Update the resume callback semantics bullet to state that on error the
> PM core resets the runtime PM status to 'suspended', returns the error
> code from synchronous resume helpers, and unlike with the suspend
> callback never treats resume failures as fatal, leaving the Section 4
> runtime PM helpers unblocked so a subsequent resume request can run
> ->runtime_resume() again. Also drop ->runtime_resume() from the
> ->runtime_idle() fatal-error comparison.
> 
> Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
> Fixes: aedc51762a0d ("PM: runtime: Clarify ->runtime_idle() callback return value handling")
> Signed-off-by: Stanley Jhu <stanleyjhu@google.com>

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks for fixing this!
