From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Add no_suspend attribute V2] Let the driver
 know if it's in use
Date: Thu, 23 Jul 2009 16:09:00 +0200
Message-ID: <4A686EFC.6040904@gandalf.sssup.it>
References: <Pine.LNX.4.44L0.0904251243360.18955-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0904251243360.18955-100000@netrider.rowland.org>
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
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

Hi all,

Alan Stern wrote:
> On Sat, 25 Apr 2009, Michael Trimarchi wrote:
>
>   
>> Anyway, I revert this beacuse is wrong but is it correct to use here the
>> list_add instead the list_add_tail, it put the child node
>> after the parent stricly and don't create hole in subtree visit. Now I 
>> see only a dump
>> reason for debugging and a simple exit in flag update.
>> The important thing is that the children follow the parent,
>> and in this way is like visiting the tree.
>>     
>
> That's not necessarily true.  There may be dependencies between devices 
> that aren't expressed by the parent-child relationship.
>
> For example, device B might require device A even though A isn't a 
> parent (or ancestor) of B.  The way dpm_list works now this is okay, 
> because devices are added in order of discovery.  That is, if B depends 
> on A then A must have been discovered before B, so A will come first on 
> the list.
>
> If you change things by adding children directly after their parent 
> then you will mess this up.  For example, if B's parent was discovered 
> before A, then adding B directly after its parent would mean putting B 
> before A on the list.  Then you'd run into trouble during a system 
> suspend, because A would be suspended before B and that would prevent B 
> from working properly.
>
>   
>> Nothing change for me because 
>> is difficult
>> to isolate only a subtree, if you have a list, but I'm sure that if I 
>> find a subtree with
>> the same parent, my subtree is finish, and if someone add a new device, 
>> the system put
>> in the correct position.
>>     
>
> It is _not_ difficult to isolate a subtree using a list.  For example:
>
> 	mutex_lock(&dpm_mutex);
> 	topdev->in_subtree = 1;
> 	list_for_each_entry(dpm_list, dev, power.entry) {
> 		if (dev->parent && dev->parent->in_subtree)
> 			dev->in_subtree = 1;
> 	}
> 	list_for_each_entry(dpm_list, dev, power.entry) {
> 		if (dev->in_subtree) {
> 			dev->in_subtree = 0;
> 			dev->dont_suspend = 1;
> 		}
> 	}
> 	mutex_unlock(&dpm_mutex);
>
> This will set the dont_suspend flag for all devices in the subtree 
> starting at topdev.
>
> Alan Stern
>   
I follow the discussion around the new runtime support and I would like 
to know if I can
add to the new interface the no_suspend flag or maybe now there is a 
better solution.

Michael
>
>
>   
