From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [linux-pm] PowerOP 1/3: PowerOP core
Date: Tue, 09 Aug 2005 09:07:33 -0700
Message-ID: <42F8D4C5.2090800@am.sony.com>
References: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@lists.linux.org.uk>
In-Reply-To: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@lists.linux.org.uk
To: Todd Poynor <tpoynor@mvista.com>
Cc: cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Todd Poynor wrote:
...
> ===================================================================
> --- linux-2.6.12.orig/include/linux/powerop.h	1970-01-01
> 00:00:00.000000000 +0000
> +++ linux-2.6.12/include/linux/powerop.h	2005-08-03
> 01:10:55.000000000 +0000
> @@ -0,0 +1,36 @@
> +/*
> + * PowerOP core definitions
> + *
> + * Author: Todd Poynor <tpoynor@mvista.com>
> + *
> + * 2005 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether
> express
> + * or implied.
> + */
> +
> +#ifndef __POWEROP_H__
> +#define __POWEROP_H__
> +
> +#include <linux/kobject.h>
> +#include <asm/powerop.h>
> +
> +struct powerop_point {
> +	int param[POWEROP_DRIVER_MAX_PARAMS];
> +};

I'm wondering if anything could be gained by having the whole 
struct powerop_point defined in asm/powerop.h, and treat it as an 
opaque structure at this level.  That way, things other than just 
ints could be passed between the policy manager and the backend, 
although I guess that breaks the beauty of the simplicity and would 
complicate the sys-fs interface, etc.  I'm interested to hear your 
comments.

Another point is that a policy manager would need to poll the system 
and/or get events and then act.  Your powerop work here only provides 
a (one way) piece of the final action.  Any comments regarding a more 
general interface?

-Geoff
