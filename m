From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: Make NUMA on 32-bit depend on
	EXPERIMENTAL again
Date: Wed, 12 Nov 2008 23:29:45 +0100
Message-ID: <20081112222945.GB13844__46757.3622162037$1226529276$gmane$org@elte.hu>
References: <20081109140726.GB1786@ucw.cz> <200811122257.50998.rjw@sisk.pl>
	<200811122322.36781.rjw@sisk.pl> <200811122326.16107.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200811122326.16107.rjw@sisk.pl>
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
> Subject: x86: Make NUMA on 32-bit depend on EXPERIMENTAL again
> 
> My previous patch to make CONFIG_NUMA on x86_32 depend on BROKEN
> turned out to be unnecessary, after all, since the source of the
> hibernation vs CONFIG_NUMA problem turned out to be the fact that
> we didn't take the NUMA KVA remapping into account in the
> hibernation code.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pavel Machek <pavel@suse.cz>
> Cc: Andi Kleen <andi@firstfloor.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to tip/x86/numa, thanks Rafael!

	Ingo
