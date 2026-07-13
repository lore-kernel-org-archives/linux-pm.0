Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44C4229A3;
	Mon, 13 Jul 2026 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948687; cv=none; b=nDFCwoLA2ST4duxMChHKRvMMWKMugRoBo9NC+pJm/jl8rjSBpBeISCcyqdI+cSSULRBCHXnCU5mvMN5NLuSVkmA+WNzEUiDxpoOZrXXkxPR2mciFjadwsLTw6By1xIQKe3HauMtW/RTjDGKeGzxJzG+iyH3WPQKqgV2eyGbfzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948687; c=relaxed/simple;
	bh=lVnuL+MP6vF2ebXuk2mTC1c2xeDUP5phi1bNiG4BI50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtULoJ6ksAqxSiJYVDdjblzOaXSUiQIX4PH6nPFMSr+TzQGqqyPkGZGW8IU3F/1N2uDdXOW65j4L6hTwsjeNze/ncgtBjoqwMJMAln3MzR20BSJsH2lR/qIHzJaOr9oLBOg2YmBZZUesf8AmF/tWPJM6Sb+cTNFXLzbwhj80JEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzDPOY75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzDPOY75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE721F000E9;
	Mon, 13 Jul 2026 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948686;
	bh=dPkxTd8ulHYTR96R53pbdGlE76A0kuPjAVeZnyK2exw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TzDPOY75We+4yVEQXTdJoThAxLc5IunbSFCSxEHSN8Q0jhQticL+lprpu7o2H5EI0
	 JZLd8tGr4DYa9/18hVaiAj4jdvYdMdDMBhITgT8VRs/3jvsoHwXTEy8qu8ig20NYcI
	 FUwKy2RQpUQ/2OnknrblZ7lOar56BBy4nLoizy0K7FlNMdqlDC2YyGuGK5jiXyht5Y
	 JSRLOvD/ZaLklf/QRP+0KB2TRVRohFDb6BFFnylrp4Rv6FqDY5V1m6Sza1VMkLTZsu
	 8Jt9HO8H+MHo4U7OxaLcHVJ1akxg/Ck1tv7dCXSr2pqyyJxXe+ICj4Wzxw93n5Rz9q
	 pc4IZ2YiL3W4w==
Date: Mon, 13 Jul 2026 14:18:03 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 07/17] ACPI: processor: idle: Rearrange
 acpi_processor_get_lpi_info()
Message-ID: <20260713-furious-sawfish-of-elegance-f5c6db@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <7965163.EvYhyI6sBW@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7965163.EvYhyI6sBW@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:36:28PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Reorder the definitions of local variables in
> acpi_processor_get_lpi_info() and drop local variable
> pr_ahandle that is not really necessary from it.
> 
> Additionally, move two definitions of local variables to
> the loop in which they are used and rearrange the code
> slightly to prepare it for subsequent changes.
> 
> No intentional functional impact.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
