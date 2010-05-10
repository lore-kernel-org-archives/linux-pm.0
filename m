From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v21 015/100] cgroup freezer: Update stale
	locking comments
Date: Mon, 10 May 2010 23:12:10 +0200
Message-ID: <201005102312.10190.rjw__38887.2144897052$1273526126$gmane$org@sisk.pl>
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
	<201005102301.45729.rjw@sisk.pl>
	<20100510210724.GP31830@count0.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100510210724.GP31830@count0.beaverton.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Cedric Le Goater <legoater@free.fr>, Oren Laadan <orenl@cs.columbia.edu>, containers@lists.linux-foundation.org, Li Zefan <lizf@cn.fujitsu.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Serge Hallyn <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Menage <menage@google.com>, Pavel Emelyanov <xemul@openvz.org>
List-Id: linux-pm@vger.kernel.org

On Monday 10 May 2010, Matt Helsley wrote:
> On Mon, May 10, 2010 at 11:01:45PM +0200, Rafael J. Wysocki wrote:
> > On Thursday 06 May 2010, Oren Laadan wrote:
> > > 
> > > On 05/06/2010 03:40 PM, Rafael J. Wysocki wrote:
> > > > On Saturday 01 May 2010, Oren Laadan wrote:
> > > >> From: Matt Helsley <matthltc@us.ibm.com>
> > > >>
> > > >> Update stale comments regarding locking order and add a little more detail
> > > >> so it's easier to follow the locking between the cgroup freezer and the
> > > >> power management freezer code.
> > > > 
> > > > I guess these three patches are for me.
> > > > 
> > > > Do you want me to handle them?
> > > 
> > > Yes, please, that would be great.
> > 
> > However, patches 16 and 17 seem to depend on checkpoint/restart and don't
> > appear to be margeable at this point.  Is this correct?
> 
> Strictly speaking they do not depend on checkpoint/restart. However, only
> checkpoint/restart uses the functionality introduced by those patches so I
> think you are correct that they aren't mergeable at this point.

OK, so I'm going to take patch 15 only for the upcoming merge window.

Thanks,
Rafael
