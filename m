From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM: trace events for device pm callbacks
Date: Tue, 10 Jun 2014 23:41:33 +0200
Message-ID: <1740847.aJcviUsT1q@vostro.rjw.lan>
References: <20140610143122.GA12851@linux.intel.com> <3737184.526pO4COlv@vostro.rjw.lan> <20140610171716.694c8414@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140610171716.694c8414@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: todd.e.brandt@linux.intel.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 10, 2014 05:17:16 PM Steven Rostedt wrote:
> On Tue, 10 Jun 2014 23:17:46 +0200
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > On Tuesday, June 10, 2014 07:31:22 AM Todd E Brandt wrote:
> > > Adds two trace events which supply the same info that initcall_debug 
> > > provides, but via ftrace instead of dmesg. The existing initcall_debug
> > > calls require the pm_print_times_enabled var to be set (either via
> > > sysfs or via the kernel cmd line). The new trace events provide all the
> > > same info as the initcall_debug prints but with less overhead, and also
> > > with coverage of device prepare and complete device callbacks.
> > > 
> > > These events replace the device_pm_report_time event (which has been
> > > removed). device_pm_callback_start is called first and provides the device
> > > and callback info. device_pm_callback_end is called after with the
> > > device name and error info. The time and pid are gathered from the trace
> > > data headers.
> > > 
> > > Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> > 
> > Steve needs to see this (CCed).
> 
> The trace events look fine. Is there anything else you wanted me to
> look at?

No, that's all, thanks!

Rafael
