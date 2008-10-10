From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: WARNING: at kernel/power/main.c:176
 suspend_test_finish+0x70/0x80()
Date: Fri, 10 Oct 2008 15:44:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0810101542320.2185-100000__25392.7474412651$1223668135$gmane$org@iolanthe.rowland.org>
References: <200810102134.27112.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810102134.27112.rjw@sisk.pl>
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
Cc: Parag Warudkar <parag.lkml@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 10 Oct 2008, Rafael J. Wysocki wrote:

> I understood it was the mainline from the report.
> 
> Parag, could you please try to suspend without the USB drivers and see if the
> delay is still there?

Or even better, suspend with the USB drivers present, and with
CONFIG_USB_DEBUG, CONFIG_PM_SLEEP, and CONFIG_PRINTK_TIME all enabled.  
The resulting detailed timing information should pinpoint the problem.

Alan Stern
