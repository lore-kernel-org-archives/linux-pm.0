Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E139B969
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778771; cv=none; b=k7hm2KIF9xddeCuMMKscLf27mbN85PzinAALQC49wbYqCiWeWvtYjsEGZfm7ixGEbPwefNDaX/GWag+gh+ZI6yZcPGwWYYlFsYKy52KCUfcyh1ubFEpeUhIQyY32HRziFwJno8rhDCAYJ+/jyZfeQQIIFa4muIumZAunkr8Y5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778771; c=relaxed/simple;
	bh=q9wggIScG0yYQHYBn8qso5oELnUyYQWG4oIpv6QMBcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW3YDa+cngFgi08egL4e8FjOuZ+ZoMguU8OmDISQyfHpH/kDuw9lfELKwM1ALpcp15Tw+fFICM4D48Aembx+SFKxecJKKvt0e59lOK0wd93gyF3a42cejUqlMlc8eBLRESy3tRLUGZNmTqJiwQ3dnEKiTqQL0Q+VzKxpcEStM5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jT/CAMLu; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jT/CAMLu"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-16ad92569b5so1285536c88.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 21:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791778768; x=1792383568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=efFkaQFetsAOpWM7VNvA0yYFgrxZuGTjrhnbsOnuNRI=;
        b=jT/CAMLuUu3UuUVx17HX02eMHxxg7gAJdwJ95UHpzktwoGPrVwXfyaFVaq2OPw446V
         KWPtS4WoyX/Nnsoqxy8Dc7BvS4xgYV0ATl6KHJ0lb2zdoQnzKClW1pXg7Z2hpARuNtg1
         USIzHEN9V7u1WxFi5guo5yV1C7uO/Z31AKQIWDeVDP9lWkvF81iww+/gnRZCLqRcA1xV
         zU5rmSJVJbHHg27rO2Mhn28/JiLL6t6uf2Sj8CIYOpQgsTDT7CcBLLs/okVKmKpZfP1a
         jQSC502wZaI+qjccEQvk5i4nm9QuLp2tF0afkuCE5q0UpErTEl7rN7bHycmYDLpcQ/iq
         fInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791778768; x=1792383568;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efFkaQFetsAOpWM7VNvA0yYFgrxZuGTjrhnbsOnuNRI=;
        b=bF/P4j+7ZVon/tZUA8b+onJZKKyq/oEWVcnR8KKkbDwEmrj14XsHfsbDFfuOCqxCDY
         0ZW21IJuqpIXcZrWDzbXdCWsKXeVmAY6lYxUpLhYWyF4FLkvw9JhL3XJzZ17cjtMDS0F
         1iXY8xciP+bAWBgjhrgRzMS2ef0qWCNV852oyIb7jE87DUXp82+Cy5sr3xPsC5MNJb1q
         yQ5AS4GYYCnk2Wux5iDutmjCyAAF4wISPA8LA5yNxXEO2sOr7R35L9o0rIlrYsQXk0MK
         HjPQ7xt6xn1XubqawLBbt/E+ZRlcDQQHV5u7RC+bDDvpY7rI6DxFEDqjS33/2qLsAmgN
         z3iQ==
X-Forwarded-Encrypted: i=1; AKwUvBwagOaKEtaZUv2M3SpWVlPouFxW6M6ZLGrpqMATvjuEALpcmFanimwaHRWNoRB94TGowgHJVZQ1bA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK1x+TWX/tEuYYaktW9YlBpE0bd+TgsxPL984LyLkDZfvqZ0TG+
	iG6awY6HPmGatt8cvVR4FEv0PrZOV80RvvnXqYrTQyw5WhVvZBXNWr+yW4kAgHDwkSs=
X-Gm-Gg: AYBFou0wnTUE007x8YO/4uZ5XIDTg0BpuZVT4QNozyrJk3R++s09deNeJM4zUNW2lRi
	8xSdpE1K1V38kgDnCmfZsiUraUIkxkEqTd8/+uITF23BKzw63sFrn3Q9daObNUD9Y/SZJ1DBx5v
	1rozAtUW2be2v186fXkJTT2HVTjT7rlh6m24+dR3Og2udqFNHVFKLa6aUqZ3jcylGi5HGwPcQOm
	+/wepzNfD4WwRmHa58nk5kwTxgvsQ1pZUHqM8aGN3ZeFZFJ7c5mpfVHvTmUSg4MeQFRHwXClviw
	fG2u52WoyuNGk0dylk2/BZk+3C43Y8CtdXQFrC9Zi6e8mTelha893OvGdRSwAdzZ7Td+SMdRHQF
	FuRsz98YmzRnfwQOxX/IgohrdKSIuRnoSjO1dy4Z2KNCI20HhR5DTk06s1R7acpNYbrpg++uaZ1
	BaxGclblUNW36e0CGcTH9ye48CijTZBR7TSElsYkKjVH4ZK5kdqHt9HTU4BeJmsKqQSD8mQUrE
X-Received: by 2002:a05:7023:a47:10b0:14c:1f57:3e86 with SMTP id a92af1059eb24-16a5f5ddf6bmr11356001c88.47.1791778767995;
        Sun, 11 Oct 2026 21:19:27 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becefdsm25739266c88.7.2026.10.11.21.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:19:27 -0700 (PDT)
Date: Mon, 12 Oct 2026 09:49:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Roman Vivchar <rva333@protonmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] cpufreq: mediatek: Suspend at the opp-suspend
 OPP, and mark one on MT8173
Message-ID: <asxfzG7bNohf-gcB@vireshk-B250M-D3H>
References: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v2-0-ba13f826eae1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v2-0-ba13f826eae1@gmail.com>

On 09-10-26, 14:44, Ryan Brue wrote:
> mediatek-cpufreq has no .suspend callback, so each cluster enters system
> sleep at whatever OPP the governor last chose. On the Amazon Fire HD 10
> (2017), an MT8173 tablet that is not upstream yet, entering
> suspend-to-RAM with both clusters at their highest OPP (2106 and
> 1703 MHz) measured 63.5 and 63.6 mA, against 52.0 and 52.0 mA with this
> series. Those are 15-minute windows of the PMIC's coulomb counter,
> alternating with and without the change; one count is about 2.9 mA.
> Earlier, on the board's previous firmware path, s2idle drew 210-232 mA
> against 158 mA.
> 
> Patch 1 takes the suspend frequency from the OPP table's opp-suspend
> entry, as cpufreq-dt does, rather than always using the lowest OPP. That
> keeps it opt-in per SoC: this driver also runs mt2701, mt7622, mt8183,
> mt8186 and others I cannot test, and no MediaTek table has opp-suspend
> today, so they are unchanged. Patch 2 marks the lowest OPP of both MT8173
> clusters.
> 
> Patch 2 also reaches elm, hana and the EVB, which I cannot test either.
> What they get is a switch to 507 MHz in cpufreq_suspend(), which runs
> before any device is suspended, so the regulators it needs should still
> be up. cpufreq_suspend() also runs from device_shutdown(), so reboot and
> power-off switch first as well; on the tablet, reboot -f still resets in
> 1.4 s.
> 
> Patch 2 does nothing without patch 1 and is harmless on its own, so the
> two can go through the cpufreq and MediaTek trees independently.

Applied. Thanks.

-- 
viresh
