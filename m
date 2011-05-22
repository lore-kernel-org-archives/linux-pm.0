From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Sun, 22 May 2011 11:54:52 +0200
Message-ID: <201105221154.52829.rjw__29425.2901491292$1306058206$gmane$org@sisk.pl>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<201105210027.17159.rjw@sisk.pl>
	<2C577202CB5719438D4E9608C565CB2C01B69D7B@NL-EXC-07.intra.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <2C577202CB5719438D4E9608C565CB2C01B69D7B@NL-EXC-07.intra.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frank Hofmann <Frank.Hofmann@tomtom.com>
Cc: linux-pm@lists.linux-foundation.org, Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, tuxonice-devel@tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Sunday, May 22, 2011, Frank Hofmann wrote:
> > [ ... ]
> > > > r8_FIQ..r12_FIQ can store arbitrary state used by the FIQ handler,
> > > > if FIQ is in use.  Can we expect any driver using FIQ to save/restore
> > > > this state itself, rather than doing it globally?  This may be
> > > > reasonable.
> > > 
> > > We don't need to save/restore those, because at the time the snapshot is 
> > > taken interrupts are off and we cannot be in any trap handler either. On 
> > > resume, the kernel that has been loaded has initialized them properly 
> > > already.
> > 
> > I'm not sure if this is a safe assumption in general.  We may decide to
> > switch to loading hibernate images from boot loaders, for example, and
> > it may not hold any more.  Generally, please don't assume _anything_ has
> > been properly initialized during resume, before the image is loaded.
> > This has already beaten us a couple of times.
> > 
> > Thanks,
> > Rafael
> 
> Hi Rafael,
> 
> regarding "cannot rely on any state", if that is so then it seems quite
> unnecessary to save/restore _any_ ARM non-#SYSTEM_MODE state - it'd better
> be reinitialized by calling cpu_init() after the "core restore" callback.

If they are always initialized in the same way and if you can do the CPU
initialization at this point, I agree.

> The archives were quite a bit helpful in this context:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12671.html
> 
> that's the same situation isn't it ?

I'm not sure, I'm not an ARM expert, but it seems so.

> Regarding FIQ: I agree with Russell and others who previously stated that
> a driver using FIQ is responsible for implementing suspend/resume hooks itself.

I agree with that too.

> But what could be done is to disable/enable it for the snapshot, just in case.

OK

> I've also found out that the vmlinux.lds changes don't seem to be necessary
> - they've been the last remnant of the "old" ARM hibernation patch, but just
> leaving those out looks to make no difference (the nosave data still ends up
> in the same place, with the same elf section attributes).
> 
> With all this in mind, the core part of the patch becomes somewhat simpler.
> See attached.

It looks reasonable, but it slightly concerns me that you seem to assume
that swapper_pg_dir will be the same in both the boot and the target kernel.
We used to make this assumption on x86 too, but it started to cause
problems to happen at one point.  To address those problems we had to create
temporary page tables using page frames that are guaranteed not to be
overwritten in the last phase of restore (that would be the for () loop in
your __swsusp_arch_restore_image()).

Thanks,
Rafael
