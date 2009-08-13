From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 0/4] introduce device async actions
	mechanism
Date: Thu, 13 Aug 2009 19:53:10 +0200
Message-ID: <200908131953.10819.rjw__38081.7557954744$1250186031$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908131028370.2940-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908131028370.2940-100000@iolanthe.rowland.org>
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

On Thursday 13 August 2009, Alan Stern wrote:
> On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:
> 
> > On a second thought, though, would it be a good idea to add
> > pm_runtime_get_noresume() / pm_runtime_put_sync() around the bus_for_each_drv()
> > in device_attach()?  That would prevent us from resuming-suspending the device
> > on each failing probe.
> 
> Good idea.  But don't remove the existing code in driver_probe_device.

Sure.

OK, I'll make this change and post rev. 16 shortly.

Thanks,
Rafael
