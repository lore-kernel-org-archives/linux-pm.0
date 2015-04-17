From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 1/2] PM / sleep: Let devices force direct_complete
Date: Fri, 17 Apr 2015 13:30:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504171325100.1319-100000@iolanthe.rowland.org>
References: <1471135.f2mh84nZFq@avalon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471135.f2mh84nZFq@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Apr 2015, Laurent Pinchart wrote:

> Hi Tomeu,
> 
> Thank you for the patch.
> 
> On Friday 17 April 2015 17:24:49 Tomeu Vizoso wrote:
> > Introduce a new per-device flag power.force_direct_complete that will
> > instruct the PM core to ignore the runtime PM status of its descendants
> > when deciding whether to let this device remain in runtime suspend when
> > the system goes into a sleep power state.
> > 
> > This is needed because otherwise it would be needed to get dozens of
> > drivers to implement the prepare() callback and be runtime PM active
> > even if they don't have a 1-to-1 relationship with a piece of HW.
> 
> I'll let PM experts comment on the approach, but I believe the new flag would 
> benefit from being documented (likely in Documentation/power/devices.txt) :-)

Documentation/power/runtime_pm.txt is the right place.

However, I'm not sure that this is the sort of thing Rafael meant when 
he suggested adding a new flag.  I thought he meant the PM core would 
look at the new flag only if there was no ->prepare method at all.  
Then if the new flag was set, the PM core would act as though ->prepare 
had returned 1.  That way there would be no need to add silly little
one-line *_prepare() routines all over the place.

Maybe he had something else in mind, though...

Alan Stern
