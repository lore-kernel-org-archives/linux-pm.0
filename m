From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
	it's in use
Date: Thu, 23 Apr 2009 23:41:19 +0200
Message-ID: <200904232341.20813.rjw@sisk.pl>
References: <20090416131323.GA16752@gandalf.sssup.it>
	<200904231659.20598.rjw@sisk.pl>
	<49F09C10.9080402@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49F09C10.9080402@gandalf.sssup.it>
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
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

On Thursday 23 April 2009, Michael Trimarchi wrote:
> Hi,
> 
> Rafael J. Wysocki wrote:
> > On Thursday 23 April 2009, Michael Trimarchi wrote:
> >   
> >> Greg KH wrote:
> >>     
> >>> On Tue, Apr 21, 2009 at 08:43:28AM +0200, Michael Trimarchi wrote:
> >>>   
> >>>       
> >>>>>>> Exactly, what are you trying to do that differs from
> >>>>>>> device_for_each_child()?
> >>>>>>>   
> >>>>>>>       
> >>>>>>>           
> >>>>>>>               
> >>>>>> Is device for each child use to visist the first level of the tree?
> >>>>>>     
> >>>>>>         
> >>>>>>             
> >>>>> Have you tried it?
> >>>>>   
> >>>>>       
> >>>>>           
> >>>> No, I take a look at the code.
> >>>>
> >>>> int device_for_each_child(struct device *parent, void *data,
> >>>>                           int (*fn)(struct device *dev, void *data))
> >>>> {
> >>>>         struct klist_iter i;
> >>>>         struct device *child;
> >>>>         int error = 0;
> >>>>
> >>>>         klist_iter_init(&parent->p->klist_children, &i);
> >>>>
> >>>> I was thinking that the klist_children is the fist_level one children, 
> >>>> so each time
> >>>> a device is registerd it add the link to the parent.
> >>>>     
> >>>>         
> >>> Yes it does.
> >>>
> >>> But you have to start at some device, right?  So you don't need to
> >>> iterate over it, just go from there on down if needed.
> >>>   
> >>>       
> >> I start for a device, go down until I find a leaf or find that the 
> >> subtree is marked.
> >> Mark the leaf and go up and take the next node like the walk_tg_tree. 
> >> The difference is
> >> that I skip subtree if they are mark in_use.
> >>     
> >>> So I don't see why this helper function is needed at all yet, shouldn't
> >>> we be doing the check within the normal suspend device walk of the tree?
> >>>   
> >>>       
> >> Sorry but here I need some help here. Where is the walk of the device 
> >> tree during suspend?
> >>     
> >
> >   
> 
> > In drivers/base/power/main.c there are functions like dpm_suspend(), for one
> > example, that walk the device tree, but they do it in a simplified way, using a
> > list prepared specifically for this purpose (so the walk is in fact linear).
> >   
> I don't want add a new list and
> If I use the dpm_list a must go back to the root for each element using 
> the parent and check
> the flag because the list maybe don't mantein the parent relation.

It does maintain the parent relation because of the way it is created.  Devices
are added to the list in the order of discovery and obviously the parents are
discovered before their children (there are a few exceptions involving a
reordering of the list, but I don't think they are relevant for your case).

> example:
> s(A) is son of A ss(A) etc
> 
> A-B-s(B)-s(B)-s(A)-ss(B)-ss(A)
> 
> I don't know if B the second element has child of B I must look it's 
> parent and so on.
> So the complexty increase.
> 
> The suspend order is correct but the computation time is worse. Maybe I 
> can move
> the code outside the base/core.c and put it in the power/main.c but I 
> don't have
> the next_device function and other to move up and down. I put there that 
> function
> because I have all the necessary code.

Please have a deeper look into the existing code before you start adding new
things.  It's a good chance the code already does some of the things you
need, although you may want to modify it slightly here and there.

Thanks,
Rafael
