From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 05/38] s390: hibernation support for s390
Date: Mon, 8 Jun 2009 08:44:51 +0200
Message-ID: <20090608064451.GD1444__37749.0088147626$1244475234$gmane$org@ucw.cz>
References: <20090604161847.513682672@de.ibm.com>
	<20090604161900.659762303@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090604161900.659762303@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Hans-Joachim Picht <hans@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Thu 2009-06-04 18:18:52, Martin Schwidefsky wrote:
> From: Hans-Joachim Picht <hans@linux.vnet.ibm.com>
> 
> This patch introduces the hibernation backend support to the 
> s390 architecture. Now it is possible to suspend a mainframe Linux 
> guest using the following command:
> 
> echo disk > /sys/power/state

Should this one be last in series?

Otherwise no obvious problems...


> Index: linux-2.6/arch/s390/power/swsusp.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/arch/s390/power/swsusp.c
> @@ -0,0 +1,31 @@
> +/*
> + * Support for suspend and resume on s390
> + *
> + * Copyright IBM Corp. 2009
> + *
> + * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
> + *
> + */
> +
> +#include <linux/suspend.h>
> +#include <linux/gfp.h>
> +#include <linux/cpu.h>
> +#include <linux/smp.h>
> +#include <linux/cpumask.h>
> +#include <asm/ipl.h>
> +#include <asm/processor.h>

Empty functions do not need 1000 includes...

> +/*
> + * save CPU registers before creating a hibernation image and before
> + * restoring the memory state from it
> + */
> +void save_processor_state(void)
> +{
> +}
> +
> +/*
> + * restore the contents of CPU registers
> + */
> +void restore_processor_state(void)
> +{
> +}

...and explaining why the functions can be emmpty would be nice.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
