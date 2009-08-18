From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume
	(updated)
Date: Tue, 18 Aug 2009 10:04:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908180954210.2995-100000__34760.4590272114$1250604446$gmane$org@iolanthe.rowland.org>
References: <200908170215.21173.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908170215.21173.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 17 Aug 2009, Rafael J. Wysocki wrote:

> On Wednesday 12 August 2009, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following patches introduce a mechanism allowing us to execute device
> > drivers' suspend and resume callbacks asynchronously during system sleep
> > transitions, such as suspend to RAM.  The idea is explained in the [1/1] patch
> > message.
> 
> Changes:
> 
> * Added [1/7] that fixes kerneldoc comments in drivers/base/power/main.c
>   (this is a 2.6.32 candidate).
> 
> * Added [2/7] adding a framework for representing PM link (idea described
>   in the patch message).
> 
> * [3/7] is the async resume patch (idea described in the patch message).
> 
> * [4/7] is the async suspend patch.
> 
> * [5/7] - [7/7] set async_suspend for devices in a few selected subsystems.
> 
> The patches have been tested on HP nx6325.
> 
> Comments welcome.

I'm not sure about the design of these things.  How much do we care 
about wasting memory?  Your scheme allocates six pointers for every 
dependency, plus four pointers for every device.  It's possible to 
reduce this considerably, especially if the parent-child dependencies 
aren't stored explicitly.

If you decide to keep this scheme, you should make pm_link_add() check 
for duplicate dependencies before adding them.

Also, I think a better approach to the async execution would not
require adding a struct completion to each device and making each async
thread wait for the completion to be signalled.  Instead, have a single
master thread (i.e., the thread doing the suspend) monitor the
dependencies and have it farm the devices out to async threads as they
become ready to be suspended or resumed.

Finally, devices that don't have async_suspend set should implicitly 
depend on everything that comes after them (for suspend) or before them 
(for resume) in the device list.

Alan Stern
