From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: calling runtime PM from system PM methods
Date: Mon, 13 Jun 2011 13:22:22 +0100
Message-ID: <20110613122221.GA19552__16616.55463181$1311769260$gmane$org@opensource.wolfsonmicro.com>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com>
	<201106102227.25391.rjw@sisk.pl>
	<20110611114239.GC2738@opensource.wolfsonmicro.com>
	<201106112256.37012.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201106112256.37012.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 11, 2011 at 10:56:36PM +0200, Rafael J. Wysocki wrote:
> On Saturday, June 11, 2011, Mark Brown wrote:

> > that's a very large proportion of the embedded space.  It really feels
> > like we could be doing a better job for drivers using these buses,
> > there's a lot of similarities in what many of them need but I can never
> > find the time to get my head round it confidently enough to actually
> > propose anything.

> I agree.  That's one of the reasons why I introduced the struct dev_power_domain
> thing a while ago and the generic PM domains patchset I've just posted is a step
> in that direction.

Ah, right - I'd not been thinking of those in the context of
simplifications for basic devices, I'd been thinking of them as being
for CPUs with more complex power domains that need managing.  I'll keep
more of an eye on what's going on there.
