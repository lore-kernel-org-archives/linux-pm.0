From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [SUSPECTED SPAM] Re: Proposal for a new algorithm
 for reading & writing a hibernation image.
Date: Sat, 05 Jun 2010 02:39:35 +0300
Message-ID: <1275694775.3853.29.camel__12313.7441267774$1275694837$gmane$org@maxim-laptop>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: TuxOnIce-devel <tuxonice-devel@tuxonice.net>, Nigel Cunningham <ncunningham@crca.org.au>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-06-03 at 16:50 +0200, Pavel Machek wrote: 
> 
> "Nigel Cunningham" <ncunningham@crca.org.au> wrote:
> 
> >Hi.
> >
> >On 30/05/10 15:25, Pavel Machek wrote:
> >> Hi!
> >>
> >>> 2. Prior to writing any of the image, also set up new 4k page tables
> >>> such that an attempt to make a change to any of the pages we're about to
> >>> write to disk will result in a page fault, giving us an opportunity to
> >>> flag the page as needing an atomic copy later. Once this is done, write
> >>> protection for the page can be disabled and the write that caused the
> >>> fault allowed to proceed.
> >>
> >> Tricky.
> >>
> >> page faulting code touches memory, too...
> >
> >Yeah. I realise we'd need to make the pages that are used to record the 
> >faults be unprotected themselves. I'm imagining a bitmap for that.
> >
> >Do you see any reason that it could be inherently impossible? That's 
> >what I really want to know before (potentially) wasting time trying it.
> 
> I'm not sure it is impossible, but it certainly seems way too complex to be
> practical.
> 
> 2mb pages will probably present a problem, as will bat mappings on powerpc.


Some time ago, after tuxonce caused medium fs corruption twice on my
root filesystem (superblock gone for example), I was thinking too about
how to make it safe to save whole memory.
Your tuxonice is so fast that it resembles suspend to ram.


I have radically different proposal.


Lets create a kind of self-contained very small operation system that
will know to do just one thing, write the memory to disk.
>From now on I am calling this OS, a suspend module.
Physically its code can be contained in linux kernel, or loaded as a
module.


Let see how things will work first:

1. Linux loads the suspend module to memory (if it is inside kernel
image, that becomes unnecessary)

At that point, its even possible to add some user plug-ins to that
module for example to draw splash screen. Of course all such plug-ins
must be root approved.


2. Linux turns off all devices, but hard disk.
Drivers for hard drives will register for this exception.


3. Linux creates a list of memory areas to save (or exclude from save,
doesn't matter)

4. Linux creates a list of hard disk sectors that will contain the
image.
This ensures support for swap partition and swap files as well.

5. Linux allocates small 'scratch space'
Of course if memory is very tight, some swapping can happen, but that
isn't significant. 


6. Linux creates new page tables that cover: the suspend module, both of
above lists, scratch space, and (optionally) the framebuffer RW,
and rest of memory RO.

7. Linux switches to new page table, and passes control to that module.
Even if the module wanted to it won't be able to change system memory.
It won't even know how to do so.

8. Module optionally encrypts and/or compresses (and saves result to
scratch page)

9. Module uses very simplified disk drivers to write the memory to disk.
These drivers can even omit using interrupts because there is nothing
else to do.
It can also draw progress bar on framebuffer using optional plugin

10. Module passes control back to linux, which just shuts system off.

Now what code will be in the module:

1. Optional compression & encryption - easy
2. Draw modules, also optional and easy


3. New disk drivers.
This is the hard part, but if we cover libata and ahci, we will cover
the common case.
Other cases can be handled by existing code that saved 1/2 of ram.


4. Arch specific code. Since it doesn't deal with interrupts nor memory
managment, it won't be lot of code.
Again standard swsusp can be used for arches that that module wasn't
ported to.

Anyone who had a dream to write a new (useful) OS is interested?


Best regards,
Maxim Levitsky
