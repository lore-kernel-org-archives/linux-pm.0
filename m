From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 11 Dec 2010 03:17:14 +0200
Message-ID: <AANLkTi=67vtfiQMQHTijx6DMo2y2-b9BfOq1nx-zG7TU__17131.569205276$1292030313$gmane$org@mail.gmail.com>
References: <201012100100.58224.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1012101202040.2521-100000@iolanthe.rowland.org>
	<AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 11, 2010 at 12:59 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>> > A different, bolder solution, will always call pm_runtime_idle instead
>>> > of pm_request_idle (see below): when a device is runtime suspended, it
>>> > can't be too bad to immediately send idle notification to its parent,
>>> > too. I'm aware this might not always be desirable, but I'm bringing
>>> > this up even just for the sake of discussion:
>>> >
>>> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtim=
e.c
>>> > index 02c652b..9719811 100644
>>> > --- a/drivers/base/power/runtime.c
>>> > +++ b/drivers/base/power/runtime.c
>>> > @@ -407,7 +407,7 @@ static int rpm_suspend(struct device *dev, int rp=
mflags)
>>> > =A0 =A0 =A0 =A0 if (parent && !parent->power.ignore_children) {
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
>>> >
>>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_request_idle(parent);
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_idle(parent);
>>> >
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
>>> > =A0 =A0 =A0 =A0 }
>>>
>>> I acutally think we can do that. =A0If the parent cannot be suspended,
>>> pm_runtime_idle() will just return, which is fine. =A0Right now I don't=
 see
>>> any big drawback of this.
>>>
>>> Alan, what do you think?
>>
>> I don't like this change quite so much. =A0It can give rise to unbounded
>> nested suspend sequences: we suspend the device, then call the parent's
>> runtime_idle routine which suspends the parent, then we call the
>> grandparent's runtime_idle routine, etc.
>
> Yes, that's why I thought this might not be desirable, but I wasn't
> quite sure why would it be wrong; if a context is willing to
> synchronously suspend a device (either a driver using put_sync() or
> the PM worker), what do we gain by deferring the idling of the parent
> and not synchronously suspending as much ancestors as possible in the
> same context ?

By allowing nested suspend sequences we even squeeze some more power
by suspending devices earlier, and saving some CPU cycles (due to the
avoided context switches), so it sounds like a win-win...

But of course I may be overlooking a real problem this may pose.. I
haven't spotted any, but it does feel like a significant behavior
change, hence the cautious approach :)

Thanks,
Ohad.

>
