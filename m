From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Fix typo modifcation -> modification
Date: Fri, 25 Sep 2015 23:39:49 +0200
Message-ID: <1667476.94AdzZVpPU@vostro.rjw.lan>
References: <1443122924-17017-1-git-send-email-sboyd@codeaurora.org> <CAKohpokkc-_PK1i+qVEfG4+W-jA-82T2P=w+tofWz2fYWX0NjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52440 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933215AbbIYVLf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2015 17:11:35 -0400
In-Reply-To: <CAKohpokkc-_PK1i+qVEfG4+W-jA-82T2P=w+tofWz2fYWX0NjQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thursday, September 24, 2015 01:58:21 PM Viresh Kumar wrote:
> On 24 September 2015 at 12:28, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/base/power/opp/core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> > index 8a72f0e586e8..62b918144b5b 100644
> > --- a/drivers/base/power/opp/core.c
> > +++ b/drivers/base/power/opp/core.c
> > @@ -961,7 +961,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_add);
> >   * share a common logic which is isolated here.
> >   *
> >   * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> > - * copy operation, returns 0 if no modifcation was done OR modification was
> > + * copy operation, returns 0 if no modification was done OR modification was
> >   * successful.
> >   *
> >   * Locking: The internal device_opp and opp structures are RCU protected.
> > @@ -1049,7 +1049,7 @@ unlock:
> >   * mutex locking or synchronize_rcu() blocking calls cannot be used.
> >   *
> >   * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> > - * copy operation, returns 0 if no modifcation was done OR modification was
> > + * copy operation, returns 0 if no modification was done OR modification was
> >   * successful.
> >   */
> >  int dev_pm_opp_enable(struct device *dev, unsigned long freq)
> > @@ -1075,7 +1075,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_enable);
> >   * mutex locking or synchronize_rcu() blocking calls cannot be used.
> >   *
> >   * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> > - * copy operation, returns 0 if no modifcation was done OR modification was
> > + * copy operation, returns 0 if no modification was done OR modification was
> >   * successful.
> >   */
> >  int dev_pm_opp_disable(struct device *dev, unsigned long freq)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael

