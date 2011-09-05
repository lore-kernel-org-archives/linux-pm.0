From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHSET cgroup] extend threadgroup locking
Date: Mon, 5 Sep 2011 06:05:57 +0200
Message-ID: <201109050605.57360.rjw__38790.0146925405$1315197431$gmane$org@sisk.pl>
References: <1315159280-25032-1-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1315159280-25032-1-git-send-email-htejun@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@linux-foundation.org, fweisbec@gmail.com, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Sunday, September 04, 2011, Tejun Heo wrote:
> Hello,
> 
> cgroup currently only blocks new threads from joining the target
> threadgroup during migration, and on-going migration could race
> against exec and exit leading to interesting problems - the symmetry
> between various attach methods, task exiting during method execution,
> ->exit() racing against attach methods, migrating task switching basic
> properties during exec and so on.
> 
> This patchset extends threadgroup locking such that it covers all
> operations which can alter the threadgroup - fork, exit and exec, and
> update cgroup to take advantage of it.  rwsem read ops are added to
> exit path but exec is excluded by grabbing the existing
> cred_guard_mutex from threadgroup locking helper.
> 
> This makes threadgroup locking complete and resolves cgroup issues
> stemming from the target taskset being unstable.
> 
> This patchset is on top of the current pm-freezer + "freezer: fixes &
> simplifications" patchset and contains the following four patches.
> Patch list and diffstat follow.

OK

I'm assuming that there will be a branch for me to pull from when
kernel.org starts to work again, right?

Rafael
