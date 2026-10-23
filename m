Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773839;
	b=dD0diLJ0xBdXFrN/H8+XFaqScwcM2SWdPByWzX2/GTvdeajGY0iWJTneLUPlikezLrll
	 qiTzT5IIokIqBA4/5ky/98ZgvzKF3mrZLSMGCVRE86SZI+8HKQ3M6iZgnotplXdaP/9I2
	 PezXTEhjnc9sPibUvyOJtnVIZUydgxp+NB/bDzHw8KmkvllEL5RfD0AMsmV3hOSrWjfBO
	 uItg+7s3iscWxZ7fZA3OFZAMH1BVupF82FAdV3H7rnxKNfhVQdmRYET0FuvI8E2Dg7sog
	 wXlLiVGP3QcaXdJ6296BBeo6BcuDe+dAfKFSjhBLkSl9d0yPSR6HuqIl9zebw/eLvoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IbU6AikASsymoWZcigm5KICcvIS1yLWM5oIUuCyGJFQ=;
	b=Rsztly+bnsrdPyQXeFC5LEsUyz3OTi7394AZcB9a5S/IRoC3hhANlJjuH3+GAOVgD121
	 Ru8EaLOdnvJ1vrkmpeoyX3IwXFSRIXNhjGosF/tsScnoagsdp2s0BzDpz9lp1jKwuDC89
	 FhXgKxIEmVd/kjjgLsm5NYpJ7oVZPrExh7FZlsHRhC3+eFwMNrzKveU5lpNXt3cPQOSQI
	 zS/Je7qAxvuKBiMxlzA6LYcBZtx4f/xs1B9JCPNQOfKQbYTFQkg9X76RcoTtuJ4aXEB0m
	 mtN23h+ylnkLzIZUdx7nzOvC4ZjL1v/ieAVkydLg2wJxfvOiRUU4SH9m177W1P6R1wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nzaU3ccM;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28334606A31F
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 16:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28334606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nzaU3ccM
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1846bc43c28so1197207c88.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792773838; x=1793378638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IbU6AikASsymoWZcigm5KICcvIS1yLWM5oIUuCyGJFQ=;
        b=nzaU3ccMU77AvpQXNcTtuC5WXz9iJYbaVtZBMgTXyyG4nq33Axd+wqILM/gXW5zNET
         qhazQYIP+HzqzYrlRqkWv+5N7lcFCV8ZT0hWkw+zBCfWY5kfu0Ibr+gWyUi6uquiA3DQ
         tt34Rj7EivfG9r6KIQ4lluL4+suBwLC/k9IQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773838; x=1793378638;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IbU6AikASsymoWZcigm5KICcvIS1yLWM5oIUuCyGJFQ=;
        b=sMz8wBcjA4VXJ1Px5MoyHVTG2mDV+3gF/Immbs/xFs6m2MNlB5EfxRvQM1SbmH3KqE
         Ox8iUTnDqkh6JNftlEK8dyuRn6fm1gS5LzmwhPzM54XdIahCA4hxip4Ic05scs3x1cL/
         lnOurE4y78Zgg65kjVu45qf3DRvrAWSv5dNy7gf9DW9O86UMjO9glnyf7zICy0aG7pGh
         auTtKVb8aPXJE60icrccW31WZ/pUfzEJ8GxloZvdY5CZFDEkR+iECnP5cvrf8Q5uUft1
         uQKcRrP+42ptG/w6NS4pcoukLxtiYYQt03fuGJwyul4cmIm7p+QFn2K94+8O2fpmxIiV
         oS/g==
X-Forwarded-Encrypted: i=1; AKwUvBx346pUGDKjBKL7sPOe/oAH/koXyMDQd+KwtvAru+453tXgcwcA+nptufrek2OYLPo4nyEl9QIh/g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLlB41xARam2fDfL7opK3qZLTjqFOiD3AkuedVjtfu3sdyf3xWm
	a6bHwHOBFL/X9kiJ+szalXyopcV7RsyJWUfgCM8ynvSQFNgCpZq2P+KhKsWJ4aTIvw==
X-Gm-Gg: AYBFou1nh+UQtgbd1joGHDg983QaKQ6WF2Jaj08hC98ys7DyiwuXEYr8dGVZeAzqJQ+
	VFOa+UfBFCFi/5AZbA8QSElzKboy2qPmnwWvmHnuLz42h4nHfZXM/fc0Jv3+Ngl8l6b3Z+zZgvO
	GwY3HLujlvU8zifNphSAub18vFqhoqpgTd7ZqYusKA5D41UjMR67ukf/9nyVl7XBeJUWOSAeAWD
	5hxPX/p8+mJyFB72xUS1uwBTxZJbvx4xF5cK47w42ztVj1LtG4gL5jOlOXuC3bMcw3uhdbJVqVv
	eFku3b8vCxieVpyB4kZVwSjmtEx7BOOAh2mCEaxf1UvfXrCwGZKR5KPV1tJEm/GxyN0upkxgIIn
	OS21D9HIz9B24bpMHdXLbc2DSZyrYqs+Gp6VVbxeedKQsaKvciu5OSe/JYTfi5m9YXSQ2Dw/2I0
	XeqQn6MPaGkfF04rYwzkkwU53+CLJ4eFsXd/QwFgpjus+I4cU1+7mnyfvUsWQRuNI3C1fe0ed4Y
	G3hQ74+8Fq/V0hqVrld8r3JBqG/FcC8HSCGI8HJ06+5TDFwie37qqcyuyCvaFR0tJRHlLi/orIv
	0/qALlUFSHTcrcxKClOZJgrqoTrIjvJX2LT1ROSF
X-Received: by 2002:a05:7022:4182:b0:144:fc5b:2121 with SMTP id a92af1059eb24-195c56ffe47mr4928192c88.17.1792773838113;
        Fri, 23 Oct 2026 09:43:58 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4a1d:784c:3fc4:37a2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-197e666f0d8sm1435609c88.1.2026.10.23.09.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 09:43:57 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:43:54 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 00/17] iio: Stop looking at
 pm_runtime_put_autosuspend() return codes
Message-ID: <atuOysdhmPRA7Waf@google.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <atm0umwtxZlQSAhy@ashevche-desk.local>
 <atpMNk6ymCpC5BL_@google.com>
 <atsEql7X20hGytXv@ashevche-desk.local>
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
In-Reply-To: <atsEql7X20hGytXv@ashevche-desk.local>

On Fri, Oct 23, 2026 at 09:54:34AM +0300, Andy Shevchenko wrote:
> On Thu, Oct 22, 2026 at 10:47:34AM -0700, Brian Norris wrote:
> > On Thu, Oct 22, 2026 at 10:01:14AM +0300, Andy Shevchenko wrote:
> > > After three patches I stopped because it seems more works needs in each of
> > > the individual drivers. Yes, the series can be applied as is in exchange for
> > > a bigger additional churn in the future. My preference is to see everything
> > > settled down in a single step.
> > 
> > There are limits in how much work I'm willing to do on a bunch of
> > drivers I don't use, can't test, and frankly have no actual interest in.
> > I'm sure if I spent a few more minutes on each driver, I could find
> > another dozen things to try to improve.
> > 
> > I can go back to the v1 approach (fix only what I came to do) if you'd
> > prefer.
> > 
> > Or, I'd prefer to stick with the sentiment Jonathan expressed in
> > optionally requesting additional refactoring:
> > https://lore.kernel.org/all/20261018211807.66bfea0d@jic23-hlaptop/
> > that most of these changes are optional, and that fixing 1 thing is not
> > a subscription to fixing everything.
> 
> Right, but my concerns is that in (some) cases you can do one step further and
> use PM_RUNTIME_ACQUIRE*() instead of putting first the explicit calls in this
> series and makes someone to basically do the same again.

I'm not making anyone do anything except stop looking at the return code
for pm_runtime_put_autosuspend(). Those cleanup-based helpers are
totally optional, and are not always all that helpful. In fact,
sometimes they introduce more problems than they're worth.

> To me it sounds like
> a double effort. Yes, that is_active thing perhaps to much to follow, but even
> there it can be refactored to something like
> 
> 	if (is_active) {
> 		ret = regmap...
> 	} else {
> 		PM_RUNTIME_ACQUIRE*();
> 		...
> 		ret = regmap...
> 	}
> 
> without changing the driver logic.

Well, IMO, this is adding more trickiness about the scoping, precisely
because all these drivers have strange logic. Here, it may or may not be
obvious to someone that the runtime PM acquisition goes out of scope at
the end of the 'else' and so drops the refcount. Then you have to reason
about, "what does the rest of the function do?" -- hopefully nothing
relevant, but that may not always be the case.

Don't get me wrong, I think the cleanup helpers are great for many
things, and especially for well-structured code. But they're optional,
and have their own downsides and risks, especially for unfamiliar
people.

Anyway, I disagree with piling your personal desires on a submitter to
"fix" when they're unrelated, unnecessary, and may cause more work and
problems of their own (or any combination of those 3).

Brian

> Whatever, I am not a maintainer here, so if Jonathan is okay with this churn,
> then it's fine.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
