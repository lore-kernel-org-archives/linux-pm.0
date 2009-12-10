From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Thu, 10 Dec 2009 07:45:14 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912100739260.3560__17863.3812386126$1260460012$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912101010090.2825-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912101010090.2825-100000@iolanthe.rowland.org>
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



On Thu, 10 Dec 2009, Alan Stern wrote:
> 
> In device_pm_remove():
> 
> 	mutex_lock(&dpm_list_mtx);
> 	if (dev == dpm_next)
> 		dpm_next = to_device(dpm_iterate_forward ?
> 			dev->power.entry.next : dev->power.entry.prev);
> 	list_del_init(&dev->power.entry);
> 	mutex_unlock(&dpm_list_mtx);

I'm really not seeing the point - it's much better to hardcode the 
ordering in the place you use it (where it is static and the compiler can 
generate bette code) than to do some dynamic choice that depends on some 
fake flag - especially a global one.

Also, quite frankly, error handling needs to be separated out of the whole 
async patch, and needs to be thought about a lot more. And I would 
seriously argue that if you have any async suspends, then those async 
suspends are _not_ allowed to fail. At least not initially 

Having async failures and trying to fix them up is just a disaster. Which 
ones actually failed, and which ones were aborted before they even really 
got to their suspend routines? Which ones do you try to resume?

IOW, it needs way more thought than what has clearly happened so far. And 
once more, I will refuse to merge anything that is complicated for no 
actual reason (where reason is "real life, and tested to make a big 
difference", not some hand-waving)

		Linus
