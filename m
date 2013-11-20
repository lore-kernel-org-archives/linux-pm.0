From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
Date: Wed, 20 Nov 2013 20:55:22 +0100
Message-ID: <20131120195522.GA31828@amd.pavel.ucw.cz>
References: <CAPDyKFocLDLLp0mJghP-+nwacxM58T3EengqW0vLka=WeRQxvw@mail.gmail.com>
 <Pine.LNX.4.44L0.1311201156070.1826-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1311201156070.1826-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2013-11-20 11:58:31, Alan Stern wrote:
> On Wed, 20 Nov 2013, Ulf Hansson wrote:
> 
> > Do note that, the intent with my RFC is also to simplify for drivers
> > in general using runtime PM. No matter how you put it, the
> > consequences of preventing runtime suspend during system suspend are
> > causing confusions.
> 
> Then fix the confusion.  Explain peoples' mistakes to them.

Exactly. Way to solve confusion is not "make core behave as part of
drivers apparently think it should".

And yes, you have a list of broken drivers... thanks for that.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
