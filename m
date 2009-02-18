From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 11:39:21 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902181135400.3186-100000__5995.91712602905$1234975336$gmane$org@iolanthe.rowland.org>
References: <200902181655.13876.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902181655.13876.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Feb 2009, Oliver Neukum wrote:

> Am Wednesday 18 February 2009 16:10:48 schrieb Alan Stern:
> > On Wed, 18 Feb 2009, Oliver Neukum wrote:
> > 
> > > But the transport and the driver may be in different subsystems, e.g.
> > > usb storage.
> > 
> > We would have to add a part of usb-storage into the SCSI subsystem, by 
> > creating a USB transport class.  Perhaps this class could be shared 
> > with Firewire/IEEE1394.
> 
> That would be a specific solution. But the problem is generic. Take
> for example HID. Several drivers may share one transport, but the transport
> may be USB 2.0/3.0 or bluetooth.

In essence what you're saying is that we won't be able to do
link-suspend for HID until something like HID transport classes (or
something simpler, devoted specifically to runtime PM) is implemented.  
And likewise for other subsystems.  I can't argue with this conclusion.

Alan Stern
