From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Thu, 17 Sep 2015 04:04:22 +0200
Message-ID: <CAJZ5v0hYUfO87hGAjKRAZMt_G4NnkEOXuVybSsVmKzAm6vznDA@mail.gmail.com>
References: <Pine.LNX.4.44L0.1509161503470.1993-100000@iolanthe.rowland.org>
	<1564644.fC4l842KYa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1564644.fC4l842KYa@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 17, 2015 at 2:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, September 16, 2015 03:22:37 PM Alan Stern wrote:
>> On Wed, 16 Sep 2015, Thierry Reding wrote:

[cut]

>
> And I'm wondering if and how that is related to runtime PM?  It only
> covers the system sleep transitions case, but who's responsible for the
> runtime PM part?  Device drivers?
>

Which reminds me of something we all seem to be forgetting about:
there is asynchronous suspend and resume which may cause suspend and
resume callbacks of devices to be executed in an order that is
different from the dpm_list order.  In those cases the device that
depends on another one has to explicitly wait for the other one to
complete its callback in the current phase of the transition.

While correct ordering of dpm_list is essential for this to work too,
it by no means is sufficient, so in the end the driver having a
dependency needs to know about it and act on it as needed (or we need
an alternative mechanism that will do that automatically, but I'm not
sure what that may be).

Actually, I was thinking about adding something like pm_get() for this
purpose that will do pm_runtime_get_sync() on the target and will
ensure that the right things will happen during system suspend/resume
in addition to that, including reordering dpm_list if necessary.
Plus, of course, the complementary pm_put().

With something like that available, there should be no need to reorder
dpm_list anywhere else.  The problem with this approach is that the
reordering becomes quite complicated then, as it would need to move
the device itself after the target and anything that depends on it
along with it and tracking those dependencies becomes quite
problematic.

Thanks,
Rafael
