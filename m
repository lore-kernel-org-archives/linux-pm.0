From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i2c: Use generic subsystem-level power
	management callbacks
Date: Sun, 14 Mar 2010 20:58:45 +0100
Message-ID: <201003142058.45981.rjw__47660.2728399031$1268596602$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1003131627270.19476-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003131627270.19476-100000@netrider.rowland.org>
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
Cc: Jean Delvare <khali@linux-fr.org>, pm list <linux-pm@lists.linux-foundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 13 March 2010, Alan Stern wrote:
> On Sat, 13 Mar 2010, Rafael J. Wysocki wrote:
> 
> > Please note that the "legacy" callbacks removed by this patch are already
> > effectively dead, because they are not going to be called by the PM core
> > anyway.  I'm not sure if this is what we want, though, so please let me know
> > in case it's not.
> 
> You know, maybe we should allow bus types to use both the old and new
> interfaces.  It would make life easier for other subsystems in addition
> to i2c.
> 
> This doesn't mean that the core would end up calling two sets of
> suspend routines.  If the bus type uses legacy routines then all the
> non-runtime entries in the pm_ops structure would be empty.
> 
> The changes to the PM core necessary to do this are quite small.

Not really.  The detection that the particular callback is not present happens
in pm_op(), while the decision which framework to use is made at the
device_[suspend|resume]() level.

> Does it seem like a reasonable thing to do?

Well, if someone spends time on implementing new callbacks for a bus type,
writing them in such a way that they will call the "legacy" callbacks from
drivers if necessary is not really a big deal IMO.

The problem in this particular case is that I don't know whether or not we
_want_ the drivers' "legacy" callbacks to be invoked at all.  The $subject
patch assumes we don't, but if we do in fact, I'll rework it to do so.

I need that piece of information, though. :-)

Rafael
