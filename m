From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Alternative approach to solve the deferred probe
Date: Wed, 21 Oct 2015 18:20:42 +0100
Message-ID: <20151021172042.GJ32532@n2100.arm.linux.org.uk>
References: <CAAObsKDS_+AZ26P_fHc6pvAYrQotsuoO0DEGQUWC514t3DD_jQ@mail.gmail.com>
 <20151019143045.GE32532@n2100.arm.linux.org.uk>
 <CAAObsKDWM6A98tdKHqi4fe5DBf0BmB0JeghcZDWan_PYbyshag@mail.gmail.com>
 <20151019153548.GM32532@n2100.arm.linux.org.uk>
 <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
 <20151020154656.GY32532@n2100.arm.linux.org.uk>
 <56270D5B.5010902@gmail.com>
 <20151021081847.GB32532@n2100.arm.linux.org.uk>
 <5627B0F7.7010600@gmail.com>
 <5627C381.60602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5627C381.60602@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: frowand.list@gmail.com, Geert Uytterhoeven <geert@linux-m68k.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 21, 2015 at 07:55:29PM +0300, Grygorii Strashko wrote:
> On 10/21/2015 06:36 PM, Frank Rowand wrote:
> > The above is currently the last point for probe to succeed or defer
> > (until possibly, as you mentioned, module loading resolves the defer).
> > If a probe defers above, it will defer again below.  The set of defers
> > should be exactly the same above and below.
> > 
> 
> Unfortunately this is not "the last point for probe to succeed or defer".

Of course it isn't.  Being pedantic, there's actually no such thing,
because the point that the kernel as finished booting can never actually
be determined with things like modules being present.  That's something
I've acknowledged from the start of this.

> There are still a bunch of drivers in Kernel which will be probed at late_initcall() level.
> (like ./drivers/net/ethernet/ti/cpsw.c => late_initcall(cpsw_init);
> Yes - they probably need to be updated to use module_init(), but that's what
> we have now). Those drivers will re-trigger deferred device probing if their
> probe succeeded.

Maybe this particular late_initcall() which triggers off the deferred
probing should be moved to its own really_late_initcall() which happens
as the very last thing - I think this is intended to run after everything
else has had a chance to probe once.

> As result, it is impossible to say when will it happen the 
> "final round of deferred device probing" :( and final list of drivers
> which was "deferred forever" will be know only when kernel exits to
> User space  ("deferred forever" - before loading modules).
> 
> May be, we also can consider adding debug_fs entry which can be used to
> display actual state of deferred_probe_pending_list? 

There are complaints in this thread about the existing deferred probing
implementation being hard to debug - where it's known that a device
has deferred, but it's not known why that happened.

That would be solved by my proposal, as this final round of probing
before entering userspace after _all_ normal device probes have been
attempted once and then we've tried to satisfy the deferred probe
(okay, that's what it's _supposed_ to be - and as it takes three lines
to write it, you'll excuse me if I just use the abbreviated "final
round of deferred probe" which is much shorter - but remember that
the long version is what I actually mean) would produce a list of
not only the devices that failed to probe, but also the cause of the
deferred probes.

My proposal would ensure that subsystems are happier to add these
prints, because in the normal scenario where we have deferred probing,
we're not littering the console log with lots of useless failure
messages which make people stop and think "now did device X probe?"
It also means scripts in our boot farms can more effectively analyse
the log and determine whether the boot was actually successful and
contained no errors.

Merely printing the list of devices which have been deferred is next
to useless.  The next question will always be "why did device X defer?"
and if that can't be answered, it means people having to spend a long
time adding lots of printks to the kernel at lots of -EPROBE_DEFER
returning sites or in the relevant drivers, tracing through the code
back towards the -EPROBE_DEFER sites to try and track it down.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
