From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Re: Suspend, followed by immediate resume
Date: Sat, 3 May 2008 08:35:14 -0500
Message-ID: <20080503083514.0b62638e@osprey.hogchain.net>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
	<200805031450.19960.rjw@sisk.pl>
	<20080503075821.673b1b14@osprey.hogchain.net>
	<200805031509.01883.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805031509.01883.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 3 May 2008 15:09:01 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Set your BIOS setting to "Auto" and boot the kernel with
> init=/bin/bash. You should get a root shell as a result of this.
> From this shell run:
> 
> # mount /proc
> # mount /sys
> # echo 8 > /proc/sys/kernel/printk
> # eche mem > /sys/power/state
> 
> and see if it suspends.  If it does, try to wake it up and see what
> happens.

The system suspends and does not spontaneously resume.  That's an
improvement.

Unfortunately I can't awaken it.  It's a desktop system and pressing
keys, shaking the mouse, or momentarily pressing the power switch has no
effect, despite setting these things in BIOS.  (There are some APM
settings in there that selectively enable waking on various events.)

Ctrl-alt-del actually did cause a reboot, though.

As an aside, I finally got wake-on-lan working, so the reason I came to
linux-pm in the first place has been satisfied.  I don't *need*
suspend/resume to work on this system, however, if you think
the suspend issue I'm having is worth pursuing, I'm perfectly willing
to press on.  Your call.
