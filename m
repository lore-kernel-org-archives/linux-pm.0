From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...)
Date: Mon, 7 May 2007 23:00:02 +0200
Message-ID: <200705072300.03299.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705051149360.1976-100000@netrider.rowland.org>
	<200705061816.46439.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705061816.46439.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 7 May 2007 03:16, David Brownell wrote:
> On Saturday 05 May 2007, Alan Stern wrote:
> 
> > Agreed, these all sound like problems in the ACPI driver's implementation 
> > of suspend and resume.  Problems that are caused (at least in part) by the 
> > fact that the PM core doesn't tell the driver whether it's doing
> > suspend-to-RAM vs. hibernation.  Once that is straighened out, everything 
> > else should become much simpler.
> 
> I'm not sure I agree with that diagnosis, but for the record:
> updating drivers/pci/pci-acpi.c so that it can implement the
> platform_pci_choose_state() hook requires ACPI to export that
> information.
> 
> So for now I have drivers/acpi/sleep/main.c exporting
> 
>         s_state = acpi_get_target_sleep_state();
> 
> so that ACPI-aware code can know to call "_S3D" instead of
> the "_S1D" or "_S4D" methods (and "_S3W" etc).  Of course
> the $SUBJECT patch will finish borking that for S4.  :(

Why exactly?

Rafael
