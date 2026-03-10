Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0AA311969;
	Tue, 10 Mar 2026 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180940; cv=none; b=tpOwskAjJR7/0ARwfW2soUDosYB+bUHoHBksIMcp9PAdCCtFZy2BRnzH/mpt1G53ldy/cxA8d8ADoU4gBKOePliqLiWiFdBfE0WxpVUISZMdhw4827fGWnFzYj+DsgSbutAU0Ax2jRCW7H5v1yg1KEkN0sT03XKRRgoRNFlKM/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180940; c=relaxed/simple;
	bh=Zs6MWsmCoBCTVRwHPKIGFCa8tRMap4jx9Lim1fCq984=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3aGAb5m4CqroadHgPckllVE8yK08ljNnUXZVI9amryT/0lsJkEeiPRBO6peqHuyUW8lC21sm58dQCoWvbE/VOj7RtzsG8q4uq5hM2p6I5rLTt6NnIoK+MKk3QPiOTA72WUae93Je2w43pFT++ztOlYUzmsVJe6EM4UdMUkeNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuUJTCPZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuUJTCPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773180938; x=1804716938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zs6MWsmCoBCTVRwHPKIGFCa8tRMap4jx9Lim1fCq984=;
  b=VuUJTCPZYf0CT84f4Wtj6cVMrlhRsQiikYd1b60VECGj/1CFhnUe1RVl
   8j4R+RKob5b5y51xsmcsB+XSW4WxP0suvJ3ywkPH8noL7sLzql5rFrLdB
   egafBlg1c7R6OtOFAahsY4d07RF2mMC4oAW+8YIjbhAHlQS97cnbtu9Fb
   gQaQcYLYsgkDMib+1/SD5D+M6Rm59sOJbz7qlO2Nj+TXi4uT+O9AeXmJp
   qKAChGW8HXu7+lF3LsiU0jCw1Y0hyfdiuPYbycAZNhpVeHV/xU1n+Ogz2
   K5ea6wpY4D4nE506f9Xn1HH73u61MC1FXBbYCamv4eI6AKbFs76RB+0lq
   w==;
X-CSE-ConnectionGUID: RQXQWa1ZQrO7mHvvxG6mww==
X-CSE-MsgGUID: 025EdiriTEq0Q/0WlGrI7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73438938"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="73438938"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:15:37 -0700
X-CSE-ConnectionGUID: fJ7FSCmpThCNXPEiqkR4oA==
X-CSE-MsgGUID: QeVm2h5ySPWjfDIPcvWT7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="218179507"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:15:37 -0700
Date: Tue, 10 Mar 2026 15:21:11 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH 1/4] x86/thermal: Add bit definitions for Intel Directed
 Package Thermal Interrupt
Message-ID: <20260310222111.GA24122@ranerica-svr.sc.intel.com>
References: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
 <20260309-rneri-directed-therm-intr-v1-1-2956e3000950@linux.intel.com>
 <20260310093530.GAaa_l4ij2mAgKEFbb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310093530.GAaa_l4ij2mAgKEFbb@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Mar 10, 2026 at 10:35:30AM +0100, Borislav Petkov wrote:
> On Mon, Mar 09, 2026 at 03:19:24PM -0700, Ricardo Neri wrote:
> > Add CPUID and MSR bit definitions required to support Intel Directed
> > Package Thermal Interrupts.
> > 
> > A CPU requests directed package-level thermal interrupts by setting bit 25
> > in IA32_THERM_INTERRUPT. Hardware acknowledges by setting bit 25 in
> > IA32_PACKAGE_THERM_STATUS, indicating that only CPUs that opted in will
> > receive the interrupt. If no CPU in the package requests it, delivery
> > falls back to broadcast.
> > 
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 1 +
> >  arch/x86/include/asm/msr-index.h   | 2 ++
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index dbe104df339b..487bf9da0cef 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -364,6 +364,7 @@
> >  #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* "hwp_pkg_req" HWP Package Level Request */
> >  #define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* HWP Highest perf change */

Thank you very much for your comments, Boris!

> >  #define X86_FEATURE_HFI			(14*32+19) /* "hfi" Hardware Feedback Interface */
> 
> Leave a space here to denote there's a hole

Sure.

> 
> > +#define X86_FEATURE_DIRECTED_PKG_THRM_INTR (14*32+24) /* Intel Directed Package Thermal Interrupt */
> 
> Also, can we agree on one naming and stick to it?
> 
> What you have there basically screams "OMG, I am trying to say *everything*
> in that single define name but there's no room." :)

Indeed, I had the feeling.

> 
> Also, the defines you have here are all a little bit different and good luck
> matching what is what in a couple of months.
> 
> So, how about
> 
> #define X86_FEATURE_DPTI	 (14*32+24) /* Intel Directed Package Thermal Interrupt */
> 
> and the comment explains what the acronym is?

Sure, I will take your suggestion.

> 
> >  /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
> >  #define X86_FEATURE_NPT			(15*32+ 0) /* "npt" Nested Page Table support */
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index 6673601246b3..aa1c652a9581 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -995,6 +995,7 @@
> >  #define THERM_INT_HIGH_ENABLE		(1 << 0)
> >  #define THERM_INT_LOW_ENABLE		(1 << 1)
> >  #define THERM_INT_PLN_ENABLE		(1 << 24)
> > +#define THERM_DIRECTED_INTR_ENABLE	(1 << 25)
> 
> And then you can do:
> 
> #define DPTI_ENABLE	(1 << 25)

Would it be OK to name it THERM_DPTI_ENABLE? It would be more consistent
with the naming of the other bits.

> 
> >  
> >  #define MSR_IA32_THERM_STATUS		0x0000019c
> >  
> > @@ -1024,6 +1025,7 @@
> >  
> >  #define PACKAGE_THERM_STATUS_PROCHOT		(1 << 0)
> >  #define PACKAGE_THERM_STATUS_POWER_LIMIT	(1 << 10)
> > +#define PACKAGE_THERM_STATUS_DIRECTED_INTR_ACK	(1 << 25)
> 
> Ditto here:
> 
> 	DPTI_ACK

Same here, would it be OK to name it PACKAGE_THERM_DPTI_ACK for consistency
with other bits' names?

> 
> And you can always add comments explaining the acronym...

Sure.

Thanks and BR,
Ricardo
