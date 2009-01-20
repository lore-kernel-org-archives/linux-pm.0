From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
 all devices early (was: Re: EeePC resume failure - timers)
Date: Wed, 21 Jan 2009 07:19:32 +1100 (EST)
Message-ID: <alpine.LFD.2.00.0901210703530.2892__14126.5636230402$1232483661$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<200901200945.37371.jbarnes@virtuousgeek.org>
	<alpine.LFD.2.00.0901210613030.3457@localhost.localdomain>
	<200901201130.17987.jbarnes@virtuousgeek.org>
	<alpine.LFD.2.00.0901210642570.2885@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0901210642570.2885@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@linux.ie>, Keith Packard <keithp@keithp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 21 Jan 2009, Linus Torvalds wrote:
> 
> I was going to say that I've been VT switching and it has worked, but I 
> decided to double-check. And yes, I can reproduce it that way. And no, no 
> kernel messages that are visible that way either. 

Ahhah!

No kernel messages, because the kernel isn't actually dead. Just X is. 

I verified that by doing a

	while : ; do echo t > /proc/sys/sysrq-trigger; sleep 5; done

while doing these things. I'm travelling, it's 7AM in Hobart now, and I 
don't have another machine, so when X dies in graphics mode, there's not a 
whole lot else I can do to debug it. No other machine to use to ssh into 
the machine from etc..

Also, the reason I at one point thought that VT switching works is that 
quite often it _does_ work. I seem to need some timing or interrupt thing 
happening to trigger the problem, because when I wasn't doing anything 
else, I could VT switch back and forth something like 10 times without 
problems.

That probably also explains why it then happens all the time on 
suspend/resume: other things are most definitely happening.

So I did another shell loop (that also gives an audible clue that things 
are working, even if the machine appears dead):

	while : ; do cat /bin/echo ; sleep 5; done > /dev/audio

and the VT switch failed the very next time I tried it. 

And since I had the sysrq loop running, and since it still made progress, 
I can now say that X seems to hang here:

	Xorg          S f52a3b98  6088  2252   2251
	 f68db340 00003082 c06ea2f8 f52a3b98 c07bb73c c07bec40 c07bec40 c07bec4
	 c07bec40 f4a58980 f4a58be8 c2010c40 00000000 00000000 bfc1f838 0000020
	 bfc1f838 f4a58be8 fffe9b5a 000a037f 00003282 c022d7ff f514fe98 f4a58c5
	Call Trace:
	 [<c022d7ff>] lock_timer_base+0x19/0x35
	 [<c022d983>] __mod_timer+0xba/0xc3
	 [<c05a65ef>] schedule_timeout+0x9f/0xbb
	 [<c022d522>] process_timeout+0x0/0x5
	 [<c05a65ea>] schedule_timeout+0x9a/0xbb
	 [<c038c494>] drm_wait_vblank+0x2d8/0x396
	 [<c0221c4c>] default_wake_function+0x0/0x8
	 [<c038a5ab>] drm_ioctl+0x1a6/0x21e
	 [<c038c1bc>] drm_wait_vblank+0x0/0x396
	 [<c0288d5e>] vfs_ioctl+0x49/0x5f
	 [<c0289527>] do_vfs_ioctl+0x464/0x49f
	 [<c02895a3>] sys_ioctl+0x41/0x58
	 [<c0202d01>] sysenter_do_call+0x12/0x21

ie it seems to be some vblank race. 

Looks like your commit dc1336ff4fe08ae7cfe8301bfd7f0b2cfd31d20a wasn't a
complete solution? Because it's definitely something I have, and I have
compiz, and I see the compiz hangs at VT switch that it claims to have
fixed. 

Added the other people that the git logs say worked on the vblank code
to the Cc.  

What an odd way to debug X lockups. What do you guys usually do? Just 
always make sure to have another machine handy?

				Linus
