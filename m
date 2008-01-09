From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Wed, 9 Jan 2008 12:22:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801091216400.2880-100000__8156.74905102259$1199899448$gmane$org@iolanthe.rowland.org>
References: <200801091711.33394.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801091711.33394.oliver@neukum.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Jan 2008, Oliver Neukum wrote:

> This has an interesting implication. As the storage driver can share
> a device with in principle any other usb driver, we must audit all usb
> drivers if we wish to adopt this patch.
> All a device's interfaces must be resumed when the storage interface
> is resumed. To resume a storage device no memory must be allocated
> because that could deadlock.

Maybe people shouldn't enable autosuspend for their swap device...

What happens during normal system resume if a driver (not just USB!)  
needs to allocate memory before the swap device has been resumed?

Alan Stern
