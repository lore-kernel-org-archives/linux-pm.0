Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276535FF5B
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182422; cv=none; b=KAA+0TDhpbJq9jXWJBeqAFxnjWrOK5rA+rvW8riwd1Kp/V6PEkYNdZ+YwIcXgiFzzCpk/CkNfqs31efZdhp2OrmxcNQBGgnMLsXQXmR91QicW+i7kuBO2JdblzS/Q7l0My7i8prFJjjLkUeYV3dz5OYBQcb3m9T/DS8fvgRxWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182422; c=relaxed/simple;
	bh=IbMfvgO+8M6pdQu44MwzP91gmhyP0v9jbj8THyyagJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsBOhES2S9x4DQCNE4xhzKO8h3jjh3UaR4sUUSNEEfmsGkfAumF+TNFGDlL16I1Vji2v0jUMUWE3Xe76LiS+HhVCUNBMq/a04a7gQ6JR2IUXbC+JP3iKOCKyEV5T88UTZBYWBCJU5/b5+FKih+wqCJn9nw0fx1dswErM8HOFfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMZwg2Mg; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMZwg2Mg"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so1746315eec.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2026 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791182420; x=1791787220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UX8x8ImfgI/m4flRrmfw9BuPrzImgwK/Apj6ObaD9rA=;
        b=QMZwg2MgkzTv3mQA4mCZLHM1vVd4U5ylASHVuZud/vPnGiTFlNUCFwJSlRG14tPbx8
         bdZLgg6ebL7m4+ifei77gD/HroDdTJ1eCqKSTUF3W+9bZJXseThyszjpiLFS2gr4Ot9G
         Z8A++mTf5XSHyyTIaomdlD62gUlcK+RcU4xpeBDMpG4aEGzWkypx2reSl7SjjXoXF4yn
         G1R2y3i5TKGlQW66uRFl18KVvsBLFQNtdlKASj5ePJmQY17Tvz8xqb1ObS4ZngINKPkV
         Uon2i+FF4tVj2D0Y8/rkkEdO/u3PgbyiBK4nEFDIrRSxIi49VIYqcz+oFMdDJjZ+K5xY
         PKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791182420; x=1791787220;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX8x8ImfgI/m4flRrmfw9BuPrzImgwK/Apj6ObaD9rA=;
        b=EWndVpaix9CvG/jsXTdkFj5sqlL6FLA+wFCCMFFwIQG8PTmCYFlz2w9RH9ZnR353lX
         ZOhRtCkqYQIQNoblq4J1Rt5swloL4dAu+MZ7eNkYcgzYt1zK2fd1f6gaHLb0t5+8IRM4
         YRc7tFYQQfMc9KDLrwk4fuBt7jcwJkS2mK1wxOjQS2PbhH0ovbEVjZIbDmh+GLhgpnyI
         deQ8pWmzUBOc4c7TbV9RtfHsRPs+U79rQxD1Ewibt5xkpdu+jnxmhcgC5VIJeqjwMx2S
         sepJ9PG/gKzOGPL4rp5lSz9uR32GFGMKGxDsVpcTcGIadVbK9x9MsORFIp8kk5WMe+Ii
         4Waw==
X-Forwarded-Encrypted: i=1; AKwUvBxQbPqjO9N/JH/Ta8PEW5qbbFMb9vvyxhReYslzqByeAszQLf0Wk3MUQHYTT3uWE9s4pVnPCTmECw==@vger.kernel.org
X-Gm-Message-State: AFuF++lOAu1HpKs+q+Vaiapw4EN6NCQxS1L7edAKGEFjYIh+9iSgWyCE
	bq/9t3CsLUja59eeLq7xVJx79jIS8ZkLSzBU2rAdjMnsywgNA5SSdAUwkDeq5UINObE=
X-Gm-Gg: AYBFou2Xm2mZbyXrhz8REOPp3bt5BngaJK87B8KDhiJMr7ztVBwc7/Wuxcb4L9VuJLt
	Zijm9JOcyjM2BUYdSSl9vjWnxzn1QGi8UPNjFH5QnbAgqHZek84QOyspNV7N7PmJdcNLm4A6XSz
	fNjhZci7ZEVWITdk1ytcQqjxFk/2Bn0VaYLHq5H6QieLjd2bucrEPoRcpdxww+5foXzcFVpWqfY
	CqPGSgLPnqfy+xF+xkMWM8ozRKqhR6HlcBeyFFJJHk3PR7aeSAkPga93RPsYpdv2vidAR+OiuRO
	kgYxBy8j22uvDM9hydBQAvCWO0T65sIpTUd/fjHvjJz5ht6gOelsI15x6wtjjmplSaVdXPPe/y/
	czp/XMqPGy0f/1qbZuL8MvPCUClaLhoHGyllJifdCgvLV8sJbC9XG+1rkqXKC23n2Fz2tuNMvSy
	YMQdY0ieCYdcX2aPVBhMIPBX9JGeciCM4HdTx9yIEhDv6hdtC5kKLt8Hx1Qj+4n7/eOw5rRvjV
X-Received: by 2002:a05:7022:296:10b0:15b:7f7a:730d with SMTP id a92af1059eb24-15b7f7a734dmr130358c88.28.1791182419835;
        Sun, 04 Oct 2026 23:40:19 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fa74fa1csm21255659c88.1.2026.10.04.23.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 23:40:19 -0700 (PDT)
Date: Mon, 5 Oct 2026 12:10:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rafael@kernel.org, spidermana <xuyiwen14@gmail.com>
Cc: ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	sumit.semwal@linaro.org
Subject: Re: [BUG] rust: cpufreq: get_callback() recursively read-locks
 cpufreq_driver_lock
Message-ID: <asNGUIFbiCncMXf6@vireshk-B250M-D3H>
References: <20261001172953.4013498-1-xuyiwen14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001172953.4013498-1-xuyiwen14@gmail.com>

On 01-10-26, 19:29, spidermana wrote:
> Possible fixes
> --------------
> I'm not sure what the right fix is, so I'd appreciate guidance:

From C API's perspective, cpufreq_quick_get() needs the lock (for setplicy
drivers) to make sure the driver stays around while its ->get() callback is
executing. But the ->get() callback is free to call cpufreq_cpu_get() in that
case to get hold of the policy if needed. Many drivers do call cpufreq_cpu_get()
from their .get() callback and it should ideally be fine.

Thankfully the only cpufreq driver with both setpolicy() and get() callbacks
doesn't call cpufreq_cpu_get() for now.

> 1. Use cpufreq_cpu_get_raw()/cpufreq_generic_get() in get_callback(). This
>    avoids the lock, but it does not take a reference on the policy. And I'm
>    not sure it is safe for the other ->get() call paths in the future that
>    don't hold cpufreq_driver_lock.

Calling cpufreq_cpu_get_raw() (as you suggested) isn't enough as the policy may
get unregistered regardless while being used.

cpufreq_generic_get() returns the frequency directly for drivers that have a
valid policy->clk. That won't work here.

> 2. Change the Rust ->get() so it does not look up the policy at all, which matches the C
>     callback signature.
> 3. Something else you'd prefer.

I think this is a C API problem as longrun doesn't call cpufreq_cpu_get() at the
moment just by chance. Maybe we need to add some workaround in
cpufreq_quick_get() instead so it doesn't take lock any longer.

Rafael, what do you suggest ?

-- 
viresh
