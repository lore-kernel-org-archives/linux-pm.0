Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469995;
	b=leKG1i980hJ+vfldjq360K7DPktIvwktvBlbo/MndWuJsXQ5bSIIPREiICedC3AMjmcw
	 HbhPZGrfUQVvkj+66H9m5uaAADGEAZMT6PI88KfAA94NJnrNDZGv3O86WUChfxykBlwTs
	 3qM+4zA3/H1RnxHwU6GTi7SXA24zT8fVbwgfusJhTWYZO9mn3qzvBX7wozPte5FeVcuLv
	 IZ+zUhLBgJ9BvtA9EOk9OkZNrM7WtWqR8O2LhHXHxhvMsBBGYrum8qSene0+3XRuCnY1o
	 cUQPsGCwbDj5GVpppmofCCjnkRQuVbiZqlGy9Teb3gcbnOxHQH7QGdux/AwQbp/rYGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=c+PDPXDESs/b1ufFkIbKI7h6YPsn4ue61XHoi6R8yv0=;
	b=aC94jt6zH1MwIAssu9nQsXlgvpyK4MflWQXa1h7YNil65bkjiVPvugrUzC7gP/rYIF8y
	 v6upi3J2hi8lqJ4mxmg8Z6GyTrB9XRKNouy+Y0oSfg9Fcu35iV1x3eF6LJ2P2CcroGm2W
	 5i9hx/E2Gg9sok4uv0XCDx2lb7Am3pURjLU9ERoDaeghxUe1m7qB9Gg3cZNZrpNQscuou
	 AJM3vOtlj4Y6ewPc0r7G+vtVkZXYV84/j15zZcfKZcQ5LZ0J0oJsQF8X3Tj0VEJG1qT4F
	 RuGLJNysMAPexKJvjb/oMjcXy1X4XUYmRPMJ+q6a1WeVNTBiBPWZYqUPCQ6bOOZMZPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=fXBFAZ+S;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A502606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 21:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A502606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=fXBFAZ+S
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-71ad2c6491fso2588366eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795469993; x=1796074793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+PDPXDESs/b1ufFkIbKI7h6YPsn4ue61XHoi6R8yv0=;
        b=fXBFAZ+SVNzrG0yNXlS5/astelhy8/7yExaD1VmjcQ/XUyvNUu1eVWiJcwCBEkZXil
         pvfTo2USrfgCS1UKDAE0ulZz3mWt8/qptFeyhQ08FcVGBGrZ/NwO5ZAVXUJBjdy1JIup
         8CVMKQdD9cu/v+EUCIDLEhTu4uMFB6gAtRCFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795469993; x=1796074793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+PDPXDESs/b1ufFkIbKI7h6YPsn4ue61XHoi6R8yv0=;
        b=F9nIZ2nQ/PdctvA5hb+cw2BoI2ro0cEfcFYB7A+labGXHxQdzyVXCCxYB36BIWCsW2
         fmY/4quxsLKKxn54fIjY8xq44dWsSeparitaR3oPVFEVf8zOnYaxLfPVIvXs7I+TmqAj
         u/cz+oW882tuxIVeDIKWqAov+UF5XnrNRI1dn+Qc+H1jRMOz3/xfV/GII9DXLwYzXkNI
         XphIWI4y5oC2Y6pLBAiNDyxTNuj+xwr3FMCtkoZM70+A865gIdCekonZMPvU4CCASkuq
         mq426OE/0zdMoAntuhpzROxGFo/P5xnY7/sTXOk1xUrzKF+5nzMHanCEyo1t0UI/vqfR
         1CTQ==
X-Gm-Message-State: APuU4Z8Lmo1drn6RAcLccGTvO9CkB2R6K+Y78eDJJxglKF7OEirbw1TE
	x3WqzjuTPJpMRn9W7KrPUf5EbFhz85rKgcKFgdCm0+4OxMur5WLkdyT/tgqBH1LoHcU=
X-Gm-Gg: AZFdTZeIERRHFITO2sCQSL1MTDqQR1qa45yz3peuz1Uwc2UuT69A7b80D4IkO0d35tQ
	5p9x7KN8ybCjIuJZYaQ84etUsL1ABOqsEnTpTK/AufKrbex/TujaXBTQqjauSlZNaDckXQ9RkkG
	ZIqi1rKEIw4fq/r7xbyU02VGkuEVqv6k43LeeddOYfgQ2kPtoayiW6kCSiyBxTHx99RRqJQSs4Z
	Nm1ONrNv+0fJ6eX2RmJrqiZbBWNGdzquTSwfh3Wk5RSlZug/nufbRNxFA4kok8zjBgI4/SX6aJn
	JlWhW3TUoMtnEPEuHy8yRHrBbPuUlt/g02MCUDDQpImNgmb++TjSlhonCI41cuXVpp3uFTGu85S
	oSiQcBQLOZ4UhpqJkDXaKoeBDPjr9tkZH+DKJiS829eJSrdBsPScONvdZopZJKg6XEgpq1+eVuM
	mr7H1OA3g0fjnP2ieD8/VQK7hiT945ieDeBAPfNrP8/A0FsiRFdI2/xmyJuO4FWp8sO2JdKLczJ
	Y9unu+c1mQOxoUu6wBXWAFaWhLqTfHD1/qR/nk/6F7BCPUANZKyRcsa8zBS2q294BwLYiNdRGm/
	lp8DtAIt/WfdB8I2wvRougJncwXAlJaJbXJgHg==
X-Received: by 2002:a05:6820:4515:b0:716:bf4e:4558 with SMTP id 006d021491bc7-71b394f4d53mr7216089eaf.20.1795469992803;
        Mon, 23 Nov 2026 13:39:52 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380bdff9sm8213426eaf.11.2026.11.23.13.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 13:39:51 -0800 (PST)
Message-ID: <b4e4fa4a-2763-42da-ae9f-3ae65132f678@linuxfoundation.org>
Date: Mon, 23 Nov 2026 14:39:48 -0700
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
Subject: Re: [PATCH v4] cpupower: fix use-after-free and stale limits in
 frequency-set
To: Lukas Beckmann <lbckmnn@mailbox.org>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20261120-cpupower-freq-set-use-after-free-v4-1-928675d53a23@mailbox.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261120-cpupower-freq-set-use-after-free-v4-1-928675d53a23@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/26 15:17, Lukas Beckmann wrote:
> do_new_policy() directly fills the unset fields of new_pol from the
> current CPU's policy. This is problematic because do_new_policy() is
> called with the same new_pol for multiple CPUs by do_one_cpu() in the
> slow path. This results in stale values in new_pol being applied
> (starting from the second CPU that should be changed), and even a
> use-after-free (for the governor string).
> 
> Fix this by building the target policy from new_pol and the current
> policy in do_new_policy() instead of filling the missing values into
> new_pol.
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
> ---
Applied to my cpupower branch for next PR to PM maintainer.

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah
