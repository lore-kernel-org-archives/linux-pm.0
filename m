From: David Brownell <david-b@pacbell.net>
Subject: Re: sleepy linux self-test
Date: Thu, 31 Jan 2008 17:55:33 -0800
Message-ID: <200801311755.33899.david-b__23167.8281016231$1201831098$gmane$org@pacbell.net>
References: <20080130131748.GA3796@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080130131748.GA3796@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 30 January 2008, Pavel Machek wrote:

> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -78,7 +78,7 @@ static inline int is_intr(u8 rtc_intr)
>  
>  /*----------------------------------------------------------------*/
>  
> -static int cmos_read_time(struct device *dev, struct rtc_time *t)
> +int cmos_read_time(struct device *dev, struct rtc_time *t)
>  {
>
>	... etc ...

You should be using the standard RTC library calls, exported
from drivers/rtc/interface.c ... and making sure this mechanism
will work with any wakeup-capable RTC.  Otherwise you'll end
being needlessly x86-specific, or reinventing those calls.

Plus, the way you're doing it now is violating the locking
protocol used by that driver.

- Dave
