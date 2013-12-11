From: Ingo Molnar <mingo@kernel.org>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Wed, 11 Dec 2013 16:09:11 +0100
Message-ID: <20131211150911.GA11048@gmail.com>
References: <alpine.DEB.2.02.1312101458040.28330@ionos.tec.linutronix.de>
 <alpine.DEB.2.02.1312110030330.28330@ionos.tec.linutronix.de>
 <1386732093.5964.6.camel@marge.simpson.net>
 <alpine.DEB.2.02.1312111206200.28330@ionos.tec.linutronix.de>
 <20131211113839.GF21683@pd.tnic>
 <20131211115239.GA21999@twins.programming.kicks-ass.net>
 <1386764955.12005.60.camel@marge.simpson.net>
 <20131211124352.GB21999@twins.programming.kicks-ass.net>
 <20131211144238.GA4510@gmail.com>
 <alpine.DEB.2.02.1312111556390.28330@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:41739 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab3LKPJQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2013 10:09:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1312111556390.28330@ionos.tec.linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <bitbucket@online.de>, Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 11 Dec 2013, Ingo Molnar wrote:
> > 
> > Another thing that is required I think is to issue a write barrier 
> > before CLFLUSH instruction. By my (possibly incorrect ...) reading of 
> > the documentation CLFLUSH does not appear to be ordered (at all), so 
> > it might execute before the modification to the affected memory?
> 
> We already have a write barrier in the code which modifies
> current_thread_info()->flags.

Which code is that, could you please cite it? (I tried finding it but 
my grep-fu failed me.)

Thanks,

	Ingo
