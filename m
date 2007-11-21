From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [lm-sensors] broken suspend [Was: 2.6.24-rc2-mm1]
Date: Wed, 21 Nov 2007 10:54:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711211053140.3226-100000__5457.37002180449$1195660561$gmane$org@iolanthe.rowland.org>
References: <200711210100.43049.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711210100.43049.rjw@sisk.pl>
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
Cc: Rudolf Marek <r.marek@assembler.cz>, Jiri Slaby <jirislaby@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 21 Nov 2007, Rafael J. Wysocki wrote:

> > Is it possible to unregister a driver on CPU_DOWN_PREPARE_FROZEN?
> 
> No.  In that case the suspend core is holding the device's mutex and your
> attempt to unregister it will deadlock with it.
> 
> Do you _have_ _to_ unregister the device at all?  Why don't you just leave
> it registered on CPU_DOWN_PREPARE_FROZEN?  The CPU is not going away
> physically in this case and it's _guaranteed_ that _cpu_up() will be called on
> it as soon as the hibernation image is ready or we are back from suspend.

This leaves the device registered if for some reason the number of CPUs 
after resuming from hibernation is smaller than the number of CPUs 
before hibernation.  Of course, in theory that's never supposed to 
happen...

Alan Stern
