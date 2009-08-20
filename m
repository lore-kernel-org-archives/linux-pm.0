From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 10:38:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908201034340.3048-100000__42736.3269300715$1250779149$gmane$org@iolanthe.rowland.org>
References: <20090820141436.GA3722@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090820141436.GA3722@srcf.ucam.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Aug 2009, Matthew Garrett wrote:

> On Thu, Aug 20, 2009 at 10:11:19AM -0400, Alan Stern wrote:
> 
> > How is the wakeup event received?  Maybe for this one type of device a 
> > PCI quirk will solve the problem.
> 
> Pretty much the same as PME events on PCI - a GPE is generated, an SCI 
> raised, the ACPI interpreter executes the code that's in the ACPI 
> tables, that generates a notification event on the appropriate UHCI 
> device, we live happily ever after.

What happens after the notification event is generated?  That is, what
functions get called?  I'm not at all familiar with this part of the
kernel.

If the wakeup signal isn't squelched at the source, as part of the
event handling, will we get an interrupt storm?  Will the uhci-hcd 
resume routine be able to handle this or does it need to be done 
earlier?  In other words, do we need special-purpose code in the PCI 
layer to handler it?

Alan Stern
