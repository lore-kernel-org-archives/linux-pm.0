From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.27-rc0 Power Bugs with HP/Compaq Laptops
Date: Thu, 7 Aug 2008 23:00:20 +0200
Message-ID: <200808072300.21771.rjw__160.508955787186$1218143193$gmane$org@sisk.pl>
References: <680ad8bc0808070757u49e13b3br1f69fb4881dc44ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <680ad8bc0808070757u49e13b3br1f69fb4881dc44ce@mail.gmail.com>
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
To: Matt Parnell <mparnell@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

[Adding CCs]

On Thursday, 7 of August 2008, Matt Parnell wrote:
> I have had a long ongoing ordeal dealing with the problems associated
> with the HP Pavilion Laptops, mine being a dv9000 series. It seems
> that these either have a broken HPET table, a missing HPET table, or
> some other ACPI issue, as this thing has always had many issues
> regarding ACPI. First, C1E was broken until I totally disabled it with
> a patch, but since .27, that code has been rewritten, and now for some
> reason HPET isn't working anymore, as I have to set the
> clocksource=tsc. On top of that, the tsc clocksource is unstable, and
> with or without dynticks the .27 kernels on my laptop feel slower, and
> laggy, as even KDE slows down whilest using it. Everything works fine
> if I disable the local apic (lapic), but when I do, only one of my CPU
> cores is detected and used, and the CPU frequency scaling doesn't work
> either. No matter what I do with .27, it just won't work.
> 
> I've tried with the linux next kernel as suggested by Eduard Munteanu,
> to no avail with the same problem. He said this:
> 
> "This is not the right fix. Instead, HPET should be used as a timer
> source for dynticks. This is not in 2.6.26, but I tried the linux-next
> tree (google it) and it looked like dynticks worked fine, without
> disabling C1E. Can't place my finger on the exact commit, but you could
> check."
> 
> Apparently, it's either this or something closely related that is
> causing such calamity for users of these HP/Compaq laptops as myself.
> I say this not just for me, as there are many thousands who have
> issues with these laptops and their crappy bios implementations. Most
> are n00bs using Ubuntu, who can't even voice what's wrong, as they are
> new to linux anyway.
> 
> That said, here are system specifics regarding the motherboard and make.
> 
> HP Pavilion dv9205us
> Motherboard: Quanta 30B7
> Processor: AMD Turion 64 x2 3.2ghz, TL-50
> Bios: Phoenix (this is known to be buggy, but until now I had no
> problems since 2.6.24. Compiled on Windows, this bios is.)
> 
> Other than that, I have no pertinent information, at least until
> someone asks something specific. I wouldn't be contacting you all if I
> wasn't at the end of my own resources, as I am part of the Zen kernel
> community, and they can usually help out with these sorts of things.
> (zen-sources.org).
> 
> Anyway, I appreciate any help/response I can get out of this.
> 
> Thanks!
> Matt Parnell
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
