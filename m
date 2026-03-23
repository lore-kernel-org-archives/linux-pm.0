Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47538370D62
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263972; cv=none; b=E1giKbO5O+hiyia6ywGOhs4mk9arRZSI9OOy0GOIpA6D4mr4mHjE45aQSYN+tHSKLJ6Nub+dVDITHrZyMKcN3JuLPBq+8EtDZGXfP3mZGXCiMaPRybx9WUUZMfA4D5LpfQVfAqcXz2a3wKxkhcHKTTT33NXPWhNHGnuE8AbnJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263972; c=relaxed/simple;
	bh=a4vGQ+/SWHex0ls1Ruj0cc3OQTi0sTyk6KfrDSMU7W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf12Q6A3lvwDONRvfkMeIdqmpt5b9BejasbaXL9zND2vVywZJUe8rgO5wf6X61pA45oNBzQOQWaSH2ihpnbwbaMVsESU31UYIRChC2oQ9z0aslsXEQb/26AtzAmRDtqy8+TSsAqYnNUR4rG43izXAPAE8J0VUHwiWf8at+Ka64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LnxQ5lEL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnxQ5lEL"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b042533de1so21037585ad.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774263970; x=1774868770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo1eBxMnrHwc5Y6ZZ3Y/REQwM+N7KKc6DT8+g4EMiCY=;
        b=LnxQ5lELEiW7D79kl+o7Rt7TgCg1TzsYH4G9tMLYgfjvmfE1kjIoJv1WExifUuHOiv
         lRYDQ8rGyZZU6Y82VRGRKZq+qQx0WcKjvKqysLViti/tQA9tXcZ13KA6KVuBVfFLl8eV
         /gvYAxZXsFEhb4ItFdfVSvbCi/07v1awgnGSipHx577QVemOm5UnP7J9+9/OLyABRcqg
         SI9vNY71zFmEQCErm20BZn0C633gi7HYvvfVnUwBgqiEUsJQaQelA2U8voYNH1wcYBcC
         cjrfiQgM7hdh6rVKi+qQYzVfKPxPtNP+PYngbjjpylpEuc0SwFyLMgPDBhZv2UdoZ6eA
         Zw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774263970; x=1774868770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lo1eBxMnrHwc5Y6ZZ3Y/REQwM+N7KKc6DT8+g4EMiCY=;
        b=XbXboyDMbxd8gbHtd5D603yafokPEIu6y6lTeW2Hfv6NzeimxRnycB/SqHpj8hvzqZ
         yi4ubsjlvk0SsYwddOz9JepRFV2M80qvEYUqBtiCKJLyBbbBCiqzYLXopDbe+qSBXIGP
         MudqSu+aUclPoiLpnK8nTCX0l9kGxpE+2DVtSoVqSXWE1d2d1cUi26walHTxPRj/8zvI
         RXFSz+7XPe5ZbmObImr032+R7KE+irN3tYJnffY7wtC8UJvOwRexuzbL0xp/9H4ojQ+7
         vPEACFpBdSioyT3+L6fP3qsKzfWWeeuYDPnuMzlpW1i+2msuqXEAnbedQ/RmiVbiDWMc
         ORKw==
X-Forwarded-Encrypted: i=1; AJvYcCXoFGIyZJe92OIOBE51hRwB29nN93A7wKGwyQVPKt8fwPXflUfrJ/aDGjJBv9LtyIn5hjiVyw2QNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPWUAN3wYaZPsP+bpkM9sYucifFd0Trdo5roj7xJf/4QyVZzJL
	YVaYnM9wqYeeDvQ17z4MxHRC9w6q1hs0mMNr14EEJQeUwB3rHsby6KC9MSsOB1MTR5I=
X-Gm-Gg: ATEYQzx27R7ZfZt4/x9QVwKHBT8fuOShQP1evh/B3pjwO7zK1EzYTRfmqZcMXnYUeEO
	85VqWttidvHRz5UIZsffUfO1uMCSZ36Uli982oQpQNCiikFOjjlPFWLoOGFLsITVurPDk1jpVFG
	gNQhc18JiNxS9hZVnfsSf2vtjm2GZo8tbseY1uTOk8/DmC17XtPnKwrvSfYCotoaXgIT+E9r6VI
	uSh4lIM9uCaURgP+hJnqi49L69sGbZQPy4Os/jLvz3fEkQvvsKSCi3M+evXpoWX1zrCiZsvJ+Fx
	wuU4it57+4sOIQmc8DvUWgWOcX/PzrA80WUNOmobGODVScaDajE5Tr/fDlLVFFbYtX9MmFdDr6n
	PnBA3cRqgU2zPeH4YxT+/aPVXk4R/itjuJ3Fysw8yZ6gRtyQWw2Zlu2670ugKYGs1c6nZfdWtJx
	s4v36/jnUrr9RQrM4YZx1RU2Za
X-Received: by 2002:a17:902:ce82:b0:2b0:6e8f:8e79 with SMTP id d9443c01a7336-2b0827f231dmr113578375ad.42.1774263970385;
        Mon, 23 Mar 2026 04:06:10 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08351675esm135873885ad.14.2026.03.23.04.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:06:09 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:36:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rui.zhang@intel.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, amit.kachhap@gmail.com, 
	daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	di.shen@unisoc.com, jeson.gao@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx
 in get_load()
Message-ID: <psrlnsgdg4afrbk7u3vq35bsqc5msncrfifrl6ee45usn27r7y@fwjklu6mcutw>
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
 <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
 <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
 <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com>
 <sbtbzkzrtgrmqhxnwcqrvxprgzytkzwcsanooyukhphymgt4t6@telvhz3yolx3>
 <c19fc390-ca3e-4ad9-92e8-e30dfd6fc95b@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19fc390-ca3e-4ad9-92e8-e30dfd6fc95b@arm.com>

On 23-03-26, 10:52, Lukasz Luba wrote:
> > How is that okay ? What am I missing ?

I was missing !SMP :)

> Right, there is a mix of two things.
> The 'i' left but should be removed as well, since
> this is !SMP code with only 1 cpu and i=0.
> 
> The whole split which has been made for getting
> the load or utilization from CPU(s) needs to be
> cleaned. The compiled code looks different since
> it knows there is non-SMP config used.

Right, we are allocating that for num_cpus (which should be 1 CPU
anyway). The entire thing must be cleaned.

> Do you want to clean that or I should do this?

It would be helpful if you can do it :)

-- 
viresh
