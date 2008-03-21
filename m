From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup
	and fixes
Date: Fri, 21 Mar 2008 02:47:18 +0100
Message-ID: <200803210247.18686.rjw__42092.8530082621$1206064198$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803202053270.11234-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803202053270.11234-100000@netrider.rowland.org>
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

On Friday, 21 of March 2008, Alan Stern wrote:
> On Fri, 21 Mar 2008, Rafael J. Wysocki wrote:
> 
> > The original code executed platform_pci_choose_state() first, if defined, and
> > if that succeeded, it just returned the result.  You put
> > platform_pci_choose_state() under the switch(). :-)
> 
> For FREEZE and QUIESCE, is there ever any reason to leave D0?

No, but there's a reason to leave it for HIBERNATE and that's what my original
comment was about.

> These calls are documented as not requiring (and not desiring!) any change
> in power level.

Correct, but that's not the point.

Is there any reason why pci_choose_state() should try to figure out what kind
of operation is being performed by the driver and tailor its output to that?
I don't think so.  Rather, the driver should know what it's doing and either
call pci_choose_state() or not.  If the state of the device is not to be
changed, there's no reason to call pci_choose_state() at all.

My opinion is that drivers should only use pci_choose_state() if they _intend_
to change the state of the device and they should expect that the result may
not depend on the 'state' argument passed to it, but on the target state set by
the platform.  [Note that with the new suspend/hibernation callbacks there
won't be the pm_message_t argument to pass to pci_choose_state().]

Now, we need to settle _what_ exactly pci_choose_state() is supposed
to return, because it's not clear right now.  Should that be the lowest power
state in which the device can be in given system state (that's what
platform_pci_choose_state() will return)?  Or should that be the highest power
state in which the device can be in given system state?  Or anything else?

Thanks,
Rafael
