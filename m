From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/1] x86 TSC: set X86_FEATURE_TSC_RELIABLE, per CPUID
Date: Mon, 01 Jun 2015 11:40:04 -0700
Message-ID: <556CA704.1070000@kernel.org>
References: <f1643565587e70dd2fe2714e9afa566689211a9a.1433050960.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32865 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909AbbFASkL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 1 Jun 2015 14:40:11 -0400
In-Reply-To: <f1643565587e70dd2fe2714e9afa566689211a9a.1433050960.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

On 05/30/2015 10:44 PM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>
> Speed cpu_up() by believing CPUID's "invariant TSC" flag,
> and skipping the TSC warp test on single socket systems.

I'm typing this email on a "Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz" 
with a "X79A-GD65 (8D) (MS-7760)" motherboard.  (DO NOT BUY THAT 
MOTHERBOARD!)

The brilliant stock firmware breaks TSC sync on bootup.  Even with the 
updated firmware I'm using, it's broken on resume from S3.

If you want to make this depend on X86_FEATURE_TSC_ADJUST and confirm 
that all cores have the same IA32_TSC_ADJUST value, then maybe that 
would be okay.  Otherwise, please don't underestimate the malice^Wgross 
incompetence of firmware vendors.

--Andy
