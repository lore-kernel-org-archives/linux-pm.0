From: Ingo Molnar <mingo@elte.hu>
Subject: Re: x86: Change static allocation of trampoline area
Date: Mon, 8 Dec 2008 13:50:58 +0100
Message-ID: <20081208125057.GC16560__30716.1449957222$1228740826$gmane$org@elte.hu>
References: <200812080050.23275.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200812080050.23275.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: x86: Change static allocation of trampoline area
> Impact: Improvement
> 
> While debugging a suspend-to-RAM related issue it occured to me that
> if the trampoline code had grown past 4 KB, we would have been
> allocating too little memory for it, since the 4 KB size of the
> trampoline is hardcoded into arch/x86/kernel/e820.c .  Change that
> by making the kernel compute the trampoline size and allocate as much
> memory as necessary.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/x86/include/asm/trampoline.h |    7 +++++++
>  arch/x86/kernel/e820.c            |   16 ----------------
>  arch/x86/kernel/head32.c          |    3 +++
>  arch/x86/kernel/head64.c          |    3 +++
>  arch/x86/kernel/trampoline.c      |   19 +++++++++++++++++--
>  5 files changed, 30 insertions(+), 18 deletions(-)

applied to tip/x86/setup-memory, thanks Rafael!

	Ingo
