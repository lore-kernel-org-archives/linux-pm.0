Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7387737756F;
	Thu,  4 Jun 2026 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566144; cv=none; b=OYLHPag4dwh7PhPRL/KRDZNNB76l4CCWqQmOHeJJTICF2AR7YDneVFmnoDOAyGL4+sb6JAJ4hycklyrDhrbfzR9YrZwduHwKQEMwnuRBZt8lSVXhowMGI9cj/+wS03tPAtjOLIJUAOAhBOAj2j/HUU/PizqA6Lf5bxL0548HadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566144; c=relaxed/simple;
	bh=1jM0IDHr8rcwgeUz3Xxf6kPLSdd0L8Q/7S5zgog9N58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn2F6pqbAqG1hCMpG5N408tuSYYsWDn7M0UBRrxWwRmnfuXynQEKxwUajHCN8efWR3h1alPR67tBtP6yJeIxhiZ9+OaqjyonWIiKrSVkpBHHa4z33Y62Wesqx3Voi73Ny5iZB+FE82MZhU9lL//CFy59Q/hIb9ovkM6L2gl7c/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XyqCBQim; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XyqCBQim"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nyZGi977o/Z35bQOZClTizAiB3Nxdk09GSq+5nhrWGY=; b=XyqCBQimASE/GNulcxZYkp3lkc
	r/IVWvbIS1KRJ45Ly/BXX5WKQ42AxMW88GOecwTuwBViaLHdE1ypW2d66KO5VOrNtdZBuRLVjmroK
	4aUXWRZ0Ca3XPO5an2Kp1CBGSXNsbe8wpdwD514q/60eKynYxf5goFv0ZhxTOSKbDqZ0Gu1a/szwk
	CcareQFTKoofqzB24Zy91Q2Q8/Ya8BwlMKN90biLoLQE2ux2hHEm+un8lC6BzHJ6EtWOhCpZnU6Ll
	ZYVS+Kdttf0izE4Vq0T80BmzTL+F6cwbQMVU9LsXJJKjtG2Yjnat2+6c2i3ORX1jZnD9AMgI6qJh/
	FTzFMJkQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wV4ae-004QLs-0O;
	Thu, 04 Jun 2026 09:42:16 +0000
Date: Thu, 4 Jun 2026 02:42:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-pm@vger.kernel.org, sumitg@nvidia.com, pierre.gondois@arm.com, 
	zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, viresh.kumar@linaro.org, 
	rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cppc: Reduce cppc delivered perf sampling jitter
Message-ID: <aiFHsZ_Ha1DKIm8N@gmail.com>
References: <20260602212052.1278365-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602212052.1278365-1-jeremy.linton@arm.com>
X-Debian-User: leitao

On Tue, Jun 02, 2026 at 04:20:52PM -0500, Jeremy Linton wrote:
> CPPC uses a pair of registers cycling at different frequencies to
> determine an accumulated performance level. For userspace reporting we
> want to convert this to an instantaneous CPU frequency, but over short
> time periods small errors caused by CPPC counter reads can cause
> fairly significant reported frequency variations even when the core
> CPU clock isn't changing.
> 
> Reduce this by keeping a start sample fixed and retrying the end
> sample until the counter deltas are large enough to reduce short
> window error, or until adjacent delivered performance estimates are
> within the CPU's observed CPPC read noise floor.
> 
> To begin, resample the initial pair a small fixed number of times
> looking for matching delivered performance deltas.  This reduces the
> chance that a disturbed start sample anchors the rest of the
> calculation.
> 
> Then look for an end sample while updating the noise floor from the
> best error seen between samples.  The floor remains zero on systems
> with stable feedback reads, but lets noisy systems stop early once
> another retry is unlikely to improve the result.  The retry loop is
> capped at 200 iterations, giving an ~20 usec explicit delay budget
> derived from ndelay(100).
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Tested-by: Breno Leitao <leitao@debian.org>

I've tested this on my grace host, checking "cat
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq" thousand times,
and the result is quite good, reducing the Std Dev by 5x, and getting
a better value.

# cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
 3339000

Baseline:
	Average: 3505050.00
	P50 (Median): 3388500.00
	Std Dev: 462607.66
	Min: 2709000.00
	Max: 4464000.00


Wth this patch:
	Average: 2393550.00
	P50 (Median): 2394000.00
	Std Dev: 68629.06
	Min: 2241000.00
	Max: 2529000.00

Thanks,
--breno
