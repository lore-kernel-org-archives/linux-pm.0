Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FC39B943;
	Mon, 13 Jul 2026 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942059; cv=none; b=HIqN8Kch7Na+igzgeggBz2OSzD225r/fK/xqu28YKJGpYmXL7115CoFkwQUJ5H5tvHw3lfjkbRS5bZCRlZlkkNn9ofEP0tq7aUGuVYykIeIoOMfWhBgPW/98C+nuvTl5fJ9/STwnBb953vZ1XCf6iWhgxyG8vvdeDxs0w8zFSSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942059; c=relaxed/simple;
	bh=HyeG5MvmGoLPxHK7pmmBrFUWfr84IxIkjZe3LvRiV8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm7wgKrovZSgsl8aERdqvZyOX7QiFnlOO3fgZVA/nA9TMy/sSGriFV+HcdbohdYWY+NTa7fxVsimWDHrEPRC5JDHpRlyVpq0U+xhORG6hzDUIZwM4wqfvqQVGyt6sswJw5zYGSTJFIjF4FUHS+QKQyPGy7eFjf+B77ZRuBWpcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdFuRItp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdFuRItp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD941F000E9;
	Mon, 13 Jul 2026 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783942057;
	bh=BEXP9qiP6A9Bz9t1BlchO24VKc5OCRCD+xWkPyejdrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BdFuRItp1QjjdA7xE7t+wSdbhUkdLeN2hQOAlMf2CFQqUszZyCPIAxPDo5MPan50Q
	 o3VLWUo8sw3b124mHmtusf4rkImmJQE/tzyp7176dS18hMUi8AVXy+DRzgPNd5kmKU
	 mZ2lTq0KGrbUJmPVT8LKRovlsOtkkhulfnugHXj4ne6ZXsKLqUM3thaVXZSj+0BK2q
	 YNZs27mqPoYNrqtFcsGbDJjBOK20bQ7VQw5u1kKhAgBlBlIAVPqO7mxRqoc/7zGaNJ
	 1mN64fXQ1mO6vKSQCXb+MizXbpgwNdHjiCWvTU3wUj0huzsK3hPvljAkbrL0/6K+kZ
	 KfqQF2tEeMFzg==
Date: Mon, 13 Jul 2026 12:27:35 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 03/17] ACPI: processor: idle: Unify debug in
 acpi_processor_evaluate_lpi()
Message-ID: <20260713-attractive-asparagus-tarsier-f504a2@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <3051550.e9J7NaK4W3@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3051550.e9J7NaK4W3@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:32:15PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Use acpi_handle_debug() consistently for printing debug messages in
> acpi_processor_evaluate_lpi() because that makes it somewhat easier
> to identify the source of the problem in the ACPI tables.
> 
> No intentional functional impact beyond debug output.
> 

Any reason why you didn't want to straight away introduce lpi_state_debug()
as done in 06/17 ?

Either way, I am fine.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
