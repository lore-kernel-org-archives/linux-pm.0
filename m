From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [RFC][PATCH] cpuidle: avoid singing capacitors
Date: Sat, 1 Mar 2008 13:31:27 +0100
Message-ID: <20080301133127.0a85f319__36643.9329962761$1204374930$gmane$org@mjolnir.drzeus.cx>
References: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
	<20080229214407.GC1289@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080229214407.GC1289@csclub.uwaterloo.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 29 Feb 2008 16:44:07 -0500
lsorense@csclub.uwaterloo.ca (Lennart Sorensen) wrote:

> On Fri, Feb 29, 2008 at 07:38:12PM +0100, Pierre Ossman wrote:
> > +/*
> > + * The minimum number of ticks needed to not oscillate faster than
> > + * 500 Hz.
> > + */
> > +#define MIN_DEEP_INTERVAL (HZ / 500)
> 
> What happens here if HZ < 500?  Or does the fact that you have less than
> 500HZ jiffies automatically imply that you can't go to sleep more than
> the jiffy rate times per second?

A low HZ will still go to sleep very often (provided NO_HZ is in effect). But a HZ < 500 makes that number up there turn to zero.  But the check further down makes sure that at least 1 tick passes. So that means it will not enter C3 more often than min(HZ, 500) Hz. Another reason to stop using jiffies.

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
