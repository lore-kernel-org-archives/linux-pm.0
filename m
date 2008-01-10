From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Thu, 10 Jan 2008 10:26:59 +0100
Message-ID: <200801101027.00269.oliver__49509.824688039$1199957276$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0801091530140.2856-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801091530140.2856-100000@iolanthe.rowland.org>
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

Am Mittwoch, 9. Januar 2008 21:36:20 schrieb Alan Stern:
> On Wed, 9 Jan 2008, Oliver Neukum wrote:
> 
> > Am Mittwoch, 9. Januar 2008 18:22:51 schrieb Alan Stern:
> > > On Wed, 9 Jan 2008, Oliver Neukum wrote:
> > > 
> > > > This has an interesting implication. As the storage driver can share
> > > > a device with in principle any other usb driver, we must audit all usb
> > > > drivers if we wish to adopt this patch.
> > > > All a device's interfaces must be resumed when the storage interface
> > > > is resumed. To resume a storage device no memory must be allocated
> > > > because that could deadlock.
> > > 
> > > Maybe people shouldn't enable autosuspend for their swap device...
> > 
> > Good advice, but not sufficient to avoid this problem. The vm may write
> > out normal dirty cached pages to scsi devices, which affects storage.
> 
> For now, I think the best approach is "head-in-the-sand".  There aren't
> a lot of USB storage devices partnered with other functions at the
> moment.

Very well with exception of the hub driver.
 
> But it might be a good idea for all USB drivers to use GFP_NOIO in
> their resume pathways.

Yes, we should make this a requirement for every driver henceforth changed
to support autosuspend.

	Regards
		Oliver
