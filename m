From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i2c: Hook up runtime PM support
Date: Fri, 5 Feb 2010 23:09:13 +0100
Message-ID: <201002052309.13966.rjw__3676.66286551884$1265407794$gmane$org@sisk.pl>
References: <1265203367-21344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201002042257.27145.rjw@sisk.pl>
	<20100205103915.GA2600@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100205103915.GA2600@sirena.org.uk>
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
Cc: Jean Delvare <khali@linux-fr.org>, pm list <linux-pm@lists.linux-foundation.org>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 05 February 2010, you wrote:
> On Thu, Feb 04, 2010 at 10:57:27PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday 03 February 2010, Mark Brown wrote:
> > > Allow I2C drivers to make use of the runtime PM framework by adding
> > > bus implementations of the runtime PM operations. These simply
> > > immediately suspend when the device is idle.
> 
> > Perhaps it would be a good idea to give the driver a chance to veto
> > the suspend by calling its _idle callback?  We do that for PCI and turns out to
> > be quite useful.
> 
> Hrm, I guess.  It seems an odd thing to want to use - for a bus like I2C
> there's nothing other than the driver involved so the request that is
> being vetoed will have been initiated by the driver which seems wrong.

Not really.  _idle is also called automatically by the runtime PM core after
_resume in case the device may be suspended again.  Your _idle has to handle
this case as well and that's when the driver may want to veto the suspend.

> Out of interest do you have any pointers to drivers using this (my greps
> aren't turning anything up in -next)?

There aren't any in -next, because I'm waiting for the base PCI runtime PM
code to settle down.  I have two in my private queue at the moment , for r8169
and e1000e (I posted some older versions of them some time ago, but they
wouldn't fit the current framework too well, which is the basic reason I'm
sitting on them, so that I don't have to post too many updates :-)).

I can send them to you privately, if needed.

Rafael
