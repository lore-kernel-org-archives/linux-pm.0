From: Greg KH <greg@kroah.com>
Subject: Re: [RFC Add in_use attribute] Let the driver know if
	it's in use
Date: Tue, 21 Apr 2009 14:56:32 -0700
Message-ID: <20090421215632.GB10343@kroah.com>
References: <20090416131323.GA16752@gandalf.sssup.it>
	<200904202354.04777.rjw@sisk.pl> <20090420224555.GA28697@kroah.com>
	<49ED54DC.6040407@gandalf.sssup.it>
	<20090421061754.GA20726@kroah.com>
	<49ED6B10.9060005@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49ED6B10.9060005@gandalf.sssup.it>
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
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 21, 2009 at 08:43:28AM +0200, Michael Trimarchi wrote:
> >>> Exactly, what are you trying to do that differs from
> >>> device_for_each_child()?
> >>>   
> >>>       
> >> Is device for each child use to visist the first level of the tree?
> >>     
> >
> > Have you tried it?
> >   
> No, I take a look at the code.
> 
> int device_for_each_child(struct device *parent, void *data,
>                           int (*fn)(struct device *dev, void *data))
> {
>         struct klist_iter i;
>         struct device *child;
>         int error = 0;
> 
>         klist_iter_init(&parent->p->klist_children, &i);
> 
> I was thinking that the klist_children is the fist_level one children, 
> so each time
> a device is registerd it add the link to the parent.

Yes it does.

But you have to start at some device, right?  So you don't need to
iterate over it, just go from there on down if needed.

So I don't see why this helper function is needed at all yet, shouldn't
we be doing the check within the normal suspend device walk of the tree?

thanks,

greg k-h
