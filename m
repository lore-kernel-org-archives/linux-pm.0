From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/10] x86: assembly, ENTRY for fn, GLOBAL for data
Date: Wed, 1 Mar 2017 11:09:16 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703011108220.4005@nanos>
References: <20170217104757.28588-1-jslaby@suse.cz> <20170301093855.GA27152@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38739 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdCAKJp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 05:09:45 -0500
In-Reply-To: <20170301093855.GA27152@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Slaby <jslaby@suse.cz>, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Wed, 1 Mar 2017, Ingo Molnar wrote:
> 
> * Jiri Slaby <jslaby@suse.cz> wrote:
> 
> > This is a start of series to unify use of ENTRY, ENDPROC, GLOBAL, END,
> > and other macros across x86. When we have all this sorted out, this will
> > help to inject DWARF unwinding info by objtool later.
> > 
> > So, let us use the macros this way:
> > * ENTRY -- start of a global function
> > * ENDPROC -- end of a local/global function
> > * GLOBAL -- start of a globally visible data symbol
> > * END -- end of local/global data symbol
> 
> So how about using macro names that actually show the purpose, instead of 
> importing all the crappy, historic, essentially randomly chosen debug symbol macro 
> names from the binutils and older kernels?
> 
> Something sane, like:
> 
> 	SYM__FUNCTION_START

Sane would be:

     	SYM_FUNCTION_START

The double underscore is just not giving any value.

Thanks,

	tglx
