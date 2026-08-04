Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9F30F938;
	Tue,  4 Aug 2026 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870937; cv=none; b=lLWIF8U0Zuzjk7y5JkZizeypSq7oPur0CxmE3sDUXXgHMnR5XbB3QGVXDBmRl1O/NnGBRWMAegapDn/CArifE7pmtKVEvPIY9caKrY6lpsbuQ5BzGe+LDUN2auquW//uol2xSh1e2sNdDu84ifwGBpqjjnODP8uCKBJ9dQvSZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870937; c=relaxed/simple;
	bh=EfEA6eY5IEquXkaPV/Kh3D52k+rYaIITXwkOtwwfIzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujN/OV16vvZ+pSoMzj2j/ShQoBTP+ukqhaNQmNJXC4CXbNGcMEdpjUjz/tfnTTSTSEXCuesejrReq+XD5SukhBNPueH3FX/9YHZknIv0q+sN4xC11LVP6rls5VX8cgZVQQS8Re9HryF5nR5zrOucVqjj628cZekvrwwub5kPvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkZ06wib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkZ06wib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B2E1F000E9;
	Tue,  4 Aug 2026 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785870936;
	bh=oMYv3XyV5C8iUykaJASvJBTljPlzVPDg/EJP/k7pA9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FkZ06wibJ64NGad4Oex/1t5fRIQMuuAZ6qHkRdR7IskK/KT4HVB4DL8Tk+sSIhp6k
	 rM2nqhA1Grw4bAQwCCWw8PU12Y14+PP2MSCg6UnlGj5uZYtoOxUdoaeY43m15Z9HxO
	 uuoI1CNZZHeKGdvsxhIBoGB4byz+Qj260F8reEgg8Y7cmwOhuP2wuKea2QnHOk6WPv
	 1w4Z0CVevZH5UVgibUKdxzVQX88b4GpYfyD7Xn4//ExJKgUqV/4t4nBdFl6VIKPIbk
	 ckyetUpq2YJXR8pAN8fxG6VpKH9fb6OSJIYdUZ+yZ9uD5oVML3JwGFgbJWAVmj0gOW
	 lT3AfDPEbtSoA==
Message-ID: <f8a89cd1-eb4f-40f7-8556-2f4d689a293a@kernel.org>
Date: Tue, 4 Aug 2026 13:15:22 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/36] cpupower: remove conditional return with no effect
To: Sang-Heon Jeon <ekffu200098@gmail.com>, Julia.Lawall@inria.fr,
 Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-36-ekffu200098@gmail.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20260723184538.3888637-36-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/26 12:45, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Applied to
https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

Will include it in my next pr to PM maintainer.

thanks,
-- Shuah
