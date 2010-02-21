From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] PM: Add arch_suspend_disable_nonboot_cpus
Date: Sun, 21 Feb 2010 16:22:20 -0600
Message-ID: <4B81B21C.2010108@linux.vnet.ibm.com>
References: <201002211631.o1LGVsw8022630@d01av02.pok.ibm.com>
	<20100221191821.GA2198@ucw.cz>
	<4B81AD25.5010204@linux.vnet.ibm.com>
	<201002212308.52023.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002212308.52023.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 02/21/2010 04:08 PM, Rafael J. Wysocki wrote:
> I'm not a big fan of __attribute__ ((weak)), though.  While we already use that
> in the suspend code, I'm not particularly comfortable with it.
> 
> Have you considered any alternative approaches?

I suppose another option would be to implement this similar to how
arch_free_page and arch_alloc_page do. Something like this:

#ifndef CONFIG_HAVE_ARCH_SUSPEND_CPUS
static inline int arch_suspend_disable_nonboot_cpus(void)
{
	return disable_nonboot_cpus();
}

static inline void arch_suspend_enable_nonboot_cpus(void)
{
	return enable_nonboot_cpus()'
}
#else
extern int arch_suspend_disable_nonboot_cpus(void);
extern void arch_suspend_enable_nonboot_cpus(void);
#endif

I figured I would just be consistent with arch_suspend_disable_irqs /
arch_suspend_enable_irqs.

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
