From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume
	(updated)
Date: Mon, 17 Aug 2009 02:15:21 +0200
Message-ID: <200908170215.21173.rjw@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908122218.13975.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 12 August 2009, Rafael J. Wysocki wrote:
> Hi,
> 
> The following patches introduce a mechanism allowing us to execute device
> drivers' suspend and resume callbacks asynchronously during system sleep
> transitions, such as suspend to RAM.  The idea is explained in the [1/1] patch
> message.

Changes:

* Added [1/7] that fixes kerneldoc comments in drivers/base/power/main.c
  (this is a 2.6.32 candidate).

* Added [2/7] adding a framework for representing PM link (idea described
  in the patch message).

* [3/7] is the async resume patch (idea described in the patch message).

* [4/7] is the async suspend patch.

* [5/7] - [7/7] set async_suspend for devices in a few selected subsystems.

The patches have been tested on HP nx6325.

Comments welcome.

Thanks,
Rafael
