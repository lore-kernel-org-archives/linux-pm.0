Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B13002CF
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393588; cv=none; b=oWoPzyLk0fy1+aGcceYlBApzFPFz40x52rr8tz8lJe35GCrDsPXF5fSB0IUCSHd1xZA2E8fLGbLHd6ArfckxFuscgIyyc4DNK0XchUZ7o1+VADaeomnIrGmwVTxKfySjiZewBnE9q1GF9f7rUF1TPXNh3C38OChWd+Bs9cmYu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393588; c=relaxed/simple;
	bh=gahvnRc5eng9OecdKZa0NTmtTxyy8exp/j8DcheZcmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LZ7Cf+LKiHdhdZdTaY8Bg+ATlR04dyKGqhIGRle+SDTLacT03Bvws29lfKNw1DxcPOgVWCtd+tyOe+ZaraowDpAIFVn3NeKDid/gWvLvnAr2sDiF/qpKXB1Nl2ftYJWTqQcsHiRRI+8u+ynFXCoYw3uZbvqHHKbe9/bRgyS3zKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ihklErjs; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ihklErjs"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-463a0e14abfso3045780b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 16:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774393586; x=1774998386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1Pw8o5ywofZ7M4GWTN9JsRn0ffunpoWBvxl98aPjp0=;
        b=ihklErjsoA6PXqB9LPNq4NpB4TeeE49q1X8kzSD4x8wGnVDaHqQvDNWo5JwxhIPZQ/
         wilM4arJdRAGS0UVCwOmMVuYSjlyIobxFxmjwDXGIiK9jKDd2UhynGL69mhqblOV7OwT
         JYSecaXV0ZYacvZZUJKUkbmMfBE56v+TyTn6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774393586; x=1774998386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1Pw8o5ywofZ7M4GWTN9JsRn0ffunpoWBvxl98aPjp0=;
        b=kv1az9ZaEQVdn/zXIrkGd2ZGAczB97wuu9+0pc2SlRb5hOE2tz3BadwKmaXcpe6KGi
         hVIYgbeko8fDQYlNl+MC/j7GhgdrtVR/gXZmKoO92T74MbIgGZrWwpMamtkA/WMmNl+o
         OvXTbLB+BnUUmyLVfKWUAvS15jjwWgghPTQTsDAUM+fQCDjSjDeuoxlA1SwGdIxMrdd8
         ui4MowJqnGyWIsVj37EvWPx6iGTF0FlqC5ej3sqCcxYaxXm6Pb3i5VcXclZ78PYh/jal
         IzgTYkl8xtzqQ177vKGJ/9xdruoRxybRVfQjgJ8lA9kKt9IXluyan+u+qa4MUFN9U0O/
         MONQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcBAUVASlsHSgCiUas++JGflUrV5lCCah/sYOCmC7ULeyeLbWucd6zFkFc3hiVVSLgSq7vKyFt9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzekVHyRQ+nZ1wK3Pc2Wg+vUWCB2KRFGiHmsAN5Ag9j1FLlNIoX
	XxgLlX5ntP5dyy++mUH0Rzr9yf43QB1ibEVM6xSlHIskoSXGmdM125nqbQuzYwuzHcM=
X-Gm-Gg: ATEYQzy5RGr/CY+bTyywYU0zKmuOOi9cB7VfCUC3eUe1YoJGLXFpWkoZcudFDaiutTx
	7FOcXIElGyBMvDj52zqYU59wtyX1JYA670fOshpraDMXrTjyOnOeiuH1mZsAwWmEzyiSAKWwYuo
	VLXRriI4g72QDcgGo6Z0s2hSi2bv0QvIgYDm3mqwpORoIvDXGs+93vNJ0tcAASEvkzBm1wR1ciE
	OqY2+AdL2XwI7b89wKd7bV9hIhfpBTa+pQMYnDTmeel2JjV7QyO4NscR4hrsroBbNNDJyw40NTc
	BVvA7Ev+qgvlOPV7YenXNuo6TwZ8KQh7r+4Oae/FTRWB9vlu2JY79Mns3e06ypdSVJT1EO5y2lG
	qvOsKyrp0ZY9r6+Iwy+lR3vjAvJV9MsY0NnZ346sOz8cvXa/ifr6EM00qbzDl8ivRbykHkbLFL5
	0A1T2K2UwXUpxWmOj6tuAGIIW4QE2jro615PngDB3K3MxyuQ==
X-Received: by 2002:a05:6808:4feb:b0:45e:6697:f983 with SMTP id 5614622812f47-46a5c5858b3mr690171b6e.5.1774393586150;
        Tue, 24 Mar 2026 16:06:26 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7ecb7f7sm8958144b6e.9.2026.03.24.16.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 16:06:25 -0700 (PDT)
Message-ID: <32cdfa7a-765c-4f74-9839-d2e0b01435dc@linuxfoundation.org>
Date: Tue, 24 Mar 2026 17:06:23 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] cpupower-frequency-info.1: use the proper name of
 the --perf option
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260324223921.14317-1-io@r-ricci.it>
 <20260324223921.14317-3-io@r-ricci.it>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260324223921.14317-3-io@r-ricci.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/26 16:39, Roberto Ricci wrote:
> The cpupower-frequency-info(1) man page describes a '--perf' option.
> Even though this form is accepted by the program, its proper name is
> '--performance'.
> 
> cpufreq-info.c:
> 	{"performance", no_argument,	 NULL,	 'c'},
> 
> Signed-off-by: Roberto Ricci <io@r-ricci.it>
> ---
>   tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
> index 47fdd7218748..1173d4f31e69 100644
> --- a/tools/power/cpupower/man/cpupower-frequency-info.1
> +++ b/tools/power/cpupower/man/cpupower-frequency-info.1
> @@ -53,7 +53,7 @@ human\-readable output for the \-f, \-w, \-s and \-y parameters.
>   \fB\-n\fR \fB\-\-no-rounding\fR
>   Output frequencies and latencies without rounding off values.
>   .TP
> -\fB\-c\fR \fB\-\-perf\fR
> +\fB\-c\fR \fB\-\-performance\fR

I would keep perf and also add performance since --perf and --performance
work - it is lot easier to type --perf

>   Get performances and frequencies capabilities of CPPC, by reading it from hardware (only available on the hardware with CPPC).
>   .TP
>   .SH "REMARKS"

thanks,
-- Shuah
