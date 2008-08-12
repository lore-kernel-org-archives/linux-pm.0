From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/5] Container Freezer v6: Reuse Suspend
	Freezer
Date: Tue, 12 Aug 2008 15:44:29 -0700
Message-ID: <20080812154429.c5377bd0.akpm__35314.9349372417$1218581291$gmane$org@linux-foundation.org>
References: <20080811235323.872291138@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080811235323.872291138@us.ibm.com>
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
Cc: containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, menage@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Aug 2008 16:53:23 -0700
Matt Helsley <matthltc@us.ibm.com> wrote:

> This patch series introduces a cgroup subsystem that utilizes the swsusp
> freezer to freeze a group of tasks. It's immediately useful for batch job
> management scripts. It should also be useful in the future for implementing
> container checkpoint/restart.

I don't think that this provides anything like sufficient detail to justify
merging a whole bunch of stuff into Linux.

What does "It's immediately useful for batch job management scripts."
mean?  How is it useful?  Examples?  Why would an operator want this
feature, and how would it be used?  _much_ more information is needed!

Once we've actually found out what this work is useful for, we can move
onto identification of and discussion of alternatives.  One would be "why not
use plain old SIGSTOP?"  Another alternative is, of course "that's not useful
enough to justify merging the code".  But we don't know yet, coz you didn't
tell us.
