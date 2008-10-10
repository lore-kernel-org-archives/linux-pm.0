From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: WARNING: at kernel/power/main.c:176
 suspend_test_finish+0x70/0x80()
Date: Fri, 10 Oct 2008 12:58:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0810101257030.2185-100000__36070.8986096599$1223658238$gmane$org@iolanthe.rowland.org>
References: <f7848160810100923j12c03769x1a05ed7091e67a1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f7848160810100923j12c03769x1a05ed7091e67a1b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 10 Oct 2008, Parag Warudkar wrote:

> On Fri, Oct 10, 2008 at 10:31 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > There's a bug that affects USB power management: commmit
> > f9dd45ce10a014bdfd5432828c44630ea7fefedd needs to be reverted.  Greg KH
> > has been asked to do this a few times but he hasn't gotten around to it
> > yet.
> 
> Hi Alan,
> 
> Thanks for the info.
> 
> I can't seem to find that commit in mainline. If you have pointer to
> the patch I will submit a revert.

It isn't in mainline; it's in linux-next.  Sorry, I wasn't sure which 
kernel you were using.

Alan Stern
