Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FEF31E82E
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111999; cv=none; b=q0tDjMnm3NXET31hz9IDpv89s9nyd9EPUMpHqfw2yz73ZNg6EsjPqJncoscrEuMq9XVI9fIHS/SkO4B03JzDkcPp3nN2cvNA1hLiSsuyRFjMlbZNcM3fhZ7Gd4+bnn7F16JzIRPosf+8XJ7XRdVqS2sH5hRHJQKpbpi2BHTPuCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111999; c=relaxed/simple;
	bh=F92uNx124eo6CuTR2SkIUKUgI7gi65kPAs8402itiy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1icd4dl/YXvWfO430Jy8OXMdpZgVKCCBCG4DGPr8twT1/JR5sSLSl6g7SvlkCsnwXV6HdlRlPcmVYCHlJd6gzOzK1bp/cZ/sNBm4eGKn4dChL/iFPLs/H2yewgw7ZT8pdwuXZt4ASrKjWoIslijamZIO4NZOoxiye9o4r7URZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qCS0O1Kp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCS0O1Kp"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so439086a91.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775111997; x=1775716797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6T2dQvI1mSEP2cZOOFDJ0349CayIDKQeIFznfl4/Jk=;
        b=qCS0O1KpJNMHd/67VjtW6zIlIkt6j/FcRnNKozor30Hs5OsLBYei+NkqMaeKXL2b14
         MqnuwNmfk4J8F8Y+kIB/8O2P8P/oD3E/xZ7larUvAa7yFN2NfYJdby/gQ8eQ8QGedt2+
         wUPrSWT5tVXqMAjNaAmwkLfkEFyhOoA5hAk+n3NWRnSrpdBydw96FpsZG37Z07DqfZGq
         Ivno4areOQoimLO8bJa2LL3L+iIFUMR7V15aWpjOPoUsQGmqQkhqkJVOX7pi+zywv/Iu
         lrjo7eEXB6vf++201TxqcwkBhQpdBd23AYLiXstQcZu2KJRhN9JFN6XXK7QLxrmCHsaR
         9vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111997; x=1775716797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6T2dQvI1mSEP2cZOOFDJ0349CayIDKQeIFznfl4/Jk=;
        b=LKtJN9YV6uD8szu6fRhM28CjeEGvTSXD1IFOzdeq59pLcgjMrIwQ+SVH4MOMfGuHSe
         pDQyhb1keS2GYhsy74iEkmrYJQUtRBnmkiTnpMURhBTn/fGDjNqOZrOVT9ZPa/BB2QMM
         pJSGbaH6TSztm8AH/xh57Hx3ldKRkl5pKQsJo946XoQvbYJS9gYbXzciNO39psEuPJhZ
         lZ1+LongsVG9cpFFqePCRuc9jP+/xY+jSEBHj6s0pO3gVVM4oSaSzdZBnnaZ05KM63pa
         GXig+D0UTX3P/oub85vKT59wnYmWsmKp9KqQgy8LI1cr9NQ8pnPj18xYYJ/m/9j12oCi
         CIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsDSv+O5+/VKUReJc0TEpgbAA+ptRNr0EiRa7j+T1/LMo+fQXStSLOK70u5i+L+mqyn47bOs2OVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRyMBZK7e5DBEOwYBfXkvoHiFJmpnVhvTvDReVytOxfNejluo
	s7xMmX8f5lWtNHdc3dyH5m3WclNCdpl6dShY0QwfvVKH9x1pMWXl8gAyKD18mZt4m5U=
X-Gm-Gg: AeBDiet9TqNXlQFtaln9F78OeV/yOcYn/NtqE58S5UiwT5Wib7PvGLOQwneT8CQ4/B2
	V/OVAV4HOrpBtLC55645MAZA1Q6fbonlbid5cgPK1O3DkIr42fzZoXraaUjrBotMJ09giOSCeP6
	u3zwZT9I8X6Psr/b/nqhu5iO/EQXknSj1Ds6Je8HBWhoCAH0ys7DmpC81dW3HH7ugeKMpax46yH
	DMPlfXEbmoz7FxLfGgbHq6zGYxKwhTlMHcVuskxz2d/GeMwmOba31WZyg2OCOXZPE60tW7/tmej
	x4OIkHOf0sROMF7BiLKdQEIDNbuBIgU8loFetZuARUiHbqjoXVh42o1n6sNHySCHbiM1A0tKJFa
	zMD7PIPnYVimZ9txGYVHnFUWjOaU/hyho0TMxejKzY+9B4c4LLRNvvXXKECOZ+gsw2AWMMYIg7y
	/K2asu0jKGqOu+oq0fMn3sXiIw
X-Received: by 2002:a17:90b:4c8e:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-35dc6f6a323mr5986457a91.19.1775111997319;
        Wed, 01 Apr 2026 23:39:57 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba54797dsm3316950a91.1.2026.04.01.23.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 23:39:56 -0700 (PDT)
Date: Thu, 2 Apr 2026 12:09:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v4 1/2] cpufreq/amd-pstate: Pass the policy to
 amd_pstate_update()
Message-ID: <4bwfgnjiywkm4dyslhzmk6lvar3a6rhvtcyyruc7okybckuwuf@mkdc5dlconx4>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-2-kprateek.nayak@amd.com>
 <hin33mzxwjjycw7oonq4klqmgmgavqpoe7r2ml6qalytxfpntk@me7d6q6yiec7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hin33mzxwjjycw7oonq4klqmgmgavqpoe7r2ml6qalytxfpntk@me7d6q6yiec7>

On 02-04-26, 12:07, Viresh Kumar wrote:
> On 16-03-26, 08:18, K Prateek Nayak wrote:
> > All callers of amd_pstate_update() already have a reference to the
> > cpufreq_policy object.
> > 
> > Pass the entire policy object and grab the cpudata using
> > "policy->driver_data" instead of passing the cpudata and unnecessarily
> > grabbing another read-side reference to the cpufreq policy object when
> > it is already available in the caller.
> > 
> > No functional changes intended.
> > 
> > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > ---
> > changelog v3..v4:
> > 
> > o No changes.
> > ---
> >  drivers/cpufreq/amd-pstate.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Oops, I already Acked it once :)

It is ready for Rafael to pick now.

-- 
viresh
