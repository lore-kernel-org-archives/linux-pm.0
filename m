From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wakeup-events implementation
Date: Fri, 20 Aug 2010 11:04:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008201051490.1716-100000@iolanthe.rowland.org>
References: <AANLkTi=AA+LMjo+M+funMd51JY1AGSW9=Lo-rrYu07Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=AA+LMjo+M+funMd51JY1AGSW9=Lo-rrYu07Eg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 19 Aug 2010, Arve Hj=F8nnev=E5g wrote:

> > Okay. =A0Nevertheless, you maintain debugging info in case a driver bug
> > causes a wakelock not to be released. =A0If the wakelocks all had
> > timeouts then a bug of that sort wouldn't be able to affect battery
> > life very much. =A0So why not add the timeouts?
> >
> =

> Because we can't. I just described how the keypad driver would break
> we just add a timeout to its wakelock. Other drivers, like the usb
> gadget driver may need to block suspend for an extended time period.

Some wakelocks can't use timeouts because they may have to be held for =

extended periods.  But the others could have timeouts.

> > How much degradation do you think you would observe if in-kernel
> > wakelocks _always_ used timeouts alone and _never_ were cancelled?
> >
> =

> I don't think that is an option. We have kernel wakelocks that need to
> be held while the device is in a specific state.

Yes, but what about all the others?  What I'm getting at is whether
it's feasible for each wakelock to be exclusively used either with
timeouts or cancellations, but never both.

> > In theory this is insufficient -- it doesn't handle the case where one
> > MMC device is enabled for wakeup and another isn't. =A0I assume you don=
't
> > really care about this (especially since Android phones aren't likely
> > to have more than one MMC device capable of generating wakeup events).
> >
> =

> I'm not sure what you mean by insufficient here. If it not optimal if
> you also have work that does not need to prevent suspend, but it
> should still work correctly.

Yeah, that's what I meant.  You would end up blocking suspends =

unnecessarily.  It's okay if it doesn't happen very often.

> >> It would be better to allocate the structure when user space changes
> >> the setting. If you wait until suspend before blocking suspend you may
> >> have passed the event on already.
> >
> > That will work for the structure directly associated with the device.
> > Additional structures allocated by the drivers have to be handled
> > differently, because the drivers aren't notified when the wakeup-enable
> > setting is changed.
> >
> =

> I'm not convinced that is it sufficient to detect that a device is
> wakeup-enabled on suspend.

It isn't.

>  However it is not a problem I have tried to
> solve since we have only used static wakeup sources.

Well, we may need to solve it eventually.  One possible solution is to =

imitate what you're doing with MMC: Use a single per-driver wakelock =

instead of separate wakelocks for each driver/device combination.  I =

don't know if that would work for all the cases, though.

Alan Stern
