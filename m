From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Add convenience macro to make switching
	to dev_pm_ops less error-prone
Date: Wed, 5 Aug 2009 23:30:07 +0200
Message-ID: <200908052330.08452.rjw__45557.8841305853$1249507916$gmane$org@sisk.pl>
References: <20090803163304.GF5002@laptop> <200908052205.14222.rjw@sisk.pl>
	<200908052222.31707.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908052222.31707.elendil@planet.nl>
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
To: Frans Pop <elendil@planet.nl>, pHilipp Zabel <philipp.zabel@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, albin.tonnerre@free-electrons.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, daniel@caiaq.de
List-Id: linux-pm@vger.kernel.org

On Wednesday 05 August 2009, Frans Pop wrote:
> Rafael J. Wysocki wrote:
> 
> > +#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> > +struct dev_pm_ops name = { \
> > +       .suspend = suspend_fn, \
> > +       .resume = resume_fn, \
> > +       .freeze = suspend_fn, \
> > +       .thaw = resume_fn, \
> > +       .poweroff = suspend_fn, \
> > +       .resume = resume_fn, \
> 
> That defines .resume twice. Guess the last should be restore.

Yes, thanks to you and Philipp for noticing that and sorry for the mistake.

Rafael
