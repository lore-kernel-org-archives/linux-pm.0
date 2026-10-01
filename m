Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87D4A5EBC
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848717; cv=none; b=A2r/pqtCooeH3Gn2ub6XWc4xcQl3qVpwIqMgpT0jdtqlK4EvJlQhsMqwqQhTTqHYmveavCj/tx+/AD9/Sg2UP/cnfuFIhSq20joy35FS7MD487U900Z6GzJB7uxLZ0PeuLxLxLAb7q+3N32k1cH+eErwsorzyimkybyPJ3SqFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848717; c=relaxed/simple;
	bh=FXxGXjkhNGEXZqrrH/byp0zQnsvjNHJfBhA+a5G296U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kboZ+g6VBIuA+iz7MAeTNtKiX4zMq7QN1VvIR08wRuORxF8vZ2QCfQ5kgyoQ74wg1d6sHV6iN0XfPSMlePbBQShJ71aDWLXBtR87jO4aVP7LmkgXQjWHBgBfEaKM2eBtJ6gFuZX18AIxc17tjZCzqBUtN14szKCip6cRP8EvWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MKYToTiV; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKYToTiV"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b223602d7so2171387eec.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 02:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790848715; x=1791453515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0p+G5kuRzezJoiYkU/GdI56ndmvFnKYEbf7hSebGh+Q=;
        b=MKYToTiVEsqTAiQw0n6uKeKMAUiGdXYozWjBpltXt7kzFzvwcbCaorisH7ByiCpayq
         n1deHFq3vJ/sf4B6dQO8UqLy7D/QC9VsSAx+5yFZrrxdrPJYqA27gsDgtIt56uEIaTif
         G/w/Dtsx/NIRx5fQiu7qCvkfQYbejOZtbm4+HzGG8Ra6WRJv9Hi/3/l1+wiSFXgYN26Z
         eSPFdPvZJp5oFRYkZm5lRaLKNKh96kYpIznrnVNrUA52TdS7kZwwPQCK7z48QA/D4oBU
         9mPHNGq9Hqj2gYGf7TF7ARUQrmW3PF6s+p1mFWAizaIWjOk/KqegDZ/MppaMGWNhQa4y
         hirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848715; x=1791453515;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0p+G5kuRzezJoiYkU/GdI56ndmvFnKYEbf7hSebGh+Q=;
        b=iU4mDCREp1/i+eLLa4VXpE2tDHF7bMu1T/nq7zSKvxSzG9UL2NBmM+a4HTbABu24oH
         w6Lcx4/W6FaZ/tfWaTA6GK7vGCmNs85wrzRsVDuAHierlkQDqu12jzmfXwhNL8GJUJCD
         YOHGE/aoPZOMT64qfh1JRbC6wjKaDToVLY900E/DzMqImT8NBM3qb4In3z8GCL76kUH0
         Eee8BPTMs67cg0srZoOfn+3dcvMGhhtUe+Hu/LIQ7URg6N/CWuq+LZgxKcxGsa6BmUFm
         SIJLR2uj7dg0q8AJ2Uzow+XaOA67c72w1Z+7XZhvCIaqjZksuD8J24tvtQ9XofAZO9/Y
         qSfA==
X-Forwarded-Encrypted: i=1; AKwUvByHs2XtS5qW5BMh4yBcQGE+K7uTEYga6/Cs3EF0gTb14C9+k0+7ONnkQvXxExKngbv46tjWhkqZLA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKIsOlECxRDjv7x2Ld2hEref3+gAN+XHSqDeD2gXDFor8qgFDaA
	WB6a6SC1/msuUeXyfO0Zb1G9p9z37tm71qVKMnMQuRP0N1SwXCXGpopoDmddm1WqoGs=
X-Gm-Gg: AYBFou3ubTT7SBEZD/xzzaEyFhf28MHxw+DzwHcw2tdQNpDaOPxSdDtyga3uqlaV8lv
	L6xubW8ZBNtfwy6Oghq8LKcTlmrPhbmTKJFWax+QtW6FEq5Cj4avZKuMPBabP0R3urGLE16fLqk
	2qVcylr3SPm96DLjzo/LUBD5htQQwHmtPMzRAZMpzjvcu5StYV5kMFD4uIrOqt7R4NBkWjH/loA
	zeh5IHd2h9HVkN0GFX6oXlRerOi/+NC9we4eD5GMgbMfAR682zDcRNID9N+zN81BU2vyS6RbNsD
	QmpvotJV9BI6FBG8kaCt0xYpd1xlSnr1spqcwWZfeUmlPvo7c0Ha4d6UFxzaCBkG/YXPyQF9qEW
	X+qhMuV/7/Z8E9ORbHNo0SvRO/C+Ys7yqQdq58/npgleQJXngrKpeK/koMwQzwKp74gQqT3D8aA
	yDcjJBUwda/Vkhrj1SN5kOapQCV2bSVX4EmcQiQZwXrFqUzTc7uywFxNOJVOZuwJKlQiIY7rie
X-Received: by 2002:a05:693c:884f:b0:34e:6ffa:ad6c with SMTP id 5a478bee46e88-34e6ffab5b3mr769959eec.40.1790848714758;
        Thu, 01 Oct 2026 02:58:34 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db491fae1sm6397324eec.24.2026.10.01.02.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:58:33 -0700 (PDT)
Date: Thu, 1 Oct 2026 15:28:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>
Cc: spidermana <xuyiwen14@gmail.com>, miguel.ojeda.sandonis@gmail.com,
	a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
	daniel.almeida@collabora.com, gary@garyguo.net,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lossin@kernel.org, ojeda@kernel.org, rafael@kernel.org,
	rust-for-linux@vger.kernel.org, tamird@kernel.org,
	tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v3] rust: cpufreq: reject NULL from cpufreq_cpu_get()
Message-ID: <ar4ux5SVxjlzTGvL@vireshk-B250M-D3H>
References: <CANiq72ki8M1KmxhO4vSkMUfLcuqOMvZtuTNdDpS-UcJy8rqWpA@mail.gmail.com>
 <20260929095539.1398671-1-xuyiwen14@gmail.com>
 <ar38vCqqekY7T3SZ@vireshk-B250M-D3H>
 <DLTEONSHWRPQ.1U2Y6GDBRURFX@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLTEONSHWRPQ.1U2Y6GDBRURFX@gmail.com>

On 01-10-26, 12:49, Mehmet Koseoglu wrote:
> I see that v3 was already applied as 0ba1ee052b3f. Would you prefer
> a follow-up patch updating the SAFETY comment, or a v4 of the original
> patch with the comment update and collected review tags?

Oops, I thought I haven't applied it yet. I did that couple of week ago before I
went on vacation :(

You can resend the patch and I will apply the new one and drop the old one.

-- 
viresh
