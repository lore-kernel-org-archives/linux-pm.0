Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E873F1052
	for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629933; cv=none; b=Jaub2dkfjQBHTNT4gESa8PBl8cv9u+M9/4yy5j6sj0cUyFRveOzaghvVCpiUirVGdbFPk9a/uC9ruZNhWVB8oaptltiH68Arn/zHUH+0ppotrEUR9SeCGFjS0XnV1Bi0MFXE5y07rxv3blapzLYYakL63Lbr1oYIF0rt+OXw8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629933; c=relaxed/simple;
	bh=ey2uGSuG3jrWAcctmiGZyGdUCH4Y/JKOYhjHktRVi18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoBEbU3ZAeHeKqtIPtJU5u5dbLbL80kTXlZxg9nQT1d0eQyCqZZe65rbeepYvqu9Q0PQ62M4qwWMZe/RgTGKGfpyppAfpabIQV2YNyiPbTAvHBJhmitnF1jNFHmkneC6UdnQ/SGOkFA7QCMj4w5AZlGXm5sSJH7+J1a5W6SmHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UORYt5yy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UORYt5yy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso6442215e9.3
        for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 03:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791629931; x=1792234731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0p+tcFuaad+Ed9GUNOLJGi5vSHUZkfcnyvs2CnZiAAQ=;
        b=UORYt5yyzjPrrVJAI4uPXT4rQkd4pDNL9AAT/KrcCHNj8dqNT+UEB5n1/SYfGvVB0K
         5IipRB0KG8I8nRjikGp9hIiotR/03LuQ8+3KPua6nWMchymndNHWaP5OskIo0o/d9Kk+
         Xlxtk0+7MKlksuiNql6F+UHol10TMducex7Kwb6VJYdme1LVwVmQnp9DBdl1itIwUktI
         Trsalck+4VVT6s8DsG8sfhjamG5uhZeLNkwBBb2gulBF47huEvCOJwUZCjn+N+7ib8V0
         JXxRfAt3kKnWu9jEB14FG0Av/Q/l0iGkvtwV1uhiq9kyCbZFKpKdTh+t4IKInlVVuzlL
         Wp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629931; x=1792234731;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0p+tcFuaad+Ed9GUNOLJGi5vSHUZkfcnyvs2CnZiAAQ=;
        b=k2tch2lfubu6YurtkgYGK27dMmyC84Ww6qZBn+QkGBvpDwVCdUiKuXqB856rHx2GPB
         1zk9zYH2YFWSPoxgg6zGE+YfSx0G+vE5jE5M5MUS7Fmrz7GPnTnEiInfE0ZzGOKM4rol
         H/P7FL+FJD9BfGlK/vYVEjvZ2DXSJ5qkttoE1WQaUhRNuzJ1Jfy4KotREseOFNORt251
         NbsFVggWV1jMSHWnWJVJzwA2qA0zi3OwuWHu/5+lWT2D2dHcyxYwb1C+CyINn44Uj8xf
         CXLfZf1PQqbW+9HOuM7Kg8cm1F4ybqgOBE7bDzkBGqLsu6Y53ww8NFPat5vUjyIj0zhI
         6jCg==
X-Forwarded-Encrypted: i=1; AKwUvBynx1Qe+4ZAOGgAHsJHUdj+Euq//PWg2nDfwzx1v5idNOF2XjcnkUw19Q99XII6u8VKYRlbIz8qhg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK0NBRoB53AHjhl9jcpTRe40axGssdpBSvfQ74emjSb1X32J8iG
	GWKdvJWI9qGES2+oY2HEhE56KW3xiDy/JHbFZqtRuT/5ISr3wGZolcBN
X-Gm-Gg: AYBFou2O22NOu4cAq6mBIy0fftvV9pH/kyBv4A1gF/Z6x+dpi3AzWWd6dC7Ikm137FO
	2YNwH0E29UoWCWXxBfReinN2UMubgmTITFmhAtSyOH4WHrjcyCHV6E18CJ69bWMF9aTpwzk6Nws
	L3rH99Ob+jlvMaOBJLXQr66gKXyl5flniXEQUfJV2kuitloWMiaFFIBje3hPdX/QEsFGQzkrs4v
	K0Q7I1pKV7nKI/7SRRBc8w0j1nIFe3GJh05OtlqvU+jQb8Ao2F8zilZqypJWM0drjg0QzSe+avH
	KfTFnBtKMOQIl0/L87mUXV3WWFlN0QBhQ6E3AWtraGZl2+TXAL6rPHJK1nYdDl5SG8dWLQ+A+Fe
	Ok99V8XtUiYx8YTsuLC/iRyrUH7RVAFEnZS/lyF+7vt+FMTfx7tz3PtxfgiF1ewdw78Mgb+HO0a
	nktnzk2lX8Zgbyf6zfALm9awZEJ1UqjRQfC4nWeZ+P0oKKmNjCcS23tfqy4FvENz3mkpR/tNX+D
	Tf4YUELJGtxDkHwPjUY7mZPFHHRiFAo7rl+DqWxHYkyt2sDbvYFLbq0hSP3K7WS7Nxp7KmueVrd
	GvaZ47Aa1Lys362SHOarWDlIVOXe6TOHjR9JIwnBbdkkrTzO+9qaXdzPOB11IR8M9whPVCJl97+
	zbdQM
X-Received: by 2002:a05:600c:3e8f:b0:4a0:263c:704f with SMTP id 5b1f17b1804b1-4a18e4a3fbdmr88482075e9.16.1791629930405;
        Sat, 10 Oct 2026 03:58:50 -0700 (PDT)
Received: from imx93-evk.localdomain (dynamic-2a02-3100-9d3f-0d01-48c7-5d76-0ec6-9dac.310.pool.telefonica.de. [2a02:3100:9d3f:d01:48c7:5d76:ec6:9dac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4a3b4asm216792105e9.5.2026.10.10.03.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:58:49 -0700 (PDT)
Date: Sat, 10 Oct 2026 12:58:47 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Changwoo Min <changwoo@igalia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PM: EM: allocate the cpumask for every perf domain
Message-ID: <asoaPjyhSAQ5r-lO@gmail.com>
References: <20260910205234.5392-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910205234.5392-1-kmehltretter@gmail.com>

On Thu, Sep 10, 2026 at 10:52:34PM +0100, Karl Mehltretter wrote:
> KASAN reports slab-out-of-bounds reads for both dump and by-ID requests
> against a synthetic non-CPU performance domain.
> 
> GET_PERF_DOMAINS does not require GENL_ADMIN_PERM, so an unprivileged
> request can reach this path when a GPU or another devfreq device has
> registered an energy model.
> 
> Allocate the cpumask for non-CPU domains too.  The zeroed mask remains
> empty, as required for the documented unused field.
> 
> Fixes: d8eef0453132 ("PM: EM: Implement em_nl_get_pds_doit()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Friendly ping on this patch

Thanks,
Karl
