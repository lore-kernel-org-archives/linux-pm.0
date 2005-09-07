From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp doesn't suspend devices
Date: Wed, 7 Sep 2005 23:06:51 +0200
Message-ID: <20050907210651.GA2878@elf.ucw.cz>
References: <431ECCE3.8080408@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932258AbVIGVHH@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <431ECCE3.8080408@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> It would seem that swsusp doesn't properly suspend devices, or more
> precisely it wakes them up again before suspending the machine.

Yes, and that's okay.

 What happens to devices during swsusp? They seem to be resumed
during system suspend?

A: That's correct. We need to resume them if we want to write image to
disk. Whole sequence goes like

      Suspend part
      ~~~~~~~~~~~~
      running system, user asks for suspend-to-disk

      user processes are stopped

      suspend(PMSG_FREEZE): devices are frozen so that they don't
interfere
                      with state snapshot

      state snapshot: copy of whole used memory is taken with
interrupts disabled

      resume(): devices are woken up so that we can write image to
swap

      write image to swap

      suspend(PMSG_SUSPEND): suspend devices so that we can power off

      turn the power off

      Resume part
      ~~~~~~~~~~~
      (is actually pretty similar)

      running system, user asks for suspend-to-disk

      user processes are stopped (in common case there are none, but
with resume-from-initrd, noone k\nows)

      read image from disk

      suspend(PMSG_FREEZE): devices are frozen so that they don't
interfere
                      with image restoration

      image restoration: rewrite memory with image

      resume(): devices are woken up so that system can continue

      thaw all user processes

-- 
if you have sharp zaurus hardware you don't need... you know my address
