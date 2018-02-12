From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] base: power: domain: Replace mdelay with msleep
Date: Mon, 12 Feb 2018 13:40:52 +0100
Message-ID: <CAPDyKFo9sjavrNP4DbTkn4yX1WeOD_5EJJEcwFkHBt+Ag8OV-A@mail.gmail.com>
References: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
 <CAPDyKFoft7aCoKtODz66AAjpDQELVhqGurFYBV6FHP9hzhy-Ug@mail.gmail.com> <1518431893.2744.1.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518431893.2744.1.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 February 2018 at 11:38, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Freitag, den 09.02.2018, 14:58 +0100 schrieb Ulf Hansson:
>> On 26 January 2018 at 09:38, Jia-Ju Bai <baijiaju1990@gmail.com>
>> wrote:
>> > After checking all possible call chains to genpd_dev_pm_detach()
>> > and
>> > genpd_dev_pm_attach() here,
>> > my tool finds that these functions are never called in atomic
>> > context,
>> > namely never in an interrupt handler or holding a spinlock.
>> > Thus mdelay can be replaced with msleep to avoid busy wait.
>> >
>> > This is found by a static analysis tool named DCNS written by
>> > myself.
>> >
>> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> > ---
>> >  drivers/base/power/domain.c |    4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/base/power/domain.c
>> > b/drivers/base/power/domain.c
>> > index 0c80bea..f84ac72 100644
>> > --- a/drivers/base/power/domain.c
>> > +++ b/drivers/base/power/domain.c
>> > @@ -2144,7 +2144,7 @@ static void genpd_dev_pm_detach(struct device
>> > *dev, bool power_off)
>> >                 if (ret != -EAGAIN)
>> >                         break;
>> >
>> > -               mdelay(i);
>> > +               msleep(i);
>>
>> This looks like a nice improvement, however moving to msleep() makes
>> the call to cond_resched() below a bit superfluous. Perhaps remove
>> that as well.
>
> At least for small values of i, msleep also has a high chance to
> overshoot the desired sleep by a lot. It would be better to convert
> them to usleep_range with an acceptable slack.

Ack!

[...]

Kind regards
Uffe
