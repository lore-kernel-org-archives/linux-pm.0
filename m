From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: avoid PM error messages during resume
 if a device was disconnected
Date: Tue, 2 Jun 2009 17:48:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906021745380.3960-100000__19094.0652545125$1244036247$gmane$org@iolanthe.rowland.org>
References: <200906022326.34491.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906022326.34491.rjw@sisk.pl>
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
Cc: Frans Pop <elendil@planet.nl>, linux-usb@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2 Jun 2009, Rafael J. Wysocki wrote:

> Returning 0 from usb_external_resume_device() if the device is not present
> any more doesn't seem wrong.  It's not really an error condition, IMO, because
> it's rather normal that the devices may be removed while suspended.
> 
> OTOH, I don't think we can ignore -ENODEV universally in the core, because
> its meaning may depend on the bus type.  For example, for PCI it sometimes
> means a hardware problem has occured (other than the device being not present
> any more).

> I'd vote in favor of the Frans' patch, at least for now.
> 
> So, Frans, please resubmit with the changelog modified as requested by Alan.

If we change -ENODEV to 0, the change should be made in usb_resume()
rather than usb_external_resume_device().

Alan Stern
