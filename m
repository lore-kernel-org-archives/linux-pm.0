From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH 1/10] PM: Add flag for devices capable
	of generating run-time wake-up events
Date: Mon, 16 Nov 2009 22:23:15 +0100
Message-ID: <200911162223.15897.oliver__31973.3176417232$1258406797$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0911161557130.2971-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911161557130.2971-100000@iolanthe.rowland.org>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 16. November 2009 22:00:49 schrieb Alan Stern:
> > > What if the user wants to override the kernel's setting?  Should there 
> > > be a sysfs attribute controlling the flag?
> >
> > 
> > I have no plans for adding anything like that.
> 
> So if the kernel makes a mistake here, the user won't be able to 
> correct it.

If the kernel cannot tell whether a device can generate a request for
remote wakeup, how would it know the enable such requests?
Now we might come to a device that has a flatly wrong firmware,
but has that really been encountered in the wild?

	Regards
		Oliver
