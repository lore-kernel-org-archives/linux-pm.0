From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v4] ARM
	hibernation/suspend-to-disk	support
Date: Fri, 10 Jun 2011 15:02:01 +0100
Message-ID: <20110610140201.GM24424__13258.146638009$1307714813$gmane$org@n2100.arm.linux.org.uk>
References: <201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<4DF0F45A.3030103@ti.com>
	<20110609164024.GB24424@n2100.arm.linux.org.uk>
	<4DF0FA73.8050607@ti.com>
	<20110609171255.GD24424@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106101110130.11513@localhost6.localdomain6>
	<20110610134311.GK24424@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106101444490.20826@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1106101444490.20826@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frank Hofmann <frank.hofmann@tomtom.com>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 10, 2011 at 02:47:30PM +0100, Frank Hofmann wrote:
> On Fri, 10 Jun 2011, Russell King - ARM Linux wrote:
>
> [ ... ]
>> What's the point when platform code has *ALREADY* to call these functions?
>>
>> Is it really too sodding difficult for platforms to do:
>>
>> my_suspend_hook()
>> {
>> 	mach_pre_suspend_hook();
>> 	cpu_suspend();
>> 	mach_post_suspend_hook();
>> }
>>
>> ?
>>
>> <not read the rest of the message, this is getting idiotic>
>>
>
> Sorry for being unclear.
>
> Yes, they already have to do all this. And they should.
>
>
> Except for one thing:
>
> They all, IN ADDITION, do ALSO:
>
> 	wfi();			/* or whatever else to power down */
>
>
> For Hibernation, _THAT_ needs to be out of the codepath.
>
>
> So that one can snapshot without powering down.

I think there's a fundamental problem here - what's required for S2RAM
is not what's required for hibernate.  After cpu_suspend() has done
its job, you are in a _very_ specific environment designed for the last
stages of S2RAM _only_ and not hibernate.

In order to use cpu_suspend() for hibernate, it requires a completely
different path entirely, and there's no getting away from that.

You can see that when you analyze the differences between S2RAM and
hibernate, when you realize that the final part of the S2RAM process
(which happens after cpu_suspend() returns) on many SoCs is dealing
with putting SDRAM into self-refresh mode before writing some kind of
power mode register to tell the power supply to kill power to most
of the platform.  That is all _very_ SoC specific.

Also realize that the code which executes after cpu_suspend() returns
is _not_ running in the same context as the code which called
cpu_suspend() - cpu_suspend() has modified the stack pointer to store
the CPU specific state and that is not the same stack pointer as was
the case before cpu_suspend() was called.

You don't want to run any of that code when you're dealing with hibernate,
so expecting to be able to reuse these S2RAM paths is not realistic.

What we could do is provide a cpu_hibernate() function which has saner
semantics for saving the CPU specific state for hibernate.
