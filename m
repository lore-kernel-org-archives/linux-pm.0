From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 10:11:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908201004100.3048-100000__4441.58232207901$1250777633$gmane$org@iolanthe.rowland.org>
References: <20090820030423.GA26357@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090820030423.GA26357@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Aug 2009, Shaohua Li wrote:

> > I don't understand the reason behind this.  Doesn't this sort of thing
> > belong in the bus and platform code, not in the PM core?  (In the case
> > of UHCI, it should be handled by the platform, in the same way as
> > remote wakeup gets enabled before the suspend.)
> > 
> > Drivers don't have to be involved at all.  When a wakeup signal is 
> > detected, the driver's runtime_resume method should get called -- 
> > nothing more is needed.
> The only case is UHCI in my mind. Because UHCI has non-standard wakeup event
> register.

That's an oversimplification.  _Some_ (I think) of _Intel's_ UHCI
implementations have a non-standard wakeup event register.

> If BIOS doesn't handle it correctly (for example, not clear the wakeup
> event after a GPE), we will keep see the wakeup event. And the bus/platform
> level has no knowledge to handle such event.

How is the wakeup event received?  Maybe for this one type of device a 
PCI quirk will solve the problem.

Or if that doesn't work, code can be added to uhci-hcd to turn off the
non-standard wakeup register as part of the resume routine.  (The
problem here is that the resume routine runs in process context so it
has to be called after the wakeup event handler has returned.)

Alan Stern
