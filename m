From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: b43_suspend problem
Date: Sun, 13 Jan 2008 01:52:31 +0100
Message-ID: <200801130152.31724.rjw__42389.9124180481$1200185511$gmane$org@sisk.pl>
References: <200801130008.29996.rjw@sisk.pl> <200801130030.45119.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801130030.45119.mb@bu3sch.de>
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
To: Michael Buesch <mb@bu3sch.de>
Cc: pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de, Larry Finger <larry.finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

On Sunday, 13 of January 2008, Michael Buesch wrote:
> On Sunday 13 January 2008 00:08:29 Rafael J. Wysocki wrote:
> > There is a problem with b43_suspend() that it (indirectly) causes
> > b43_leds_exit() to be called, which attempts to unregister the leds device
> > objects, which is forbidden (ie. you can't unregister and/or register devices
> > during a suspend or resume).
> 
> Why?

Well, the unregistering itself is not really harmful, provided that the device
is not registered back during the subsequent resume.

The PM core uses a list of active devices that are added to the list in
device_add().  The ordering of this list is important, because it is expected
to reflect the order in which the devices are to be suspended.

This list is manipulated during suspend/resume and devices are moved from it
and back to it, so unregistering devices during a suspend and registering them
during the subsequent resume generally changes its ordering and may lead to
problems during the next suspend/resume cycle.

This is also undesirable if we're going to stop using the freezer for
suspend/resume at one point in the future.

I'm sure Alan can add some more details.

Greetings,
Rafael
