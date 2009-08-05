From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] ds2760: switch to new dev_pm_ops
Date: Wed, 5 Aug 2009 17:41:57 +0200
Message-ID: <200908051741.58698.rjw__31924.3806334727$1249488152$gmane$org@sisk.pl>
References: <1249476387-27325-1-git-send-email-daniel@caiaq.de>
	<200908051657.49810.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908051657.49810.elendil@planet.nl>
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
To: Frans Pop <elendil@planet.nl>, Daniel Mack <daniel@caiaq.de>
Cc: mreimer@vpop.net, pm list <linux-pm@lists.linux-foundation.org>, szabolcs.gyurko@tlt.hu, linux-kernel@vger.kernel.org, cbou@mail.ru
List-Id: linux-pm@vger.kernel.org

On Wednesday 05 August 2009, Frans Pop wrote:
> Daniel Mack wrote:
> > +static struct dev_pm_ops ds2760_battery_pm_ops = {
> > +       .suspend        = ds2760_battery_suspend,
> > +       .resume         = ds2760_battery_resume,
> > +};
> 
> Just to make sure...
> 
> Have you followed the earlier discussions on dev_pm_ops conversions and 
> are you aware that if done like this the driver no longer supports 
> hibernation?
> 
> If omitting hibernation is intentional, it should probably be justified in 
> the commit log.
> 
> See http://lkml.org/lkml/2009/7/25/118 for background.
> 
> Same goes for your patch for w1_gpio of course.

Frans, thanks for your vigilance. :-)

Daniel and everyone doing dev_pm_ops conversions or any other PM-related
things, please CC your patches to linux-pm@lists.linux-foundation.org .

Best,
Rafael
