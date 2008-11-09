From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to disk broken in latest 2.6.28-rc3
Date: Sun, 9 Nov 2008 20:59:30 +0100
Message-ID: <200811092059.31178.rjw__38680.9156080291$1226260730$gmane$org@sisk.pl>
References: <20081109195033.GA1335@mobydick>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081109195033.GA1335@mobydick>
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
To: Mathieu Chouquet-Stringer <mchouque@free.fr>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 9 of November 2008, Mathieu Chouquet-Stringer wrote:
> 	Hello Pavel and Rafael,
> 
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

Please check if that's http://bugzilla.kernel.org/show_bug.cgi?id=11989 and
if that's the case, please add a "me too" to the bug entry.

Thanks,
Rafael
