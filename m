From: Patrick Mochel <mochel@digitalimplant.org>
Subject: [Patch 0/6] Remove Deprecated PM Interface from Obsolete Sound
 Drivers
Date: Wed, 23 Nov 2005 12:23:25 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0511231114340.14446-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932306AbVKWUXh@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, linux-pm@lists.osdl.org
Cc: akpm@osdl.org
List-Id: linux-pm@vger.kernel.org


Hi there.

This is a series of 6 patches that remove the old, deprecated power
management interface from a variety of old OSS drivers, most of them
marked OBSOLETE and scheduled for removal in January 2006.

These patches facilitate the removal of the ancient PM interface by
reducing the number of in-kernel users to 3:

	drivers/net/3c509.c
	drivers/net/irda/ali-ircc.c
	drivers/serial/68328serial.c

Of the drivers affected by these patches, the following are marked
OBSOLETE:

	- cs4281
	- cs46xx
	- maestro
	- nm256

The following is not, though there seems to be a corresponding ALSA
driver:

	- opl3sa2

The ad1848 driver is used by several OSS drivers. This may be the most
controversial removal.

Does any one have any objections to these patches?


Thanks,


	Pat


Patrick Mochel:
      [OSS] Remove deprecated PM interface from ad1848 driver.
      [OSS] Remove deprecated PM interface from cs4281 driver.
      [OSS] Remove deprecated PM interface from cs46xx driver.
      [OSS] Remove deprecated PM interface from maestrodriver.
      [OSS] Remove deprecated PM interface from nm256 driver.
      [OSS] Remove deprecated PM interface from opl3sa2driver.

 sound/oss/ad1848.c             |   92 -------------------------
 sound/oss/cs4281/cs4281m.c     |   21 -----
 sound/oss/cs4281/cs4281pm-24.c |   39 ----------
 sound/oss/cs46xx.c             |   60 ----------------
 sound/oss/cs46xxpm-24.h        |    4 -
 sound/oss/maestro.c            |  149 -----------------------------------------
 sound/oss/nm256_audio.c        |   47 ------------
 sound/oss/opl3sa2.c            |  110 ------------------------------
 8 files changed, 1 insertion(+), 521 deletions(-)
