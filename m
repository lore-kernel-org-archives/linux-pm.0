Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735282;
	b=O20lFlQFLkWMl2MT72y5ikiwOHeCbwJVnuLo7Wl7cDXreuVuHJd5JWfcci8WF6lILf5z
	 hY+a9jdYUWvPV4eRwLxn8nBpyrLDcfaIm+SMzlpqTCTMIFFpUqAU3iIglp0QDNpmAi3mg
	 ZzQOyp1ZZdvBeL1u1Q5mJqVuCwQoacvpqx2O4pjW22mAkoI5QCrPQyqI41x2pB0u7Z+I3
	 IDb62u0I3TSlNfxDCN7vihOykDyk/Rw9MdZKT1oWvjosK6POI46ciJ8ognvd7U+Sq9aWG
	 OM06P64usqYBDtpeHK9aju067M2IBqv60+NSmGMYTP2A1wTLYvoYUnjMa02q1u5en3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VXvJfI/dWhdkcdG1zI34QvgiZR0Honn8mj5uvJip0QM=;
	b=oimUpd+fzfHvXIIBtbH8ErFhCXKvW7nsg55P33cuhToSG8MYqBglba3z8G1E+VU2KsvX
	 Psm6lSMzxWw8X6A8lke8NegfWXAZAx+rau0cXuUqxElC1Kw/olNQyfquqcH+bg79+TBYX
	 XmO0oyU++m8t9IIfGIN0WlamKqtxUlQdJqikyYJMtvfM+hk2HN5jq4m0pkz4M4kiSXnQq
	 XSQWt8Tar4vUAsPJCwga0QbEfe/Qk0jrPB1iJaEGFD7MH3YLoqgea+L7x01Gr7cLDopHs
	 pXPYMhXGcyrpv/8HRMp0fC/MXLUC/Eky3B+VAQb0OHy8pzZrBuuVWs/Nh02ybhWWDag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=H6WQJUUF;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1CD606A326
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 19:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C1CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=H6WQJUUF
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so9375c88.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 11:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793735281; x=1794340081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXvJfI/dWhdkcdG1zI34QvgiZR0Honn8mj5uvJip0QM=;
        b=H6WQJUUFlKKaWZ84UY9W3Yr2WFBYEWYpyd+D7n0FN+LVdGD+bRROnCOjYNVqMwCTQG
         KYs1wqIsKvXcB68tNuJZc9gxs3kXtfzgzdac9QURPRloGkktHfOgMZQB3m1puNKVTS2e
         A6GPY1DVBItpBXuSCL1joUHZR+cwVNP+Vg/CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735281; x=1794340081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXvJfI/dWhdkcdG1zI34QvgiZR0Honn8mj5uvJip0QM=;
        b=SKzB/y2WYBI7WMeEBBbEduJbT3oc1aVt4/blaGq8TQsBhLBRkLzCbSUkbLn9afX5Bl
         ffDWOzZrf4AxugT8CG5U0mpPGlNo79GkyW3gPMGiES9sXdXcw5eF6iS9mDwoBFvGoWBf
         D6npTEJb6ndliLEdE3N0WaQiB3nM/6NXIJvbkzcFDQBtNVpdFhBRgJR7DIxOmcDGckUS
         Gwl9zgIQC3FyvQ7H0u3ZA9litfg4QeoeTQ2foIV8VCTE7HkOSmEeo5b5S57X73pz6s5n
         pn2GAoz8zma1wijCQ5SYr1fI2XwOxTw46GcEtW4tpCIvG2YYMt0J4HV50rKuRZBmZDg/
         YqxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwCcJtm/ZHpPFHnKwLRHqGMaN76wMuQHHiQowPcpziR9Qi90L0VYeqiA0eegsV3i8lz1JTAmQ/cA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9iTadDtNUEKQ4iPH1GUo1Ozt74lkGBakqhGof2Hv+mYdk7tNrW
	Cr18KOuQgAtUFo15TRCgRGdeF/Wxq3MH1VNQKAK0bsFiCRSd1L24ZvPk009d6Rum+w==
X-Gm-Gg: AYBFou3UvO2pJAIpWuM0xBcdtQ/ekuhQhIqCthlw4PELiRO2Bxu9bZrwJIYzJOdIIWj
	JX47Cxio50PsDjaooPlL4yy0MeBuKisg+CU3lJOl2959qdXYm1KxXFe2v1qSDvz+wdn9eh3tSJd
	hZYR/jK9LDXwmcrUfkMWZxve6rmM03AoTJNnv/tcwoM1cDHN3dnHXJmhWLNp0tYxQaLWzGtswXl
	RuiVtEKrGSUPGvp+M55n3E3NUELOVOyZZErjKSNj8hL9xk6qZJkpjGHR5P5jraL+8S08Hk28UNB
	SovGQMHDopRt6Qw19+khtFCQPQhNPePi2Jt1oVJS+wbIdc/lvG1cCbC3BPvTZafJiucu3SLsZDT
	278GIIUpGueIkQrpIUMDGV3OmF1Fv+/ipjA0gYgDPST0APnVeVp31IcD6GjyWHZ4nFnKHXeJ05D
	IucqjsXbxvDSusHg6gq0DsaKqMiKgyuANgdYsOMMVMe+BK0pWOdDh4UXfhy50lHw4tPia0uwoJD
	NoGbZW22innv76pNUIek5bgy7odxB4Eepk7+viJmfraFbp7f6lWsxpEn9ds3WIYzjsm48z4a1Xd
	LLZQ310kdizG2r6uzBWrqTs54LqkG/QbAyu4qyYH/DE2u9VxZpty46GyN04zBE0dzm4=
X-Received: by 2002:a05:7022:e807:b0:1b2:4188:840b with SMTP id a92af1059eb24-1b2418884a4mr3582177c88.25.1793735280597;
        Tue, 03 Nov 2026 11:48:00 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245c463e9sm1010564c88.14.2026.11.03.11.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:47:59 -0800 (PST)
Date: Tue, 3 Nov 2026 11:47:58 -0800
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
Subject: Re: [PATCH] PM: runtime: Update runtime_pm.rst for non-fatal resume
 errors
Message-ID: <auo6bvjDtwAMKOid@google.com>
References: <20261029040005.2100005-1-stanleyjhu@google.com>
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
In-Reply-To: <20261029040005.2100005-1-stanleyjhu@google.com>

Hi Stanley,

On Thu, Oct 29, 2026 at 03:11:45PM +0800, Stanley Jhu wrote:
> Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
> suspend callback failures"), rpm_callback() no longer sets
> dev->power.runtime_error when ->runtime_resume() returns an error.
> However, Documentation/power/runtime_pm.rst still states that the PM
> core treats any ->runtime_resume() error as a fatal device error and
> refuses to run runtime PM helper functions until the device status is
> manually reset.
> 
> Update the resume callback semantics bullet to state that on error the
> PM core resets the runtime PM status to 'suspended', returns the error
> code from synchronous resume helpers, and leaves power.runtime_error
> unset so a subsequent resume request can invoke ->runtime_resume()
> again. Also drop ->runtime_resume() from the ->runtime_idle()
> comparison of callbacks whose negative return codes are treated as fatal
> device errors.
> 
> Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
> Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
> ---
> This updates Documentation/power/runtime_pm.rst as discussed in the v3
> thread for commit eef1d74bf88f:
> https://lore.kernel.org/r/CAJZ5v0ga8qqYg79+hQVtO8T=FOCj8XLmTz3HpEKoOykV_K-HSQ@mail.gmail.com
> 
> Two .runtime_resume() paths assumed the old latching behavior:
> - blk_pre_runtime_resume() (q->pm_only underflow):
> https://lore.kernel.org/r/20261029040001.2100001-1-stanleyjhu@google.com
> - __ufshcd_wl_resume() in UFS, where after a failed resume the retried
>   resume releases the clock-gating hold a second time:
> https://lore.kernel.org/r/20261029040002.2100002-1-stanleyjhu@google.com

Those need a close eye, as the code involved is a bit subtle. I tried to
review, but I'm not really an expert in those subsystems. (I'm also not
quite sure the second one was 100% a regression, vs further exposing an
existing underlying problem.)

> Should other .runtime_resume() callbacks that undo suspend-time state
> on failure, assuming no retry, be audited?

Sure, that seems reasonable (although difficult), especially considering
you seem to have identified real problems here already. I don't know
that you'll get a formal sign-up from anyone here for that work, but
you're free to do it yourself :)

>  Documentation/power/runtime_pm.rst | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 40a5c23d5259..04dc2a538352 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -222,11 +222,12 @@ what to do to handle the device).
>      I/O operations as needed.  The runtime PM status of the device is then
>      'active'.
>  
> -  * If the resume callback returns an error code, the PM core regards this as a
> -    fatal error and will refuse to run the helper functions described in
> -    `Section 4`_ for the device, until its status is directly set to either
> -    'active', or 'suspended' (by means of special helper functions provided by
> -    the PM core for this purpose).
> +  * If the resume callback returns an error code, the PM core sets the
> +    device's runtime PM status back to 'suspended' and returns the error
> +    code from synchronous resume helpers.

This part seems good.

> As with a suspend callback
> +    returning -EBUSY or -EAGAIN, this does not set power.runtime_error,

I think this is a weird comparison to make, for two reasons:

1) we don't talk about power.runtime_error anywhere else in this doc.
   That's probably a good thing, since it's not really something any
   consumers should need to inspect in most cases. Instead, the
   runtime_suspend() section you're referring to mentions "remains
   'active'" (i.e., can be retried later) or "fatal error" and "will
   refuse to run [...] until [...]" (i.e., not retriable).

2) -EBUSY and -EAGAIN aren't relevant here at all. All error codes are
   now treated the same for runtime_resume(). (I know you aren't
   claiming they matter in runtime_resume(); but the wording seems a bit
   cloudy to me.)

I think it would be better to flip the comparison to the other
direction, and deemphasize power.runtime_error. For example:

  "Unlike with the suspend callback, failures in the resume callback are
  never considered fatal, [...]"

> so
> +    the helper functions described in `Section 4`_ are not blocked and a
> +    subsequent resume request can run the resume callback again.

Looks good to me.

>  The idle callback (a subsystem-level one, if present, or the driver one) is
>  executed by the PM core whenever the device appears to be idle, which is
> @@ -250,9 +251,9 @@ call to pm_runtime_autosuspend().
>  To prevent this suspension (for example, if the callback routine has scheduled
>  a delayed suspend or determined the device cannot be idle), the routine must
>  return a non-zero value (typically -EBUSY or -EAGAIN).  Unlike
> -->runtime_suspend() and ->runtime_resume(), the PM core does not treat negative
> -return codes from ->runtime_idle() as a fatal device error; any non-zero value
> -simply stops the PM core from suspending the device.
> +->runtime_suspend(), the PM core does not treat negative return codes from
> +->runtime_idle() as a fatal device error, and any non-zero value simply stops
> +the PM core from suspending the device.

Looks good. Sorry, I think I missed this part when updating this
language recently in commit aedc51762a0d ("PM: runtime: Clarify
->runtime_idle() callback return value handling").

Brian

>  
>  Core Guarantees and Synchronization Rules
>  -----------------------------------------
> -- 
> 2.56.0.313.g2479322e68-goog
> 
