From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: /proc/acpi/wakeup regression in 2.6.39-rc3
Date: Fri, 15 Apr 2011 10:38:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104151034580.2051-100000__32573.7494197258$1302878382$gmane$org@iolanthe.rowland.org>
References: <201104150053.37037.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104150053.37037.rjw@sisk.pl>
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
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Tino Keitel <tino.keitel@tikei.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 15 Apr 2011, Rafael J. Wysocki wrote:

> On Friday, April 15, 2011, Tino Keitel wrote:
> > Hi,
> > 
> > with 2.6.38, I enabled wakeup from suspend to RAM with the USB keyboard
> > this way:
> > 
> > echo USB2 > /proc/acpi/wakeup
> > 
> > This does not work anymore with 2.6.39-rc3. Wakeup using the keyboard
> > won't work, and the USB2 line in /proc/acpi/wakeup doesn't change to
> > "enabled" after the echo command.
> > 
> > Is this intended? If yes, what is the new way to enable keyboard
> > wakeup?
> 
> No, it's supposed to work IIRC.  I'll have a look at that code tomorrow.

Tino, can you check the contents of the power/wakeup files in the
appropriate sysfs directories?  That would be the directory for the
keyboard device itself and the directory for the USB host controller
for the bus the keyboard is on.

By default, power/wakeup should be "enabled" for the keyboard device 
and "disabled" for the host controller.  If you write "enabled" into 
the host controller's file by hand, does that fix the problem?

Alan Stern
