From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression,
	2.6.36-rc1] ath9k resume problem on Acer Ferrari One
Date: Thu, 19 Aug 2010 22:31:01 +0200
Message-ID: <201008192231.01722.rjw__42979.2838906453$1282250020$gmane$org@sisk.pl>
References: <201008190001.11342.rjw@sisk.pl> <201008191605.08053.rjw@sisk.pl>
	<4C6D3D5C.7010504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C6D3D5C.7010504@kernel.org>
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
Cc: ath9k-devel@venema.h4ckr.net, Luis Rodriguez <lrodriguez@atheros.com>, linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 19, 2010, Tejun Heo wrote:
> Hello,
> 
> On 08/19/2010 04:05 PM, Rafael J. Wysocki wrote:
> > On Thursday, August 19, 2010, Tejun Heo wrote:
> >> Hello, Rafael.
> >>
> >> On 08/19/2010 12:01 AM, Rafael J. Wysocki wrote:
> >>> While testing 2.6.36-rc1 (with a couple of fixes on top) I noticed
> >>> that the ath9k driver didn't work after resume from suspend to RAM.
> >>> An attempt to unload the driver using rmmod caused the BUG_ON() in
> >>> kernel/workqueue.c:2844 to trigger.
> >>
> >> That BUG_ON() triggers if destroy_workqueue() is called while work
> >> items are still pending on the workqueue.  Can you please trigger
> >> stack traces after resume and post it?
> > 
> > Do you mean sysrq-t?
> 
> Yeah, I'm a bit confused regarding what's going on.  I thought the
> most likely cause is thawing failing to kick a frozen workqueue into
> working state but then flush_workqueue() which is called from
> destroy_workqueue() should have hung too, that is, unless
> flush_workqueue() is broken too.  If flush_workqueue() is not broken,
> then it could be that workqueue itself isn't at fault and works are
> being scheduled and executed fine for the workqueue ath9k is using but
> the driver doesn't work for another reason.
> 
> Also, the BUG_ON() being triggered means either flush_workqueue() is
> broken or the driver is failing to stop works on the workqueue from
> being requeued before calling destroy_workqueue().  So, finding out
> the followings would be great,
> 
> * While the driver isn't working, do a sysrq-t and see whether any
>   worker is executing a work for ath9k.
> 
> * Repeat it several times and see whether the work is stuck or making
>   progress and/or executing on different workers.

Actaully, I'm unable to reproduce the resume issue with current mainline
(HEAD = 763008c4357b73c8d18396dfd8d79dc58fa3f99d), so I guess it either is
a race (or another timing issue), or it's been fixed by one of the patches on
top of -rc1.

I'll let you know if I see it again.

Thanks,
Rafael
