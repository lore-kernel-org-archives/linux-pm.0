From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] PM / OPP: list_del_rcu should be used in function _remove_list_dev
Date: Mon, 15 Jan 2018 16:33:20 +0800
Message-ID: <CAAfSe-sjD4i7QWkwQTA7YPkTkjRFgzbO9TvjB4amwS3df8K3rQ@mail.gmail.com>
References: <20171218093738.27960-1-chunyan.zhang@spreadtrum.com>
 <20171218095717.GA12565@kroah.com> <20180115080328.GA23414@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43305 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754652AbeAOIeD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jan 2018 03:34:03 -0500
In-Reply-To: <20180115080328.GA23414@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chunyan Zhang <chunyan.zhang@spreadtrum.com>, Viresh Kumar <viresh.kumar@linaro.org>, stable <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Vincent Wang <vincent.wang@spreadtrum.com>, Orson Zhai <orson.zhai@spreadtrum.com>

On 15 January 2018 at 16:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Dec 18, 2017 at 10:57:17AM +0100, Greg Kroah-Hartman wrote:
>> On Mon, Dec 18, 2017 at 05:37:38PM +0800, Chunyan Zhang wrote:
>> > From: Vincent Wang <vincent.wang@spreadtrum.com>
>> >
>> > list_del_rcu() should be used to replace list_del() in the function
>> > _remove_list_dev(), since the opp is a rcu protected pointer.
>> >
>> > For example, on an ARM big.Little platform of spreadtrum, there are
>> > little cluster, big cluster and gpu using pm_opp. And the opp_table
>> > of big cluster will be removed when big cluster is removed, which
>> > is implemented in the cpufreq driver. Sometimes an issue maybe occur:
>> >
>> >
>> > [  237.647758] c0 Unable to handle kernel paging request at virtual address dead000000000110
>> > [  237.647776] c0 pgd = ffffffc073e78000
>> > [  237.647786] c0 [dead000000000110] *pgd=0000000000000000, *pud=0000000000000000
>> > [  237.647808] c0 Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> > [  237.653535] c0 Modules linked in: sprdwl_ng(O) mtty marlin2_fm mali_kbase(O)
>> > [  237.653569] c0 CPU: 0 PID: 38 Comm: kworker/u12:1 Tainted: G S      W  O    4.4.83+ #1
>> > [  237.653578] c0 Hardware name: Spreadtrum SP9850KHsmt 1h10 Board (DT)
>> > [  237.653594] c0 Workqueue: devfreq_wq devfreq_monitor
>> > [  237.653605] c0 task: ffffffc0babd0d80 task.stack: ffffffc0badbc000
>> > [  237.653619] c0 PC is at _find_device_opp+0x58/0xac
>> > [  237.653629] c0 LR is at dev_pm_opp_find_freq_ceil+0x2c/0xb8
>> >
>> > [  237.921294] c0 Call trace:
>> > [  237.921425] c0 [<ffffff80085362b0>] _find_device_opp+0x58/0xac
>> > [  237.921437] c0 [<ffffff8008536560>] dev_pm_opp_find_freq_ceil+0x2c/0xb8
>> > [  237.921452] c0 [<ffffff80088760f4>] devfreq_recommended_opp+0x54/0x7c
>> > [  237.921494] c0 [<ffffff8000b6a96c>] kbase_wait_write_flush+0x164/0x358 [mali_kbase]
>> > [  237.921504] c0 [<ffffff800887485c>] update_devfreq+0x8c/0xf8
>> > [  237.921514] c0 [<ffffff80088749e4>] devfreq_monitor+0x34/0x94
>> > [  237.921529] c0 [<ffffff80080bd75c>] process_one_work+0x154/0x458
>> > [  237.921539] c0 [<ffffff80080be428>] worker_thread+0x134/0x4a4
>> > [  237.921551] c0 [<ffffff80080c4bec>] kthread+0xdc/0xf0
>> > [  237.921564] c0 [<ffffff8008085f20>] ret_from_fork+0x10/0x30
>> >
>> > Cc: stable <stable@vger.kernel.org>     # 4.4
>> > Signed-off-by: Vincent Wang <vincent.wang@spreadtrum.com>
>> > Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > ---
>> > This patch is for 4.4 stable branch only.
>> > Once this patch accepted, I can cook a similar patch for 4.9 stable branch.
>>
>> I need that one first, as you don't want to regress from a working 4.4
>> release when moving to a 4.9 release, right?
>>
>> > This fix can't be done to upstream kernel as the OPP code doesn't
>> > use RCUs anymore.
>>
>> What was the upstream fix that changed this?  Why is this not a problem
>> in 4.14?  In Linus's tree?
>>
>> I _REALLY_ do not like taking patches that are not in Linus's tree, as
>> when we do that, we almost always get it wrong.  Seriously, our track
>> record here is horrid.
>>
>> So I need a lot of assurance that this is the correct fix, that it has
>> been tested properly, and that there really is no way to take the
>> upstream patches instead of your one-off patch.
>>
>> Also, what commit does this fix?  When did the bug show up?  When did it
>> go away?  Why not include a Fixes: line?
>>
>> See, a lot more work needs to be done here, as I said previously :)
>>
>> Taking patches that are not in Linus's tree is a very expensive, and
>> difficult thing, for good reason.
>
> Now dropped from my queue due to lack of response, if you want this

Ok.

Vincent (the author of this patch)  told me that general cases can
rarely trigger this problem, and also this in fact is not a issue for
the mainline kernel, as the OPP code doesn't use RCUs anymore like
Viresh said above.  So he also agree to not merge this patch for now.

Thanks,
Chunyan

> applied, please address the questions I have above and resend.
>
> thanks,
>
> greg k-h
