From: Tom Marshall <tommy@home.tig-grr.com>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Date: Fri, 6 Jan 2006 06:34:14 -0800
Message-ID: <20060106143414.GA14043@home.tig-grr.com>
References: <20051227213439.GA1884@elf.ucw.cz> <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com> <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net> <20060105215528.GF2095@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750795AbWAFOff@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060105215528.GF2095@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> > I have a firewire controller in a desktop system, and a ATI Radeon in a
> > T42 that support D1 and D2..
> 
> Ok, now we have a concrete example. So Radeon supports D1. But putting
> radeon into D1 means you probably want to blank your screen and turn
> the backlight off; that takes *long* time anyway. So you can simply
> put your radeon into D3 and save a bit more power.
> 
> So yes, Radeon supports D1, but we probably do not want to use it.

I understand this is a theoretical argument.  However, in reality, a
significant number of T42 owners get less than 12 hours of battery life in
S3 suspend because the Radeon chip sucks a huge amount of power with the
current code.  We would be eternally grateful if someone could figure out
why only some models are affected and, more importantly, submit a patch that
will reliably enter D2 (or D3 if it is supported?) for all Radeon 7500
chips.  I've found a couple patches that were submitted to this list but,
for whatever reason, nobody seems to have found a solution that is
acceptable yet.  I've been manually patching my kernels with code to enter
D2 for the last year or so, and from the volume of google results, it looks
like quite a lot of other folks are doing the same... :(
