From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Tue, 23 Aug 2011 10:21:56 +0100
Message-ID: <20110823092155.GJ9232__11316.1126887009$1314091409$gmane$org@opensource.wolfsonmicro.com>
References: <20110820062543.GA5011@opensource.wolfsonmicro.com>
	<201108202114.37502.rjw@sisk.pl>
	<20110821082509.GA10380@opensource.wolfsonmicro.com>
	<201108212005.53898.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108212005.53898.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 21, 2011 at 08:05:53PM +0200, Rafael J. Wysocki wrote:
> On Sunday, August 21, 2011, Mark Brown wrote:

> > I don't understand why the driver would need to know what situation it's
> > in.  I'd been working on the basis that the idea was that the driver
> > said what the constraints it has are and then some code with a more
> > system wide view would make the actual decisions for things outside the
> > driver domian.

> That's correct, but in order to figure out a "sensible default"
> the driver generally would need to know what the expectations with
> respect to it are.  Otherwise it can very well generate a random
> number and use that.

Right, but I'd expect that should be something that the driver can
generally do based on knowledge of what it needs to deliver to its
users.  It doesn't need to be tunable to that - for example, input
devices will have a reasonable idea of the response time needed to
deliver interactive performance.  If it's really got no idea then
hopefully not providng any constraints will do something sensible.
