From: "Parag Warudkar" <parag.lkml@gmail.com>
Subject: Re: WARNING: at kernel/power/main.c:176
	suspend_test_finish+0x70/0x80()
Date: Fri, 10 Oct 2008 12:23:36 -0400
Message-ID: <f7848160810100923j12c03769x1a05ed7091e67a1b__20887.8407058821$1223659721$gmane$org@mail.gmail.com>
References: <200810101452.27929.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0810101028260.2459-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0810101028260.2459-100000@iolanthe.rowland.org>
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

On Fri, Oct 10, 2008 at 10:31 AM, Alan Stern <stern@rowland.harvard.edu> wrote:

> There's a bug that affects USB power management: commmit
> f9dd45ce10a014bdfd5432828c44630ea7fefedd needs to be reverted.  Greg KH
> has been asked to do this a few times but he hasn't gotten around to it
> yet.

Hi Alan,

Thanks for the info.

I can't seem to find that commit in mainline. If you have pointer to
the patch I will submit a revert.

Parag
