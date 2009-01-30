From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspend regression, hang after matroxfb
Date: Fri, 30 Jan 2009 18:21:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901301818400.2785-100000__35283.4045807414$1233357943$gmane$org@iolanthe.rowland.org>
References: <200901302359.18309.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901302359.18309.rjw@sisk.pl>
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
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-pm@lists.linux-foundation.org, Kernel Testers <kernel-testers@vger.kernel.org>, vandrove@vc.cvut.cz
List-Id: linux-pm@vger.kernel.org

On Fri, 30 Jan 2009, Rafael J. Wysocki wrote:

> Suspend to RAM is reported to break on some machines as a result of
> attempting to put one of driverless PCI devices into a low power
> state.  Avoid that by not attepmting to power manage driverless
> devices during suspend.

Just out of curiosity, what would happen if one of these troublesome
devices _did_ have a driver?  Would suspend still be broken?  Would you
then blame the driver instead of the PCI core?  Or would the driver be
smart enough to avoid putting the device in a low-power state?  But
doesn't that defeat the purpose of suspending in the first place?

Alan Stern
