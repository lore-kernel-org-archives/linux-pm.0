Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3EA2BDC05;
	Fri,  3 Jul 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112370; cv=none; b=ZXciIxQsXT/9uAxbQtfABolVlGv9Dmq6tUSjhE8efctDxRFbNviKLpDG/LsTifO3Tp993ycAUZngtboOKKP70W0pewidyriMgwj24lkwUOOFq6C6K+9YymSmDholNZ0PMxR87ZRkLpQx6ec41l50PNwyANxUyCo5VewiwLIixuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112370; c=relaxed/simple;
	bh=lDCAW5JxkEZaw8O6yCVACMA+ujcuVnhrrunY9Av18BQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LdA4goNeH0Q0zDjwTQJA/RW2E9Xn+5oMohX78J04zVj8BQKaDu1KfE4RxThS8/m1sn0o2mpxAsuxfJJWMRcJqNBOycs7hWUDvlitZMj/FnUqjNT4uZt+GzMMi0JCWvCwNbrdxor+3igV/jE1ZY2Ncs5/SK5ZLpmzPrvWIlGO98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=sodW93uj; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="sodW93uj"
Received: by chaosmail.tech (Postfix) id 8649C1CC21E;
	Fri, 03 Jul 2026 20:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1783112367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61HVUUUBujYWxZF3kJRe/CaNMwhNM+5pPU5vtUBZmdc=;
	b=sodW93ujKc4YTfy1kcia8w4GUnTCnMEACok4ZgMl/VfTYfztulZ+4rn0H3hR4IITyXwzuD
	zFWlsaTWkFe2K9LoUAj+nd2OIMhtT8d3UPs70iIQdyp12Cny9WYltFvvlonuyh3AxrFRnu
	uqH0cJvPntZdT3GumJ5KKLVN0Lqt62w=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] cpufreq: apple-soc: Calculate frequency as a 64-bit value
From: Sasha Finkelstein <k@chaosmail.tech>
In-Reply-To: <20260703215244.437ec9ac@pumpkin>
Date: Fri, 3 Jul 2026 22:59:15 +0200
Cc: Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <AD6119B8-88DE-45BD-8241-3E8585F892FC@chaosmail.tech>
References: <20260703-cpufreq-64-v1-1-c406c705319a@chaosmail.tech>
 <20260703215244.437ec9ac@pumpkin>
To: David Laight <david.laight.linux@gmail.com>

On Jul 3, 2026, at 22:52, David Laight <david.laight.linux@gmail.com> wrote:
> 
> If it matters you need to fix it for 32bit builds as well.
> It is pretty much really wrong to use 'unsigned long' for frequencies.
> IMHO the should either be 32bit or 64bit.

This module has a 64BIT dep, and is not applicable to 32-bit devices.
In addition, the calculation is passed to dev_pm_opp_find_freq_floor,
which is core code and takes an unsigned long.

