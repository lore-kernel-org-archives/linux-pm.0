From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v1 5/6] bitops: Introduce BIT_ULL
Date: Thu, 19 Sep 2013 20:48:55 +0200
Message-ID: <20130919184855.GG9412@pd.tnic>
References: <1379606435-15871-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1379606435-15871-6-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20130919164830.GB9427@pd.tnic>
 <523B2F57.2050504@linux.intel.com>
 <20130919172819.GD9412@pd.tnic>
 <1379614490.22168.7.camel@joe-AO722>
 <523B43BC.2020701@linux.intel.com>
 <1379615641.22168.15.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33412 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434Ab3ISStA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 Sep 2013 14:49:00 -0400
Content-Disposition: inline
In-Reply-To: <1379615641.22168.15.camel@joe-AO722>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com

On Thu, Sep 19, 2013 at 11:34:01AM -0700, Joe Perches wrote:
> On Thu, 2013-09-19 at 11:34 -0700, Srinivas Pandruvada wrote:
> 
> > Let's do in two steps:
> > - In the next patcheset I will add BIT_ULL_MASK and BIT_ULL_WORD in 
> > addition to BIT_ULL
> > - Once this series is approved, submit a separate patch to change BIT_64 
> > to BIT_ULL
> 
> Fine by me.

+1.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
