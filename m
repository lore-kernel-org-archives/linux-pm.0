From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] PM: Asynchronous suspend and resume of
	devices
Date: Thu, 27 Aug 2009 23:18:19 +0200
Message-ID: <200908272318.19868.rjw__40020.1569348157$1251407992$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908271637480.25639-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908271637480.25639-100000@iolanthe.rowland.org>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 27 August 2009, Alan Stern wrote:
> On Wed, 26 Aug 2009, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > The following patches introduce a mechanism allowing us to execute device
> > drivers' suspend and resume callbacks asynchronously during system sleep
> > transitions, such as suspend to RAM.
> > 
> > The idea is explained in the changelogs of the first two patches.
> > 
> > Comments welcome.
> 
> I've been terribly busy and haven't had a chance to look at this.  The
> earlier version seemed to have a bunch of mutual-exclusion issues; are
> they resolved now?

Please be more specific.

> There were also some problems involving unsafe iteration over the dpm_list
> -- remember that devices can be unregistered at any time, not just while
> they are suspending or resuming.

Not at the time we're holding dpm_list_mtx, though.

I don't think there are any unsafe iterations over dpm_list in the patches.

> When a device finishes, instead of having the async thread look for 
> another device to work on, I think it would be better to have the 
> thread check the dependents of the current device.  Those which are 
> now ready can be added to a "device-ready" list, which is used to 
> direct the actions of new async threads.

Actually, I wanted to avoid adding such a list, because that would be
duplicating of the async framework's actions, to some extent.  Yes, we can
duplicate the async framework just for the suspend/resume needs.  No, I don't
think it's worth it.

BTW, the patches have been tested on a dual-core box and I haven't seen any
problems with them so far.  Also, the testing shows that the waiting for
devices with unsatisfied dependencies is almost eliminated (on my test box
it happens 4-8 times during the entire suspend-resume cycle).

Thanks,
Rafael
