Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842764;
	b=cOQqBhhjkHcAmEOjNd6+OtjO3Jv5YsGueTEfh8qxGhn2nX8ajC1Rhk5qChUlGX6C1hzP
	 3MIQSYLcqs8gHOScy5WXQkXx7oAmJ1y2eklX16rrjrRChp7GKEeCxnMtUqya4eKx4MXC6
	 IyOtDc/t4v0Uy0yrHKyhm/BEjRe7eUyW6N0naTSnKJfaeWYqYlerS+wXW0cOj7xuErSw+
	 TFOq+17b9Fk7Icjwf9yrCLYQlg8Kq93le3WHBSNjNuE1WsPRaQHhiL1BRIYHhjG8K0aEm
	 NQfHYv9Yp5kUX9igQ5XF/m3E3FL6ZeBoDrfcTz4vBz8MWr6rc41nfQK1wsUyA91KNfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842764;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1wPnmKKjukBlg6mKJq/abTjzK4jsDQXLhtug2ycfM1o=;
	b=h4sgmWvrjgvexrRpyGSthjyko7Ip5m59uA6C95LUfYrWD+GDzKQgQNMVfIeKQKqwokkE
	 CXBmP9ww639g8ZxC+7RCRrK1FZpBCRmVCZ4WfJGYUGBHDE8GyGZUhOGQfTvqsXU8RsG1y
	 GfkXcnqMXBR1d2Oa/9rpeoScFGgK2oJtfIxyZoK+sk+pR++NTs3YR/kup7y+O0KfV00eR
	 0zyedrX0gyjPchyKvA4cH6eKV9W0IuAzK7/A+LSQkwIIe1Y5uKrmXkn5wE9H0tCOPwlCZ
	 QnYaV8NLUkIzLYeS6hAiZvLxcBE8TAjg2UuQ4otilqKQiK4d8UGTOPvoUSOuOHWkTWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyh8JlvM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812D606A8A1;
	Mon, 16 Nov 2026 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyh8JlvM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365441F000C6;
	Mon, 16 Nov 2026 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842763;
	bh=1wPnmKKjukBlg6mKJq/abTjzK4jsDQXLhtug2ycfM1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kyh8JlvMoWPPq3JODc4QeHM0xI4ctGP9cQu6ZkGEWs5RcrkwsVQOP3Qxwx0OIqoIJ
	 tNdcfyGkaYG2Ne/dNPeqJQ5L7+7F6UD315x5ODN1QbeQQ17e+ZE5Y5SwL3QpuHCnM9
	 L0msQv40UOEGu++ZjYTwHWtZgzF9yfaPoFjQnn91d8pq33bylLD+BXO+5BBxQE6YYs
	 TTntyNKkPudBlZO4YEfCozaWx8zLLS5Bl5sZDsodLSamCIBzfoMywtF/ExRrZVZSkb
	 MaMys6nDZh5Ev7M3lJ+F6eud1cYaRAfCrk5NDsTNBOREJ9zku7alh0LUtKFx9d+mgn
	 NieScFAwPqV8g==
Date: Mon, 16 Nov 2026 15:26:00 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org, philip.radford@arm.com,
	Sashiko <sashiko-bot@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/3] powercap: arm_scmi: Reject zones hierarchy
 containing cycles or holes
Message-ID: <20261116-statuesque-pompous-zebu-11f7ef@sudeepholla>
References: <20261115110546.2344308-1-cristian.marussi@arm.com>
 <20261115110546.2344308-3-cristian.marussi@arm.com>
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
In-Reply-To: <20261115110546.2344308-3-cristian.marussi@arm.com>

On Sun, Nov 15, 2026 at 11:05:45AM +0000, Cristian Marussi wrote:
> While walking the hierarchy of powercap zones received from the SCMI server
> bailout with an error if any cycle or hole is detected in the received set
> of zones which has to represent a tree or a forest.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-6466cd8d-c2b1-43da-8141-bf8bf49a17b1
> Closes: https://sashiko.dev/#/bug/linux-4895c0ac-74f4-4860-a006-9f5ef7b0a012
> Fixes: 3e767d6850f8 ("powercap: arm_scmi: Remove recursion while parsing zones")
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
