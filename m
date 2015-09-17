From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Thu, 17 Sep 2015 13:02:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509171253520.1270-100000@iolanthe.rowland.org>
References: <CAJZ5v0hYUfO87hGAjKRAZMt_G4NnkEOXuVybSsVmKzAm6vznDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hYUfO87hGAjKRAZMt_G4NnkEOXuVybSsVmKzAm6vznDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 17 Sep 2015, Rafael J. Wysocki wrote:

> On Thu, Sep 17, 2015 at 2:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, September 16, 2015 03:22:37 PM Alan Stern wrote:
> >> On Wed, 16 Sep 2015, Thierry Reding wrote:
> 
> [cut]
> 
> >
> > And I'm wondering if and how that is related to runtime PM?  It only
> > covers the system sleep transitions case, but who's responsible for the
> > runtime PM part?  Device drivers?

In theory the drivers are responsible.  In practice, I don't know how 
this is handled.

> Which reminds me of something we all seem to be forgetting about:
> there is asynchronous suspend and resume which may cause suspend and
> resume callbacks of devices to be executed in an order that is
> different from the dpm_list order.  In those cases the device that
> depends on another one has to explicitly wait for the other one to
> complete its callback in the current phase of the transition.
> 
> While correct ordering of dpm_list is essential for this to work too,
> it by no means is sufficient, so in the end the driver having a
> dependency needs to know about it and act on it as needed (or we need
> an alternative mechanism that will do that automatically, but I'm not
> sure what that may be).
> 
> Actually, I was thinking about adding something like pm_get() for this
> purpose that will do pm_runtime_get_sync() on the target and will
> ensure that the right things will happen during system suspend/resume
> in addition to that, including reordering dpm_list if necessary.
> Plus, of course, the complementary pm_put().
> 
> With something like that available, there should be no need to reorder
> dpm_list anywhere else.  The problem with this approach is that the
> reordering becomes quite complicated then, as it would need to move
> the device itself after the target and anything that depends on it
> along with it and tracking those dependencies becomes quite
> problematic.

Keeping explicit track of these non-child-parent dependencies seems 
reasonable.  But I don't know how you could combine it with reordering 
dpm_list.

One possibility might be to do a topological sort of all devices, with 
the initial set of constraints given by the explicit dependencies and 
the parent-child relations.  So basically this would mean ignoring the 
actual dpm_list and making up a new list of your own whenever a sleep 
transition starts.  It might work, but I'm not sure how reliable it 
would be.

Alan Stern
