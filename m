Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CE936B047
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515058; cv=none; b=Y8LIZz18wRtbL8UB90j8i91iLycaH7fhBVUjSh543RCOwFiDEsTXY6HdrdnEpfIlsyh1oWGctHh+Z5raHv8hb2qIg6XPIfK3CylX4MDM7Mmu3l61poFNjMHlB8u6lSn9NtuQr4i7a39pyQKmk2tJ0UQIA9kz5QY6NXl+K88LdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515058; c=relaxed/simple;
	bh=ImkBVCkUBEKyey0QPJ4F16DDe4F5bx1S/JvLX2EXDB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCloRaAyGDPfITvx5R6caOmxy5mtmcopkUhshOikw9rnr+bz+hej9P2ix5tWdYAwRUdeDr2w+U6vSBFgxDcZPFUrsqghkXdM+uRkiXsHYPge8xzqosVq0feLKS+BIzdUBI2UeJYtbyP5wTJbohTSUDJEzLuiL8ECegiuJqAoUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hOSN6MkE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOSN6MkE"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab46931cf1so14005285ad.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515056; x=1775119856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EhsBpGc02o/BwRxqolRHgVJCSvjvY7/JYjQ8yR2KTos=;
        b=hOSN6MkEMKCwT9NkQvdLbnGbr8ySjSGgBNwBx4RFlfUfyDGhHweYJrXoCiepM/8VAY
         0gAW6R52/aYsqg64mQnqorPfvVyfZnMZhS36XisaY/y64Vs2k0ichDj8rwQOzzRhxwdx
         cTqyNQ5Z5GGORKKEKW4jzoMcVXhOrtacdOqbNK1Qdn/fyZjG+pxJATvZq/zCzk5/VxSj
         zZzkQM9FW4b2NofnFNaLk4M63etxJRM58jcTYLrGB9SIAysuE4jpBvhAY5MAgalCnvJa
         SORxfmCQ+oCBTzjZKFOWArbUQS12u162VuPdH9En1dNhkFlddeMQjgrxCp3zc7DGHowy
         lbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515056; x=1775119856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhsBpGc02o/BwRxqolRHgVJCSvjvY7/JYjQ8yR2KTos=;
        b=bn+xbYRXGnj6Bv4S7rBTgtE7mGX+qXpsPuUH5XxE1pHHAm6qWewDJB7ucCJX/AWnrr
         j06yixH+y0wq5Aph8DJMPhQI6GZyF65aeQrOUEPKW/GX1+ggwZbJnYFKvMCSETy0/1Xu
         w1RweTJX9liUvC4luaRKrwMl49erDfmU0O53wIK0Q6HE7NNaFiYhnUGcloOmPmGCa3NZ
         A9re3qEM6qBDQ/CvNrYjs/07yoVsS3EiGHaHAgCdZWKdgY+Q9tV9dBYCnz02l99JG0eh
         Xb7hYbTq4dC5OaUHgSkdNuXsa93NaAf8PMLwpOT8JimJPmhHzoz22SFRzO7tmU6O9z2g
         Xpww==
X-Forwarded-Encrypted: i=1; AJvYcCVM1ws4VxuLb2v7Om8N7QdQuAMpFdRpCVsp9V0wjQJlHoyl4B+U+pk9h7HUKJ1er8Qg0qx8r+QYhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywagcmo2Ry+JCkty/SI/Y064QT5Sfy1qoKU1RZ3SaVUX41HCSgk
	vd57U9d4/uJsPkccJ4ZncXiqsua59qw9NsMmB5cgBtQWMZV/HcisJC9p3FvvXqR0Gc0=
X-Gm-Gg: ATEYQzxszOraYypbhcLvVi4KWkV2IYK82biLeYk6XQeRsqD0BAr5RLQS7+FeJdWbHew
	HxPgKXIVJTbTctWaE6xyw6IB1zvj5s/sCI2tymz/zsVzWFehXmQtHRRjNTK48prWcc8qe5vm+yz
	yO/2ygPoJZY7qwS1rmC6g91V3XBgiU7EWrAiwBNTh5mbzfnUvmvkvgGqpc+Z1zbt9eS1qQy4dr3
	7iXW0pnmh/7pE8NZDWawtlrHTfVzjbdZ6l+XwxyUxOUm6xntzd9vVWIsyf4irIECUd+0ZTpmzv9
	YYObQMLgV0LGfxBN5qbdxLsVZ2UFCIA512QZlB3i/5K7ua1WPqjYZJi0PNgckDcJmuhyXDXD37j
	bP00hdrLdQ0paIkVtc+Y+d+6DEwHN/VjwxbwDh83WHM3lSGw1hHl/q782/ds110oNe+pDQgUx4t
	EpHMhDPIxycdt9jAV4Ogj+bSu6
X-Received: by 2002:a17:902:f542:b0:2b0:52dc:f1c1 with SMTP id d9443c01a7336-2b0c48ad790mr7946495ad.16.1774515056390;
        Thu, 26 Mar 2026 01:50:56 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8be006sm22777975ad.60.2026.03.26.01.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:50:55 -0700 (PDT)
Date: Thu, 26 Mar 2026 14:20:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 2/2] cpufreq: Add boost_freq_req QoS request
Message-ID: <odpfr3sz5ualy2wnwpnpfbkjjjcmcydwm744aew2vnpbsnajdh@xd7pbkwnkwmu>
References: <20260325165255.386576-1-pierre.gondois@arm.com>
 <20260325165255.386576-3-pierre.gondois@arm.com>
 <a382a832-d71b-4227-a469-07c96b70c372@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a382a832-d71b-4227-a469-07c96b70c372@oss.qualcomm.com>

On 26-03-26, 16:18, Zhongqiu Han wrote:
> Would it be reasonable to add a NULL check for policy->boost_freq_req in
> policy_set_boost() before calling freq_qos_update_request(), even though
> callers already check policy->boost_supported? Thanks

Not required. policy_set_boost() should only be called if boost is supported.

-- 
viresh
