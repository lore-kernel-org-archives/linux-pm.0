From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Weird Resume Problem
Date: Sat, 24 Nov 2007 19:43:19 +0100
Message-ID: <200711241943.20054.rjw@sisk.pl>
References: <20071124013014.GA4605@best.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071124013014.GA4605@best.com>
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
To: "Leo L. Schwab" <ewhac@best.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 24 of November 2007, Leo L. Schwab wrote:
> 	Today I saw a resume-from-RAM problem that I've never witnessed
> before.
> 
> 	I have a ThinkPad Z61t running the Debian version of kernel
> 2.6.22.10 (linux-source-2.6.22.6).  I normally avoid suspend-to-RAM, as
> there's a bug in the Intel graphics code that can lock up the machine when
> switching virtual terminals.  But with the latest xserver-xorg-video-intel,
> in which this bug is reputedly fixed, I've been trying it more often.
> 
> 	I suspended-to-RAM yesterday afternoon, and attempted to resume
> roughly 24 hours later.  It's the longest I've ever left the machine in a
> suspend-to-RAM state.  Up until this point, resume-from-RAM has always
> worked.
> 
> 	Normally, when resuming from RAM, I see the display wake up to a text
> console.  At the top of the display in yellow text appears, "inu".  I never
> gave much thought to this, assuming it was some sort of glitched attempt to
> print "Linux" to the console.  After that, I normally see kernel resume
> messages appear, followed by the restoration of the X display.
> 
> 	Today, when I resumed, I got the text console, but instead of a
> yellow "inu" at the top, only "i" appeared.  A few moments later, the
> ThinkPad BIOS/boot screen appeared, and the machine proceeded with a fresh
> reboot (praise be to journalled filesystems).

This "Linux" string is a part of debugging code that has been removed recently,
because we suspected it might interact badly with some graphics adapters.

Perhaps something like this happened on your system.

Greetings,
Rafael
