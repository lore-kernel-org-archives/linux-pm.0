From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Tue, 15 Dec 2009 10:57:25 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912151051580.14385__48616.6754774333$1260903757$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912151047410.3566-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0912150803250.14385@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912150803250.14385@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 15 Dec 2009, Linus Torvalds wrote:
> 
> And even when you know it's PCI, our rules are actually not simple at all. 
> Our rules for PCI devices (and this strictly speaking is true for bridges 
> too) are rather complex:
> 
>  - do we have _any_ legacy PM support (ie the "direct" driver 
>    suspend/resume functions in the driver ops, rather than having a 
>    "struct dev_pm_ops" pointer)? If so, call "->suspend()"
> 
>  - If not - do we have that "dev_pm_ops" thing? If so, call it.
> 
>  - If not - just disable the device entirely _UNLESS_ you're a PCI bridge.
> 
> Notice? The way things are set up, if you have no suspend routine, you'll 
> not get suspended, but you will get disabled. 

Side note - what I think might be a clean solution for PCI at least is to 
do something like the following:

 - move that "disable the device entirely" thing to suspend_late, rather 
   than the earlier suspend phase. Now PCI devices without drivers or PM 
   will not be touched at all in the first suspend phase.

 - initialize all PCI devices to have 'async_suspend = 1' on discovery

 - whenever we bind a driver to the PCI device, we'd then look at whether 
   that driver implements suspend/resume callbacks (legacy or new), and 
   clear the async_suspend bit if so.

That way we'd have the same old synchronous behavior for all PCI suspend 
and resume events (unless the driver itself then sets the async_suspend 
bit at device init time, which it could do, of course), while still always 
doing async "no-op" events.

That would avoid the ugly one-liner that just "knows" that PCI bridges are 
special and don't do anything at suspend time (even though they aren't 
really - a PCI bridge _could_ have a driver associated with it that does 
something that might not be happy being asynchronous).

			Linus
