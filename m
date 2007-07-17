From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec
	base	hibernation
Date: Tue, 17 Jul 2007 13:59:31 +0200
Message-ID: <200707171359.33317.rjw__44687.8491355621$1184673226$gmane$org@sisk.pl>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<1184491804.1898.121.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707170101010.19248@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707170101010.19248@asgard.lang.hm>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 17 July 2007 10:13, david@lang.hm wrote:
> Ying, as the kexec guru in this thread I have a question for you about how 
> kexec works (and possibly where you are going with this)
> 
> for the power-off hibernate with ACPI disabled the hibernation seems 
> fairly straightforward (although there are still some missing pieces)
> 
> however, since the resume designed for ACPI won't work would the following 
> approach work
> 
> 1. boot one kernel
> 2. setup a kexec the same way you would for hibernate
> 3. kexec to the new kernel
> 4. overwrite the memory of the first kernel
> 5. kexec 'back' to the main kernel that has now been overwritten by what was saved?
> 
> as part of this question, when you do a kexec, how does the kernel that 
> you are doing the kexec to know what to run next?
> 
> it needs to do some initialization first before it starts running normal 
> things, and at that point it the move back doesn't look for init like a 
> normal kernel boot (or the system would effectivly boot instead of picking 
> up where it left off)
> 
> is this 'restart point' flexible enough that either the pre-hibernate 
> kerenl or the small hibernate kernel could tell the pre-hibernate kernel 
> to go into suspend-to-ram mode before doing anything else?
> 
> Rafael,
>    if ACPI is disabled and not used, is there any memory in the origional 
> kernel that _must not_ be saved in the hibernate image? I recognise that 
> for efficancy it would save time to not save free memory, but if I'm 
> willing to waste some resources would it hurt to save everything?

On some systems there are valid 'struct page' structures that correspond to
memory holes and the kernel will oops if you try to save the contents of
these pages.  Unfortunately, only the early initialization platform code can
tell you which they are.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
