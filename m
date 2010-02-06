From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] USB: implement non-tree resume ordering
	constraints	for PCI host controllers
Date: Sat, 6 Feb 2010 00:58:27 -0800
Message-ID: <20100206085827.GA4807__44504.7943540432$1265446928$gmane$org@suse.de>
References: <Pine.LNX.4.44L0.1002011531490.1368-100000@iolanthe.rowland.org>
	<201002042316.37532.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201002042316.37532.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 04, 2010 at 11:16:37PM +0100, Rafael J. Wysocki wrote:
> On Monday 01 February 2010, Alan Stern wrote:
> > On Mon, 25 Jan 2010, Rafael J. Wysocki wrote:
> > 
> > > On Monday 25 January 2010, Alan Stern wrote:
> > > > On Mon, 25 Jan 2010, Rafael J. Wysocki wrote:
> > > > 
> > > > > > I intend to write this code, but merging it will be a little tricky.  
> > > > > > You'll have to coordinate with Greg KH.
> > > > > 
> > > > > OK, I don't think that's a big deal.  I can defer patch 7/8 until that code has
> > > > > been merged.
> > > > 
> > > > You may have to delay 6/8 as well, since the controllers are PCI
> > > > devices.  Writing the new code shouldn't take too long, though.
> > > 
> > > No problem with that.
> > > 
> > > Alternatively, if Greg agrees, I can add your patches modifying this into this
> > > series.  Greg?
> > 
> > The patch is below.  It does indeed prevent unwanted disconnects during 
> > system resume.  However I don't know whether it will apply cleanly to 
> > anybody's tree but my own.  :-)
> 
> It applies to my tree and even builds without errors. :-)
> 
> Greg, I'd like to add this patch to the async suspend patchset and put it into
> my tree if you don't mind, since otherwise the merging of it would be quite
> problematic.
> 
> Do you agree or do you want to handle that in a different way?

I agree, please merge it through your tree, I have no objection to that
at all.

thanks,

greg k-h
