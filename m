Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2D34D3B9
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479238; cv=pass; b=M2rmT4HD0xSIn663i7UFG5J8BAiyXGcpZQjFFDxmxezwu4mV5CRj3HFbMKFJx5fMlwrHA6Gw+Wb/QKtOPZA1b88D85lyppvRB+w44VVzatk6QrlT2yBs8QfGCWTQx5lwUkUUtAgArpPRdFMsOCVZ2hXwCAo7wa+DBWLR/ESn3P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479238; c=relaxed/simple;
	bh=QqDI6Bbid4Z5TSJM6uhAIwDVDE3XcRkTjQOjWmVeRn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayPJP0fupBGmfNbFdxzxG/o3ChI0cIWb7+yQH1mjWheUNaE0v1b/9JE0z86y/ttndUE7VqeAN6o31s8leDcQHumPALpJ4qe7MsFerq1O/A8Hr7+U31f2dFVQzCVknjt2zlEjEPGZx1Dr1O46ETUZjdXdFB7M6tXTo0wX4J8Huo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjskiTdX; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjskiTdX"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ac4806e210so32513937b3.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 10:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791479236; cv=none;
        d=google.com; s=arc-20260327;
        b=ekDgrf38l19rq74SCHsqefnd5tXJffAsqsSe732ys0DEpRdOMQ2258gpZ+Kkhe6ZAy
         3WfTjMGEGon7x0CDgOX5QdxZTZL4WZut8x5kvxsO+aqSGRQozXLy+xARpP+/FIkqChKA
         EaGHcQajHIbYgbZJ6MOCaBbf/TGj11EyCxq1OZyJ9CKj23zDQydbKvKpxzylEU4PijlK
         ra7Yvg4MxeaXY3LeqRfyzjOhJtFzoGoziyikDzSfUnua5XUgrQAbhC+Jhwm+BwxgBHbf
         Gc59l4My+qn6hqbG0i9ZwOG2SMU49mwxRCFzTZN6sjt90m5V5QZDsfgsCzOW6McDgBG0
         RlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2vxAQYqUPu2IyOv6/hcaTpeROBNAxx/kWZ9+SB1EYqQ=;
        fh=PNSsGid4NJlZ+NQ1YuGV9ATLmDRvkdIu3y026uCm4Xg=;
        b=hBDsDg5cboAKwqqczej0Xhx8M9NBrvQ277DTKXXRRUjE/mxpQS03Y3jNmkIsq27jdT
         LcFOsLrNUbw+o0K0UmiU4fWawJIvfF/ZcmtcLRxAJXAMkX5mcPHDtAHqM/UPx0eQUkGi
         mKGfNPMME9S7bsQhguYFz+L/8Dux5rrJ8Vy4AAlATrVOw5FGGT8F3N3913l3ZzYqr9X2
         NCbsd18TCFR35n3MRIRzJangRsR9JvIPNureD+tsCJbLgpmVafdG9fQ4O3HY3eVVZn37
         3NfCBz/8L86RItrnSZDavlJja/LVmhyAsRR0a9S7yRAK98CSnJ69kMZHNg9wU1VRpwSM
         L4rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791479236; x=1792084036; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2vxAQYqUPu2IyOv6/hcaTpeROBNAxx/kWZ9+SB1EYqQ=;
        b=CjskiTdXhMBCOIOnG/ji8z7M7K/m2VM8bxynqze80Ch/Mad0y202dkdou7i8ZDrmGh
         pLXt6tEMMlu6isPmJjYONw0zlbyXN57WCSfJK2IqcD5y9CXWdpou684S3S3UefBh8m08
         d2fyETfcYmd/aBr6Fff9lHWFaF9d3TIbPFf5hE2ZYufrgNTosPdvW3Vws0Zn2h/+2r80
         wssMtraSEYY4zJmFsPiAzFjNq+j3E1lRC5s4fLoNSHhoYsIgrzDHSyjl5h+YzswXRf5c
         hEHXMo0+NUFC5JKAFGzM2Ff/yA4yX77jDoyM66BbKKiZWRqsL4WIOtSXFu5Y8BZjmozm
         cU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479236; x=1792084036;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2vxAQYqUPu2IyOv6/hcaTpeROBNAxx/kWZ9+SB1EYqQ=;
        b=EyUYXIOJiPAV1do+aEjnPtn6468OYIfOgfrHOziEqYdKmEt/AcNmSgTsYscYO5vokI
         3r4M2DBM3UtIUT+NjrvbdjdqHp1pCBQW6KH8RuxePHWqihS551CykytaFS2AiFwJllW2
         DdT0XjYYVzURWAzxqu//ShrWkDMo4bTxsLAnBdjq7dBSAgaQNdIRFtiFLTP0+um/Nrkr
         mXnQHr6jGHLKZF1MF4vF/GJGe41KCJWkTmzJRXDp6wcyG/TlIbDBDFjOiD92ky7Aj13i
         ZI9n1/vzckKmDLyqx5511yH6VQDakcN+KaA0mbOPVYlXGgWjbwG1Lg5JxN2QcuaTmal2
         ATJA==
X-Forwarded-Encrypted: i=1; AKwUvBxfLl4i1DQIwRJAleQ+ZeImDp2jlP492UAiWeVY6ebUCKFC9yXYdNu1p4KNcZFk1BBIBxuHLGq+/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKMRxW2BhEd3njoekpJe480/9WUeQuzOkOoFs/9HDwoxQjfn8u9
	2AiXa8RZkNFqrQX6TDu4zRViy6d9fEXLMGBGYu5TKMY9PdOplH2Qv+wEejQG/edS9HlzEibb7er
	B2Sp+n0zxk+kjTGKWSw/v3VRIvzlRrTPkgrOwoY0MsA==
X-Gm-Gg: AYBFou0CaEaxP50rjxUvTqUrbrNhusOV9TmG1HZ/jpBse2PYmDBxTy8u+8OQLJTfgGP
	wxBZxPSc3gcDMZBIuqzjErzr/nCoKY+i7YoSq9ZLEwbJrXcX0PjcOvQY/RkYPSJRSRzYTsZk7vE
	zCpqhszyRX7yB6BAc3q64zf2QXIMTlUcJYZkvhrq85T1iuMXVXBSRJz+9Uxt5p3h0/743OVVw8X
	mFC7lt0DgqNxMTf+8Q1ZRrlJBM65Bkagbgea0+CWoEQWGmBbpwM3EnJuVlskuqBaNegCgQf/950
	eLgUssw/zGrVZkhihGpdhO6NPF+yz6DpFoHZYJ/ElU9oWNY3x5PYFwcnUzKtqYC5zhV9MGJqGxx
	4OxxEoCD19AOsYG0answCXKNKaXckwuOxctTagggeGZdRFZ//vHtGv4c9YhMyfMfntLT9IKHlJ9
	3ji6j0Pcn/OFLHTTV7QHkIk6CwbYEXkovFkORDCRCLXjcjucWXRu7FVAxA5IUhKCC/qDDpKQEUU
	BRonmyNXdlJDJqSNwrZ1TzaOJbaRcpzo5HIjpDEXaStVwWjHz4oYNsLkFH6CcK03XOwpQYjHbAO
	3wWXJ6EiTtQi0pfh2CsQPSPOrbHCMNo4FnnOXenutf0lvNlfwdsup1uvRXh/t0DsK1ScjG4+gYz
	hhEyLx1tDkvValJTclJMRS7MXdllIYn9bOUtFateHF4jaTN3uDOahhl4uhA0Mc4hB
X-Received: by 2002:a05:690c:6d84:b0:8ae:b617:7113 with SMTP id
 00721157ae682-8b05ae92339mr32919307b3.6.1791479235462; Thu, 08 Oct 2026
 10:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008132532.1155166-1-matthewg@nvidia.com> <20261008132532.1155166-2-matthewg@nvidia.com>
In-Reply-To: <20261008132532.1155166-2-matthewg@nvidia.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Oct 2026 20:06:39 +0300
X-Gm-Features: AclHuK_axRHHNMJXbXP5qGzIg8glDqrcsSviR3SuESczjar1LzYO3sHRH5FmG7w
Message-ID: <CAC_iWjJJMgTCPwmVA+vhDq+qfh5U36TbBiqyzPaKeDxTaYjqsQ@mail.gmail.com>
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
To: Matthew Garrett <matthewg@nvidia.com>
Cc: mjg59@srcf.ucam.org, keyrings@vger.kernel.org, 
	James.Bottomley@hansenpartnership.com, linux-integrity@vger.kernel.org, 
	rafael@kernel.org, linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Matthew,

On Thu, 8 Oct 2026 at 16:25, Matthew Garrett <matthewg@nvidia.com> wrote:
>
> TPM NV indexes can be used for various purposes, including using them as
> PCRs without depleting the limited number of hardware PCRs. It would be
> beneficial to have one that's under control of the kernel in order to be
> able to prove whether certain TPM operations occurred within the kernel
> or not.
>
> Reserve NV index 0x014c4853 for use by the kernel, and filter commands
> submitted through /dev/tpm* and /dev/tpmrm* so that userspace cannot
> undefine or modify it. Blocking definition is more awkward so let's
> allow that for now, not being able to modify it means there's nothing
> interesting they can do there. The filter simply validates which handle
> the relevant set of commands is referring to and returns -EPERM if it's
> the kernel one.
>
> NV indexes are from allocated ranges and this is a range allocated to
> Linux, so there should be no userland depending on the ability to access
> this - but let's gate it behind a default N config option anyway.

I think the idea is useful overall.

>
> Signed-off-by: Matthew Garrett <matthewg@nvidia.com>
> ---

[...]

> +static bool tpm2_dev_cmd_is_blocked(const u8 *buf, size_t bufsiz)
> +{
> +       const struct tpm_header *header = (const void *)buf;
> +       size_t len = min_t(size_t, be32_to_cpu(header->length), bufsiz);

I haven't read the entire code base but don't you have to check bufsiz
and make sure it's a valid header before dereferencing header->length?

> +       u32 cc;
> +       int i, index;
> +
> +       if (len < TPM_HEADER_SIZE)
> +               return false;
> +
> +       cc = be32_to_cpu(header->ordinal);
> +
> +       for (i = 0; i < ARRAY_SIZE(tpm2_nv_modify_cmds); i++) {
> +               size_t offset;
> +
> +               if (tpm2_nv_modify_cmds[i].cc != cc)
> +                       continue;
> +
> +               offset = TPM_HEADER_SIZE +
> +                        tpm2_nv_modify_cmds[i].handle * sizeof(u32);
> +               if (len < offset + sizeof(u32))
> +                       return false;
> +
> +               index = get_unaligned_be32(&buf[offset]);

nit, but get_unaligned_be32() returns a u32, might as well define the
index as such

> +
> +               if (index == TPM2_KERNEL_NV_INDEX)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +#else
> +static inline bool tpm2_dev_cmd_is_blocked(const u8 *buf, size_t bufsiz)
> +{
> +       return false;
> +}

[...]

Regards
/Ilias
