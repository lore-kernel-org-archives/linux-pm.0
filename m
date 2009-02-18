From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 16:55:11 +0100
Message-ID: <200902181655.13876.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0902181009410.3186-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902181009410.3186-100000@iolanthe.rowland.org>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Am Wednesday 18 February 2009 16:10:48 schrieb Alan Stern:
> On Wed, 18 Feb 2009, Oliver Neukum wrote:
> 
> > But the transport and the driver may be in different subsystems, e.g.
> > usb storage.
> 
> We would have to add a part of usb-storage into the SCSI subsystem, by 
> creating a USB transport class.  Perhaps this class could be shared 
> with Firewire/IEEE1394.

That would be a specific solution. But the problem is generic. Take
for example HID. Several drivers may share one transport, but the transport
may be USB 2.0/3.0 or bluetooth.

	Regards
		Oliver
