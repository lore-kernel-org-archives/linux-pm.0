From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: [PATCH] make hci_notifier a blocking notifier (was
	Re: BUG: sleeping function called from invalid context at
	net/core/sock.c:1523)
Date: Sun, 6 May 2007 16:15:00 -0700
Message-ID: <2c0942db0705061615i1c6147a1h6aca54012c3509aa__30184.170677285$1178493352$gmane$org@mail.gmail.com>
References: <a781481a0705060816v59c1ae70m1d5067fcaba5a25d@mail.gmail.com>
	<Pine.LNX.4.44L0.0705061801330.21407-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705061801330.21407-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: marcel@holtmann.org, LKML <linux-kernel@vger.kernel.org>, Max Krasnyansky <maxk@qualcomm.com>, Satyam Sharma <satyam.sharma@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 5/6/07, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 6 May 2007, Satyam Sharma wrote:
>
> > Anyway, the hci_notifier is called from the following six call sites:
> >
> > hci_dev_open() and hci_dev_close() -> both called from
> > hci_sock_ioctl() => both can sleep
> > hci_register_dev() and hci_unregister_dev() => again both are capable
> > of sleeping
> > hci_suspend_dev() and hci_resume_dev() -> called from the .suspend()
> > and .resume() of the hci_usb_driver, and again both of these can sleep
> >
> > Is there any other reason why hci_notifier must be an atomic notifier?
> >
> > (CC'ing Alan Stern just in case, apparently hci_notifier became atomic
> > when notifier chains were classified into atomic / blocking)
>
> I don't remember exactly why this particular choice was made.  Perhaps we
> found that the notifier callout routines didn't use any blocking
> primitives (we may have been mistaken about this -- there was a lot of
> code to check) and so therefore the choice didn't matter.  In that case we
> probably just decided to make it an atomic notifier to keep things simple.
>
> As you found, changing it to a blocking notifier is very easy.  Provided
> all the callers are non-atomic it should work just fine.

Okay, I'll go ahead and try the patch, then, and report back.

Thanks,

Ray
