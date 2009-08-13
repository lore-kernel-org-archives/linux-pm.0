From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] usb: Add support for runtime power management
	of the hcd
Date: Thu, 13 Aug 2009 14:16:41 +0200
Message-ID: <200908131416.42189.oliver__46390.8495651141$1250165825$gmane$org@neukum.org>
References: <200908081625.57333.rjw@sisk.pl>
	<20090813002925.GA2532@srcf.ucam.org>
	<20090813003544.GB2532@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090813003544.GB2532@srcf.ucam.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 13. August 2009 02:35:44 schrieb Matthew Garrett:

> The power savings from this are measurable but not huge - it still seems

How large?

> like a decent optimisation. The main problem is that BIOS bugs on some
> Dell laptops will kill USB if this is used, so we either default to off
> or add some quirks to handle that case (I have some ideas in that
> respect).

Your earlier failures don't look promising regarding BIOSes.
What do you have in mind?

> @@ -1968,6 +1972,9 @@ struct usb_hcd *usb_create_hcd (const struct
> hc_driver *driver, INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
>  #endif
>
> +	pm_runtime_enable(dev);

So you don't get a reference from that?

> +	pm_runtime_get(dev);

What happens if you get a runtime suspend request in between? Is this a flaw
of the API?

	Regards
		Oliver
