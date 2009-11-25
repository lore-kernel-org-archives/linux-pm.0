From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Fix kernel-doc notation
Date: Wed, 25 Nov 2009 01:18:46 +0100
Message-ID: <200911250118.47015.rjw__45544.3018851385$1259108661$gmane$org@sisk.pl>
References: <1258877637.4495.45.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1258877637.4495.45.camel@ht.satnam>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 22 November 2009, Jaswinder Singh Rajput wrote:
> 
> Fix the following htmldocs warnings:
> 
>   Warning(drivers/base/power/main.c:249): No description found for parameter 'master'
>   Warning(drivers/base/power/main.c:249): Excess function parameter 'slave' description in 'device_pm_wait_for_slaves'
>   Warning(drivers/base/power/main.c:292): No description found for parameter 'master'
>   Warning(drivers/base/power/main.c:292): Excess function parameter 'slave' description in 'device_pm_check_slaves'
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Randy Dunlap <randy.dunlap@oracle.com>

Applied to suspend-2.6/linux-next.

Thanks,
Rafael
