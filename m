Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503C1D5CF2
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331171; cv=none; b=dSo7W4UyVLcK0XEykq9uosS8/yKyq5YgBqJpod/6IBgoK6PPdZoiiWeUXz9NXYk4lOTWnrMx9EDyCniAoKekZgOK05xtfFjNEVBSL/N2vx9XY6iGNOAb/G1pKWHotQV2LlXEWwMridOwDTUWcSS+W0hbgXoEu/ZIG22r5UdkmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331171; c=relaxed/simple;
	bh=yKoI+mP86Kfvx2YpuIGgq2DlSLMeopQ9VeCMh5+SQt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Chko/MyOSCHzL4o6WXpgwF8415SQxb0WvYlBfOj0Mmdgya8fzqpw3WLfJ3vl92zl+EK9OgLeXC14HOrQlH5EtKCkav/LTmy0dWZPDAS6ZOfhetoG8JRF74oecXFxnkI3P7wruHEmS+aecuuNBDV4Eb5BNV0Y7P/RjWNOPjwgCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rxnH/DTi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxnH/DTi"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829abaaa92bso786292b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773331168; x=1773935968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7aq8O/L1syaz49vyMOtdSoKm2czgPlHZpnJOAbgPdnM=;
        b=rxnH/DTiqqPh4rU6Jc7qVEAf10HqobDDnzjZFExAMjegUk6PbPQp+ReKfGCXSNTB/P
         ji8XpLFCG8+XzcWWkP/Zq2ohPN4U+LLzNzyBnGQe+Zg8Jgw/tClgxM0MQNzX1vZfxIu9
         +mf7MaCHZnxlL59dyzfU90qnfrFacvgSGs03U/1Hkb8bIFPRjW93K9fASFQJfz+kg4qf
         219v4yJt1bHr4R9deMz0KgvGdSSufYUiL8fPkw9rmuLuIYxJVdYDQaYZ0Ej5PngycEdU
         75x3yFpNGKoyU9PLovuAVW7qqmAkc5YChdM7VOmS1iLk0xiQ3sxrM6jnX/dn2x0Tqnp5
         gNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773331168; x=1773935968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aq8O/L1syaz49vyMOtdSoKm2czgPlHZpnJOAbgPdnM=;
        b=JgAumC4XJmytLuOaeSQoOxq74I8AO3CuSMQEcYikpkG7GICvly6U0KykQWTUxDX9wb
         oaB/VNWB/pSm17PMcRmlA+9GWZJbQ2oUFbSRazZHf3iURYH5gU6Xju6Q+B5jaAzbg9Ie
         xLfnPlgZhnceE5DPsAi474vEzXbDXeOREXaykarTKbpGZcRoNqC9FoIdLgFjLREzwtEj
         adQdz08C8C9qOtnDr7+G6HT4uYJfhFEpzs18e3A7+0aq8Y9DR3xlk8114u2Y7cy+h5yw
         az1U/eE7rVESQTSCTfniqFW5QsHcjeTMnoH2ciptHzWwwOA5Lx6+muDJKpv7SAx2q4qJ
         F9pg==
X-Forwarded-Encrypted: i=1; AJvYcCWmnJQbQKF7cGFdslQ4+xq2/3yCsOKNSmseIU8KeLjz29St3v+xQZtYjDzTzhM53xD9xDu47qz8cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9/IA95F7aSmTbVG/HliTb6/dDkiL8eW4+wlwmb43gvqlma6n
	cnYiDdhZKr71hIjtNeLiSvqhiut7j4/HhIQRIN5W0luUSbaXvkkJGiJF4yi0P5YlglU=
X-Gm-Gg: ATEYQzxgfmx3dhNSxduIoxLIJscjpJmUHj5oQ8m7mrFq0oVHvrEsqS4hkT+z7dl4q/Y
	dc4WeXrx5yxhE9Mqtb4sszEiyAVE3ZjecuJi39upoeo4R6DExFbVnEIVdCce8d2hAanvbQKC6/4
	Iwc8BdRe3qyl697qnyJWHlrWPWfaYIz4ICkLPBgQfutA7YAQw+Tgd8nIu5b6PY6o7NYL1QfrvX0
	ITCl1S3wrWwLXjYpYdRo+4PnsoHnp+E9M+5ZuUcK4YRMI5jobP6B30JSifStaB6wPRNkVSabPFE
	BfEEUOVXZ80M6ewZpGomj50/DjvRm79fyUwG1Tr9q9ENovm/VlgDOIdgmQodFGYMvyLjRsUtja0
	GCoRss457aNl0s6Hg9E7MKLdNbn+75tAJTEZyfa83wdIQhZzyw+zNqHjoF3Fcc3kUpUfkxRKZ54
	HtIs/O18yERnKEAIs0mMSSyGrv5eKmtIOAkFM=
X-Received: by 2002:a05:6a00:2e90:b0:823:b1f:892e with SMTP id d2e1a72fcca58-82a198fca43mr47749b3a.43.1773331167500;
        Thu, 12 Mar 2026 08:59:27 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a073419a9sm3449809b3a.42.2026.03.12.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:59:26 -0700 (PDT)
Date: Thu, 12 Mar 2026 21:29:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
Message-ID: <laiiguxeqjrxk36txx3g2ij3yzz7aldzcnnqoxdv3m6pjo42vz@e6a3mvnusqrx>
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
 <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com>
 <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
 <CAJZ5v0jvVNd3v_LcsM9Q2tZRavx0OQwZ-R4vWSzYr6edinRk4A@mail.gmail.com>
 <z33jb5vwatwba24f2ftz5zb75qzqv7h4tljq72bwbvgphuvuds@jtxtl7geedtb>
 <CAJZ5v0htdQqaQT+-FJ-Agt4aAONXH36Qg2htoo+onLmst0ZoZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0htdQqaQT+-FJ-Agt4aAONXH36Qg2htoo+onLmst0ZoZg@mail.gmail.com>

On 12-03-26, 16:43, Rafael J. Wysocki wrote:
> But how exactly does policy->cur get out the limits?

From the first email:

"Later, some frequency division strategies on our platform were triggered
and the actual frequency become 500MHz -- 1/4 of the OS distribution
frequency."


> I guess there's some notification from the firmware or similar that
> causes the limits to be updated, but the only way policy->cur can
> change is to still fall between the new limits AFAICS.

AFAIU, the limits (in the view of cpufreq core) doesn't change, just
the end hardware frequency changes without informing the cpufreq core.
And if someone tries to read cpuinfo_cur_freq, cpufreq core tries to
get everything in sync.

-- 
viresh
