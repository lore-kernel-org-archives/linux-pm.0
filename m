From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Resume after suspend-to-ram broken for Vaio SR19VN
	in 30rc2
Date: Tue, 21 Apr 2009 15:21:31 +0200
Message-ID: <200904211521.31450.rjw@sisk.pl>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
	<200904202253.54768.rjw@sisk.pl>
	<31c940650904201511l45e32bfbn8c30955c7b81962d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <31c940650904201511l45e32bfbn8c30955c7b81962d@mail.gmail.com>
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
To: fanderay <fanderay4@googlemail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 21 April 2009, fanderay wrote:
> On Mon, Apr 20, 2009 at 9:53 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> I have a Vaio SR19VN (Radeon HD 3400 video) and resume after
> >> suspend-to-ram fails with 2.6.30rc2/x86_64.  I have been testing with
> >> the s2ram tool using the approach described at
> >> http://en.opensuse.org/S2ram.  None of the s2ram options changes the
> >> behavior, which is that the system freezes hard while attempting to
> >> resume (screen stays off/black) and must be physically powered down.
> >> The caps-lock test fails, which suggests this is more than just a
> >> video problem.  Suspend/resume actually did work with the stock Debian
> >> lenny kernel (2.6.26/amd64).  The kernel config is pasted at
> >> http://pastebin.com/mb4dd790.  Any idea what might be wrong?
> >
> > Have you tried to suspend after booting with init=/bin/bash ?
> > You'll need to mount /sys and /proc manually before the suspend for it to work.
> >
> > Also it might be worth checking if anything changes with the fglrx binary
> > driver.
> 
> Thanks, Rafael.  Yes, all my tests were run by booting with
> init=/bin/bash and conducted at the console, so no X.  So it seems
> like something quite low-level is broken.

Please try if booting with acpi_sleep=old_ordering changes anything.

Best,
Rafael
