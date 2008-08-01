From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] Container Freezer: Reuse Suspend Freezer
Date: Fri, 1 Aug 2008 15:04:02 +0200
Message-ID: <200808011504.03251.rjw__47309.757260564$1217596142$gmane$org@sisk.pl>
References: <20080801050659.924495279@us.ibm.com>
	<1217567816.25300.197.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1217567816.25300.197.camel@localhost.localdomain>
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Paul Menage <menage@google.com>
List-Id: linux-pm@vger.kernel.org

On Friday, 1 of August 2008, Matt Helsley wrote:
> 
> On Thu, 2008-07-31 at 22:06 -0700, Matt Helsley wrote:
> > This patch series introduces a cgroup subsystem that utilizes the swsusp
> > freezer to freeze a group of tasks. It's immediately useful for batch job
> > management scripts. It should also be useful in the future for implementing
> > container checkpoint/restart.
> 
> <snip>
> 
> > Andrew, since I hear Rafael doesn't have time to review these (again) at this
> > time, please consider these patches for -mm.
> 
> 	Argh -- that "(again)" is ripe for misinterpretation! Rafael has
> reviewed and commented on these patches often in the past but, from what
> I hear, lacks the time to do so now. Hence I'm sending these to -mm.
> 
> 	Sorry about the wording Rafael.

No problem.

If there are not too many new regressions reported today, I'll have a look at
the patches in the evening.

Thanks,
Rafael
