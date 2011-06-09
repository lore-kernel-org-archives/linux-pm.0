From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v4] ARM hibernation/suspend-to-disk
	support
Date: Thu, 9 Jun 2011 17:50:29 +0100
Message-ID: <20110609165029.GC24424__30688.8065570549$1307638547$gmane$org@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
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

On Tue, Jun 07, 2011 at 05:48:17PM +0100, Frank Hofmann wrote:
> There are a few dependencies this patch brings in:
>
> * due to the use of cpu_suspend / cpu_resume, it'll only apply as-is
>   to kernels no older than f6b0fa02e8b0708d17d631afce456524eadf87ff,
>   where Russell King introduced the generic interface.
>   Patching these into older kernels is a little work.
>
> * it temporarily uses swapper_pg_dir and establishes 1:1 mappings there
>   for a MMU-off transition, which is necessary before resume.
>   In order to tear these down afterwards, identity_mapping_del() needs
>   to be called; for some reason that's #ifdef CONFIG_SMP ...
>
> * it needs to "catch" sleep_save_sp after cpu_suspend() so that resume
>   can be provided with the proper starting point.
>   This requires an ENTRY(sleep_save_sp) in arch/arm/kernel/sleep.S so
>   that the symbol becomes public.
>
> * it assumes cpu_reset will disable the MMU. cpu_v6_reset/cpu_v7_reset
>   are currently not doing so (amongst some other minor chip types).
>
> * there's kind of a circular dependency between CONFIG_HIBERNATION and
>   CONFIG_PM_SLEEP, on ARM. The latter is necessary so that cpu_suspend
>   and cpu_resume are compiled in, but it cannot be selected via
>   ARCH_HIBERNATION_POSSIBLE because CONFIG_PM_SLEEP depends on
>   CONFIG_HIBERNATION_INTERFACE - selected by CONFIG_HIBERNATION.

Another issue is that it uses PHYS_OFFSET in assembly code which is not
permissible with P2V patching.
