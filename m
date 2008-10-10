From: "Parag Warudkar" <parag.lkml@gmail.com>
Subject: Re: WARNING: at kernel/power/main.c:176
	suspend_test_finish+0x70/0x80()
Date: Fri, 10 Oct 2008 17:01:33 -0400
Message-ID: <f7848160810101401l250fa459pdbe00d57c51a326__41664.3573240892$1223672698$gmane$org@mail.gmail.com>
References: <200810102134.27112.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0810101542320.2185-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0810101542320.2185-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 10, 2008 at 3:44 PM, Alan Stern <stern@rowland.harvard.edu> wrote:

> Or even better, suspend with the USB drivers present, and with
> CONFIG_USB_DEBUG, CONFIG_PM_SLEEP, and CONFIG_PRINTK_TIME all enabled.
> The resulting detailed timing information should pinpoint the problem.

As of now it is reproducible without USB modules loaded. But any way
will try this over weekend.

Parag
