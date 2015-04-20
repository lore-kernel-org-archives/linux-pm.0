From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 1/1] x86: replace cpu_up hard-coded mdelay with variable
Date: Mon, 20 Apr 2015 12:37:52 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94846861500@fmsmsx115.amr.corp.intel.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
 <87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com>
 <20150420071306.GA14315@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12504 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbbDTMhz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 08:37:55 -0400
In-Reply-To: <20150420071306.GA14315@gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

> What's the cutoff for 'modern hardware' - which CPUs stopped requiring
> the delay?

This is the topic of ongoing research, and I'm not ready to send
the patch setting a new default until I've heard back from a few more HW people.

Every system I've tested appears to work with delay 0.
Were I to guess, I'd venture that every
system that runs an X86_64 kernel might count as "modern" -- even
the 2005 AMD Turion laptop I've got in the bone pile.

> Also, is there any public document where the no-delay is specified for
> 'modern hardware'?

Unfortunately only the converse is true.  There is an ancient document specifying
that the delay may be necessary.

cheers,
-Len

