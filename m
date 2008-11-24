From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Tying sysfs "wakeup" file to
	platform-level?handler
Date: Mon, 24 Nov 2008 18:08:39 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811241802350.6702-100000@iolanthe.rowland.org>
References: <20081124223258.GB28801@trantor.hsd1.or.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081124223258.GB28801@trantor.hsd1.or.comcast.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, Andres Salomon <dilinger@queued.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Nov 2008, Deepak Saxena wrote:

> On Nov 24 2008, at 23:19, Rafael J. Wysocki was caught saying:
> > > Maybe there is some other way to do this that I don't quite grok?
> > > Right now, the i8042 device does not have the can_wakeup flag set
> > > so writing either "enabled" or "disabled" leads to -EINVAL.
> > 
> > For PCI we set the can_wakeup flag during the initialization of devices.
> > 
> > For some other devices, ACPI BIOS contains information telling us whether
> > they are capable of waking the system up and the ACPI code sets that flag for
> > them on this basis.
> > 
> > Does your platform know which devices can wake up?
> 
> Yep. i8042, lid, power button, battery state change, WOL. I think 
> I can do something similar to what ACPI is doing by trapping the
> device registration.

ACPI may not be such a good model after all.  It's very table-driven, 
with its own little interpreter (or not so little!), whereas most 
platforms have a pretty good idea beforehand of what devices can exist, 
and they are described as static data.  Right?

So the platform code could initialize the "can_wakeup" setting when it
first detects and registers the device.  And you could add a
"set_wakeup" function pointer to struct platform_device, which the
bus-level suspend and resume routines would invoke to enable or disable
remote wakeup, as appropriate.  In the static structures these function 
pointers would point to routines that set or clear the appropriate bits 
in your Embedded Controller.

I think this is the right way to go...

Alan Stern
