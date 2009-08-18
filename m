From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume
	(updated)
Date: Tue, 18 Aug 2009 09:59:22 +0800
Message-ID: <1250560762.5351.44.camel__26946.1557073102$1250560940$gmane$org@rzhang-dt>
References: <200908122218.13975.rjw@sisk.pl> <200908170215.21173.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908170215.21173.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

hmm,
what are these patches based on?
I tried an 2.6.31-rc6 kernel together with your run-time PM patch (rev.
17) but still failed.

thanks,
rui

On Mon, 2009-08-17 at 08:15 +0800, Rafael J. Wysocki wrote:
> On Wednesday 12 August 2009, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following patches introduce a mechanism allowing us to execute device
> > drivers' suspend and resume callbacks asynchronously during system sleep
> > transitions, such as suspend to RAM.  The idea is explained in the [1/1] patch
> > message.
> 
> Changes:
> 
> * Added [1/7] that fixes kerneldoc comments in drivers/base/power/main.c
>   (this is a 2.6.32 candidate).
> 
> * Added [2/7] adding a framework for representing PM link (idea described
>   in the patch message).
> 
> * [3/7] is the async resume patch (idea described in the patch message).
> 
> * [4/7] is the async suspend patch.
> 
> * [5/7] - [7/7] set async_suspend for devices in a few selected subsystems.
> 
> The patches have been tested on HP nx6325.
> 
> Comments welcome.
> 
> Thanks,
> Rafael
> 
