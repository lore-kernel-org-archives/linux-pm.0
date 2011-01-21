From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 00:28:37 +0100
Message-ID: <201101220028.38105.rjw__31729.5898953036$1295652679$gmane$org@sisk.pl>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<AANLkTi=_-bMsp1K-thY+4wUMC5wDMVT+8m=fmVEx_wqE@mail.gmail.com>
	<201101220016.46227.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101220016.46227.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Lin Ming <ming.m.lin@intel.com>, Jeff Chua <jeff.chua.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, January 22, 2011, Rafael J. Wysocki wrote:
> On Friday, January 21, 2011, Linus Torvalds wrote:
> > On Fri, Jan 21, 2011 at 2:42 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > >
> > > Something like this, perhaps.  It doesn't blow up my Toshiba test box, so
> > > hopefully it won't blow up yours ...
> > 
> > Failed suspend on the very first try..
> 
> Well, so it's not this problem (which was a red herring).
> 
> I wonder if you can reproduce the failure with the
> 
> # echo core > /sys/power/pm_test
> # echo mem > /sys/power/state
> 
> test?  I think you can even try to run the second command in a tight loop
> (the first one simply triggers a switch) and see what happens.

Hmm, this is a long shot.

Can you try to change acpi_os_ioremap() in your current tree so that it calls
ioremap() instead of ioremap_cache() and see if that makes a difference?

Rafael
