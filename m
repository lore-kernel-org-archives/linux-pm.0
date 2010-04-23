From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Is it supposed to be ok to call del_gendisk while
	userspace is frozen?
Date: Fri, 23 Apr 2010 07:17:07 +0200
Message-ID: <201004230717.07086.rjw__31467.730124905$1271999974$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1003032142580.6963-100000@netrider.rowland.org>
	<20100304201548.GA1341@elf.ucw.cz>
	<y2yf383264b1004221640rd1fca614zfa15d7e7984ab3ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <y2yf383264b1004221640rd1fca614zfa15d7e7984ab3ba@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Reimer <mattjreimer@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 23 April 2010, Matt Reimer wrote:
> On Thu, Mar 4, 2010 at 1:15 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> > My thought exactly.  This is the only approach that also solves the
> >> > following race:
> >> >
> >> >     A driver is unloaded at the same time as a suspend starts.
> >> >
> >> >     The writeback thread gets frozen.
> >> >
> >> >     Then before the rmmod thread is frozen, it calls del_gendisk.
> >> >
> >> > Delaying things by means of a workqueue (or the equivalent) might also
> >> > work, but it doesn't seem as safe.  For example, some important
> >> > writebacks might end up getting delayed until too late.
> >
> > Delaying writebacks during sleep should be ok... That's why we do
> > sync() after userspace is frozen -- nothing really important should be
> > waiting for writeback after that point.
> 
> Has this been fixed,

No, it hasn't.

> or has a consensus about how to fix this been
> achieved? I'm hitting the same problem and have some time to work on a
> fix.

Generally, it looks like del_gendisk should thaw writeback threads, but not
during suspend, only during resume.

Rafael
