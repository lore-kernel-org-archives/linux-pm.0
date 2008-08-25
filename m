From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: btusb hibernation/suspend breakage in current -git
Date: Mon, 25 Aug 2008 13:37:14 +0200
Message-ID: <200808251337.16076.rjw__9385.70024814016$1219664223$gmane$org@sisk.pl>
References: <200808221520.19791.oliver@neukum.org>
	<200808221551.57225.oliver@neukum.org>
	<1219415470.7591.472.camel@violet.holtmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1219415470.7591.472.camel@violet.holtmann.net>
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
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi,

Speaking of btusb, I'm obseving a reproducible breakage of suspend and
hibernation (for hibernation it's 100% reproducible, for suspend to RAM about
50%) on my hp nx6325 with the current -git kernel.

The system crashes as soon as user space is thawed after a resume and it's
sufficient to switch the bluetooth subsystem off to avoid this.  After such a
crash I'm usually unable to get any information from the box (from the stack
traces I've seen once after such a crash it looks like interrupt handlers are
involved somehow).

Since the bluetooth adapter in this box is apparently handled by btusb, I'm
suspecting the problem may be related to it or to the USB subsystem (ehci-hcd
in particular).  I'm going to debug it further, but if you have any ideas to
try, I'll appreciate any help.

Thanks,
Rafael
