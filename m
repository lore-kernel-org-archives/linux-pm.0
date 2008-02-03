From: Ingo Molnar <mingo@elte.hu>
Subject: Re: sleepy linux self-test
Date: Sun, 3 Feb 2008 06:05:37 +0100
Message-ID: <20080203050537.GA18942__28529.9833318733$1202015306$gmane$org@elte.hu>
References: <20080130131748.GA3796@elf.ucw.cz>
	<20080202193202.GB31621@elf.ucw.cz>
	<20080202193843.GB32039@elte.hu>
	<200802021837.17777.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802021837.17777.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


* David Brownell <david-b@pacbell.net> wrote:

> On Saturday 02 February 2008, Ingo Molnar wrote:
> > 
> > * Pavel Machek <pavel@ucw.cz> wrote:
> > 
> > > > It would have been easier to just use the public interface and 
> > > > hard-wire "rtc0".  But going directly to the hardware was dirtier, 
> > > > and more in the spirit of "hack that obviously shouldn't go upstream 
> > > > until it gets done properly".
> > > 
> > > Yes, it was "quick and dirty". And I do not think it is going upstream 
> > > in this form...?
> > 
> > which would be a pity - this thing _almost_ started doing suspend and 
> > resume cycles on my testsystems, all by itself :-)
> 
> OK, here's a version that's cleaner and suspends.  Resuming ... 
> another story, it's currently broken on this ARM board (no 
> relationship to this testing code).

yay! Threw this into my setup. It built fine with the new option 
disabled and enabled as well. Unfortunately it said this:

[   23.509562] Calling initcall 0xc0c49e00: be_sleepy+0x0/0x170()
[   23.515837] PM: no wakelarm-capable RTC
[   23.517562] initcall 0xc0c49e00: be_sleepy+0x0/0x170() returned 0.

(oh, btw., a small typo: s/wakelarm/wakealarm/)

is "wakealarm" something generally available on PC RTCs? I'll try to 
look into the BIOS setup, maybe it's just disabled ...

	Ingo
