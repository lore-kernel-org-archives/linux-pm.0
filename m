From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 04/20] x86, intel_idle: use Intel family macros for intel_idle
Date: Thu, 16 Jun 2016 22:39:16 -0400
Message-ID: <CAJvTdK=7WxkPp5wjaNrp1bsSRbgFfOQY23ryqMu--6ULH-Tnhg@mail.gmail.com>
References: <20160603001927.F2A7D828@viggo.jf.intel.com> <20160603001932.EE978EB9@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f68.google.com ([209.85.192.68]:33141 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbcFQCjS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2016 22:39:18 -0400
In-Reply-To: <20160603001932.EE978EB9@viggo.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Hansen <dave@sr71.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, jacob.jun.pan@intel.com, dave.hansen@linux.intel.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Jun 2, 2016 at 8:19 PM, Dave Hansen <dave@sr71.net> wrote:
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Use the new INTEL_FAM6_* macros for intel_idle.c.  Also fix up
> some of the macros to be consistent with how some of the
> intel_idle code refers to the model.
>
> There's on oddity here: model 0x1F is uniquely referred to here
> and nowhere else that I could find.  0x1E/0x1F are just spelled
> out as "Intel Core i7 and i5 Processors" in the SDM or as "Intel
> processors based on the Nehalem, Westmere microarchitectures" in
> the RDPMC section.  Comments between tables 19-19 and 19-20 in
> the SDM seem to point to 0x1F being some kind of Westmere, so
> let's call it "WESTMERE2".
>

>  #define INTEL_FAM6_NEHALEM_EP          0x1A
>  #define INTEL_FAM6_NEHALEM_EX          0x2E
>  #define INTEL_FAM6_WESTMERE            0x25
> +#define INTEL_FAM6_WESTMERE2           0x1F

Model 0x1F, like 1A and 1E is a Nehalem, not a Westmere.
This can be seen in the current SDM section 35.5.

For the historians, I believe that the name "Havendale" was originally
associated with that model# -- though I don't know if that binding persisted.

My NHM desktop is a 1A, though, not a 1F.

thanks,
Len Brown, Intel Open Source Technology Center
