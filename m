From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation
 callbacks (highest level) - updated
Date: Mon, 10 Mar 2008 14:54:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803101452580.5082-100000__22300.9111280136$1205175431$gmane$org@iolanthe.rowland.org>
References: <200803101758.01826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803101758.01826.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Mar 2008, Rafael J. Wysocki wrote:

> Okay, I reworked the patch so that ->complete() is not called after a failing
> ->prepare() (even if that returns -EAGAIN).  For this purpose I had to rework
> dpm_suspend() quite heavily (once again).  Hopefully, I didn't break it.

> The updated patch is appended.

It all looks good.  The next step is testing...

Alan Stern
