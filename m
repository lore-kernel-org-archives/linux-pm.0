From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq-next opps with cpufreq-bench
Date: Sun, 13 Oct 2013 22:38:58 +0200
Message-ID: <1495620.7xAc6pX6Cx@vostro.rjw.lan>
References: <20131013090159.GB24566@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59137 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755284Ab3JMU1L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2013 16:27:11 -0400
In-Reply-To: <20131013090159.GB24566@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Sunday, October 13, 2013 11:01:59 AM Andrew Lunn wrote:
> Hi Viresh
> 
> I said off list last week i has having problems with your cpufreq-next
> branch with cpufreq-bench.
> 
> It is simple to reproduce, just run cpufreq-bench and within a few
> seconds you get:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = cfa60000
> [00000000] *pgd=0d7c9831, *pte=00000000, *ppte=00000000
> Internal error: Oops: 17 [#1] PREEMPT ARM
> Modules linked in:
> CPU: 0 PID: 2427 Comm: cpufreq-bench Not tainted 3.12.0-rc4-00708-g1546af5 #86
> task: cfa98e60 ti: ce58a000 task.ti: ce58a000
> PC is at wake_up_process+0xc/0x48
> LR is at __up_write+0x158/0x164
> pc : [<c0040a14>]    lr : [<c0209630>]    psr: 60000093
> sp : ce58bd90  ip : ce58bda8  fp : ce58bda4
> r10: cfb3aa28  r9 : ce58bea8  r8 : ce58beb8
> r7 : ce58beac  r6 : 00000000  r5 : cfb3a9c0  r4 : ce58be10
> r3 : cfb3aa5c  r2 : cfb3aa5c  r1 : 00000000  r0 : 00000000
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 0005397f  Table: 0fa60000  DAC: 00000015
> Process cpufreq-bench (pid: 2427, stack limit = 0xce58a1c0)
> Stack: (0xce58bd90 to 0xce58c000)
> bd80:                                     ce58be10 cfb3a9c0 ce58bddc ce58bda8
> bda0: c0209630 c0040a18 0000000b 80000013 ce58bdcc ce58be10 cfb3a9c0 c064c2a8
> bdc0: ce58bea8 ce58beb8 0000000b cfb3aa28 ce58bdec ce58bde0 c0039fe8 c02094e8
> bde0: ce58be0c ce58bdf0 c03578a0 c0039fe8 cfb3a9c0 ce58be10 00000000 0000000b
> be00: ce58beec ce58be10 c0358efc c0357790 00000001 00000001 00000000 00000000
> be20: 00000000 00000000 00186a00 00082355 00001388 00082355 00186a00 00082355
> be40: 00000000 c064c278 cfae7220 00000001 ffffffe0 cfb3aa04 cfb3aa04 c0358dec
> be60: 00082355 00186a00 00000000 c064c2a8 c064c108 c064c108 cfae71c0 cfb3aa2c
> be80: cfb3aa2c c0622808 00000000 c064c0c4 cfae6880 00000002 00000003 00000000
> bea0: cfb3aa50 cfb3aa50 00000000 cfb3aa5c cfb3aa5c 00000000 66726570 616d726f
> bec0: 0065636e ce58bed0 c04ab470 cfb3aa58 cfb3a9c0 ce58bf78 cfae6a80 c04d6e3c
> bee0: ce58bf14 ce58bef0 c03576e8 c0358e60 c0082cd4 0000000b cfb43000 c064c1b0
> bf00: cfa12f40 cfa12f58 ce58bf44 ce58bf18 c011a078 c0357670 ce58bf78 cf8f6a00
> bf20: 0000000b bedcfaf0 ce58bf78 0000000b ce58a000 00000000 ce58bf74 ce58bf48
> bf40: c00bb340 c0119f80 c00b8b10 c00c97f8 cf8f6a00 00000000 00000000 00000000
> bf60: 0000000b 00000000 ce58bfa4 ce58bf78 c00bb4f0 c00bb284 00000000 00000000
> bf80: c00095e4 0000000b 00000006 bedcfaf0 00000004 c00095e4 00000000 ce58bfa8
> bfa0: c0009480 c00bb4b4 0000000b 00000006 00000006 bedcfaf0 0000000b bedcfa15
> bfc0: 0000000b 00000006 bedcfaf0 00000004 000139b0 0000b08c 0000b0c0 00014008
> bfe0: 00000000 bedcf9d4 b6ebba68 b6e4186c 60000010 00000006 00000000 00000000
> Backtrace: 
> [<c0040a08>] (wake_up_process+0x0/0x48) from [<c0209630>] (__up_write+0x158/0x164)
>  r5:cfb3a9c0 r4:ce58be10
> [<c02094d8>] (__up_write+0x0/0x164) from [<c0039fe8>] (up_write+0x10/0x14)
> [<c0039fd8>] (up_write+0x0/0x14) from [<c03578a0>] (cpufreq_set_policy+0x120/0x1cc)
> [<c0357780>] (cpufreq_set_policy+0x0/0x1cc) from [<c0358efc>] (store_scaling_governor+0xac/0x1a4)
>  r7:0000000b r6:00000000 r5:ce58be10 r4:cfb3a9c0
> [<c0358e50>] (store_scaling_governor+0x0/0x1a4) from [<c03576e8>] (store+0x88/0xa4)
>  r8:c04d6e3c r7:cfae6a80 r6:ce58bf78 r5:cfb3a9c0 r4:cfb3aa58
> [<c0357660>] (store+0x0/0xa4) from [<c011a078>] (sysfs_write_file+0x108/0x188)
>  r5:cfa12f58 r4:cfa12f40
> [<c0119f70>] (sysfs_write_file+0x0/0x188) from [<c00bb340>] (vfs_write+0xcc/0x198)
> [<c00bb274>] (vfs_write+0x0/0x198) from [<c00bb4f0>] (SyS_write+0x4c/0x78)
> [<c00bb4a4>] (SyS_write+0x0/0x78) from [<c0009480>] (ret_fast_syscall+0x0/0x2c)
>  r8:c00095e4 r7:00000004 r6:bedcfaf0 r5:00000006 r4:0000000b
> Code: e89da800 e1a0c00d e92dd830 e24cb004 (e5903000) 
> ---[ end trace a412cb5cfd5edab9 ]---
> note: cpufreq-bench[2427] exited with preempt_count 1
> 
> I did a bisect, and the problem is in the patch:
> 
> cpufreq: create per policy rwsem instead of per cpu cpu_policy_rwsem
> e4762ba2d652dbc4c496c5abdcc80702544ca1fc

Is this bug present in current linux-next?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
