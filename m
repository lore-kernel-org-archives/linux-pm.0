From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 0/6] Container Freezer: Reuse Suspend Freezer
Date: Thu, 31 Jul 2008 22:16:56 -0700
Message-ID: <1217567816.25300.197.camel__44129.817284602$1217568560$gmane$org@localhost.localdomain>
References: <20080801050659.924495279@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080801050659.924495279@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Paul Menage <menage@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


On Thu, 2008-07-31 at 22:06 -0700, Matt Helsley wrote:
> This patch series introduces a cgroup subsystem that utilizes the swsusp
> freezer to freeze a group of tasks. It's immediately useful for batch job
> management scripts. It should also be useful in the future for implementing
> container checkpoint/restart.

<snip>

> Andrew, since I hear Rafael doesn't have time to review these (again) at this
> time, please consider these patches for -mm.

	Argh -- that "(again)" is ripe for misinterpretation! Rafael has
reviewed and commented on these patches often in the past but, from what
I hear, lacks the time to do so now. Hence I'm sending these to -mm.

	Sorry about the wording Rafael.

Cheers,
	-Matt Helsley
