From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] PCI: Runtime power management
Date: Sun, 16 Aug 2009 17:04:06 +0100
Message-ID: <20090816160406.GA10163__8019.47975201092$1250438713$gmane$org@srcf.ucam.org>
References: <200908152321.53283.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0908161151020.6522-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0908161151020.6522-100000@netrider.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 16, 2009 at 11:57:53AM -0400, Alan Stern wrote:
> On Sat, 15 Aug 2009, Rafael J. Wysocki wrote:
> 
> > > Why would you ever want runtime_wakeup to be false unless 
> > > runtime_forbidden is true? Surely the point of runtime power management 
> > > is to be transparent to the user, in which case remote wakeup is 
> > > required?
> 
> Matthew, what makes you think remote wakeup is required?  Lots of
> power-manageable devices don't support it at all (consider disk drives
> or display screens).

Sorry, I meant in cases where remote wakeup is a sensible concept. For 
things like storage there's obviously no reason to require it, but for 
something like USB the absence of remote wakeup would effectively break 
the driver for most users.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
