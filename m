From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: WARNING: at kernel/power/main.c:176
 suspend_test_finish+0x70/0x80()
Date: Fri, 10 Oct 2008 10:31:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0810101028260.2459-100000__26860.7463258833$1223649413$gmane$org@iolanthe.rowland.org>
References: <200810101452.27929.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810101452.27929.rjw@sisk.pl>
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

> On Friday, 10 of October 2008, Parag Warudkar wrote:
> > 2.6.27 seems to be taking long time to resume, it hits this WARN_ON in
> > kernel/power/main.c:176 suspend_test_finish -
> > Never seen earlier.
> 
> Resuming devices takes too much time (more than 5 sec. actually)
> and the stack trace indicates USB.
> 
> Can you test with the USB modules unloaded?

There's a bug that affects USB power management: commmit 
f9dd45ce10a014bdfd5432828c44630ea7fefedd needs to be reverted.  Greg KH
has been asked to do this a few times but he hasn't gotten around to it 
yet.

Alan Stern
