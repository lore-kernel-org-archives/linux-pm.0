Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AD3CCFCF;
	Fri,  5 Jun 2026 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649077; cv=none; b=Ey8fkfrerT82NIXmL2DINqscoulc6a+pd6CTXZAp4ex/e+TTny1Mo9C/Qr2uxOSIzzHJshjeeX5BhwLy5XAJbd4+4LbvnQ4u6AFubPrdRWMFe7EYqsdvdyvx/TlHrA4KYQ/bf72UgZSTsiV5CGSR6B4hiuJoAt7kqhWW+ybuhNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649077; c=relaxed/simple;
	bh=LrvExHeszfpU1ByAWylPdyV4ejnYrr0R2k/TkUfeNII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mk28Db2ubP4LWRbQQfnRYPs0Taa8Nc3m03C3FWFwNryG+gcP0bjG/LqGDxyvyI/hB9hSnoQ/ygvLgotr7nSlVC0UEJSj+ZBe71q1gSH9m4UUx87gJLMIpzheFvRFMnJD6Qrhkrmxl7UhPcAjszLiZR2Xuy+ia2IgZry4Aceblgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+9Tz8LC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+9Tz8LC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9717A1F00898;
	Fri,  5 Jun 2026 08:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780649076;
	bh=74Rfk+yVMTJe1DhjbNVT4f66L3XVI70CTDaqI4Gfif8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T+9Tz8LCFNlh5SPy7jiupYEuJr2f2gTxy6ugozL9iShrTXO7NHYNogiEaeyhmm9RF
	 MIB+dxdvmLIJhhywiQFKHLuNdEblt937TxU+tcybqLp5vmJ3zdoFsvAiQ1zVoTb8xX
	 T6xx/0sy4LICeFvaPtX10WPQaZwO5GtyHvwSEa3sQdiAaqOuxPWliYGOozEca7IqyJ
	 0HNWYWVGmqi3J0ZNgbnvzTfLOUfv84p7EVR0/CibBbuCo8BplmP9kVfkCVHquuughB
	 hki2bHNHnRmZA+QxKERJG/rCkJ7f8lV1RIYMtZuAtMDpVEDIiYEFwCZ7sWevs398Of
	 nP3id1unJXA+A==
Date: Fri, 5 Jun 2026 10:44:31 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 7/8] x86/msr: Switch wrmsr_safe_on_cpu() to use a 64-bit
 quantity
Message-ID: <aiKMbzEat0E2Op9A@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <20260605070826.2995913-8-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605070826.2995913-8-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> In order to prepare retiring wrmsrq_safe_on_cpu() switch
> wrmsr_safe_on_cpu() to have the same interface as wrmsrq_safe_on_cpu().

This should be patch #1.


> Switch all wrmsr_safe_on_cpu() callers to use the new interface.

This should be patch #2.

Thanks,

	Ingo
