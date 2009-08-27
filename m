From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/6] PM: Asynchronous suspend and resume of
	devices
Date: Thu, 27 Aug 2009 16:46:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908271637480.25639-100000__31163.9270432808$1251406032$gmane$org@iolanthe.rowland.org>
References: <200908262217.19609.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908262217.19609.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Aug 2009, Rafael J. Wysocki wrote:

> Hi,
> 
> The following patches introduce a mechanism allowing us to execute device
> drivers' suspend and resume callbacks asynchronously during system sleep
> transitions, such as suspend to RAM.
> 
> The idea is explained in the changelogs of the first two patches.
> 
> Comments welcome.

I've been terribly busy and haven't had a chance to look at this.  The
earlier version seemed to have a bunch of mutual-exclusion issues; are
they resolved now?  There were also some problems involving unsafe
iteration over the dpm_list -- remember that devices can be
unregistered at any time, not just while they are suspending or
resuming.

When a device finishes, instead of having the async thread look for 
another device to work on, I think it would be better to have the 
thread check the dependents of the current device.  Those which are 
now ready can be added to a "device-ready" list, which is used to 
direct the actions of new async threads.

Alan Stern
