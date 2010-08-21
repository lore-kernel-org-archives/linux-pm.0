From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fan runs full speed after S3 sometimes (regression)
Date: Sat, 21 Aug 2010 19:05:51 +0200
Message-ID: <20100821170551.GA27159__42317.3765339472$1282410547$gmane$org@elf.ucw.cz>
References: <4C613619.30309@gmail.com> <4C619CF0.30609@gmail.com>
	<20100820063107.GB1607@ucw.cz> <4C6E233A.5000209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C6E233A.5000209@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >>> till I was running on 2.6.34-rc5-mm1 (mmotm) and earlier everything was
> >>> fine. Now, I'm running 2.6.35-rc6-mm1 (.35-rc5-mm1 was the same) and
> >>> sometimes when the computer (desktop) returns from S3, the CPU fan is
> >>> running at full speed making a big noise.
> >>
> >> Just to add, full power cycle is needed to get rid of that. Warm reboot
> >> is not enough.
> > 
> > Seems like bios problem... Update bios?
> 
> I don't think so, it had been working for more than 2 years before this
> issue appeared.

Well; if it survives warm reboot, then it looks like BIOS problem...

> >>> I don't know how to debug that. Bisection is out of question -- it
> >>> happens once in 10 or 20 cases. There are no fan entries in /sys.
> > 
> > Well, doing 20 suspends in a row from a script should not be too bad.
> 
> 20 is just a guess. I haven't seen it for pretty few days until the day
> before yesterday. And it looks like CPU1 is brought up a half way. When
> the fan was at full speed I tried:
> echo 0 > /sys/devices/system/cpu/cpu1/online
> and whole system freezed. Otherwise this commands succeeds.

Ok, so this looks like the kernel problem, on the other hand. Two
different problems?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
