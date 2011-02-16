From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1,
 v9] cgroup/freezer: add per freezer duty ratio control
Date: Wed, 16 Feb 2011 10:18:05 -0800
Message-ID: <20110216101805.5ef41bf6__42613.6144706563$1297928150$gmane$org@putvin>
References: <1297807750-28844-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1297807750-28844-2-git-send-email-jacob.jun.pan@linux.intel.com>
	<201102160100.15487.rjw@sisk.pl> <20110215163812.7fa020b5@putvin>
	<20110216032321.GA14893@count0.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110216032321.GA14893@count0.beaverton.ibm.com>
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
Cc: Cedric Le Goater <clg@vnet.ibm.com>, container cgroup <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Paul Menage <menage@google.com>, Arjan van de Ven <arjan@linux.intel.com>, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Feb 2011 19:23:21 -0800
Matt Helsley <matthltc@us.ibm.com> wrote:

> On Tue, Feb 15, 2011 at 04:38:12PM -0800, Jacob Pan wrote:
> > On Wed, 16 Feb 2011 01:00:15 +0100
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> <snip>
> 
> > > Well, quite frankly, I'm not going to take this patch unless it
> > > gets an ACK from the scheduler people (which I'm guessing is not
> > > going to happen before hell freezes over).
> > > 
> > > IOW, please find a better way to address the issue at hand.
> > > 
> > We do have a real need that there is no exist feature in the kernel
> > can provide solution for. You want ACK from scheduler people
> > because it has impact on disabling irq? or you think scheduler
> > should be the one that provide the solution. I did try cpu
> > subsystem, but it seems to be limited to RT and certain scheduling
> > policy e.g. RR and FIFO.
> 
> I agree with Rafael. I think the scheduler should provide the solution
> and it can be done via modifications to the cpu cgroup subsystem. 
> Yes, it only has the shares and rt-related files *right now*. However,
> Kame replied earlier with a link to some patches for extending it
> that introduce files with similar (granted: not the same) semantics:
> 
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2010-10/msg04335.html
> 
> I think you could build on that and help push those patches towards
> mainline along with your enhancements for reducing wakeups rather
> than modify the freezer cgroup subsystem.
>
I will give CFS bandwidth control patches a try. See if I can be any
help. Thanks.

Jacob
