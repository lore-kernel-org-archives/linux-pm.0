From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Few enhancement ideas
Date: Wed, 13 Jul 2005 20:52:55 +0300
Message-ID: <1121277175.6338.105.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67122976026261516=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Igor Stoppa <Igor.Stoppa@nokia.com>, Sampsa Fabritius <sampsa.fabritius@nokia.com>
List-Id: linux-pm@vger.kernel.org

--===============67122976026261516==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Being our first post to this list, I would like to introduce ourselves
as part of the team behind the Nokia 770 (www.nokia.com/770). We have
been preoccupied with the product launch, but now we will be able to
participate, starting with the Ottawa Linux Symposium.

Team contributions
==================
The Nokia 770 Linux team has made many contributions to the Linux-OMAP
port, some of the PM-specific ones being:

- Dynamic tick patch by Tony Lindgren
(http://www.muru.com/linux/dyntick/): Initially for
the OMAP architecture followed by the recent x86 port
- Clock framework for the OMAP architecture - Thanks to Tuukka Tikkanen
- PM-enabling various drivers in the mach-omap tree

The Product
===========
Nokia 770 is powered by an OMAP1710 on a custom board. The device will
ship with a 1500mAh battery which will give a continuous browsing
use-time (WLAN or Bluetooth) of 3hrs. The device needed to be
instant-ON, so we have used run-time power management. This gives us an
official 'standby-time' of 7 days. All the drivers make extensive use of
the clock framework and release clocks when peripheral is not in use.

Interests
=========
Here are a few ideas that we are planning to investigate in order to
address shortcomings in the current PM model with respect to system-wide
PM:

- Regulator framework: similar to clock framework HAL
- Generic framework for system-wide constraints: to handle constraints
outside bus control
- PM framework: Enhance PM framework to allow flexible policy control.
Like DPM?
- User space API: Requires study

Are these ideas of interest to the PM community or Nokia-specific?

Contacts
========
We will be in Ottawa 16.07.05 - 24.07.05. It would be nice to meet
others on this list to discuss these ideas further.

Have a good day.

Regards,
Amit
-- 
Amit Kucheria <amit.kucheria@nokia.com>
Nokia

--===============67122976026261516==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============67122976026261516==--
