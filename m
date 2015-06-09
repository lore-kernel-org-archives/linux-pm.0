From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] x86 TSC: set X86_FEATURE_TSC_RELIABLE, per CPUID
Date: Tue, 9 Jun 2015 10:15:31 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506091014180.4133@nanos>
References: <f1643565587e70dd2fe2714e9afa566689211a9a.1433050960.git.len.brown@intel.com> <556CA704.1070000@kernel.org> <CAJvTdKm8mksFNnhchXepOanjCT4qiYTjmt3BtL81BepuPw+K1w@mail.gmail.com> <CALCETrWJSqeJsyo7p2cw-cfrt75igQy8FLddvS5adGQ2Wu+8ag@mail.gmail.com>
 <CAJvTdKmnzaOEi-j4J-yA2VP+EFT014gBKX7sEPrP2cz1v02avg@mail.gmail.com> <CALCETrUvkBLQZXQYKs2nNTgUeBQvP1jntFPEkh0m6r_-CQt3-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45000 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbFIIP3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2015 04:15:29 -0400
In-Reply-To: <CALCETrUvkBLQZXQYKs2nNTgUeBQvP1jntFPEkh0m6r_-CQt3-w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Mon, 8 Jun 2015, Andy Lutomirski wrote:
> On Wed, Jun 3, 2015 at 12:03 PM, Len Brown <lenb@kernel.org> wrote:
> > If you boot this machine with "tsc=reliable", to disable the cpu_up
> > check_tsc_sync,
> > what happens?  Does the run-time clocksource code detect the bogus TSC values?
> > If yes, how long does that take?
> 
> They didn't detect it in the time I watched it.

Which is not surprising as the run-time check is disabled with the
reliable flag as well.

        if (tsc_clocksource_reliable)
                clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;

Thanks,

	tglx
