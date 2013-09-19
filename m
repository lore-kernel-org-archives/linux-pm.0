From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v1 5/6] bitops: Introduce BIT_ULL
Date: Thu, 19 Sep 2013 11:34:01 -0700
Message-ID: <1379615641.22168.15.camel@joe-AO722>
References: <1379606435-15871-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1379606435-15871-6-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20130919164830.GB9427@pd.tnic> <523B2F57.2050504@linux.intel.com>
	 <20130919172819.GD9412@pd.tnic> <1379614490.22168.7.camel@joe-AO722>
	 <523B43BC.2020701@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0249.hostedemail.com ([216.40.44.249]:35728 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752045Ab3ISSeF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2013 14:34:05 -0400
In-Reply-To: <523B43BC.2020701@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com

On Thu, 2013-09-19 at 11:34 -0700, Srinivas Pandruvada wrote:

> Let's do in two steps:
> - In the next patcheset I will add BIT_ULL_MASK and BIT_ULL_WORD in 
> addition to BIT_ULL
> - Once this series is approved, submit a separate patch to change BIT_64 
> to BIT_ULL

Fine by me.


