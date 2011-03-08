From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Tue, 8 Mar 2011 23:15:55 +0100
Message-ID: <201103082315.55561.rjw__26292.1849768192$1299622599$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1102221029100.1968-100000@iolanthe.rowland.org>
	<201103082312.26675.rjw@sisk.pl> <4D76AA2C.2010805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D76AA2C.2010805@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 08, 2011, Jiri Slaby wrote:
> On 03/08/2011 11:12 PM, Rafael J. Wysocki wrote:
> > On Tuesday, March 08, 2011, Jiri Slaby wrote:
> >> On 03/08/2011 08:25 PM, Rafael J. Wysocki wrote:
> >>> On Tuesday, March 08, 2011, Jiri Slaby wrote:
> >>>> On 02/22/2011 04:36 PM, Alan Stern wrote:
> >>>>> By the way, are you booting with no_console_suspend?  And do you do 
> >>>>> "echo 8 >/proc/sys/kernel/printk" (or equivalently, Alt-SysRq-8) before 
> >>>>> suspending?
> >>>>
> >>>> Unfortunately there are no messages at all.
> >>>>
> >>>> Rafael, this is a Factory with intel gfx (modesetting). Do pm-utils
> >>>> switch a console in such case? And if yes, to which one?
> >>>
> >>> pm-utils don't, but s2ram does, I'm not sure from the top of my head to
> >>> which one, though.
> >>>
> >>> If you use a KMS driver (I get you do), please just "chmod a-x /usr/sbin/s2ram".
> >>
> >> Yeah, I meant kernel modesetting, of course. Sorry for the confusion.
> >>
> >> I don't have /usr/sbin/s2ram.
> > 
> > Ah.  So it's gone from Factory?  Interesting.
> 
> I don't know, maybe it's in suspend package which I don't have installed.

It's there, yes.
