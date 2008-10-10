From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: WARNING: at kernel/power/main.c:176
	suspend_test_finish+0x70/0x80()
Date: Fri, 10 Oct 2008 21:34:26 +0200
Message-ID: <200810102134.27112.rjw__4846.3006424301$1223667198$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0810101257030.2185-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0810101257030.2185-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>, Parag Warudkar <parag.lkml@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 10 of October 2008, Alan Stern wrote:
> On Fri, 10 Oct 2008, Parag Warudkar wrote:
> 
> > On Fri, Oct 10, 2008 at 10:31 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > > There's a bug that affects USB power management: commmit
> > > f9dd45ce10a014bdfd5432828c44630ea7fefedd needs to be reverted.  Greg KH
> > > has been asked to do this a few times but he hasn't gotten around to it
> > > yet.
> > 
> > Hi Alan,
> > 
> > Thanks for the info.
> > 
> > I can't seem to find that commit in mainline. If you have pointer to
> > the patch I will submit a revert.
> 
> It isn't in mainline; it's in linux-next.  Sorry, I wasn't sure which 
> kernel you were using.

I understood it was the mainline from the report.

Parag, could you please try to suspend without the USB drivers and see if the
delay is still there?

Thanks,
Rafael
