From: Greg KH <greg@kroah.com>
Subject: Re: [RFC 1/2] Merge power-management source files
Date: Thu, 27 Sep 2007 20:42:04 -0700
Message-ID: <20070928034204.GC23764@kroah.com>
References: <Pine.LNX.4.44L0.0709211442140.4344-100000@iolanthe.rowland.org>
	<200709212111.55823.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709212111.55823.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 21, 2007 at 09:11:55PM +0200, Rafael J. Wysocki wrote:
> On Friday, 21 September 2007 20:44, Alan Stern wrote:
> > On Fri, 21 Sep 2007, Greg KH wrote:
> > 
> > > On Thu, Sep 20, 2007 at 02:05:03PM -0400, Alan Stern wrote:
> > > > This proposed patch applies to 2.6.23-rc6-mm1.  It merges the suspend.c 
> > > > and resume.c files in drivers/base/power into main.c, while making some 
> > > > public symbols private.
> > > > 
> > > > If nobody objects, I will submit it to Andrew Morton.
> > > 
> > > Why Andrew?  I thought I had to handle all of the drivers/base/* stuff
> > > :)
> > 
> > To tell the truth, I wasn't sure how all this was supposed to work.  
> > Rafael has been making a lot of changes to the PM infrastructure 
> > (though almost all of them affect the files in kernel/power, not 
> > drivers/base/power) and his work goes into -mm.
> > 
> > But never mind, I will shortly send the changes to you so they can go
> > into your tree.
> 
> Well, we're going to have a suspend branch in the ACPI tree and perhaps it's
> a good time to start it. :-)
> 
> These patches are strictly related to suspend, so maybe it's better to send
> them to Len, so that we can easily keep track of them in the future?
> 
> Greg, what do you think?

As long as they concern the driver core, I'd like to be notified of
them, and will be glad to host them in my tree.  Anything that is
ACPI-only, I have no problem ignoring and letting Len handle :)

So for these patches, I'll be glad to review them and add them to my
queue.  Give me a few days as my to-review queue is kind of big right
now and I'm supposed to be writing a speech for next week...

thanks,

greg k-h
