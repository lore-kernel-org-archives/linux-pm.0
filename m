From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i2c: Use generic subsystem-level power
	management callbacks
Date: Mon, 15 Mar 2010 20:34:12 +0100
Message-ID: <201003152034.12195.rjw__6197.40597107938$1268681622$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1003142117200.7108-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003142117200.7108-100000@netrider.rowland.org>
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

On Monday 15 March 2010, Alan Stern wrote:
> On Sun, 14 Mar 2010, Rafael J. Wysocki wrote:
> 
> > On Sunday 14 March 2010, Alan Stern wrote:
> > > On Sun, 14 Mar 2010, Rafael J. Wysocki wrote:
> > > 
> > > > > You know, maybe we should allow bus types to use both the old and new
> > > > > interfaces.  It would make life easier for other subsystems in addition
> > > > > to i2c.
> > > > > 
> > > > > This doesn't mean that the core would end up calling two sets of
> > > > > suspend routines.  If the bus type uses legacy routines then all the
> > > > > non-runtime entries in the pm_ops structure would be empty.
> > > > > 
> > > > > The changes to the PM core necessary to do this are quite small.
> > > > 
> > > > Not really.  The detection that the particular callback is not present happens
> > > > in pm_op(), while the decision which framework to use is made at the
> > > > device_[suspend|resume]() level.
> > > 
> > > All you have to do is change the "else if" lines in
> > > device_[suspend|resume]() to "if".
> > 
> > Then, if a bus type implements both "new" and "old" callbacks, we'll end up
> > calling both.  Not nice.
> 
> Why would a bus type implement both?  Or looked at another way, if it 
> did implement both then wouldn't it want both sets of callbacks to be 
> invoked?
> 
> If a bus type does define both types of callback by mistake and only 
> wants one of them to be used, that's a bug -- pure and simple.  It's 
> not the PM core's fault if something goes wrong under those 
> circumstances.

In fact, I'd like the "legacy" callbacks to go, at least at the subsystem
level, so I'd prefer not to make it easier to keep them around.

How many bus types are there and how many of them actually implement power
management callbacks?  I don't really think the issue is so big.

Rafael
