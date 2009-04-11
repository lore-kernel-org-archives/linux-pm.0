From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
 (minor but annoying) audio problem
Date: Fri, 10 Apr 2009 18:19:44 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904101817100.4583__7063.66028539396$1239413181$gmane$org@localhost.localdomain>
References: <200904100057.43827.rjw@sisk.pl> <200904102058.36018.rjw@sisk.pl>
	<alpine.LFD.2.00.0904101204350.4583@localhost.localdomain>
	<200904110206.33525.rjw@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904110206.33525.rjw@suse.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Sat, 11 Apr 2009, Rafael J. Wysocki wrote:
> 
> On Friday 10 April 2009, Linus Torvalds wrote:
> > 
> > On Fri, 10 Apr 2009, Rafael J. Wysocki wrote:
> > > 
> > > I've just verified that the resume-after-hibernation issue goes away after
> > > reverting commit 9710794383ee5008d67f1a6613a4717bf6de47bc
> > > (async: remove the temporary (2.6.29) "async is off by default" code) , so it
> > > is async-related.
> > 
> > Arjan? Clearly all the necessary fixes weren't found..
> > 
> > There _is_ a module loading problem wrt initmem - I think you found that 
> > and we added a hack for it for the ACPI battery driver. I wonder if we're 
> > hitting a similar issue now with module discovery: modules that use 
> > "async_schedule()" to do their discovery asynchronously are now not 
> > necessarily fully "done" when the module is loaded. 
> > 
> > And so, anything that expected the devices to be available after module 
> > load (like they used to) would be screwed.
> > 
> > IOW, maybe something like the totally untested patch appended here (that 
> > should also allow us to make the ACPI battery code to go back to using 
> > __init).
> 
> I tested it and it worked.

Hmm.

I'm not 100% sure that patch is good.

The reason? I think it's going to deadlock if an async caller ends up 
wanting to load a module, because then the nestecd 
"async_synchronize_full()" will basically want to wait for itself.

So it's a good test-patch, and maybe no async caller ever loads a module, 
but it makes me a bit nervous.

But the fact that it fixes things for you at least means that the _reason_ 
for the problem is know, and maybe there are alternative solutions. Arjan?

		Linus
