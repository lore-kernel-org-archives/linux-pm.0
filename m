From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec
	base	hibernation
Date: Tue, 17 Jul 2007 01:13:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707170101010.19248__8977.95545538447$1184660611$gmane$org@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707141159.47289.rjw@sisk.pl>
	<1184410554.1898.84.camel@caritas-dev.intel.com>
	<200707142116.10237.rjw@sisk.pl>
	<1184491804.1898.121.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1184491804.1898.121.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Ying, as the kexec guru in this thread I have a question for you about how 
kexec works (and possibly where you are going with this)

for the power-off hibernate with ACPI disabled the hibernation seems 
fairly straightforward (although there are still some missing pieces)

however, since the resume designed for ACPI won't work would the following 
approach work

1. boot one kernel
2. setup a kexec the same way you would for hibernate
3. kexec to the new kernel
4. overwrite the memory of the first kernel
5. kexec 'back' to the main kernel that has now been overwritten by what was saved?

as part of this question, when you do a kexec, how does the kernel that 
you are doing the kexec to know what to run next?

it needs to do some initialization first before it starts running normal 
things, and at that point it the move back doesn't look for init like a 
normal kernel boot (or the system would effectivly boot instead of picking 
up where it left off)

is this 'restart point' flexible enough that either the pre-hibernate 
kerenl or the small hibernate kernel could tell the pre-hibernate kernel 
to go into suspend-to-ram mode before doing anything else?

Rafael,
   if ACPI is disabled and not used, is there any memory in the origional 
kernel that _must not_ be saved in the hibernate image? I recognise that 
for efficancy it would save time to not save free memory, but if I'm 
willing to waste some resources would it hurt to save everything?

David Lang
