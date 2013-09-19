From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v1 5/6] bitops: Introduce BIT_ULL
Date: Thu, 19 Sep 2013 19:28:19 +0200
Message-ID: <20130919172819.GD9412@pd.tnic>
References: <1379606435-15871-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1379606435-15871-6-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20130919164830.GB9427@pd.tnic>
 <523B2F57.2050504@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:52633 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab3ISR2Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 Sep 2013 13:28:25 -0400
Content-Disposition: inline
In-Reply-To: <523B2F57.2050504@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com

On Thu, Sep 19, 2013 at 10:07:35AM -0700, Srinivas Pandruvada wrote:
> The current definition for BIT_64 is in arch/x86/include/asm/bitops.h.
> I feel it should be applicable for all architectures and move to some
> common file.

Feel free to move it there or change BIT_64 to BIT_ULL or whatever ...
just don't add yet another redundant macro.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
