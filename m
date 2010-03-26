From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [C/R v20][PATCH 15/96] cgroup freezer: Fix buggy
	resume test for tasks frozen with cgroup freezer
Date: Fri, 26 Mar 2010 23:53:26 +0100
Message-ID: <201003262353.26181.rjw__25065.2816532694$1269643879$gmane$org@sisk.pl>
References: <1268842164-5590-1-git-send-email-orenl@cs.columbia.edu>
	<201003230028.40915.rjw@sisk.pl> <4BA8E659.1030702@cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BA8E659.1030702@cs.columbia.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oren Laadan <orenl@cs.columbia.edu>
Cc: Paul Menage <menage@google.com>, Cedric Le Goater <legoater@free.fr>, linux-api@vger.kernel.org, containers@lists.linux-foundation.org, Li Zefan <lizf@cn.fujitsu.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@lists.linux-foundation.org, Serge Hallyn <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 March 2010, Oren Laadan wrote:
> 
> Rafael J. Wysocki wrote:
> > On Wednesday 17 March 2010, Oren Laadan wrote:
> >> From: Matt Helsley <matthltc@us.ibm.com>
> >>
> >> When the cgroup freezer is used to freeze tasks we do not want to thaw
> >> those tasks during resume. Currently we test the cgroup freezer
> >> state of the resuming tasks to see if the cgroup is FROZEN.  If so
> >> then we don't thaw the task. However, the FREEZING state also indicates
> >> that the task should remain frozen.
> >>
> >> This also avoids a problem pointed out by Oren Ladaan: the freezer state
> >> transition from FREEZING to FROZEN is updated lazily when userspace reads
> >> or writes the freezer.state file in the cgroup filesystem. This means that
> >> resume will thaw tasks in cgroups which should be in the FROZEN state if
> >> there is no read/write of the freezer.state file to trigger this
> >> transition before suspend.
> >>
> >> NOTE: Another "simple" solution would be to always update the cgroup
> >> freezer state during resume. However it's a bad choice for several reasons:
> >> Updating the cgroup freezer state is somewhat expensive because it requires
> >> walking all the tasks in the cgroup and checking if they are each frozen.
> >> Worse, this could easily make resume run in N^2 time where N is the number
> >> of tasks in the cgroup. Finally, updating the freezer state from this code
> >> path requires trickier locking because of the way locks must be ordered.
> >>
> >> Instead of updating the freezer state we rely on the fact that lazy
> >> updates only manage the transition from FREEZING to FROZEN. We know that
> >> a cgroup with the FREEZING state may actually be FROZEN so test for that
> >> state too. This makes sense in the resume path even for partially-frozen
> >> cgroups -- those that really are FREEZING but not FROZEN.
> >>
> >> Reported-by: Oren Ladaan <orenl@cs.columbia.edu>
> >> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> >> Cc: Cedric Le Goater <legoater@free.fr>
> >> Cc: Paul Menage <menage@google.com>
> >> Cc: Li Zefan <lizf@cn.fujitsu.com>
> >> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> >> Cc: Pavel Machek <pavel@ucw.cz>
> >> Cc: linux-pm@lists.linux-foundation.org
> > 
> > Looks reasonable.
> > 
> > Is anyone handling that already or do you want me to take it to my tree?
> 
> Yes, please do.

Applied.

Rafael
