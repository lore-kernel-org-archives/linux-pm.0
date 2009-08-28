From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] rtc: Set wakeup capability for I2C and SPI
	RTC drivers
Date: Fri, 28 Aug 2009 04:30:10 +0400
Message-ID: <20090828003010.GA19160__9436.24731521613$1251419495$gmane$org@oksana.dev.rtsoft.ru>
References: <20090827182207.GA7358@oksana.dev.rtsoft.ru>
	<200908271452.37358.david-b@pacbell.net>
	<20090827231925.GA1131@oksana.dev.rtsoft.ru>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090827231925.GA1131@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 28, 2009 at 03:19:25AM +0400, Anton Vorontsov wrote:
[...]
> > That is why platform code should device_init_wakeup() and
> > drivers should check device_can_wakeup(dev) ...
> 
> They should (and do) check may_wakeup() (i.e. should_wakeup) before
> suspending, not can_wakeup().
> 
> static int ds1374_suspend(struct i2c_client *client, pm_message_t state)
> {
>         if (client->irq >= 0 && device_may_wakeup(&client->dev))
>                 enable_irq_wake(client->irq);
>         return 0;
> }
> 
> (quite funny, they issue enable_irq_wake(), assuming that otherwise
> IRQ line won't trigger CPU wakeup. But in reality, there are interrupt
> controllers that you can't control in that regard: any IRQ activity
> will always resume CPU. And so 'echo disable > /sys/.../wakeup' won't
> guarantee anything. Unreliable, nasty? Could be.)

BTW, of course we can fix this by masking interrupts before
suspending, but nobody actually do this (but should, I think).

And if RTC's IRQ is wired to power switch you're in trouble
without any way to fix this.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
