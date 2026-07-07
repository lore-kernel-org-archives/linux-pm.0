Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21213822A2
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 05:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401133; cv=none; b=X+0K5d87Q+eO9cnKZ07NlefJEVgfdx2hNXGbK8AsxKXub+pP9bQFbwHdz6ci1ChuZIkt6Feq2UNfhYwJpDQEer9PECcwnTQlJirrr69JlpPOhmwE4LB0KHlw/TNj6dDKr9LjgeHWD+F7ZtjCsQNEOvIm79g12EsiPkANRXcBJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401133; c=relaxed/simple;
	bh=ime//DaYmBqwIhHrao7HYFzuOkwTo6QeoLEfQQ5ICek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSvXuvoyAsnzXymIre0RT/BoIR5Q7+yp0Q4sSJL9ziZ/u+LGcSlbO+pCH/3MGYfvmB/8sTbzXJcvnlnU4PzxLYL3xD2em2haCNNQ0znZq7UYsXv0AHyJr8T7VckHcb7D2V+XjJWZFgMs2rpMpoTy4I59ltOPKoTcIJGI1oQ3auw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M5SRDs9U; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5SRDs9U"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso2815101a91.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 22:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783401130; x=1784005930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WoCABaekpbPXiB4d8t0gR5TdOk1VNytyridycavPgIc=;
        b=M5SRDs9UqE94VoVw95nOLugxduyu8pLlu5BhHHEZnNMRiSjSZTQDEpT6wK2sPfCbwf
         mnhhS/FlmLoKoCqbANIHk1MWQd/AJG27k2Yv5zJIIQQ1kjk+4JS0JYEiv3ZIR83n7VeZ
         ss7LTtUdUGnJD+QleyNl3XjSNrg3xzGGxJdyo0QMFxOWePpYTlHQWJGuiOSo8FYjsZuB
         85uJCfZcuQfzYVVWdTM5BGHditkoUkTKd6vG8X5AuDa1YLQLV9dSgUn6LVIDbigsJWm3
         x0lWqxJEIChs2gIPmemcz2yeJgoR1LXk8cjQdvYBhHZZjPWKuPTgBq8WJjnPvgNA9Z7Q
         w5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783401130; x=1784005930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoCABaekpbPXiB4d8t0gR5TdOk1VNytyridycavPgIc=;
        b=DccGjxBNfbQvLPYVP7BHnrBd8nXAP3eS3zdo2nlX3vmAHhCmcK/YC1Skm/biRT0fd/
         G4zlFERWz/wSrOBJisrCpOKtxP0bRIOENvMVDiBX6sA6fvsQvXF2Rc4760Tw531DRL78
         tPc+uhdunyzTReHcKVteg/Jkgd9TRp7Gk/w8wqEk9d9dUui5Ja/DPyV8NR11jwWiUa18
         Q1UzYJSDXpC9YIAwJP5IT/VqQmYOc1R7XH8cpzAu+IMWtVulx64tG1PoTBuuESDpjlDE
         GmryUeKsksA6UrpshtLFjapgIfmPcHqCAhiKtvti3eSJq0JCPVUZRWSNJY+ynF1/7Sek
         797g==
X-Forwarded-Encrypted: i=1; AHgh+Rp/eUmBCWOzJKKv1eLvnTVEXUT9prRLYjAOzFdqGDEN8ukSE7dE5k1IqrU6F0C0JwTMp/VtTloFOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye639VXA6XerQJJN0ZY11r8eiqR/dsKZpowovP7dgiy0ou4cwu
	VuE4nXRBxJM45BF6Kwvm/zLz++2eXUS73KmF8WZAQTxHf2RkutdAj1uzXzaHzLnYXHk=
X-Gm-Gg: AfdE7clu+K6AXrTaN3QDC7oxPy9jTGowk/TFNVuJB+iydjgTNkRJU+OABgtdZ5OY93H
	QE4kZrxlxEiglMvw5SldtZ/vkaV5wCRJuKOU13CBo39qtf+16IIPpQZyct2UTlAMsn0g/W705BR
	1dAhGPHCmx7B4Ow8WM3oQoGfblMaNERIdjjXB9zwlSFp8FKyxD1oT+LxH+1Nrd7dCbAFk0qUkcm
	MRHsa9ViFEAhvWxsY5Yks5upyU710+rrF6YlR8TJShOSLEbGq/7agSnhu10EDWJspT9KiGdZ33a
	8/5iUFe0KYDnubkqDKqh+7ahDNgmgZf5rlBSUULO2BpGdTD/ObHycrt925qwIqKDzpr64keXEpg
	tpDWeVrSjp6Hx0d+QQAVcJ+tpgZ/v8x1NKSrYE3qNFB3HTLmzHwyz9pDqB5E4s/KlCVjT+kLcFf
	LJmrZck+pDjY67
X-Received: by 2002:a17:90b:254d:b0:387:e0bb:57f8 with SMTP id 98e67ed59e1d1-387e0bb5b9emr1407204a91.41.1783401130082;
        Mon, 06 Jul 2026 22:12:10 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56d4dsm3514693eec.14.2026.07.06.22.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 22:12:08 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:42:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinseok Kim <always.starving0@gmail.com>
Cc: rafael@kernel.org, shuah@kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/cpufreq: Remove unnecessary sudo from
 quick_shuffle()
Message-ID: <eqvoizjmktaqucv5wd6vwjdxniz67ehs5fl67lte3ubq46vz36@f4f63vngqyet>
References: <20260706143857.3306-1-always.starving0@gmail.com>
 <20260706143857.3306-2-always.starving0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706143857.3306-2-always.starving0@gmail.com>

On 06-07-26, 23:38, Jinseok Kim wrote:
> The cpufreq selftests are always executed through main.sh, which verifies
> that the test is run as root before dispatching any test case.
> 
> Therefore, invoking sudo inside quick_shuffle() is redundant and may cause
> failures in environments where sudo is unavailable.
> 
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  tools/testing/selftests/cpufreq/special-tests.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
