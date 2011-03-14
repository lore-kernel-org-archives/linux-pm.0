From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 10/10] ARM: Use struct syscore_ops instead of
 sysdevs for PM in timer and leds
Date: Mon, 14 Mar 2011 02:06:36 -0700
Message-ID: <4D7DDA9C.9020700__8733.95069870657$1300114256$gmane$org@codeaurora.org>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl>
	<201103131402.48129.rjw@sisk.pl> <201103131404.33311.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103131404.33311.rjw@sisk.pl>
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
Cc: Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 3/13/2011 6:04 AM, Rafael J. Wysocki wrote:
>   #if defined(CONFIG_PM)&&  !defined(CONFIG_GENERIC_CLOCKEVENTS)
> -static int timer_suspend(struct sys_device *dev, pm_message_t state)
> +static int timer_suspend(void)
>   {
> -	struct sys_timer *timer = container_of(dev, struct sys_timer, dev);
> -
> -	if (timer->suspend != NULL)
> +	if (system_timer->suspend)
>   		timer->suspend();
>

Shouldn't this be system_timer->suspend() ?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
