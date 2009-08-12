From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 0/4] introduce device async actions
	mechanism
Date: Wed, 12 Aug 2009 22:10:35 +0200
Message-ID: <200908122210.35591.rjw__33977.5108070627$1250108051$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908120958200.2955-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908120958200.2955-100000@iolanthe.rowland.org>
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
Cc: "dtor@mail.ru" <dtor@mail.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 12 August 2009, Alan Stern wrote:
> On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:
> 
> > That looks quite complicated at first sight, but asynchronous resume with
> > completions can be done in a relatively simple patch.  I've got one, so
> > tomorow I'll post it for further discussion.
> 
> Okay.  I would think that managing the threads would account for most 
> of the complexity in either implementation, but I'll wait to see how 
> your approach works out.
> 
> > Thanks,
> > Rafael
> > 
> > 
> > PS
> > Did you have a chance to look at rev. 15 of the runtime PM patch
> > (http://patchwork.kernel.org/patch/40306/)?
> 
> Yes, sorry for not getting back to you.  It looks okay.
> 
> The one thing I'm not sure of is the pm_runtime_put_noidle calls in 
> driver_probe_device and __device_release_driver.  It seems that we 
> should always call pm_runtime_put regardless of whether the probe 
> succeeds or not.

Did you mean pm_runtime_put_sync()?

> For example, the USB stack is set up to suspend devices that don't have
> a driver (this is handled at the bus subsystem level).  But if probing
> failed, there wouldn't be any idle callback and so the suspend wouldn't
> take place.

OK, I'll make this change.

Thanks,
Rafael
