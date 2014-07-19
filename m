From: Dmitry Torokhov <dtor@google.com>
Subject: Re: Power-managing devices that are not of interest at some point in time
Date: Sat, 19 Jul 2014 11:21:52 -0700
Message-ID: <2047146.r4vphTZhkk@dtor-glaptop>
References: <Pine.LNX.4.44L0.1407191357140.28179-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1407191357140.28179-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benson Leung <bleung@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Patrik Fimml <patrikf@chromium.org>, Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, July 19, 2014 01:59:01 PM Alan Stern wrote:
> On Sat, 19 Jul 2014, Benson Leung wrote:
> > > This raises an interesting question.  Suppose the system gets suspended
> > > while the lid is closed.  At that point, shouldn't wakeup devices be
> > > enabled, even if they were already inhibited?
> > 
> > It's possible that this could be a policy decision, ie, whether
> > power/wakeup is set to enabled for those devices or not.
> > However, I'd say that there's only one policy that makes sense in that
> > case : wakeups should be disabled while suspended.
> > 
> > If we inhibited the device during runtime to prevent stray input
> > events from being generated, it wouldn't make sense to allow the
> > device to potentially generate an accidental wakeup while suspended.
> 
> That doesn't really make sense.  If you're afraid of a device
> generating spurious wakeup events when the lid is closed, you should
> never enable it for wakeup.  After all, one of the first things that
> people often do after suspending their laptop is close the lid.

That's a fair point, and I think should be done by default. But that does not 
change what Benson said - I think if we inhibited the device it should stay 
inhibited across system suspend, including being disabled as wakeup source 
even if it could be enabled as such.

Thanks,
Dmitry

