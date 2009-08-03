From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 0/4] introduce device async actions
	mechanism
Date: Mon, 3 Aug 2009 23:18:33 +0200
Message-ID: <200908032318.35070.rjw__19502.2290143699$1249334331$gmane$org@sisk.pl>
References: <1248404514.2670.107.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1248404514.2670.107.camel@rzhang-dt>
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
To: Zhang Rui <rui.zhang@intel.com>
Cc: dtor@mail.ru, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday 24 July 2009, Zhang Rui wrote:
> Hi,

Hi,

> this is the patch set I made to speed up the device
> suspend/resume/shutdown process.
> 
> A new mechanism called Device Async Actions is introduced
> in this patch set.

Well, I'm not sure we'll need that.

> The basic idea is that,
> if the suspend/resume/shutdown process of a device group, including
> a root device and its child devices, are independent of other devices,
> we create an async domain for this device group,
> and make them suspend/resume/shutdown asynchronously.    

I don't really think this is the right approach.  IMO, we should rather try to
identify groups of devices for which the PM callbacks (forget about .shutdown()
for now) can be executed in parallel.  One such group is leaf devices, ie.
devices that have no children.  Of course, some of them will depend of the
other indirectly, so we should make it possible to declare (in the driver)
whether the device can be suspended/resumed asynchronously and use the
following logic (at the core level), in pseudo code:

if (has_no_children(dev) && asynchronous_suspend_resume_allowed(dev))
    async_resume(dev);
else
    resume(dev);

and analogously for suspend.  Then, we can easily use one async domain for all
of these devices.

Later, we can add async domains for devices that have children, but can be
suspended and woken up in parallel with each other.  IOW, I think the async
domains should span the levels rather than branches of the device tree.

Thanks,
Rafael
