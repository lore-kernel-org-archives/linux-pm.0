From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Failure of device_add() and parent's child_count
Date: Fri, 27 Nov 2009 12:37:19 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911271230590.30903-100000@netrider.rowland.org>
References: <200911270157.57141.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911270157.57141.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Nov 2009, Rafael J. Wysocki wrote:

> > This means that following a failure of device_add(), the caller has to
> > be responsible for making sure the parent's child_count is correct.  So 
> > after calling device_add(), we need to do:
> > 
> > 	if (rc < 0) {
> > 		dev_warn(dev, ...);
> > 		pm_runtime_disable(dev);
> > 		pm_runtime_set_suspended(dev);
> > 		put_device(dev);
> > 	}
> > 
> > I doubt that people using the Runtime PM interface are aware of this.  
> 
> I'm quite sure they aren't.
> 
> > Did you do it in your new PCI runtime-PM code?
> 
> No, I don't.  In the case of a network adapter I've been working on recently,
> it's sufficient to enable/disable the runtime PM in _open()/_close().
> 
> > It would be good to remove this awkwardness, but I don't know what is
> > the best way to do it.  Perhaps __pm_runtime_set_status() shouldn't
> > adjust the parent's child_count unless the device is registered.  Then
> > device_pm_add() could adjust the child_count as needed.
> 
> It seems fine at first sight, but I need to think a bit more about that.

Is anybody going to do runtime PM on a device (or allow its parent to
be suspended) before registering it with the driver core?  That's the 
case to worry about.

Failures of device_add() are going to be pretty rare in any case.  So
maybe this doesn't much matter.

Still, a short paragraph could be added to the end of the documentation
file, showing the right way to do this.

Alan Stern
