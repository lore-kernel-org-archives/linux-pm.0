From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/5] w1_gpio: switch to new dev_pm_ops
Date: Wed, 5 Aug 2009 20:45:00 +0200
Message-ID: <20090805184500.GO13236__17183.2821718001$1249507286$gmane$org@buzzloop.caiaq.de>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<200908052044.02103.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908052044.02103.rjw@sisk.pl>
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
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ville Syrjala <syrjala@sci.fi>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 05, 2009 at 08:44:01PM +0200, Rafael J. Wysocki wrote:
> > +static struct dev_pm_ops w1_gpio_pm_ops = {
> > +	.suspend	= w1_gpio_suspend,
> > +	.freeze		= w1_gpio_suspend,
> > +	.resume		= w1_gpio_resume,
> > +	.thaw		= w1_gpio_resume,
> 
> You need
> 
> +	.poweroff	= w1_gpio_suspend,
> +	.restore		= w1_gpio_resume,
> 
> in addition to these, which seems to be the case with the rest of the patches
> too.
> 
> If you wait for a little while with the patchset, we're going to have a
> convenience macro for defining such 'standard' dev_pm_ops objects.

Ok, fine. Letting them all point the same function looks somwhat hackish
to me, so I'll wait for that macro. Let me know when that has arrived :)

Daniel
