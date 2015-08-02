From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] x86: replace RDRAND forced-reseed with simple sanity
 check
Date: Sun, 2 Aug 2015 20:50:21 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508022050010.3825@nanos>
References: <001e354e9435443b1720838a111620c4eec12a61.1438356386.git.len.brown@intel.com> <20150802174239.GD58373@unpythonic.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58260 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbHBSup (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 14:50:45 -0400
In-Reply-To: <20150802174239.GD58373@unpythonic.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
Cc: Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Sun, 2 Aug 2015, Jeff Epler wrote:

> On Fri, Jul 31, 2015 at 11:27:39AM -0400, Len Brown wrote:
> >  	if (!cpu_has(c, X86_FEATURE_RDRAND))
> > -		return;		/* Nothing to do */
> > +		return;
> 
> Why remove this comment?

Because it's pointless.
 
