From: Paul Menage <menage@google.com>
Subject: Re: [PATCH 1/1,
	v9] cgroup/freezer: add per freezer duty ratio control
Date: Fri, 25 Feb 2011 09:53:59 -0800
Message-ID: <AANLkTinyhp29X8-atA=0DaHFuthTjVMJgBOitP52gwEX__18770.9442376674$1298656537$gmane$org@mail.gmail.com>
References: <1297807750-28844-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1297807750-28844-2-git-send-email-jacob.jun.pan@linux.intel.com>
	<201102160100.15487.rjw@sisk.pl> <20110215163812.7fa020b5@putvin>
	<20110216032321.GA14893@count0.beaverton.ibm.com>
	<20110224154525.1b463723@jacob-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110224154525.1b463723@jacob-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jacob pan <jacob.jun.pan@linux.intel.com>
Cc: Cedric Le Goater <clg@vnet.ibm.com>, container cgroup <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, LKML <linux-kernel@vger.kernel.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, akpm@linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 24, 2011 at 3:45 PM, jacob pan
<jacob.jun.pan@linux.intel.com> wrote:
> I played with v3 and v4 of the CFS bandwidth patch. When the cpu
> cgroup exceeds its cfs_quota, it does have the same effect as this
> patch in terms of freeze/thaw at given period and allowed runtime. But
> when the cgroup cpu usage is below cfs_quota, it is not throttled.
> Therefore, it cannot reduce wakeups.

How about a userspace daemon that periodically flips the CPU quota for
the cgroup between zero and the group's runnable level? Wouldn't that
achieve what you need pretty easily without having to introduce
additional complexity and threads into the kernel?

Paul
