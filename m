From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH 1/2] orinoco: Use PM notifier to cache
	firmware for use during resume
Date: Fri, 31 Oct 2008 22:27:38 +0100
Message-ID: <200810312227.39057.rjw__47651.9252792515$1225488523$gmane$org@sisk.pl>
References: <1225415743-28209-1-git-send-email-kilroyd@googlemail.com>
	<1225415743-28209-2-git-send-email-kilroyd@googlemail.com>
	<200810312037.00936.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810312037.00936.arvidjaar@mail.ru>
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
To: linux-pm@lists.linux-foundation.org
Cc: orinoco-devel@lists.sourceforge.net, David Kilroy <kilroyd@googlemail.com>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-wireless@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, 31 of October 2008, Andrey Borzenkov wrote:
> On Friday 31 October 2008, David Kilroy wrote:
> > When preparing for either suspend or hibernation, load the necessary
> > firmware from userspace.
> > 
> > Upon error or resume, release the firmware.
> > 
> > Works for both Agere and Symbol firmware.
> > 
> > Signed-off by: David Kilroy <kilroyd@gmail.com>
> 
> This is on top of my old patch; was it ever accepted anywhere? I guess
> it should be rediffed against clean tree.
> 
> > @@ -621,7 +620,7 @@ symbol_dl_image(struct orinoco_private *priv, const struct fw_info *fw,
> >  	ret = hermes_init(hw);
> >  
> >  	/* hermes_reset() should return 0 with the secondary firmware */
> > -	if (secondary && ret != 0)
> > +	if (secondary && (ret != 0))
> 
> Extra parenthesis are redundant, are not they?
> 
> >  /********************************************************************/
> > +/* Power management                                                 */
> > +/********************************************************************/
> > +
> > +static int orinoco_pm_notifier(struct notifier_block *notifier,
> > +			       unsigned long pm_event,
> > +			       void *unused)
> 
> It probably should be conditional on CONFIG_PM somehow? 

CONFIG_PM_SLEEP, actually.

Thanks,
Rafael
