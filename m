From: Michael Buesch <mb@bu3sch.de>
Subject: Re: b43_suspend problem
Date: Sun, 20 Jan 2008 21:10:36 +0100
Message-ID: <200801202110.36556.mb__20915.0323913947$1200859953$gmane$org@bu3sch.de>
References: <Pine.LNX.4.44L0.0801131634380.28667-100000@netrider.rowland.org>
	<200801201333.10123.mb@bu3sch.de> <200801201926.56363.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801201926.56363.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de, Larry Finger <larry.finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

On Sunday 20 January 2008, Rafael J. Wysocki wrote:
> > Nah, please don't obfuscate the code.
> > Better add a flag to struct b43_wldev and check that in the few places
> > that need different behaviour.
> 
> I can do that, if you prefer, but that will look worse, IMHO.

I'm pretty sure it won't. We had such a flag in the past for firmware.
(Fixed that differently now).
You simply have do do dev->suspending = 1; at the beginning of suspend/resume
and dev->suspending = 0; at the end. The if() checks in the code remain the same.
The only thing that this approach won't do it clutter the (already hard
to understand) interface up/down API. And that is good. We already have
enough special cases for this stuff due to device weirdness. Let's not make it worse.
I had a hard time to make a sane API for this (look at bcm43xx to compare to
the old crap that doesn't work on lots of devices. ;) )

Thanks for doing this patch.
