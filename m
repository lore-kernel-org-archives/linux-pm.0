From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
	wake-up constraints
Date: Sun, 21 Aug 2011 20:05:53 +0200
Message-ID: <201108212005.53898.rjw__30692.4885874198$1313949905$gmane$org@sisk.pl>
References: <20110820062543.GA5011@opensource.wolfsonmicro.com>
	<201108202114.37502.rjw@sisk.pl>
	<20110821082509.GA10380@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110821082509.GA10380@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Sunday, August 21, 2011, Mark Brown wrote:
> On Sat, Aug 20, 2011 at 09:14:37PM +0200, Rafael J. Wysocki wrote:
> 
> > I guess you mean the driver here and I'm not really sure it can.
> > For instance, the driver may not know what configuration it works in,
> > e.g. is there a power domain or a hierarchy of those and how much time
> > it takes to power them all down and up and what the power break even is.
> 
> I don't understand why the driver would need to know what situation it's
> in.  I'd been working on the basis that the idea was that the driver
> said what the constraints it has are and then some code with a more
> system wide view would make the actual decisions for things outside the
> driver domian.

That's correct, but in order to figure out a "sensible default"
the driver generally would need to know what the expectations with
respect to it are.  Otherwise it can very well generate a random
number and use that.

Thanks,
Rafael
