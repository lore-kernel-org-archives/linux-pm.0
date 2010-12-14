From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: pm_runtime_suspended() and non-pm_runtime-using
 (i2c) drivers
Date: Tue, 14 Dec 2010 12:44:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012141236530.2087-100000__30221.53550196$1292349288$gmane$org@iolanthe.rowland.org>
References: <20101214164059.GE5723@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101214164059.GE5723@sirena.org.uk>
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
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 14 Dec 2010, Mark Brown wrote:

> On Tue, Dec 14, 2010 at 11:16:45AM -0500, Alan Stern wrote:
> 
> > I'm not familiar with the details of how the i2c subsystem works.  But
> > in general, the subsystem code should call pm_runtime_set_active()  
> > for every device before registering it.  Then if a driver doesn't use
> > any runtime-PM functions, pm_runtime_suspended() will return false.
> 
> Hrm, if that's the case then we also need to update at least the
> platform and SPI buses.  Though looking at the documentation this is
> going to get a bit interesting as there's a requirement that the parent
> has runtime PM enabled on it...

The parent can either be set to the active state or set to ignore its 
children.  The parent does not have to be enabled for runtime PM.

>  It's certainly not terribly apparent
> from the documentation.

What part isn't clear from the documentation?  I think the description 
of pm_runtime_set_active() in Documentation/power/runtime_pm.txt is 
pretty straightforward.

> It'd be really helpful if it were clearer what noop buses like this were
> supposed to do to get runtime PM working.

I'm a little confused.  When you say this is a "noop" bus, do you mean
that it can't do any power management?  If so, why does it need to get
runtime PM working?

Alan Stern
