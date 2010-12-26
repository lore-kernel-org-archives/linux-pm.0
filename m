From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 25 Dec 2010 21:48:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012252041260.10725-100000__39613.5638388388$1293331771$gmane$org@netrider.rowland.org>
References: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sat, 25 Dec 2010, Ohad Ben-Cohen wrote:

> On Sat, Dec 25, 2010 at 6:21 PM, Alan Stern <stern@rowland.harvard.edu> w=
rote:
> > Right. =A0You may or may not realize it, but this requirement means that
> > the driver _must_ bypass runtime PM sometimes.
> =

> http://www.spinics.net/lists/linux-pm/msg22864.html
> =

> > Now you've lost me. =A0Which of the driver's handlers are you talking
> > about?
> =

> The driver's handler, which is called by mac80211, and is responsible
> to power off the device.
> The _same_ handler is being called either during runtime or during a
> system transition to suspend

Is there a separate handler responsible for powering the device back
on?  What are the names of these handlers?

> > What races?
> =

> Driver thinks power is off and device is now fully reset, but it's isn't =
really

That's not a race; it's just a misunderstanding.  A race is when you
have two threads of control executing concurrently and either one can
end up carrying out some action first.

> > Why does the driver have to _assume_ the device was powered off -- why
> > doesn't it simply _do_ the power down?
> =

> runtime PM is disabled during suspend. and the driver doesn't know
> that the system is suspending, and it is using pm_runtime_put_sync().

What is the name of the routine that calls pm_runtime_put_sync()?  =

What is the name of the driver's runtime_suspend routine?  Is either of
them the same as the handler you mentioned above?  And while we're at =

it, what is the name of the routine that _actually_ changes the =

device's power level?

It's very difficult to talk about different pieces of code without =

knowing their names.

> It's the same code that executes during runtime and while system is
> suspending

Okay, there's nothing wrong with that.  But the code that runs during =

system suspend should not call pm_runtime_put_sync().

> Even if we changed mac80211 to tell us the system is suspending, so we
> would power off the device directly in this case, it won't solve all
> of our problems, because even during runtime we need to bypass runtime
> PM due to /sys/devices/.../power/control.

Evidently you are facing two distinct problems, and they need to be
solved together.  In fact, solving one problem (bypassing runtime PM)  =

will probably help to solve the other (doing system resume correctly).

> > Maybe it would help if you provided a list of the relevant subroutines
> > together with descriptions of the circumstances under which they are
> > called and what they are expected to do. =A0For example, a brief
> > pseudo-code listing.
> =

> Frankly, I don't think it's worth it.
> =

> We're just a single use case and Rafael already said he won't support it.

Well, I'd like to help you find the best solution, but I can't because =

I don't understand how the subsystem and driver are structured, and you =

aren't providing enough details.  We won't make any further progress on =

this unless you abandon the incomplete high-level overviews and instead =

give a more or less complete lower-level description -- including the =

subroutine names!

> > It's not necessary to maintain usage_count while you're bypassing
> > runtime PM. =A0Just make sure when you're done that everything is back =
in
> > sync.
> =

> I think you are missing the fact that we will have to bypass runtime
> PM also during runtime, and not only in suspend/resume, and that's due
> to /sys/devices/.../power/control.

No, I realize that.

> That's why we will also have to maintain usage_count - to prevent
> dpm_complete() from powering the device down, when it is really up.

When else should dpm_complete() power the device down?  You certainly
don't want to power the device down when it is already down!  :-)

Maybe you mean that you want to prevent dpm_complete() from powering
the device down while it is in use.  That should never be a problem --
the device should never be used without the PM core being aware.  The
unusual cases you have described all involve powering the device down
at times when it is supposed to be in use (e.g., in order to do a
reset).  If you do these power-downs directly instead of trying to use =

runtime PM, then the PM core will never think the device is idle when =

it really is being used.

Ultimately it boils down to this.  You have several possible reasons
for powering-down the device: runtime PM, system sleep, and reset (or
other similar driver-specific things).  Presumably the reset case
occurs only while the device is in use, and with sufficient locking to
prevent the driver from trying to access the device while the reset is
in progress.

Therefore you need to have a single routine that actually powers-down
the device, and you need to call this routine in different settings:
during system sleep or runtime suspend (the same code in the driver =

handles these two cases, right?) and when a reset is needed.

Alan Stern
