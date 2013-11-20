From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
Date: Wed, 20 Nov 2013 12:23:03 +0100
Message-ID: <20131120112303.GA5123@amd.pavel.ucw.cz>
References: <CAPDyKFpypLVKiOZEweWMig9LrNHcOpNQnm+J3KJ3KzCDBgkv9A@mail.gmail.com>
 <Pine.LNX.4.44L0.1311191011470.1145-100000@iolanthe.rowland.org>
 <CAPDyKFopHvAvpb1O__3HoMv2YuhYnVLg5sk+NeRs9tsg8OLSig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFopHvAvpb1O__3HoMv2YuhYnVLg5sk+NeRs9tsg8OLSig@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2013-11-20 11:52:05, Ulf Hansson wrote:
> On 19 November 2013 16:35, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, 19 Nov 2013, Ulf Hansson wrote:
> >
> >> At the moment, system PM is already affecting behaviour of runtime PM
> >> since it is preventing runtime suspend during system suspend.
> >
> > Sure.  And that behavior is documented.  In any case, it's a bug for
> > drivers to depend on runtime suspend for carrying out a system suspend.
> 
> Why do you say that?

Because that's the way it is?

> A significant amount of drivers should be able to cope with only the
> runtime PM callbacks, if only the PM core have respected the drivers
> in the way my RFC proposes.

So what? It is not as additional callback is huge burden -- code is
the same -- and we do want option of disabling runtime PM.

Don't make system suspend dependend on runtime PM.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
