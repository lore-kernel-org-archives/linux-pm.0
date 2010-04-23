From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: document open(/dev/snapshot) sideeffects -- was Re:
	syncing the disks when entering sleep
Date: Fri, 23 Apr 2010 20:28:55 +0200
Message-ID: <201004232028.56005.rjw__35241.9406910942$1272049004$gmane$org@sisk.pl>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201001281143.08993.rjw@sisk.pl> <20100405063852.GA1924@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100405063852.GA1924@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

On Monday 05 April 2010, Pavel Machek wrote:
> Hi!
> 
> > > > Please note that merely _opening_ /dev/snapshot has side effects, so that's
> > > > not just "three ioctls".
> > > 
> > > I search Doc*/power/userland-swsusp.txt, and could not find mentions
> > > of sideeffects. Perhaps that should be fixed?
> > 
> > Please feel free to make the docs more complete, then.
> 
> Yes, something like this?

Yes, looks reasonable.

I've applied it to suspend-2.6/linux-next (added a changelog).

Rafael


> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> --- a/Documentation/power/userland-swsusp.txt
> +++ b/Documentation/power/userland-swsusp.txt
> @@ -24,6 +24,10 @@ assumed to be in the resume mode.  The device cannot be open for simultaneous
>  reading and writing.  It is also impossible to have the device open more than
>  once at a time.
>  
> +Even opening the device has side effects. Data structures are
> +allocated, and PM_HIBERNATION_PREPARE / PM_RESTORE_PREPARE chains are
> +called.
> +
>  The ioctl() commands recognized by the device are:
>  
>  SNAPSHOT_FREEZE - freeze user space processes (the current process is
> 
> 
> 
> 
