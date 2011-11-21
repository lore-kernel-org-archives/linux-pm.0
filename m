From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET] cgroup: stable threadgroup during attach
 & subsys methods consolidation
Date: Mon, 21 Nov 2011 14:07:19 -0800
Message-ID: <20111121220719.GP25776__35913.1856159822$1321913256$gmane$org@google.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320191193-8110-1-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paul@paulmenage.org, rjw@sisk.pl, lizf@cn.fujitsu.com
Cc: fweisbec@gmail.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 01, 2011 at 04:46:23PM -0700, Tejun Heo wrote:
> This patchset is combination of the following two patchsets.
> 
>  [1] cgroup: extend threadgroup locking
>  [2] cgroup: introduce cgroup_taskset and consolidate subsys methods, take#2

Li, do you agree with the proposed patches?  If so, I'll wait for
Frederic's response, repost updated series and merge it into the
cgroup tree.

Thank you.

-- 
tejun
