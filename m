From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc6 7/7] PCI set up
	device.power.can_wakeup flags
Date: Thu, 20 Mar 2008 15:22:26 -0700
Message-ID: <200803201522.26587.david-b__35784.0772405781$1206051865$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0803201750010.881-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803201750010.881-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 20 March 2008, Alan Stern wrote:
> On Thu, 20 Mar 2008, David Brownell wrote:
> 
> > A previous version of this patch broke on PowerPC platforms after they
> > changed how they do early PCI initialization (following the first version
> > of this patch).  Potentially the real fix involves switching PCI init on
> > all platforms so they all adopt the driver model "init() then add()" model,
> > calling device_initialize() early and pci_setup_device() before device_add().
> 
> Would it help to break this apart into two patches: the first to switch 
> PCI over to the driver model approach, and the second to set up the 
> can_wakeup flags?  Those really are two very different goals.

Presumably, yes.  I'm not sure why there isn't a more
homogeneous approach to PCI init, between arch/* trees,
so I suspect there may be some down'n'dirty voodoo to
avoid tripping over.

That said, I'd sure *hope* that it could be cleaned up
in a way that all platforms can share one chunk of code
doing setup (like this) based on config space access.


> What are the barriers to doing the first part right now?  Is it just 
> PPC?

I have no idea, since I've not really looked at this in
any detail for some time now.  (The relevant PPC change
was more than two years ago...)  Heck, maybe it's even
been done already, and I just didn't notice!

- Dave
