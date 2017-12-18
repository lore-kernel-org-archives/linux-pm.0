From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM / OPP: list_del_rcu should be used in function
 _remove_list_dev
Date: Mon, 18 Dec 2017 10:32:21 +0100
Message-ID: <20171218093221.GA25991@kroah.com>
References: <20171218083223.26647-1-chunyan.zhang@spreadtrum.com>
 <20171218090747.GB10436@kroah.com>
 <20171218091139.GJ19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758303AbdLRJcT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 04:32:19 -0500
Content-Disposition: inline
In-Reply-To: <20171218091139.GJ19815@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Chunyan Zhang <chunyan.zhang@spreadtrum.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Wang <vincent.wang@spreadtrum.com>, Orson Zhai <orson.zhai@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>

On Mon, Dec 18, 2017 at 02:41:39PM +0530, Viresh Kumar wrote:
> On 18-12-17, 10:07, Greg Kroah-Hartman wrote:
> > On Mon, Dec 18, 2017 at 04:32:23PM +0800, Chunyan Zhang wrote:
> > > From: Vincent Wang <vincent.wang@spreadtrum.com>
> > > 
> > > list_del_rcu() should be used to replace list_del() in the function
> > > _remove_list_dev(), since the opp is a rcu protected pointer.
> > > 
> > > For example, on an ARM big.Little platform of spreadtrum, there are
> > > little cluster, big cluster and gpu using pm_opp. And the opp_table
> > > of big cluster will be removed when big cluster is removed, which
> > > is implemented in the cpufreq driver. Sometimes an issue maybe occur:
> > > 
> > > [  237.647758] c0 Unable to handle kernel paging request at virtual address dead000000000110
> > > [  237.647776] c0 pgd = ffffffc073e78000
> > > [  237.647786] c0 [dead000000000110] *pgd=0000000000000000, *pud=0000000000000000
> > > [  237.647808] c0 Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > > [  237.653535] c0 Modules linked in: sprdwl_ng(O) mtty marlin2_fm mali_kbase(O)
> > > [  237.653569] c0 CPU: 0 PID: 38 Comm: kworker/u12:1 Tainted: G S      W  O    4.4.83+ #1
> > > [  237.653578] c0 Hardware name: Spreadtrum SP9850KHsmt 1h10 Board (DT)
> > > [  237.653594] c0 Workqueue: devfreq_wq devfreq_monitor
> > > [  237.653605] c0 task: ffffffc0babd0d80 task.stack: ffffffc0badbc000
> > > [  237.653619] c0 PC is at _find_device_opp+0x58/0xac
> > > [  237.653629] c0 LR is at dev_pm_opp_find_freq_ceil+0x2c/0xb8
> > > 
> > > [  237.921294] c0 Call trace:
> > > [  237.921425] c0 [<ffffff80085362b0>] _find_device_opp+0x58/0xac
> > > [  237.921437] c0 [<ffffff8008536560>] dev_pm_opp_find_freq_ceil+0x2c/0xb8
> > > [  237.921452] c0 [<ffffff80088760f4>] devfreq_recommended_opp+0x54/0x7c
> > > [  237.921494] c0 [<ffffff8000b6a96c>] kbase_wait_write_flush+0x164/0x358 [mali_kbase]
> > > [  237.921504] c0 [<ffffff800887485c>] update_devfreq+0x8c/0xf8
> > > [  237.921514] c0 [<ffffff80088749e4>] devfreq_monitor+0x34/0x94
> > > [  237.921529] c0 [<ffffff80080bd75c>] process_one_work+0x154/0x458
> > > [  237.921539] c0 [<ffffff80080be428>] worker_thread+0x134/0x4a4
> > > [  237.921551] c0 [<ffffff80080c4bec>] kthread+0xdc/0xf0
> > > [  237.921564] c0 [<ffffff8008085f20>] ret_from_fork+0x10/0x30
> > > 
> > > Cc: stable <stable@vger.kernel.org>     # 4.4
> > > Signed-off-by: Vincent Wang <vincent.wang@spreadtrum.com>
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> > > ---
> > > 
> > > This patch is only for 4.4 stable branch.
> > > Once this patch accepted, I can cook a similar patch for 4.9 stable branch.
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> 
> Are you worried about this not being merged upstream first ? Or something else ?

Yes, and yes.

> This can't be done to upstream kernel as the OPP code doesn't use RCUs anymore
> and yes, this reason should have been part of the commit message to make things
> clear.

Yes, that too.  But the most basic issue of not cc: stable@vger is also
a problem here :(

This needs a lot of work to go anywhere...

greg k-h
