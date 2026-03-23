Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2DE20CCDC
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290745; cv=none; b=LDx0m1400Yub9DEIV7uYJHKcm4AaxyCIYNqlzsUCZRw0i3ubsNH9TJfkc0gcfupS8toepUgEXJt0kmvowrf3yZElALpb7qSeC1sWIWXQ0BW6JrixZ3VGoLiknj14Kb9ypDOIa5afS+OyNeW9OTRkgrSIyq0P0YGXXZomcryBUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290745; c=relaxed/simple;
	bh=4+xkueA56lXdxuWcVj/UGyV1w2Hl4FcSzvq1ZV0DTlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K9fZLl8EuptLiIk4jk9xg3HDKT+esrZLrAMr4RPJgclHeuf0IfikJslsu6nPXkc/UMqUmGfOxbUAa2urZkzQoXMcnLipBiRmdj+7AW5VsIOnUkGX6INv/i5wc5gNwd/zqQKIPDWsiS5JlNfXh9W2LL3va41sqMncM9coxSAXoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F+urSs7X; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F+urSs7X"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4671cbce32bso648601b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774290743; x=1774895543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=03M/13T2nVvYaE1tL9n+BB4H8G4FLbEeUzGUmHVLvJg=;
        b=F+urSs7Xmti/esXBMhdYBh+jaO7HI0olJZGM2yQji5sm8VO7UPabNkDruEQ2Nlna7q
         1PEqXCfo7IBSRXJmB7DBa9rthUp+h7zRmgrlpLMJV8tpSLIXQuwJM6uBysGolfsMW10X
         r/J+sCp70owLW7hUZua+L+rTIW2KzmmRl/DRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290743; x=1774895543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03M/13T2nVvYaE1tL9n+BB4H8G4FLbEeUzGUmHVLvJg=;
        b=DGD2eOI0mkvxnUwQI8YVoX+2UP0WlM5sgobEOGImt1jYXy3qVFGGCmCTR+P+naNQj4
         JStokpsQRU0H6AcdCvFupqddg///VoxlbimZjS4uQyZvOkl/bpK1XCGobeA9/alwSxfB
         HmqPmr2aFyNffGqu1zeB6RgTawW0kZrgEHKVr4PgM7rtduh3/X1jRhXrUDmtDD47qQ4q
         IgJwLI7w4Ll1FyvQf5/T2AD29s1aNqtWK5Q/gw9+bjEYdiEzmZUdAygTdctxDE1zBGo8
         IINDhvy4GpjGFt5zT229LeZZcdOti4UbUS5ubFwWq8avecxotOpiYggogJWDej85Q3u+
         pBRw==
X-Forwarded-Encrypted: i=1; AJvYcCUsR7GxEZDWg4YnVsoW87aNeXOMZ7MsT9vCXXI+TATcfI30AIyu2CYf7k8Vb/Z46DAyrWcmKZqFUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXjWJKG03Q1WR9HnLEyKxDmBpteWXKNgkrhaZVsOe3rR82c0+
	LjkDp3ayF3NLxlTdKHphiRSG1aLTESqhkhRgyWTW78xIXbP9hTxP+bN61F9cegYigjE=
X-Gm-Gg: ATEYQzyj1V9FFKehQEPf/verVxKbJOC7210XimsrmoTTtDZBGItyMeVuDYnnJxet24f
	hGTGO5XP9d/Y2YJuieUPsKjQk5vP5vt7EH/WZplIUEWqTHm/DrirG4JhSudH62hYj37svXleaGR
	Vo/K/omvUWNiu0r+FZhLJpSMzfBjXbxGdQF1LmWLwVFYJ2xJPmRO8VgzaepccEMbvvqjNqySwDn
	Oiv+mi5c0OGJ4LhzFW8hdFdMzFAEYfnxrordy2Dflc4IROtk+8paik9MsBj9SAjiGN4OIHosYD2
	afO4JJ9DsCSc7O7i3A953/vpNF6DTSJE1XVaNKe/h103lh0x95F0ityFbgDDz+sUAwGM2R+6UQP
	QVHd9gxNfKQbFXDTqOCZ+aJFW6VJY4xuopThNJMsSw/jdEOwCQuaDYCFhoX1GtZj4gqteQZNlO8
	9KqUTTDiwt62KTwmssSj/5ZbJXTF+HfYeg3DM=
X-Received: by 2002:a05:6808:1313:b0:467:1e7b:72d8 with SMTP id 5614622812f47-467e5d13d5bmr6825713b6e.7.1774290742731;
        Mon, 23 Mar 2026 11:32:22 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14d64fbbsm9398856fac.9.2026.03.23.11.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 11:32:21 -0700 (PDT)
Message-ID: <8ff778cc-c1c7-471c-9fca-7fa30a384876@linuxfoundation.org>
Date: Mon, 23 Mar 2026 12:32:20 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] cpupower-frequency-info.1: use the proper name of
 the --perf option
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260312102029.14980-1-io@r-ricci.it>
 <20260312102029.14980-2-io@r-ricci.it>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260312102029.14980-2-io@r-ricci.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/26 04:20, Roberto Ricci wrote:
> The cpupower-frequency-info(1) man page describes a '--perf' option.
> Even though this form is accepted by the program, its proper name is
> '--performance'.
> 
> cpufreq-info.c:
> 	{"performance", no_argument,	 NULL,	 'c'},
> 
> Fixes 8382dce5e4835c045f33b8958a5f559d212cdd11 ("cpupower: Add "perf" option to print AMD P-State information")

Remove Fixes tag from all these 4 patches and run checkpatch
before sending patches to me adding version information.

thanks,
-- Shuah
