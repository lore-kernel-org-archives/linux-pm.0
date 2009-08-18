From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Tue, 18 Aug 2009 12:07:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908181149300.2684-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0908171640590.2680-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908171640590.2680-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, 17 Aug 2009, Alan Stern wrote:

> It appears that some part of the resume messed up the VT console
> driver.

I have narrowed this down.  The problem occurs in agp_intel_resume()
in drivers/char/agp/intel-agp.c.  Here's the beginning of the routine:


static int agp_intel_resume(struct pci_dev *pdev)
{
	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
	int ret_val;

	pci_restore_state(pdev);

	/* We should restore our graphics device's config space,
	 * as host bridge (00:00) resumes before graphics device (02:00),
	 * then our access to its pci space can work right.
	 */
	if (intel_private.pcidev)
		pci_restore_state(intel_private.pcidev);


As the comment says, pdev is 0000:00:00.0 and intel_private.pcidev is
0000:00:02.0.  So this is the resume routine for 00:00.0, and it calls
pci_restore_state() for 00:02.0 before that device has been resumed.

Note that there is no corresponding agp_intel_suspend() function.

Stuff stops appearing on the screen in the middle of the second
pci_restore_state() call.  That is, I see messages about "restoring
config space at offset..." for each of the two devices, but a
debugging message added at the end of pci_restore_state() doesn't
appear for the second call.

(Should these config space changes occur at all, given that I'm
testing with "echo devices >pm_test"?)

It's also worth noting that a debugging message added to the start of
pci_restore_state() shows that for both of these calls,
pdev->state_saved is false.  It's not clear whether that matters,
though, because the suspend and resume routines in the PCI core do so
many calls to pci_save_state() and pci_restore_state() on their own.

Commenting out the second call to pci_restore_state() apparently fixes 
the problem.  I have no idea whether it's the right thing to do, 
though.

Does all this suggest any ideas?

Alan Stern
