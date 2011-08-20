From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sat, 20 Aug 2011 16:30:00 +0100
Message-ID: <20110820152959.GA22424__3016.39844333312$1313854278$gmane$org@opensource.wolfsonmicro.com>
References: <20110820062543.GA5011@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1108200943500.26680-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1108200943500.26680-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 20, 2011 at 09:48:25AM -0400, Alan Stern wrote:

> No, I as wasking about driver- and subsystem-specific interfaces to
> userspace that translate into things users are already doing.  Kevin's
> example was a touchscreen (although that was really an example of
> setting a power usage level, not a latency constraint).  Do you have
> any others?

Any sort of media streaming would be an obvious example - the
application picks the amount of data it buffers and how often it's
notified of progress depending on the usage which then controls how
quickly the system needs to handle things.
