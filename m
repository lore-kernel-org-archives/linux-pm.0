From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [RFC][PATCH 3/5] Container Freezer: Implement
	freezer cgroup	subsystem
Date: Wed, 30 Apr 2008 15:30:49 -0700
Message-ID: <1209594649.29759.43.camel__48476.845798041$1209594791$gmane$org@localhost.localdomain>
References: <20080424064756.643890130@us.ibm.com>
	<20080424064757.526468716@us.ibm.com>
	<1209590905.29759.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1209590905.29759.38.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Oren Laadan <orenl@cs.columbia.edu>, Linux Containers <containers@lists.linux-foundation.org>, Cedric Le Goater <clg@fr.ibm.com>, Paul Menage <menage@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


On Wed, 2008-04-30 at 14:28 -0700, Matt Helsley wrote:
> On Wed, 2008-04-23 at 23:47 -0700, Matt Helsley wrote:
> 
> <snip>

> > +	cgroup_lock();
> > +
> > +	if (cgroup_is_removed(cgroup)) {
> > +		retval = -ENODEV;
> > +		goto unlock;
> > +	}
> 
> I think this was copy/paste'd from cgroup_common_file_write() which
> modifies the cgroup hierarchy. However this function does not modify the
> cgroup hierarchy and we're not getting the cgroup from the task. So I
> don't think cgroup_lock()/unlock() are needed here. Paul, do you agree?

Oops! I didn't track the call chain correctly. Sorry for the noise...

Cheers,
	-Matt Helsley
