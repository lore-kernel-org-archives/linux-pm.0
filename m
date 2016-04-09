From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Sat, 09 Apr 2016 09:27:26 +0200
Message-ID: <1460186846.3765.168.camel@gmail.com>
References: <1460092854.4051.1.camel@gmail.com>
	 <20160408064510.GK3448@twins.programming.kicks-ass.net>
	 <1460098254.5582.17.camel@gmail.com> <2428384.mEkP3EOpsR@vostro.rjw.lan>
	 <001101d191e4$b00602d0$10120870$@net> <001e01d1922f$ef219a10$cd64ce30$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37633 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbcDIH1b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 03:27:31 -0400
In-Reply-To: <001e01d1922f$ef219a10$cd64ce30$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Rik van Riel' <riel@redhat.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>

On Sat, 2016-04-09 at 00:17 -0700, Doug Smythies wrote:

> I still didn't find the exact same program, but I think I found some
> earlier version of the correct test.
> 
> I get (long term average):
> Kernel 4.4.0-17: Powersave 3.93 usecs/loop ; Performance 3.93 usecs/loop 0.89
> Kernel 4.5-rc7: Powersave 3.47 usecs/loop ; Performance 3.51 usecs/loop  1.00
> Kernel 4.6-rc1: Powersave 3.84 usecs/loop ; Performance 3.88 usecs/loop  0.90
> 
> So, similar results (so far, I didn't try reverted yet).

I likely see a bit more go missing because I throttle no_hz when idle
is being hammered at high frequency.

	-Mike
