From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 09/10] cgroup,
	cpuset: don't use ss->pre_attach()
Date: Tue, 15 Nov 2011 01:51:35 +0100
Message-ID: <20111115005131.GK9446__45613.4339016446$1321318314$gmane$org@somewhere>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-10-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320191193-8110-10-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, paul@paulmenage.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 01, 2011 at 04:46:32PM -0700, Tejun Heo wrote:
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

Reviewed-by: Frederic Weisbecker <fweisbec@gmail.com>
