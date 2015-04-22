From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/1] x86: replace cpu_up hard-coded mdelay with variable
Date: Wed, 22 Apr 2015 08:07:34 +0200
Message-ID: <20150422060734.GA25230@gmail.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
 <87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com>
 <CAP=VYLqofSyGmApHWF4wvidAZ+C0GCV7ScCYnSU2REaCPGywkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37075 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbbDVGHk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 02:07:40 -0400
Content-Disposition: inline
In-Reply-To: <CAP=VYLqofSyGmApHWF4wvidAZ+C0GCV7ScCYnSU2REaCPGywkg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Len Brown <lenb@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>


* Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> On Sat, Apr 18, 2015 at 8:53 PM, Len Brown <lenb@kernel.org> wrote:
> > From: Len Brown <len.brown@intel.com>
> >
> 
> [...]
> 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index b7d31ca..d2a91da 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -884,6 +884,21 @@ config SCHED_MC
> >           making when dealing with multi-core CPU chips at a cost of slightly
> >           increased overhead in some places. If unsure say N here.
> >
> > +config X86_INIT_MDELAY
> > +       int "Milliseconds to wait to de-assert INIT upon CPU startup" if SMP
> > +       range 0 10
> > +       default "10"
> > +       ---help---
> > +         This allows you to specify how long the BSP will delay
> > +         between asserting INIT and de-asserting INIT when starting another CPU.
> > +         This delay is paid on each cpu-online operation, including boot-time,
> > +         resume from suspend, and resume from hibernate.  The the value of
> 
> Happened to notice a 2x "The the..." when I came across this in 
> linux-next today and was reading the help out of curiousity...

Len, this commit isn't in a permanent Git tree yet, right? We want to 
do this through the x86 tree, and along the suggestions I made.

Thanks,

	Ingo
