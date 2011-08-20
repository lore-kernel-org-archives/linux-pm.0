From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
	wake-up constraints
Date: Sat, 20 Aug 2011 18:34:34 +0200
Message-ID: <201108201834.34741.rjw__45396.8339054429$1313858039$gmane$org@sisk.pl>
References: <20110820062543.GA5011@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1108200943500.26680-100000@netrider.rowland.org>
	<20110820152959.GA22424@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110820152959.GA22424@opensource.wolfsonmicro.com>
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

On Saturday, August 20, 2011, Mark Brown wrote:
> On Sat, Aug 20, 2011 at 09:48:25AM -0400, Alan Stern wrote:
> 
> > No, I as wasking about driver- and subsystem-specific interfaces to
> > userspace that translate into things users are already doing.  Kevin's
> > example was a touchscreen (although that was really an example of
> > setting a power usage level, not a latency constraint).  Do you have
> > any others?
> 
> Any sort of media streaming would be an obvious example - the
> application picks the amount of data it buffers and how often it's
> notified of progress depending on the usage which then controls how
> quickly the system needs to handle things.

Well, what about other types of devices?
