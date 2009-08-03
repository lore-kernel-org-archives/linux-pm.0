From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
Date: Mon, 3 Aug 2009 21:23:16 +0200
Message-ID: <200908032123.17069.rjw__46695.9944148131$1249327440$gmane$org@sisk.pl>
References: <20090803163304.GF5002@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090803163304.GF5002@laptop>
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
To: Albin Tonnerre <albin.tonnerre@free-electrons.com>
Cc: Frans Pop <elendil@planet.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 03 August 2009, Albin Tonnerre wrote:
> On Sat, Jul 25, 2009, Frans Pop wrote:
> > Yes, I see that in drivers/base/platform.c (legacy) .suspend resp. .resume
> > also got called for those cases?
> > Ouch :-(
> 
> This really looks like it's error-prone (I made this mistake for atmel_serial
> and wouldn't have noticed if Frans hadn't told me), and AFAICS, for a number of
> drivers we'll have suspend = freeze = poweroff and resume = thaw = restore.
> Maybe putting something like this in pm.h would help ?
> 
> #define PM_OPS(name, suspend, resume) \
> struct dev_pm_ops name = { \
> 	.suspend = suspend, \
> 	.resume = resume, \
> 	.freeze = suspend, \
> 	.thaw = resume, \
> 	.poweroff = suspend, \
> 	.restore = resume, \
> };

That looks like a good idea, but please call that macro SIMPLE_PM_OPS (or
something similar) and submit a patch.

Best,
Rafael
