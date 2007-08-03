From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PM: Fix dependencies of CONFIG_SUSPEND and
 CONFIG_HIBERNATION
Date: Fri, 3 Aug 2007 15:01:44 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708031459090.8184__6365.29788976095$1186182412$gmane$org@woody.linux-foundation.org>
References: <200708032359.37677.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708032359.37677.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Fri, 3 Aug 2007, Rafael J. Wysocki wrote:
>  	depends on PM
> -	depends on !SMP || SUSPEND_SMP_POSSIBLE
> +	depends on SUSPEND_SMP_POSSIBLE || ((BLACKFIN || MIPS || SUPERH || FRV \
> +		    || (PPC32 && PPC_MPC52xx)) && !SMP)

Please, do that as SUSPEND_UP_POSSIBLE, and make it look like

	config SUSPEND_UP_POSSIBLE
		depends on BLACKFIN || MIPS || SUPERH || FRV || ((PPC32 && PPC_MPC52xx)
		depends on !SMP
		default y

and now you can write the above thing as

	depends on SUSPEND_SMP_POSSIBLE || SUSPEND_UP_POSSIBLE

and it's all much nicer.

I would say that doing a similar setup for HIBERNATE would be nice too, 
but the SUSPEND case is more noticeable because the SMP case is so nice 
already.

		Linus
