From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Ottawa Linux Power Management Summit, June 25-26,
	2007 - Minutes
Date: Tue, 25 Sep 2007 13:39:36 +0200
Message-ID: <200709251339.37601.rjw@sisk.pl>
References: <200709050426.04793.lenb@kernel.org>
	<200709091426.39854.rjw@sisk.pl> <20070924194102.GH8127@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070924194102.GH8127@redhat.com>
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
To: Dave Jones <davej@redhat.com>
Cc: linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Monday, 24 September 2007 21:41, Dave Jones wrote:
> On Sun, Sep 09, 2007 at 02:26:39PM +0200, Rafael J. Wysocki wrote:
> 
>  > > Dave mentioned that Fedora Core 7 32-bit is now shipping with
>  > > CONFIG_NOHZ=y and CONFIG_HZ=1000.
>  > 
>  > CONFIG_NOHZ is known to break suspend and resume on some machines.  These
>  > problems are being fixed over time, but that's a risky decision for a
>  > distribution to switch it on by default.
> 
> Expect to see everyone else doing the same thing in the next versions.
> Without field-testing this stuff it remains busted.  A lot of bugs got
> found and fixed by having this in Fedora that weren't tripped over
> by linux-kernel testers at all.

Well, that's certainly true.

Still, we have open suspend bugs in which NO_HZ appears to be the culprit,
eg. http://bugzilla.kernel.org/show_bug.cgi?id=8680

Greetings,
Rafael
