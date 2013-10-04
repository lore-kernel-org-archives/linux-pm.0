From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 6/6] Introduce Intel RAPL power capping driver
Date: Fri, 04 Oct 2013 15:14:22 -0700
Message-ID: <1380924862.2081.118.camel@joe-AO722>
References: <1380904616-17519-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1380904616-17519-7-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1380910065.2081.117.camel@joe-AO722> <20131004131228.54eb7098@ultegra>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:39146 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752945Ab3JDWO0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2013 18:14:26 -0400
In-Reply-To: <20131004131228.54eb7098@ultegra>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com

On Fri, 2013-10-04 at 13:12 -0700, Jacob Pan wrote:
> On Fri, 04 Oct 2013 11:07:45 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > On Fri, 2013-10-04 at 09:36 -0700, Srinivas Pandruvada wrote:
> > > The Intel Running Average Power Limit(RAPL) technology provides
> > > platform software with the ability to monitor, control, and get
> > > notifications on power usage.
> > []
> > > diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
> > []
> > > +/* bitmasks for RAPL MSRs, used by primitive access functions */
> > > +#define ENERGY_STATUS_MASK      0xffffffff
> > > +
> > > +#define POWER_LIMIT1_MASK       0x7FFF
> > > +#define POWER_LIMIT1_ENABLE     BIT(15)
> > > +#define POWER_LIMIT1_CLAMP      BIT(16)
> > > +
> > > +#define POWER_LIMIT2_MASK       (0x7FFFULL<<32)
> > > +#define POWER_LIMIT2_ENABLE     BIT_ULL(47)
> > > +#define POWER_LIMIT2_CLAMP      BIT_ULL(48)
> > > +#define POWER_PACKAGE_LOCK      BIT_ULL(63)
> > > +#define POWER_PP_LOCK           BIT(31)
> > > +
> > > +#define TIME_WINDOW1_MASK       (0x7F<<17)
> > > +#define TIME_WINDOW2_MASK       (0x7FULL<<49)
> > 
> > 
> > Is there a reason why these masks aren't all ULL?
> > 
> > 
> 
> are you referring to this line below not being ULL?
> > > +#define TIME_WINDOW1_MASK       (0x7F<<17)
> if this is the case, I did that because it is not more than 32 bit.
> 
> Thanks,
> 
> Jacob

Isn't LIMIT1/WINDOW1 used as ull anyway?
It doesn't hurt to show that the value is also ull.

