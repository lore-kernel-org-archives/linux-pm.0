From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Wed, 9 Jan 2008 17:11:32 +0100
Message-ID: <200801091711.33394.oliver__8420.45491231165$1199895205$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0801071244180.2748-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801071244180.2748-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 7. Januar 2008 20:42:23 schrieb Alan Stern:
> When all the devices under a host are suspended, the LLD is informed=20
> (via a new "autosuspend" method in the host template) so that it can=20
> put the host adapter in a low-power state. =A0Likewise, a new=20
> "autoresume" method is called when the host adapter needs to return to=20
> full power. =A0An implementation of these methods for the usb-storage=20
> driver will be posted in a followup patch.

This has an interesting implication. As the storage driver can share
a device with in principle any other usb driver, we must audit all usb
drivers if we wish to adopt this patch.
All a device's interfaces must be resumed when the storage interface
is resumed. To resume a storage device no memory must be allocated
because that could deadlock.

	Regards
		Oliver
