Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA338331D;
	Mon, 13 Jul 2026 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942152; cv=none; b=jdLhzuVAF+o9AoRMu60BiBOf6W2/cOFna9hkdYiQUVphfuWLoSGx8rYiaj7Fjj8RvsStVvNpWIPhofUGq2tYMSEvK5YKElO+Xv8PXE0YGdNKeaL/OFgQVTP69mC8KgsEPe1Y3NhBO31zAGnLnfzXsj6s3ttk6hyeo2780uPeNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942152; c=relaxed/simple;
	bh=Ux+WKlVeYA6sJizOb0ejloUgcIsnVU7fF0wdjRJ/zB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK51PFHmASC4Nf6py/OHMf+MmASz4acsvrzCDCAHA5QWRTEtYNR5D9v7BnUWxwb4f8Kcn9E/CtfqLDNwQCBCovJ4090Z3LzYF5XttT+Ad7OJxzl8g2GiwzVpB1yOjqZT0abNMJOWKG8ZevrClC1ua3gIMg3I6vpp5KQAhq7du4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqnnp02f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqnnp02f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAC71F000E9;
	Mon, 13 Jul 2026 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783942150;
	bh=bBOMi5ERjxXTpbuU6AYGlznEKf7k1Qh4zyk3TT77bBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jqnnp02fK1OpXuVP1jbG6qX0pu7akpGwxSYluPS9+bV8fEUGNvZQLXNBSggcrqXh8
	 VeUmyfU3DwDJrcDSJdoRv2qr38azMpo77yXVTCLKDbv9XZxw7hqWWvcjR5i7UZF5BI
	 eagNHxNxzJRy/Z0waa8e/c7jeLdQnUmnqFObwiM1ITjVOQtISITIY2zVaRBhxhyWPw
	 y4U6xOBYoOKEGIBjAW1w6NxgtrHl1o3a77tjvdMNY9HQQjBz4tVyJd7CwmCD9+Q4Bt
	 nOR51jx/4rcjkOX/5EPTXqeG7/FQbNKM8LKY6AzP6KsFCSunbzJOccHvqtD2pjU2Jd
	 0jmM6wSm/LDjA==
Date: Mon, 13 Jul 2026 12:29:08 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 04/17] ACPI: processor: idle: Rearrange
 acpi_processor_evaluate_lpi()
Message-ID: <20260713-ultraviolet-toad-of-patience-1aea5f@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <3426078.44csPzL39Z@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3426078.44csPzL39Z@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:33:41PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Rearrange acpi_processor_evaluate_lpi() to make it somewhat easier to
> follow and diagnose (if need be).  In particular:
> 
>  * Rename some local variables and reorder their definitions.
> 
>  * Change the type of local variables used for storing firmware-provided
>    values to unsigned int (they cannot be negative).
> 
>  * Eliminate local variable "loop" that is redundant.
> 
>  * Avoid explicit pointer arithmetic.
> 
>  * Print the correct number of _LPI state packages in the final debug
>    message.
> 
> No intentional functional impact beyond debug output.
> 

Nice cleanup/refactoring.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
