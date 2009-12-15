From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM: Calling Device runtime PM callbacks?
Date: Tue, 15 Dec 2009 21:30:41 +0100
Message-ID: <200912152130.41272.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912150933460.3566-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912150933460.3566-100000@iolanthe.rowland.org>
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 15 December 2009, Alan Stern wrote:
> On Tue, 15 Dec 2009, Rafael J. Wysocki wrote:
> 
> > > Idle is very similar to suspend.  They should use the same order.
> > > 
> > > I guess there's one extra thing to look out for: If one of the idle
> > > callbacks does pm_runtime_suspend() then there's no point invoking the
> > > later callbacks.
> > 
> > But how do we know that?
> 
> How do we know whether the callback does pm_runtime_suspend()?  Because 
> dev->runtime_status changes to RPM_SUSPENDED.
> 
> How do we know there's no point invoking the later callbacks?  Because 
> an idle callback is merely supposed to decide whether or not to suspend 
> the device.  If the device is already suspended then the callback's job 
> is already done.
> 
> > I'm still not sure what actually the point executing _idle for device types and
> > device classes is.  The only situation I can aticipate if when there's a device
> > without a bus type.
> 
> In the USB stack we have "devices" and "interfaces", two different
> device types (both belonging to the USB bus type).  They need to have
> separate callbacks.  The device idle callback will do a bunch of
> testing, whereas the interface idle callback will always invoke
> pm_runtime_suspend() immediately.
> 
> > Hmm.  Actually, are we ever going to call two or more suspend callbacks (ie.
> > bus type one and device type one or device type one and device class one)
> > for the same device?  If not, we'll be able to simplify things significantly
> > by making them mutually exclusive (ie. if there's bus type, call bus type,
> > or else if there's device type, call device type, or else if there's device
> > class, call device class).
> 
> I don't plan ever to have more than one callback.  But I can't speak 
> for other parts of the kernel.
> 
> The situation should be very much the same as with the DPM callbacks.  
> They could make the same assumption.  Or neither should make it -- as
> the case may be.

However, as you said before, the runtime PM interface is new so they can
adapt.

In fact, I'm not very comfortable with the current possibility to call DPM
callbacks of two or three kinds in a row for the same device, because that
means very close connection between the bus type and device type or device
class (or all three of them).  Nobody does that, as far as I can tell, and I
guess nobody will.

Now, if we agree that only one callback will be called for given device
(either bus type, or device type, or device class), the code may be simpler
and there won't be an issue with the ordering in _idle.

Rafael
