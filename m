From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM: Calling Device runtime PM callbacks?
Date: Sat, 19 Dec 2009 22:31:40 +0100
Message-ID: <200912192231.40234.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912191138410.29317-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912191138410.29317-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 19 December 2009, Alan Stern wrote:
> On Sat, 19 Dec 2009, Rafael J. Wysocki wrote:
> 
> > On Tuesday 15 December 2009, Rafael J. Wysocki wrote:
> > > On Tuesday 15 December 2009, Alan Stern wrote:
> > > > On Tue, 15 Dec 2009, Rafael J. Wysocki wrote:
> > ...
> > > 
> > > > > Now, if we agree that only one callback will be called for given device
> > > > > (either bus type, or device type, or device class), the code may be simpler
> > > > > and there won't be an issue with the ordering in _idle.
> > > > 
> > > > That would be perfectly fine with me.
> > > 
> > > OK
> > 
> > Updated patch is appended, please tell me what you think.
> 
> Yes, this is the sort of thing I had in mind.  Although it might be
> nice to avoid all the repeated code.  For example, you might add a
> helper routine:
> 
> 	static int invoke_callback(struct device *dev,
> 			int (*func)(struct device *))
> 	{
> 		int retval;
> 
> 		spin_unlock_irq(&dev->power.lock);
> 		retval = func(dev);
> 		spin_lock_irq(&dev->power.lock);
> 		return retval;
> 	}

The problem with dev->power.runtime_error would reappear in
that case and I think the "unlock, do something, lock" structure looks odd. :-)

The only things repeated are unlocking, locking and
"dev->power.runtime_error = retval", which I think is not too much ...

Rafael
