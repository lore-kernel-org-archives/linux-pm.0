From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH v21 015/100] cgroup freezer: Update stale
 locking comments
Date: Thu, 6 May 2010 15:34:57 -0700
Message-ID: <20100506223457.GN31830__3350.55377004228$1273185555$gmane$org@count0.beaverton.ibm.com>
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
	<1272723382-19470-16-git-send-email-orenl@cs.columbia.edu>
	<201005062140.19821.rjw@sisk.pl>
	<20100506203117.GM31830@count0.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100506203117.GM31830@count0.beaverton.ibm.com>
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

On Thu, May 06, 2010 at 01:31:17PM -0700, Matt Helsley wrote:
> On Thu, May 06, 2010 at 09:40:19PM +0200, Rafael J. Wysocki wrote:
> > On Saturday 01 May 2010, Oren Laadan wrote:
> > > From: Matt Helsley <matthltc@us.ibm.com>
> > > 
> > > Update stale comments regarding locking order and add a little more detail
> > > so it's easier to follow the locking between the cgroup freezer and the
> > > power management freezer code.
> > 
> > I guess these three patches are for me.
> > 
> > Do you want me to handle them?
> > 
> > Rafael
> 
> Hi Rafael,
> 
> 	I think you can take 15 as it's an update to the comments.
> 
> 16 and 17 are specific to checkpoint/restart. There are no other in-kernel
> uses, that we've identified, for them. So I was under the impression that it's
> inappropriate to add them without also adding the checkpoint/restart patches
> that use them.

Of course, assuming I'm wrong about the dependency on checkpoint/restart, I
have no objection to your taking them.

Thanks again!

Cheers,
	-Matt Helsley
