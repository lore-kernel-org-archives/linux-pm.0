From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 11:04:23 +0800
Message-ID: <20090820030423.GA26357__8621.2927163162$1250737605$gmane$org@sli10-desk.sh.intel.com>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
	<Pine.LNX.4.44L0.0908191044060.3001-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0908191044060.3001-100000@iolanthe.rowland.org>
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
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 19, 2009 at 10:49:30PM +0800, Alan Stern wrote:
> On Wed, 19 Aug 2009, Shaohua Li wrote:
> 
> > Introduce .wakeup_event(). When a device gets a wakeup event,
> > the callback is called. The callback usually should check if the device
> > really invokes wakeup event and disable wakeup event if yes.
> > 
> > Usually driver should does nothing in the op as bus can handle it. But in some
> > cases, like pci bus, UHCI controller doesn't use standard PME registers for
> > wakeup, instead of using special approach. In this case, UHCI controller driver
> > should implement this op.
> 
> I don't understand the reason behind this.  Doesn't this sort of thing
> belong in the bus and platform code, not in the PM core?  (In the case
> of UHCI, it should be handled by the platform, in the same way as
> remote wakeup gets enabled before the suspend.)
> 
> Drivers don't have to be involved at all.  When a wakeup signal is 
> detected, the driver's runtime_resume method should get called -- 
> nothing more is needed.
The only case is UHCI in my mind. Because UHCI has non-standard wakeup event
register. If BIOS doesn't handle it correctly (for example, not clear the wakeup
event after a GPE), we will keep see the wakeup event. And the bus/platform
level has no knowledge to handle such event.

Thanks,
Shaohua
