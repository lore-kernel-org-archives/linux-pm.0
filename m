From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Add convenience macro to make switching
	to dev_pm_ops less error-prone
Date: Thu, 6 Aug 2009 14:16:08 +0200
Message-ID: <200908061416.08564.rjw__34959.7137574621$1249561142$gmane$org@sisk.pl>
References: <20090803163304.GF5002@laptop> <200908052330.08452.rjw@sisk.pl>
	<20090806085144.GS13236@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090806085144.GS13236@buzzloop.caiaq.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Frans Pop <elendil@planet.nl>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, pHilipp Zabel <philipp.zabel@gmail.com>, linux-pm@lists.linux-foundation.org, albin.tonnerre@free-electrons.com
List-Id: linux-pm@vger.kernel.org

On Thursday 06 August 2009, Daniel Mack wrote:
> On Wed, Aug 05, 2009 at 11:30:07PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday 05 August 2009, Frans Pop wrote:
> > > Rafael J. Wysocki wrote:
> > > 
> > > > +#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> > > > +struct dev_pm_ops name = { \
> > > > +       .suspend = suspend_fn, \
> > > > +       .resume = resume_fn, \
> > > > +       .freeze = suspend_fn, \
> > > > +       .thaw = resume_fn, \
> > > > +       .poweroff = suspend_fn, \
> > > > +       .resume = resume_fn, \
> > > 
> > > That defines .resume twice. Guess the last should be restore.
> > 
> > Yes, thanks to you and Philipp for noticing that and sorry for the mistake.
> 
> When is a good point to resend patches that use this macro? I guess they
> won't make it to .31 anyway, right? So I just wait for the next merge
> window?

Yes, I think that would be the right thing to do.

Best,
Rafael
