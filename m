Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB93B3BF3
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093072; cv=none; b=DHRc6MFWoYlugNlQOnYFWGEKnhQoz8hqRU/vimfIR/guf83jxJTn7iC3TZzagtp7F6vkYSr4QWbxRYeaCd1SnGWXtHGheLO7RGf5B9nXRtEQYY6N8U+B+a7aljgPipup5w/apuRt5aGGhLKm1PUqyR8h32ZIcOnhs+qebT9Cggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093072; c=relaxed/simple;
	bh=CDBhUD07VqoOrZ7JPoq0Co54wzQWjl/AWvxNjZvCjn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYx1Be74MMjGMYw87i6YA67dFhIqsEua1ez31EiaVN1Cx8aObfIEs+DZueqPGZ6QuuZ5chTjM6lZ3zR2ImoiP1s48jRhPiSyvhDJuFOTNHHzu1IY8VSrkMY/NPIlMUbjH4dBEafbeGdJ4qRq4Nmo3TPBfRQ3PJNYPT+W+pucges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDdRAS/F; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDdRAS/F"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso2864860a12.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 22:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784093071; x=1784697871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qkAQWsDtozfXBoNsWKH68JrBdyZXkRqVk9vmTGGiMwc=;
        b=IDdRAS/FyIOpHGdC7Bh7AFXk1Db0dVrcpGHwh1mm+WRfjBXnMotngKUWUjAnO0/d5L
         3QId5jwnCUP0uW1ExLwSkwX9ClUhvuhZf/cMbN+IDRs96N3VWK/HDZhe+BcW2KzRa/V/
         +81evVE9n01rbmUrRXqcfd8leEcG1VYNKVmmQVvJHN7sgVq7rBsJNA89X5RUDRSwsyFB
         TqTcDCXzhq2oXr4UinOUDMQFerqxeeYlzayTYhA2VaN7hr22yNpA+HV5jvr+wbRuL4qj
         OvW/AQJq69ETfknpKxLoxPQpvu00vMaplYwXXfEumF8aelrPlXtkEokfFzxpgKoLzTA3
         OmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784093071; x=1784697871;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkAQWsDtozfXBoNsWKH68JrBdyZXkRqVk9vmTGGiMwc=;
        b=VaQJoVCa33uxuk77d2Cr9t5Y2lkhWRLhhippY5Ov8C4U2oyQ384Hbi0jXag0DFXWKz
         ryzyT00HFWc1g/oRNyJojjkCC6icTILXKJOlN7hU1UtDwl2J+CrMpRaKqu6pgIYsehFi
         l/OPOzQpWz5nBwuXOd6bI9HHmaMhbQdoN1B4nC3DFr3naxefyXE/k8aQFGM9fwPDIYDq
         lILMaern0+T6pBLCOARFJ2AMPSlpWkHBC9RjDxmMttUEABfQKUDc0KC/dHPyrL4EFO48
         WFFa+vke8/fWoAWFa30Wd6nivqI6gZt4E9rqoCdG122d7psUmmyRIaijpO0ByIxc7Ol4
         ggaw==
X-Forwarded-Encrypted: i=1; AHgh+RrEDzATPz4tYuMJoMEYZsCwrJ22eJfYbm+LyHCNoZbnXWVkZLZgcsQUbv7DAryevVWwkzQNIZwTZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwihsvZe57QvHIfN37p7gtUff8lvtzKgSzEeOq1B8Qfi+Bl1yyH
	S9q5KCkG/3v80wRsSLJ+LD4bo+8AeAO0CoyucM1oUS+lfRQyTryIKIogZNs6D9/qr2A=
X-Gm-Gg: AfdE7ckWrbwaqHSH7PVsO/kdQw4ywkpjMp4mz2BU2z5qHF9/esZ8s1fFnUuUCrcQHoP
	eZOAX/rIK+S1yi8jOGUbB0wol1280M0T7IM+wLWvPRbpR1sxdbh7aEqnYnzXIBY6uEGj4ALzDOX
	StT8IDJ0iZ30xuh9RVz0wtoG/bNZpaieIAmW5GJBNA0jiGZIjKyh3yE19ENMUh4PA3d5JHWiP71
	41eKIkNvNt+nYRkKGI701CFUz2sQcKPJB+OpiZj7S/FxMbBaCW9r4gqRwgG1YS0I33KLiY0Kmu+
	veX3oVAWUHZDKKc5Q0ETR9xe4ydNdfR61gd84xjgcr1FIRxXplEHTG1hEc/PRz1GQSDcNOl3FUT
	/TxpEgSlVGXD8HFckHORrlYR+33MKtz+MX4Zr3OOH47j1kSSIt3x5vbt5yBvbmig0KdXGcCXL1W
	x3GuHGo4FCiKLE
X-Received: by 2002:a05:6a20:9183:b0:3bf:d62f:44e1 with SMTP id adf61e73a8af0-3c36c35d250mr1712601637.53.1784093070581;
        Tue, 14 Jul 2026 22:24:30 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm48176784c88.0.2026.07.14.22.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:24:29 -0700 (PDT)
Date: Wed, 15 Jul 2026 10:54:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: rafael@kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu, 
	dzueck@uci.edu, ytan089@ucr.edu
Subject: Re: [PATCH 1/1] rust: cpufreq: Add CPUFREQ_TABLE_END as last table
 entry in TableBuilder::to_table
Message-ID: <64v2tabszrjrgdi4ietcj5ndmlstbdudrhen3bvzypsermnikn@xjns562yfh6y>
References: <cover.1783548374.git.pgovind2@uci.edu>
 <833f1ca55f3709387804abe18e5759383ba7898b.1783548374.git.pgovind2@uci.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833f1ca55f3709387804abe18e5759383ba7898b.1783548374.git.pgovind2@uci.edu>

On 14-07-26, 20:29, Priya Bala Govindasamy wrote:
> The `TableBuilder::to_table` function adds `Hertz(c_ulong::MAX).as_khz()` 
> as the last frequency entry in the frequency table. 
> But the C API expects the last entry to have frequency set to 
> `CPUFREQ_TABLE_END` which is `~1u` as per include/linux/cpufreq.h.
> 
> Fix this by setting the last frequency entry to `CPUFREQ_TABLE_END` 
> instead of `Hertz(c_ulong::MAX).as_khz()`.
> 
> ---

Did you hand edit the patch ? The above line (---) shouldn't be here. Please fix
the commit properly and don't edit the patch once created.

> Fixes: 2207856ff0bc8d953d6e89bda70b8978c2de8bab ("rust: cpufreq: Add initial abstractions for cpufreq framework")
> Reported-by: Dylan Zueck<dzueck@uci.edu>
> Reported-by: Yuan Tan<ytan089@ucr.edu>
> Signed-off-by: Priya Bala Govindasamy<pgovind2@uci.edu>
> Assisted-by: ChatGPT:gpt-5.4
> 
>  rust/kernel/cpufreq.rs | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 58ac04c650a1..97ab97724931 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -377,8 +377,14 @@ pub fn add(&mut self, freq: Hertz, flags: u32, driver_data: u32) -> Result {
>      /// Consumes the [`TableBuilder`] and returns [`TableBox`].
>      pub fn to_table(mut self) -> Result<TableBox> {
>          // Add last entry to the table.
> -        self.add(Hertz(c_ulong::MAX), 0, 0)?;
> -
> +        self.entries.push(
> +            bindings::cpufreq_frequency_table {
> +                flags: 0,
> +                driver_data: 0,
> +                frequency: bindings::CPUFREQ_TABLE_END as u32,
> +            },
> +            GFP_KERNEL,
> +        )?;
>          TableBox::new(self.entries)
>      }
>  }

Maybe do something like this as well:

    fn push(&mut self, frequency: u32, flags: u32, driver_data: u32) -> Result {
        Ok(self.entries.push(
            bindings::cpufreq_frequency_table {
                frequency,
                flags,
                driver_data,
            },
            GFP_KERNEL,
        )?)
    }

    /// Adds a new entry to the table.
    pub fn add(&mut self, freq: Hertz, flags: u32, driver_data: u32) -> Result {
        self.push(freq.as_khz() as u32, flags, driver_data)
    }

-- 
viresh
