From: Pavel Machek <pavel@suse.cz>
Subject: Re: Suspend to disk broken in latest 2.6.28-rc3
Date: Mon, 10 Nov 2008 10:42:39 +0100
Message-ID: <20081110094239.GA14204__13830.2683401436$1226310309$gmane$org@atrey.karlin.mff.cuni.cz>
References: <20081109195033.GA1335@mobydick>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081109195033.GA1335@mobydick>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mathieu Chouquet-Stringer <mchouque@free.fr>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> I've just finished compiling a recent snapshot of rc3 (namely gfed4d59
> [1]) on a F9 distro (gcc 4.3.0 20080428) and suspend to disk doesn't
> work anymore.  My config is attached below [2].
> 
> It just freezes my laptop (an old Thinkpad T30) while it works with
> kernel version 2.6.26 (I've never tried 2.6.27).
> 
> I've tried playing with the pm_test facility, and while the "freezer"
> test works, the "devices" test fails like the real suspend...
> 
> When that happens, the console still works (ie I can switch VTs and
> type) but the whole system doesn't respond: I can't login for example...
> Guess the disk driver is already off at that point.
> 
> I don't have another computer to capture a serial trace so I guess I'm
> going to try to bisect it (which is going to take while on this slow
> computer).  If I reconfigure my syslog could I get the output of the
> suspend process on the screen (for some reason I used to get it during
> suspend but now I only get it during resume)?
> 
> Any ideas or pointers to fix this appreciated...

Trying with minimum drivers is likely to help here, and should be
easier than bisect. Boot with init=/bin/bash, then try "devices" >
pm_dest and disk > state...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
