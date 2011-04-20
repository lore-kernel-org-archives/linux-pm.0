From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: /proc/acpi/wakeup regression in 2.6.39-rc3
Date: Wed, 20 Apr 2011 22:57:35 +0200
Message-ID: <201104202257.36079.rjw__43205.8935090483$1303333077$gmane$org@sisk.pl>
References: <201104150053.37037.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1104151034580.2051-100000@iolanthe.rowland.org>
	<20110415145457.GA27650@eazy.amigager.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110415145457.GA27650@eazy.amigager.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tino Keitel <tino.keitel@gmx.de>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, April 15, 2011, Tino Keitel wrote:
> On Fri, Apr 15, 2011 at 10:38:47 -0400, Alan Stern wrote:
> > On Fri, 15 Apr 2011, Rafael J. Wysocki wrote:
> > 
> > > On Friday, April 15, 2011, Tino Keitel wrote:
> > > > Hi,
> > > > 
> > > > with 2.6.38, I enabled wakeup from suspend to RAM with the USB keyboard
> > > > this way:
> > > > 
> > > > echo USB2 > /proc/acpi/wakeup
> > > > 
> > > > This does not work anymore with 2.6.39-rc3. Wakeup using the keyboard
> > > > won't work, and the USB2 line in /proc/acpi/wakeup doesn't change to
> > > > "enabled" after the echo command.
> > > > 
> > > > Is this intended? If yes, what is the new way to enable keyboard
> > > > wakeup?
> > > 
> > > No, it's supposed to work IIRC.  I'll have a look at that code tomorrow.
> > 
> > Tino, can you check the contents of the power/wakeup files in the
> > appropriate sysfs directories?  That would be the directory for the
> > keyboard device itself and the directory for the USB host controller
> > for the bus the keyboard is on.
> > 
> > By default, power/wakeup should be "enabled" for the keyboard device 
> > and "disabled" for the host controller.  If you write "enabled" into 
> > the host controller's file by hand, does that fix the problem?
> 
> I already tried to write "enable" into all USB related wakeup files
> yesterday, not change.
> 
> I'll check again how these files look like in 2.6.38, what sysfs
> wakeup files change when writing into /proc/acpi/wakeup, and what
> differences to 2.6.39-rc can be seen.

Please post the contents of /proc/acpi/wakeup (without reverting the commits
you have identified as "bad").

Thanks,
Rafael
