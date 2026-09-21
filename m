Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBD4949F0;
	Mon, 21 Sep 2026 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994634; cv=none; b=N91FRNzNTK9qh0zCrt3udRibxaE3K8IuDgYiZHfWXzscmh1MrWzG/1qDf9FHCGCYmhabry60YjvqozfwvFT8JLSVmXurKJD1zuS0+7wT2JZ4PAdzQcjUMco5wvLpyDc8m3SPfVhCLOfUSuZqgEYtGKk99BXP50YxM6/O1/a888I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994634; c=relaxed/simple;
	bh=e/4q7t+xmkqGO7Tshm6xPaSfs/c/vU2WrZQMVUJrWiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcLym+i9jYq/lmaaP0U3tRxHwnMRWp7Zg1Du/mM3cxbP6R1PMeV7w79/hGbovaUGDXppUxJ9ApXgWTyTOtQ7kQFo6l6KQtZYUflxGUJbuP7/Q/qyaUFTF1K7HP5Q851RYIRKjmCHVLJO43kZiIoxJE5xTNMtHNdbdd/YXg1jzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onl0CDvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onl0CDvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006FB1F000FF;
	Mon, 21 Sep 2026 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789994633;
	bh=iaLayvDfapV0bJvw+3FKi2a+/cU7femQxfBRaV3D/sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Onl0CDvHcWinsA4KtPqRh3IMJ/cbIh0uQdwPYmEYr1RuYxxJtmM5dgIBP40LDEYMs
	 qyOoff9BaQge/ouzkqn3+wXEf5ZVcPD6AZmEpFW69caCozlqOij/EuYUM2Z2MbVtoJ
	 C+ClQjFYoH0qFCL5w5tW0pbRhJHRVTPvMZruJnTPbp7D/ra0ILXdwsPsK9ygBWqP/6
	 5S13CXcL1dbsrP+Xw1yv0R0nu+QdHHveSMiU0mQcIAKqJihWbSiO/9huYb1GOuO4HH
	 vxMRaXZwrfWjcjgqQGME0aiuoohjx5Cxj47faqc+oNLn7/rjnDms/ZMH/3+TRp0XVI
	 kObU3rJaIM6Uw==
Date: Mon, 21 Sep 2026 12:43:51 +0000
From: Yixun Lan <dlan@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
Message-ID: <20260921124351-GKJ297024@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
 <56e5f32102c67575ded8af9e81a06dc9f1dcf0ee.camel@icenowy.me>
 <20260921033540-GKG297024@kernel.org>
 <8ac3815961bebc5065ecabbbaed3e9920d5cbba7.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ac3815961bebc5065ecabbbaed3e9920d5cbba7.camel@icenowy.me>

Hi Icenowy, 

On 11:39 Mon 21 Sep     , Icenowy Zheng wrote:
> 在 2026-09-21一的 03:35 +0000，Yixun Lan写道：
..
> 
> Should the GENPD_FLAG_ALWAYS_ON flag be applied onto this power domain
> if it's not meant to be shut down?
> 
Yes, I think this is better approach, thanks

-- 
Yixun Lan (dlan)
