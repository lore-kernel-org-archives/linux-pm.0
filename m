From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv2 00/17] cpuidle for Marvell Armada 370 and 38x
Date: Wed, 16 Jul 2014 14:59:05 +0200
Message-ID: <20140716145905.33105756@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20140713222223.GH13108@titan.lakedaemon.net>
	<20140716124522.GV13108@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34539 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932770AbaGPM7J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 08:59:09 -0400
In-Reply-To: <20140716124522.GV13108@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Dear Jason Cooper,

On Wed, 16 Jul 2014 08:45:22 -0400, Jason Cooper wrote:

> Ok, so I applied patch #10 to mvebu/dt, and #17 to mvebu/defconfig.  I
> was then going to apply the rest into a tentative topic branch
> (mvebu/soc-cpuidle), but it failed when based on v3.16-rc1, and it
> failed when based on mvebu/soc.
> 
> Could you please outline the deps so I can get this into -next?  We're
> really cutting the deadline close for v3.17, and I'd like to already
> have some time in -next if/when cpuidle Ack's it going through the mvebu
> tree.

As explained in the cover letter:

 * Series rebased on top of mvebu/fixes + mvebu/soc to take into
   account the conflicts with the changes already merged on the PMSU
   code.

Just in case, here is the full set of commits, all the way up to
3.16-rc1 :

c68a8e41037c1443f44bacd2de243ce761567987 ARM: mvebu: defconfig: enable cpuidle support in mvebu_v7_defconfig
31106f504f2bddcb214a7b03ed51341066391fba ARM: mvebu: add cpuidle support for Armada 38x
984a9d0e32b022a90153d75232278d11d43382c0 ARM: mvebu: add cpuidle support for Armada 370
246ba1f5237f9a85fdc340200e6a28648327ed74 cpuidle: mvebu: add Armada 38x support
57e1ed20dfed486f62719ef90f3bde561430288e cpuidle: mvebu: add Armada 370 support
958bba0fd9db8a79ed79630b9d3f25d8a6c91bdb cpuidle: mvebu: make the cpuidle driver capable of handling multiple SoCs
bc1adfdeb4e15cdd4ab0e357ed07653a12abdcbb cpuidle: mvebu: rename the driver from armada-370-xp to mvebu-v7
314891239e2b9887aa88c0501e005aa9ff18e6f4 ARM: mvebu: add CA9 MPcore SoC Controller node
2c312d84db29fc41536961c5274e96e489549308 ARM: mvebu: export the SCU address
48275e4a6675aefeac4c00250e29cedc18a81c44 ARM: mvebu: make the snoop disabling optional in mvebu_v7_pmsu_idle_prepare()
2e0f02b91d081e32e35cf2c2717cd29ba4de0e35 ARM: mvebu: use a local variable to store the resume address
cac78ba4a7b246fcd3ac063916cb492d8e3309a6 ARM: mvebu: make the cpuidle initialization more generic
c5a3b4f51e6224f36f7b240e14703c96b10d1c68 ARM: mvebu: rename the armada_370_xp symbols to mvebu_v7 in pmsu.c
dcb1c2b686b389a119c8cbbc152378c61ea9e06b ARM: mvebu: use the common function for Armada 375 SMP workaround
4f445c9139ab99cf14cd776a4d2775f803766944 ARM: mvebu: add a common function for the boot address work around
1eab99ad7ef255dfb771f10b4224003679d98e6c ARM: mvebu: sort the #include of pmsu.c in alphabetic order
82a3df50272fed534250dad2b78f08d3c3e5c884 ARM: mvebu: split again armada_370_xp_pmsu_idle_enter() in PMSU code
e08b644d947512adf34140c26a32e55af2fe79ea Merge remote-tracking branch 'mvebu/mvebu/soc' into 3.16/cpuidle-v2-base
0d461e1b087048b0cc37c9d7b351649578c507b4 ARM: mvebu: Fix the operand list in the inline asm of armada_370_xp_pmsu_idle_enter
0e2be4c1121ae3dc2771c4d9b99d4c39ea9577d8 ARM: mvebu: fix SMP boot for Armada 38x and Armada 375 Z1 in big endian
6509dc74c9f55ffaa558738b96c4da8b98d39571 ARM: mvebu: fix cpuidle implementation to work on big-endian systems
e65714740d65237c40878b63acad6bf921481974 ARM: mvebu: Staticize mvebu_cpu_reset_init
6fc770f28d10809474ec3fafb162ba76ac435cd4 ARM: mvebu: Staticize armada_370_xp_cpu_pm_init
1440fbd271127c283790063f735afd75f832751d ARM: mvebu: Staticize armada_375_smp_cpu1_enable_wa
9674d4a3cf4307dda468a0b48e5e43a2fdb56b68 ARM: mvebu: Use system controller to get the soc id when possible
5e80d81acc420fa33b56078f73f38546ab99be6f ARM: mvebu: Use the a standard errno in mvebu_get_soc_id
011788907ba955f87875fcfb4914881b28f7f99d ARM: mvebu: update L2/PCIe deadlock workaround after L2CC cleanup
752ef800a604c0b855077ec480dc9c6ea5b797ee ARM: mvebu: move Armada 375 external abort logic as a quirk
8dbdb8e704db34085f5978c335c10256b0fb9629 ARM: mvebu: Fix the improper use of the compatible string armada38x using a wildcard
b514fb28ead93332a1660d3ce81def9eb74ed640 ARM: dts: kirkwood: fix phy-connection-type for Guruplug
9d6373485c0c3b38de666d8e0af95ee7c692ecbe ARM: mvebu: Don't apply the thermal quirk if the SoC revision is unknown
a178050a0e4030fe1b7b4ca76c5d41278b48d792 Documentation: arm: add URLs to public datasheets for the Marvell Armada 370 SoC
26337779465637b761624d9752f52d1ec88f71d9 ARM: mvebu: implement CPU hotplug support for Armada XP
8ea875e72d2dd66eea393f22c6bf4707f92f4a50 ARM: mvebu: export PMSU idle enter/exit functions
bbb92284b6c821e9434223d437fbd10b8a24c294 ARM: mvebu: slightly refactor/rename PMSU idle related functions
3169455448ea6d021b1b761b4fd241810de8c335 ARM: mvebu: remove stub implementation of CPU hotplug on Armada 375/38x
55fc83023212f940927b9a44e31ad93d7e67d27d ARM: Kirkwood: Add setup file for netxbig LEDs
adb1d99384c7480886153a97d2ea22e9c0d2e053 ARM: mvebu: mark armada_370_xp_pmsu_idle_prepare() as static
52fcc56753de91ae337aeaa0a664f72d93f19827 ARM: mvebu: select ARM_CPU_SUSPEND for Marvell EBU v7 platforms
ed2d859119f9cb04410d94b5fbd2bb12907c8932 ARM: mvebu: Fix broken SoC ID detection
7171511eaec5bf23fb06078f59784a3a0626b38f Linux 3.16-rc1

Does this helps?

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
