From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Fundamental flaw in system suspend,
 exposed by freezer removal
Date: Wed, 27 Feb 2008 15:15:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802271509230.9523-100000__14733.9130090133$1204143506$gmane$org@iolanthe.rowland.org>
References: <200802272050.39769.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802272050.39769.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 27 Feb 2008, Rafael J. Wysocki wrote:

> > All right, we can set it to RESUME_RUNNING before calling the resume
> > method and then set it to 0 afterwards.  The point is that the value
> > shouldn't remain SUSPEND_DONE while resume runs, because it should be
> > legal for resume to register new children.
> 
> I'm not sure.  The core moves the device to dpm_active only after ->resume()
> has run.

Actually the move is done before the method is called.  So this isn't a
problem.

...
> > > > The one tricky thing to watch out for is when a suspend or resume 
> > > > method wants to unregister the device being suspended or resumed.
> > > 
> > > That can't happen, because dev->sem is taken by suspend_device() and
> > > device_del() would lock up attempting to acquire it once again.
> > 
> > We'll have to fix device_del() to prevent that from happening.  Your 
> > in_sleep_context() approach should work.
> 
> I'm not sure if we need to do it.  It's always been like this, so the current
> drivers' ->suspend() and ->resume() don't unregister the device they're called
> for.  I don't see any advantage from doing that for future drivers.

All right, if it doesn't happen now then we don't need to allow for it.  
That makes life a little simpler.

Alan Stern
