From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression] USB wakeup problem on Toshiba Portege R500
Date: Thu, 8 Jan 2009 08:35:39 +0100
Message-ID: <200901080835.39639.rjw__1071.0202659995$1231400407$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@suse.de>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Alan,

Unfortunately, the following commit:

commit 6fd9086a518d4f14213a32fe6c9ac17fabebbc1e
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Dec 17 17:20:38 2008 -0500

    USB: automatically enable wakeup for PCI host controllers

    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

causes a regression to appear on my Toshiba Portege R500.

The regression is that when suspended to RAM, the box wakes up immediately
unless 'disabled' is written into the /sys/devices/.../power/wakeup file of the
EHCI controller.  I know of at least 10 different boxes out there that are
going to have similar problems forcing their users to use manual workaround.

Also, it wakes up on a USB mouse activity, which I don't want it to do, so in
fact I have to write 'disabled' to the /sys/devices/.../power/wakeup files of
all USB controllers.

I'm not sure if the commit went into the right direction.

Thanks,
Rafael
