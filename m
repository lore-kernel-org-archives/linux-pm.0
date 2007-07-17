From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec
	base	hibernation
Date: Tue, 17 Jul 2007 20:48:38 +0800
Message-ID: <1184676518.10998.34.camel__6034.65177487141$1184676692$gmane$org@caritas-dev.intel.com>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707141159.47289.rjw@sisk.pl>
	<1184410554.1898.84.camel@caritas-dev.intel.com>
	<200707142116.10237.rjw@sisk.pl>
	<1184491804.1898.121.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707170101010.19248@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707170101010.19248@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-07-17 at 01:13 -0700, david@lang.hm wrote:
> however, since the resume designed for ACPI won't work would the following 
> approach work
> 
> 1. boot one kernel
> 2. setup a kexec the same way you would for hibernate
> 3. kexec to the new kernel
> 4. overwrite the memory of the first kernel
> 5. kexec 'back' to the main kernel that has now been overwritten by what was saved?
> 
> as part of this question, when you do a kexec, how does the kernel that 
> you are doing the kexec to know what to run next?

For kernel in 3 that do kexec, the devices and CPU state are saved into
memory before executing the new kernel. So when jumping back, the
control will continue from kexec point. If the memory image of main
kernel is restored from disk, the devices and CPU state in memory is
restored too. Before jumping back in 5, the devices are put in the known
state, after jumping back, the devices and CPU state is restored. If the
"kexec -j" is used to trigger the kexec in 3, the system will continue
with "kexec -j" exiting with exit code 0.

> it needs to do some initialization first before it starts running normal 
> things, and at that point it the move back doesn't look for init like a 
> normal kernel boot (or the system would effectivly boot instead of picking 
> up where it left off)

I think the early initialization can be done in a initramfs. At that
point, the resume image can be checked, the next step depends on the
result of checking.

> is this 'restart point' flexible enough that either the pre-hibernate 
> kerenl or the small hibernate kernel could tell the pre-hibernate kernel 
> to go into suspend-to-ram mode before doing anything else?

It is possible for hibernate kernel to pass information back to
pre-hibernate kernel. For example, the information can be passed in jump
buffer page. 

Best Regards,
Huang Ying
