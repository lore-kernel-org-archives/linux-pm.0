From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sat, 20 Aug 2011 18:04:03 +0100
Message-ID: <20110820170403.GA27040__24024.2810025395$1313859904$gmane$org@opensource.wolfsonmicro.com>
References: <20110820062543.GA5011@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1108200943500.26680-100000@netrider.rowland.org>
	<20110820152959.GA22424@opensource.wolfsonmicro.com>
	<201108201834.34741.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108201834.34741.rjw@sisk.pl>
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

On Sat, Aug 20, 2011 at 06:34:34PM +0200, Rafael J. Wysocki wrote:
> On Saturday, August 20, 2011, Mark Brown wrote:

> > Any sort of media streaming would be an obvious example - the
> > application picks the amount of data it buffers and how often it's
> > notified of progress depending on the usage which then controls how
> > quickly the system needs to handle things.

> Well, what about other types of devices?

Other than the input case (which is a latency issue - there's two
components, one is how much data is delivered for things like
touchscreens which stream and the other is how quickly the first data is
delivered) nothing immediately springs to mind but this may just be a
product of what I'm most familiar with.  I don't really see this as a
problem, for a lot of devices it's probably the case that the device can
figure out something sensible to do without any help.
