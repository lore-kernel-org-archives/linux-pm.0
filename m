From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH, DEBUG] x86/32: Add small delay after resume
Date: Wed, 17 Jun 2015 14:29:40 -0400
Message-ID: <20150617182939.GA11465@x230>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20150612060747.GA25024@gmail.com>
 <1434125724.2353.19.camel@spandruv-DESK3.jf.intel.com>
 <20150613071547.GA27446@gmail.com>
 <1434384627.2353.47.camel@spandruv-DESK3.jf.intel.com>
 <55809616.80204@zytor.com>
 <20150617163350.GA7250@l.oracle.com>
 <5581ACE9.1010005@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43870 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbFQSam (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2015 14:30:42 -0400
Content-Disposition: inline
In-Reply-To: <5581ACE9.1010005@zytor.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, mingo@redhat.com, tglx@linutronix.de, pavel@ucw.cz, rjw@rjwysocki.net, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Denys Vlasenko <dvlasenk@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Kleen, Andi" <andi.kleen@intel.com>

On Wed, Jun 17, 2015 at 10:22:49AM -0700, H. Peter Anvin wrote:
> On 06/17/2015 09:33 AM, Konrad Rzeszutek Wilk wrote:
> >>>>
> >>
> >> Where does the GDT get initialized?
> >>
> >> 	-hpa
> > 
> > mit 84e70971e67d97bc2db18a4e76d42846272a54bd
> > Author: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Date:   Fri Apr 5 16:42:22 2013 -0400
> > 
> >     x86-32, gdt: Store/load GDT for ACPI S3 or hibernation/resume path is not needed
> > 
> 
> Store, no.  LOAD?

__save_processor_state:
..
  /*
         * We save it here, but restore it only in the hibernate case.
         * For ACPI S3 resume, this is loaded via 'early_gdt_desc' in
         * 64-bit
         * mode in "secondary_startup_64". In 32-bit mode it is done via
         * 'pmode_gdt' in wakeup_start.
         */

> 
> 	-hpa
> 
> 
