From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: (fwd) empty /sys/power/state?
Date: Sun, 20 May 2007 01:49:54 +0200
Message-ID: <464F8D22.7070501@s5r6.in-berlin.de>
References: <Pine.LNX.4.44L0.0705191714070.32062-100000@netrider.rowland.org>
	<200705200053.58388.rjw@sisk.pl>
	<464F8395.4080300@s5r6.in-berlin.de>
	<200705200120.45892.rjw@sisk.pl>
	<tkrat.64219d323de1c016@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <tkrat.64219d323de1c016@s5r6.in-berlin.de>
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

I wrote:
> --- linux.orig/arch/i386/Kconfig
> +++ linux/arch/i386/Kconfig
> @@ -891,7 +891,7 @@ config PHYSICAL_ALIGN
>  	  Don't change this unless you know what you are doing.
>  
>  config HOTPLUG_CPU
> -	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
> +	bool "Support for suspend on SMP hot-pluggable CPUs (EXPERIMENTAL)"
                                        ^
                                        insert "and" here
-- 
Stefan Richter
-=====-=-=== -=-= =-=--
http://arcgraph.de/sr/
