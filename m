Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D60494838;
	Tue, 22 Sep 2026 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068669; cv=pass; b=CU+FVqPcV30Ige7Kj0NzeZwB7pRF2Q53LW7BpWLMP/G2G8HGqaSj/ZbJDRvVMTGcurgHI3gBQekHU2JmfIUKNFEe/ln0CDKMLMhcisnyZeN020/Orl61ClRHwWq+Qh+rrHaXyEKqXtHen3+5iPKwiyLsVZMexMAafjQLArWhspI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068669; c=relaxed/simple;
	bh=57Es6NZESVXgW0bg44LVTutvdUIj4NVdnqKoQoWQO2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IaipSceqr20+6oLaf5SB3d7jLzC6CvPvB72TdvAnezscZaY9s8MSM4//4ifTP1juuBQAU9MN+cK+eJrCb+34qA78Gvz2+LbfFAR1HbHnOd26Acy7O++AkqxZwECB772krJ3EVeh8eQYrn4LOV7rOp8fJYQfccxY75+83Ynj7qXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b=OXG1Dwaf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b="OXG1Dwaf"
ARC-Seal: i=1; a=rsa-sha256; t=1790068658; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cTv1nxQxqf6FU5HovUiYCcGmemuahvANGFHplnIb4dqDZkNwYzGvpUobC+KZZbJP131QwxTWripWtCh43Uh2LkaskBIoK/77uNTi4PYLwEfg2yREDCO8B1UwteDscjVAWdZrHTvlaK0MlTUAAFi558cYaptm19+JMNZn2Oq5lxg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790068658; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zCjzBVKR8u12JvuQ2qca4mEUykA3cL/B/myQ/at385w=; 
	b=Psi8hp9GcdnTlv6e1NlIg4m0PP9OYgefse5i6TzJQ2cP88IqDHEYuKlSAA7hS18uP0g/G3iJRJDB2rHOn+Lj2kplg9K0pK5bs8UbXidAlsF28Ud+7Besrl3mwvRP7fNkZUwZIP/OgSKJYPmjLZAMPEJENDVGWpqPpYMJNvLFBdM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=matthew.leach@collabora.com;
	dmarc=pass header.from=<matthew.leach@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790068658;
	s=zohomail; d=collabora.com; i=matthew.leach@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=zCjzBVKR8u12JvuQ2qca4mEUykA3cL/B/myQ/at385w=;
	b=OXG1Dwafq5Vn8T38kxiQt2cbIzm3beAmdABs/YwASmMQFJ5AGJwDQ+CLtT+tO0Fp
	5bWHl97nPY8yGEYZj3fIrRZGSRKBdOmKyvN3fmm/D2upujUyQ00BzixxDLONcouLBLC
	LoiHYvRUWSLrZJbbi+JQU/lHUs5tpZ+MhUXUoVPc=
Received: by smtp.zohomail.com with SMTPS id 1790068654271645.8567626058531;
	Tue, 22 Sep 2026 02:17:34 -0700 (PDT)
From: Matthew Leach <matthew.leach@collabora.com>
To: flo@geekplace.eu
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  Pavel Machek
 <pavel@kernel.org>,  Len Brown <lenb@kernel.org>,  "Mario Limonciello
 (AMD)" <superm1@kernel.org>,  "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org, Thorsten Leemhuis
 <regressions@leemhuis.info>
Subject: Re: [PATCH] PM: hibernate: Freeze kernel threads after image
 preallocation
In-Reply-To: <20260920-fix-hibernation-v1-1-f9940c2d7d7f@geekplace.eu>
References: <20260920-fix-hibernation-v1-1-f9940c2d7d7f@geekplace.eu>
User-Agent: mu4e 1.14.3; emacs 31.1
Date: Tue, 22 Sep 2026 10:17:30 +0100
Message-ID: <87zex963x1.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

Hi Florian,

Florian Schmaus via B4 Relay <devnull+flo.geekplace.eu@kernel.org> writes:

> From: Florian Schmaus <flo@geekplace.eu>

[...]

> Fixes: 783c81098445 ("PM: hibernate: call preallocate_image() after freeze prepare")
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
>

Thanks for the fix, and sorry for the breakage. I've tested this on top
of 7.2 and the original issue my patch addressed remains fixed. I wasn't
able to reproduce the deadlock under high memory-pressure locally, so I
can't confirm that side of it.

Tested-by: Matthew Leach <matthew.leach@collabora.com>
Reviewed-by: Matthew Leach <matthew.leach@collabora.com>
-- 
Matt
