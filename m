From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: When to use a freezeable workqueue?
Date: Sun, 12 Aug 2007 22:29:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708122222000.5743-100000__12724.7363249355$1186972201$gmane$org@netrider.rowland.org>
References: <200708130018.38652.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708130018.38652.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Mon, 13 Aug 2007, Rafael J. Wysocki wrote:

> On Sunday, 12 August 2007 10:11, Stefan Richter wrote:
> > In which situations is create_freezeable_workqueue() to be preferred
> > over create_singlethread_workqueue()?
> > 
> > Is a freezable worqueue preferable whenever the worker thread /can/ be
> > frozen, or is it only to be used if the thread /must/ be frozen during
> > suspend?
> 
> The latter, IMO.
> 
> Generally, if you want it to be frozen.

A good example of a reason for making a workqueue freezable is that the 
workqueue contains entries which would cause a suspended device to be 
resumed.  Obviously you don't want such things to happen while the 
system is going to sleep.  A little less obviously, there might also be 
problems if such a routine ran while the system was waking up.

Another reason might be that the workqueue contains entries which would
try to register or unregister a device.  Such actions aren't a good
idea at times when the PM core is iterating through a list of all
devices in order to suspend or resume them.  And in the future such
actions may block, effectively freezing the workqueue anyway -- which
could be troublesome if you don't want the workqueue to be frozen!

Alan Stern
