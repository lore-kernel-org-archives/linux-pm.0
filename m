Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5B426D11;
	Mon, 13 Jul 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948912; cv=none; b=ErCgJy+n8Oop+KG3+8TrIufC/NzUunb/+s+A54Ewev8j+9Lc+M1rgs3W6ojNV4j4G+E31oqQVf8eSFS+boE1JB3CPwUyszjs/kVevOS7wRipW/U5HCMOALUjjdfyKEjM1+ByyX/PKFqyvFS16WloFn8MGZRxBNW799n2vWqk4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948912; c=relaxed/simple;
	bh=puC6y/lJbfkdrjauxlIjFLEcOPl/oT75/w9qXcKUQvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=essqRfMVFR3XvlQzJrueRqDpOpCaoqMviqMI987NHe+q1SJYz97lkx4LxQnJJsY96NzmPZYqu2xHvtdIqxyQPbnaBioBi/8Y50hH+grb6RWmkwx0+TID3OD43k0K7IcSWfTvr2G2tNY3yDVvblkyl5SGZOVE7vU4XN9GYz5vKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfXEekDC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfXEekDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AF61F000E9;
	Mon, 13 Jul 2026 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948911;
	bh=pFl9F1S05YuTvLSicuCTpFBR+n890HuaCQRwHnZaeys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BfXEekDCu1U/3CeGBFvEP3tKZ0CmiDifkNz2uX0pYoXWxVahb50r3TSTNJEmG18RU
	 76IsQ1OU+EKdSzgG9O6/YKe11b7X2dc1LVRShDL+e9dtb+pT0ciaNt1i6HI6muhVRN
	 9dWcEH0z08om/AZ9+iOLTx4gPvvu2nqIhpGqnavlGwn0NwMkICk0UZ/fYWQZEI4WMp
	 clP/0wobn8EaEKTj6iUJ0IiDNAALo4rOkbNieHkMusEORtgcJx+YzLFv9igqH8ZVte
	 mUEO3IVOkBtrS2CzNtTz2aiXLJVu+8qSR24YUlIw2BoJnL8LYEYM7vl3dXWqg1W1Jz
	 Oul1LNsJP2Bfg==
Date: Mon, 13 Jul 2026 14:21:48 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 10/17] ACPI: processor: idle: Rearrange loop in
 acpi_processor_get_lpi_info()
Message-ID: <20260713-dazzling-opalescent-pheasant-4aab3f@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <1862515.VLH7GnMWUR@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1862515.VLH7GnMWUR@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:38:29PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Eliminate local variable status (that is redundant) from
> acpi_processor_get_lpi_info() and make that function call
> acpi_get_parent() in one place.
> 
> No intentional functional impact.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
