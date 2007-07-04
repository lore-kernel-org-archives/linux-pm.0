From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 11:57:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707041152350.25704-100000__45753.0239633799$1183564678$gmane$org@netrider.rowland.org>
References: <20070704145818.GA7784@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070704145818.GA7784@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Jul 2007, Matthew Garrett wrote:

> On Wed, Jul 04, 2007 at 10:38:47AM -0400, Alan Stern wrote:
> 
> > Okay, I agree that (1) can be handled without too much effort.  But 
> > doing it adds an extra test to _every_ driver's I/O pathway.  Freezing 
> > userspace does not incur all this additional overhead.
> 
> For runtime PM to work it's already necessary to have a test in that 
> path to check if the device is suspended. I can't see how this adds any 
> overhead to the common case.

Actually it isn't necessary to have a test to check if the device is 
suspended.  We simply call the autoresume routine; if the device isn't 
suspended that routine doesn't have to do anything.

I agree that that the extra test (for system-wide suspend underway) is
needed only if the autoresume fails, which isn't part of the main
pathway.  So it doesn't add runtime overhead -- but handling it does
add code overhead.

Alan Stern
