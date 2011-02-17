From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] USB: Move runtime PM callbacks to
	usb_device_pm_ops
Date: Wed, 16 Feb 2011 16:03:19 -0800
Message-ID: <20110217000319.GB6439__29904.9367932186$1297936828$gmane$org@suse.de>
References: <201102170058.56503.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102170058.56503.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 17, 2011 at 12:58:56AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> USB defines usb_device_type pointing to usb_device_pm_ops that
> provides system-wide PM callbacks only and usb_bus_type pointing to
> usb_bus_pm_ops that provides runtime PM callbacks only.  However,
> the USB runtime PM callbacks may be defined in usb_device_pm_ops
> which makes it possible to drop usb_bus_pm_ops and will allow us
> to consolidate the handling of subsystems by the PM core code.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> 
> Hi Greg,
> 
> Would you mind if I merged the following patch?  It is requisite for
> https://patchwork.kernel.org/patch/552411/ which I think is the right thing
> to do and people seem to generally agree with me.
> 
> Alan has seen it and says it is fine.

Looks great to me, feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to it and take it through your tree.

thanks,

greg k-h
