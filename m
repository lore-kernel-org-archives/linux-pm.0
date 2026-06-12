Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DE381AE7;
	Fri, 12 Jun 2026 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293347; cv=none; b=gv1Bh14Mla9zDmKnsCUPsoovixQsq7JAbd959IMWFIAXd2q8VXm4Qy7jY0YfiHN/rZLAbVVZZxHwZ7IMHXmjB6pKsxK9Te4gVCrl63UTnZpfOMBeaXumEMxJhwRmDRsBSw/NZxQeHPYdGTTAqOu6RAGmDKV1/pfYHkELxAazLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293347; c=relaxed/simple;
	bh=/0FVu1vR6IhVJ9oa0xemnl6UMomIhZwqDxkrle3Q5k4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BTjEd7I1AZ6TV8DeUwKjXoZZFUto4J26mT0iUiarKmrF1tb3nLFfPsqt2aIqDUzjsgllTj5BDECdVtCWfPSpWE2DuWQbGZ9R6kum/fQvBL4MFfukB1cVzU+OEVKF+k5WGu1/m4HRKPibaCzzpAmY/Gpk6EYzhMzGWom0HXIbIe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=en68+gmG; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="en68+gmG"
Received: by chaosmail.tech (Postfix) id 80FA01C962C;
	Fri, 12 Jun 2026 19:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1781293343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCaoWzQZZYJ5HrMTb4wHgOTXwSO+AIoqNwLYxwe8Syc=;
	b=en68+gmGmIX+JwO4AQIZGwNJeHwJmwpMxEtdB2m6A5NFGX9e5Ct7FmS3PdDe/1HIofXECp
	OIyg9oZkWUBLvbknN1GEwf2CG5b9aeHftMcDPpjPcGf8/AuDt9Pyhho4JHVrOaUck0JRE/
	Bs6SguVq6ZwB210LJQ1AsdNL2hfIZgY=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] power: supply: macsmc: Support macOS 27 SMC firmware
From: Sasha Finkelstein <k@chaosmail.tech>
In-Reply-To: <20260612193353.GA7993@robin.jannau.net>
Date: Fri, 12 Jun 2026 21:42:12 +0200
Cc: Sven Peter <sven@kernel.org>,
 Neal Gompa <neal@gompa.dev>,
 Sebastian Reichel <sre@kernel.org>,
 asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <18396D14-17AF-4B43-AD6D-A88D2E7C44D3@chaosmail.tech>
References: <20260612-gate-power-v2-1-de76cb9bb7ef@chaosmail.tech>
 <20260612193353.GA7993@robin.jannau.net>
To: Janne Grunau <j@jannau.net>


> On Jun 12, 2026, at 21:33, Janne Grunau <j@jannau.net> wrote:
> 
> I think the following is slightly easier to read
> 
> {
> if (power->bcf0_1byte) {
> u8 tval = 0;
> int ret = apple_smc_read_u8(power->smc, SMC_KEY(BCF0), &tval);
> *val = tval;
> return ret;
> }
> 
> return apple_smc_read_u32(power->smc, SMC_KEY(BCF0), val);
> }

I personally prefer using early returns as much as possible, as it makes
it easier for me to read in linear order and due to line length reasons.
But no strong opinion either way.


