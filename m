From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/7] drivers/cpufreq: change CONFIG_6xx to CONFIG_PPC_BOOK3S_32
Date: Sat,  8 Dec 2018 00:07:10 +1100 (AEDT)
Message-ID: <43BCRg312Mz9s55@ozlabs.org>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2018-11-17 at 10:24:54 UTC, Christophe Leroy wrote:
> Today, powerpc has three CONFIG labels which means exactly the same:
> - CONFIG_6xx
> - CONFIG_PPC_BOOK3S_32
> - CONFIG_PPC_STD_MMU_32
> 
> By consistency with PPC64, CONFIG_PPC_BOOK3S_32 is the preferred one.
> Using a label with includes _PPC_ also makes it clearer that it is
> linked to powerpc.
> 
> In preparation of the removal of CONFIG_6xx, this patch replaces it
> by CONFIG_PPC_BOOK3S_32
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f99e33f12490d03e34e1b9cb1b3e3a

cheers
