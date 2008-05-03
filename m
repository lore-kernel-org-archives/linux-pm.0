From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend, followed by immediate resume
Date: Sat, 3 May 2008 15:09:01 +0200
Message-ID: <200805031509.01883.rjw@sisk.pl>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
	<200805031450.19960.rjw@sisk.pl>
	<20080503075821.673b1b14@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080503075821.673b1b14@osprey.hogchain.net>
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
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 3 of May 2008, Jay Cliburn wrote:
> On Sat, 3 May 2008 14:50:19 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > BTW, have you tested it with init=/bin/bash already?
> 
> No.  Is mounting /proc and /sys manually as simple as this?
> 
> mount -t proc rw proc /proc
> mount -t sysfs rw sysfs /sys
> 
> What sort of suspend/resume behavior am I looking for when I use
> init=/bin/bash?

Set your BIOS setting to "Auto" and boot the kernel with init=/bin/bash.
You should get a root shell as a result of this.  From this shell run:

# mount /proc
# mount /sys
# echo 8 > /proc/sys/kernel/printk
# eche mem > /sys/power/state

and see if it suspends.  If it does, try to wake it up and see what happens.

Thanks,
Rafael
