From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21-rc4-mm1
Date: Tue, 20 Mar 2007 21:12:17 +0100
Message-ID: <200703202112.18236.rjw@sisk.pl>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
	<20070320183821.GD2670@elf.ucw.cz> <4600389E.6030901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4600389E.6030901@gmail.com>
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
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 20 March 2007 20:40, Jiri Slaby wrote:
> Pavel Machek napsal(a):
> > Hi!
> > =

> >>> Andrew Morton napsal(a):
> >>>>   http://userweb.kernel.org/~akpm/2.6.21-rc4-mm1/
> >>> I'm getting this while trying to swsusp:
> >>> Stopping tasks ...
> >>> Stopping kernel threads timed out after 20 seconds (1 tasks refusing =
to freeze):
> >>>  swapper
> >>>  Restarting tasks ... done.
> >>>
> >>> What to test? Enable PM_DEBUG?
> > =

> > Is it repeatable? Freezer normally works better than that.
> =

> Yes, at least it happened 3 times consecutively, when I tried to asleep t=
he
> machine, then I turned it off.
> =

> >> Also, it might be useful to add a temporary /proc/freeze-unfreeze thing
> >> which will simply do a freeze/unfreeze cycle.  Then we can apply vario=
us
> >> workloads to the machine while madly stressing the freezer code.  =

> > =

> > echo testproc > /sys/power/disk; echo disk > /sys/power/state ... is
> > pretty much what you want.
> =

> Ok, I'll try this.

Can I see .config please?

Rafael
