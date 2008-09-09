From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Tue, 9 Sep 2008 10:18:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809091014010.2486-100000__25155.0659923398$1220970121$gmane$org@iolanthe.rowland.org>
References: <200809082226.11399.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809082226.11399.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 8 Sep 2008, David Brownell wrote:

> > For example the UHCI case. A GPE is fired, we need to clear/disable
> > the wakeup event. PCI bus can't handle it, as UHCI has special
> > registers for this, so we need call into device specific handling.  
> 
> So the bus-level PCI operation would end up with a device
> that's either (a) known to have fired PME#, or (b) known
> to be a device with legacy PM -- like UHCI -- which it's
> presuming has been wakeup-enabled.
> 
> Then in the (a) case it can clear PME# the normal way, and
> would rarely need to do anything else.
> 
> While in the (b) case the UHCI driver would need to have
> provided some device-specific -- not bus-generic -- op
> called like dev->driver->pm.is_wakeup(), to diddle those
> registers (only for Intel silicon, not UHCI from VIA or
> Genesys or anyone else).

What about case (c): The device uses legacy PM but the wakeup settings 
have already been handled by the ACPI AML code?  There's no need to 
clear any extra wakeup-related stuff, but it still is necessary to tell 
the driver about the event.

(As a matter of fact, I have no idea whether or not Intel's legacy PM 
for UHCI is implemented in AML.  It may vary from one BIOS to another.)

Alan Stern
