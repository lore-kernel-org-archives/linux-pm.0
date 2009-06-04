From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] USB: Avoid PM error messages during resume
	if a device	was disconnected
Date: Thu, 4 Jun 2009 14:02:48 -0700
Message-ID: <20090604210248.GA17039__35895.3917203054$1244151902$gmane$org@kroah.com>
References: <200906042230.49825.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906042230.49825.rjw@sisk.pl>
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
Cc: linux-usb@vger.kernel.org, Frans Pop <elendil@planet.nl>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 04, 2009 at 10:30:48PM +0200, Rafael J. Wysocki wrote:
> From: Frans Pop <elendil@planet.nl>
> 
> Currently if a laptop is suspended e.g. while docked and then resumed after
> undocking it, the following errors get generated because the USB hub in the
> docking station and the devices connected to it are no longer available:
> pm_op(): usb_dev_resume+0x0/0x10 returns -19
> PM: Device 1-2 failed to resume: error -19
> pm_op(): usb_dev_resume+0x0/0x10 returns -19
> PM: Device 1-2.2 failed to resume: error -19
> pm_op(): usb_dev_resume+0x0/0x10 returns -19
> PM: Device 1-2.3 failed to resume: error -19
> 
> As the removal of USB devices while a system is suspended is a relatively
> common use case and in most cases not an error, just return success on
> -ENODEV. The user gets informed anyway as the USB subsystem generates
> regular disconnect messages for the devices shortly afterwards:
> usb 1-2: USB disconnect, address 3
> usb 1-2.2: USB disconnect, address 4
> usblp0: removed
> usb 1-2.3: USB disconnect, address 5
> 
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> Hi Greg,
> 
> I can take this patch to the suspend tree, but if you think it should go
> through USB, please consider including it into the 2.6.31 push.

I've now queued it up in my usb tree, as that is probably the best place
for it.

thanks,

greg k-h
