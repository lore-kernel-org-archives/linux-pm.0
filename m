From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 5/6] cgroup,
	cpuset: don't use ss->pre_attach()
Date: Fri, 26 Aug 2011 13:19:21 +0900
Message-ID: <20110826131921.b643491a.kamezawa.hiroyu__19476.157698273$1314333365$gmane$org@jp.fujitsu.com>
References: <1314312192-26885-1-git-send-email-tj@kernel.org>
	<1314312192-26885-6-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314312192-26885-6-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: fweisbec@gmail.com, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On Fri, 26 Aug 2011 00:43:11 +0200
Tejun Heo <tj@kernel.org> wrote:

> ->pre_attach() is supposed to be called before migration, which is
> observed during process migration but task migration does it the other
> way around.  The only ->pre_attach() user is cpuset which can do the
> same operaitons in ->can_attach().  Collapse cpuset_pre_attach() into
> cpuset_can_attach().
> 
> -v2: Patch contamination from later patch removed.  Spotted by Paul
>      Menage.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: Paul Menage <paul@paulmenage.org>
> Cc: Li Zefan <lizf@cn.fujitsu.com>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
