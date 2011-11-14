From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 04/10] cgroup: always lock threadgroup during
	migration
Date: Mon, 14 Nov 2011 19:52:43 +0100
Message-ID: <20111114185242.GF9446@somewhere>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-5-git-send-email-tj@kernel.org>
	<20111114184630.GE9446@somewhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111114184630.GE9446@somewhere>
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

On Mon, Nov 14, 2011 at 07:46:34PM +0100, Frederic Weisbecker wrote:
> I have the feeling the task_lock is now useless given that we are synchronized
> against cgroup_exit() with the threadgroup_lock.
> 
> It's probably also useless in cgroup_exit(). But that's something for a further
> patch...
> 
> Thanks.

Oops, I missed what Kamezawa said and your answer, sorry.
