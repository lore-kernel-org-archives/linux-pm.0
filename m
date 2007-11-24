From: "Leo L. Schwab" <ewhac@best.com>
Subject: Weird Resume Problem
Date: Fri, 23 Nov 2007 17:30:14 -0800
Message-ID: <20071124013014.GA4605@best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

	Today I saw a resume-from-RAM problem that I've never witnessed
before.

	I have a ThinkPad Z61t running the Debian version of kernel
2.6.22.10 (linux-source-2.6.22.6).  I normally avoid suspend-to-RAM, as
there's a bug in the Intel graphics code that can lock up the machine when
switching virtual terminals.  But with the latest xserver-xorg-video-intel,
in which this bug is reputedly fixed, I've been trying it more often.

	I suspended-to-RAM yesterday afternoon, and attempted to resume
roughly 24 hours later.  It's the longest I've ever left the machine in a
suspend-to-RAM state.  Up until this point, resume-from-RAM has always
worked.

	Normally, when resuming from RAM, I see the display wake up to a text
console.  At the top of the display in yellow text appears, "inu".  I never
gave much thought to this, assuming it was some sort of glitched attempt to
print "Linux" to the console.  After that, I normally see kernel resume
messages appear, followed by the restoration of the X display.

	Today, when I resumed, I got the text console, but instead of a
yellow "inu" at the top, only "i" appeared.  A few moments later, the
ThinkPad BIOS/boot screen appeared, and the machine proceeded with a fresh
reboot (praise be to journalled filesystems).

	Moments before I attempted the resume, I had plugged the machine
into mains power.  I don't think this is relevant, as the battery had 70%
capacity remaining.

	Sadly, there is no further data other that this account as
(obviously) no logs survive, and I haven't (yet) enabled the RTC-destroying
suspend debugging option.

	I was idly curious if anyone had seen anything like this before, and
whether the yellow "inu" I've been seeing at resume has any significance at
all.

					Thanks,
					Schwab
