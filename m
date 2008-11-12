From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: Hibernate: Fix breakage on x86_32
	with	CONFIG_NUMA set (was: Re: CONFIG_NUMA breaks hibernation
	on x86-32	with PAE)
Date: Wed, 12 Nov 2008 23:29:27 +0100
Message-ID: <20081112222927.GA13844__4190.78937634385$1226529195$gmane$org@elte.hu>
References: <20081109140726.GB1786@ucw.cz> <20081112104951.GB11945@ucw.cz>
	<200811122257.50998.rjw@sisk.pl> <200811122322.36781.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200811122322.36781.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: x86: Hibernate: Fix breakage on x86_32 with CONFIG_NUMA set
> 
> The NUMA code on x86_32 creates special memory mapping that allows
> each node's pgdat to be located in this node's memory.  For this
> purpose it allocates a memory area at the end of each node's memory
> and maps this area so that it is accessible with virtual addresses
> belonging to low memory.  As a result, if there is high memory,
> these NUMA-allocated areas are physically located in high memory,
> although they are mapped to low memory addresses.
> 
> Our hibernation code does not take that into account and for this
> reason hibernation fails on all x86_32 systems with CONFIG_NUMA=y and
> with high memory present.  Fix this by adding a special mapping for
> the NUMA-allocated memory areas to the temporary page tables created
> during the last phase of resume.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pavel Machek <pavel@suse.cz>
> Cc: Andi Kleen <andi@firstfloor.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/include/asm/mmzone_32.h |    4 ++++
>  arch/x86/mm/numa_32.c            |   35 +++++++++++++++++++++++++++++++++++
>  arch/x86/power/hibernate_32.c    |    4 ++++
>  3 files changed, 43 insertions(+)

Applied to tip/x86/numa, thanks Rafael for the detective work!

	Ingo
