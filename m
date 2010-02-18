From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Two problems with system sleep
Date: Thu, 18 Feb 2010 15:16:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002181134370.1294-100000@iolanthe.rowland.org>
References: <201002172143.16206.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002172143.16206.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, 17 Feb 2010, Rafael J. Wysocki wrote:

> > The difficulty is that I have no way to find out what's going on.  The
> > serial port isn't working (or nothing gets sent to it, or both) and the
> > system hangs before the video output gets enabled.
> 
> You can try to put no_console_suspend into the kernel command line, but I doubt
> it'll help with the serial resume.

It has been there all along.

> Anyway, we need to check if control gets back to acpi_suspend_enter().
> 
> BTW, does anything change if you put acpi_sleep=sci_force_enable into the
> kernel command line?

Nothing changes.  I also added "pci=use_crs", based on a suggestion in 
the log, but that didn't make any difference either.

Alan Stern
