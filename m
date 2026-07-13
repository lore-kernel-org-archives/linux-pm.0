Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DB40FD99;
	Mon, 13 Jul 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949445; cv=none; b=TDUvzFIvYRANb/kO8e1iRF6G2wTHd62erZo5NEn6O5b8FahxOJrMpLYZ2/nOA5/H7R+y8a1Lj6MvQv4D29Cjbqs0x8FlJy/PRryep0GYqZBZOOfrcE22kfzhMOsf8pMVeGKKqSrIwHaKMOe68mKFndcUcFffx9EE5tfPchyiFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949445; c=relaxed/simple;
	bh=5VI0L1GhB7ATzIBRuzGxK3SLhvrBErjEQz15xL1Y4C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwPadp/dTDSRquQNndwtAL41OBvq7e7pP/O/ncrcPCQdBWm0B2CQtP1WygGEYNqAq91ht/0DmnzDFYJYwRBp1PMb9ijjBRdrSsqj2GNJ9YJyjbf+cmseU9DKzDgKtqn26dqMwsh83QH7JaFiwoXTIwDdge9SB0NGMC839vUhOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H62ARIwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H62ARIwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF2B1F000E9;
	Mon, 13 Jul 2026 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949444;
	bh=0Cj+0CNtMf4fXMNU8zsoiMRR3yODObqVqvsAD0wI+/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H62ARIwG537MZqACbQf6/sgOOpM5SUbskv1HfVf3wm3+/9pggscDTV1R+JfI0T7/O
	 v4eF8RPnKMjzj8VWr5vS1U/IPiO+TtWbxjfsEvMppeVRz496kqb5sDXxp+nyrE2/n/
	 gqxevqtDSbHPpsMuNs78XHZiuwRYCYsgErcq2WTquCE3cPxpJfgkkbVhyKoAGuwkjG
	 545D86EPvsYE0QFUwt8diXRaIWpZuZK9fg4zcRPgeRldNUSmGl2+KBKz3NCnE6JdJy
	 OuuMSm+Kzq9LmkRjNV2LOV5NYDIHL7EPAOz+YUWO1tTtnquIXboUqHNlMe3yVOvV+b
	 I1f9NkZ+3eG6A==
Date: Mon, 13 Jul 2026 14:30:41 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 14/17] ACPI: processor: idle: Relocate
 acpi_processor_extract_lpi_info()
Message-ID: <20260713-awesome-excellent-wrasse-eece2f@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <2277662.Mh6RI2rZIc@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2277662.Mh6RI2rZIc@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:41:36PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In preparation for adding ACPI _LPI support to the intel_idle driver,
> move acpi_processor_extract_lpi_info() along with some static functions
> used by it to the acpi_processor.c file containing the non-modular part
> of the ACPI processor driver, so it can be called by external non-modular
> code like intel_idle.
> 
> However, export it to modules in the ACPI_PROCESSOR_IDLE import
> namespace so that the modular part of the ACPI processor driver
> can still invoke it.
> 
> No intentional functional impact.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
