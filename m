Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333155;
	b=suosjZhVnzKqOH67Y3SdwqcWKNGIDgmu9kKhwCSrVEnIu0mczpZVhs6ZGcgOJIcy1B/D
	 0PNtQUsmDT6k7J0xdXy9TusRkLLZ3sSvt0XNGTc4EElQtsXPQAWa9WJrPdgASUtwq4Hi0
	 aBAdobs0dlOWpLpB8k+zDghFUkLKZzR/6/jBErOQ5KesYHrbh7AybQT6nzKG0UfPVzg6G
	 oscOGPM2tYbFJclFiNcLVARiYoWihz+GiM2Ne6c4P2f3a2zmwFB8tfTcSoyl3J1ebjR5l
	 38WLv8uQV6gXvz8TlxzXbuD8bVuvOSuXBAuCuE5yf2Zb6jqNYyQ3htl/ph/1SZTIyvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
	b=icOdPx01EQYwljTvEYX4PK/w32DAhfbc3IPlrSfmpXBqoJ+BtqZLn/2XxBxc4rb4qodg
	 9Yjjq5XQEHHVXjQ5wOlzRJamBvgK8YQDOMDb46Hn08t2zvJiC/Ht8CrFQeDTNlZRb7vpI
	 0UHNdIhpFlE4K+SM8zpDNSiBjPs2PVWsWFEkomxds2tyKeB06wBJ1Uh8f8qbKZijdjwFF
	 6Rc0hLz1MYlMzILfD5QdeyUyzDnOK6rVpLkCB27dN9wQungSaTEBrtS3GfPyqJ2kdFXU6
	 L1q2cIAwXOFAwd34KcjzxEvFtb5rl6u8POKoklu/M6EM6XJCxN6IKzGNnyw4EOTkJCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="cZUI88/L";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37C606A31D
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 04:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F37C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cZUI88/L
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so519841eec.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793333154; x=1793937954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=cZUI88/L9F1F6vaHkoJiPubaFvpBx9ZOZoFIH4WzYEl9uT8+1501kBXRQ+iQnW1rG/
         4Fw7u6pK2bhGr83aiABmILWeko3myUezgpD4yxFu1q8ofu7DAw3nd3xwaeMW+dOR7WjW
         fF2I6XSi4uBYslctXHDwkVQCwzAYXH2+VEB4ld4ijUFXCUVYiKPoDWGSOArpmY2b6MgQ
         9ZvnqUJjjMcJdZxPtAbFTkDp6O48lwLVb7JSCvyQcehPpzJbJ6jeHUnZCR3iOiOfxhs1
         cwBXgsfbLoMorO9ZFOLAr33BI+k9rnycgZilL+r2ECnd+fRbSczk3whlomOJkp24wZFS
         GQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333154; x=1793937954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=E9cI8/tCL1XpmpenZStZfIb0BNGbzYsx/WRkA39XJ2viNOU3+tdDWfElZfeKfwJYcI
         wMuSuFPEGXtdirlbba/citDsJeI9TLl27ipeUg2oW3+jk8enjy4KGySUqC3EMza/Xtcr
         qGDlmNQSGGq/qduW9WIWV4b7BKfXKbeEMUuIv4n+y36Ln6eIz0YgnAAOQ6loPcRrB2W/
         0yNHlHfVtzWmPV5ORLRopUZ3/VaC9v7sxVRn4isMJB4q9MxDuSKRc7g9gG47OQtiJBjU
         y3mtNg8+Xu6XnboI+i2Emy1h1A4hjsul+2U2d2CQgLUZQfzXclEXhuPs8toxJGx7m3st
         08CQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1Rb5WfY+It3VIWjSIiZT+QfInt8d++DpkN7lGNE0v/B+wFeinAWGvU52yPFQX9onwYOzu2ofxFA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIIR+inZWEd/X8NT91y6l+q+B7yPgnM7Kawbwi1e24LTXy21trs
	3JGG7MTnFq4DBiYLrplfOScBpfTxz/ZFw2tfzs3nQi0CmHrJqsPSNtXEp3sS0BrgGu8=
X-Gm-Gg: AYBFou35w1EFdI/qbpAgulD5NHAt9+NE56vJdyLTeEc7qyv1rmfQQ409/8jmcmzsEUU
	gMyv/y8MPHaNnd2xCyk/oya29s+P2X6om4nqauxUuNwflizfcNvdAnJ51+ZGZeITF60C/+vLv4L
	DJQpgZinIafCe9NjDEz4a8KJjOhlv875Nmnas71mjkXIn2zrQS+i0YgVURIf72+wYVeyACRqjmH
	bX+DKUzNpMW5U8tOe1VPkkyXPM9cOdDRop1Y2rK83bIW/7OAplxtPWd6QPbLkLSyZ5dXvwhSBJP
	GaN8TGRDMohG7lboqVaa89CqIcJMcMBeDava0BDOw3BisL8VvA/OZvZ1GWESEb8WRejX0KYQP36
	Dgdb7V4KmHLehw+htZadLqca2ZqLsSwuMI8QghfjZo6MovGSHn0vZSo/wAYMKx3PPaGGJr9a6zB
	ud/kWfC63mUfO8Q6fUFWM1tUFDnK3tOUSc6fLJp54acsDSO3dnXqPQBOiWQBNuDC+y/1V5sMz+S
	FkBL9CBk5YM+Ny2ZquzuyDy3Gl9UO9UinSDneOxT726jLOI/vqNm68349eAsmZsN/xiM60l5n9d
	xKbzb0uyTpVs91zwEugtiV8vhgVRe6k=
X-Received: by 2002:a05:7301:53cb:b0:35c:e696:2d4a with SMTP id 5a478bee46e88-36a423ea99dmr1772736eec.24.1793333153319;
        Thu, 29 Oct 2026 21:05:53 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm3512579eec.15.2026.10.29.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:05:52 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:35:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Message-ID: <auQXnep2xKpuNJOF@vireshk-B250M-D3H>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
 <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
 <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>

On 28-10-26, 16:39, Rafael J. Wysocki (Intel) wrote:
> I'd expect the driver core to pick up the series as a whole then, so
> please feel free to add
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
