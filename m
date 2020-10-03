Return-Path: <SRS0=E5yJ=DK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E6C41604
	for <linux-pm@archiver.kernel.org>; Sat,  3 Oct 2020 21:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54986206C3
	for <linux-pm@archiver.kernel.org>; Sat,  3 Oct 2020 21:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgJCVuz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 3 Oct 2020 17:50:55 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:40334 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgJCVuz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Oct 2020 17:50:55 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Oct 2020 17:50:55 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 7099F1800CFD7
        for <linux-pm@vger.kernel.org>; Sat,  3 Oct 2020 21:43:12 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 40ABA100E7B43;
        Sat,  3 Oct 2020 21:43:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: son82_5e02d3d271b0
X-Filterd-Recvd-Size: 2434
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat,  3 Oct 2020 21:43:10 +0000 (UTC)
Message-ID: <472008b94f4b20915425db4714fdb505cb0cbe5a.camel@perches.com>
Subject: Re: [PATCH] test_power: add missing newlines when printing
 parameters by sysfs
From:   Joe Perches <joe@perches.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 03 Oct 2020 14:43:09 -0700
In-Reply-To: <20201003212336.5et7erdf6fihqscu@earth.universe>
References: <1599199798-27804-1-git-send-email-wangxiongfeng2@huawei.com>
         <20201003212336.5et7erdf6fihqscu@earth.universe>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2020-10-03 at 23:23 +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Sep 04, 2020 at 02:09:58PM +0800, Xiongfeng Wang wrote:
> > When I cat some module parameters by sysfs, it displays as follows.
> > It's better to add a newline for easy reading.
[]
> > root@syzkaller:~# cd /sys/module/test_power/parameters/
> > root@syzkaller:/sys/module/test_power/parameters# cat ac_online
> > onroot@syzkaller:/sys/module/test_power/parameters# cat battery_present
> > trueroot@syzkaller:/sys/module/test_power/parameters# cat battery_health
> > goodroot@syzkaller:/sys/module/test_power/parameters# cat battery_status
> > dischargingroot@syzkaller:/sys/module/test_power/parameters# cat battery_technology
> > LIONroot@syzkaller:/sys/module/test_power/parameters# cat usb_online
> > onroot@syzkaller:/sys/module/test_power/parameters#
> > 
> > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > ---
> 
> Thanks, queued.
[]
> > diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
[]
> > @@ -353,6 +353,7 @@ static int param_set_ac_online(const char *key, const struct kernel_param *kp)
> >  static int param_get_ac_online(char *buffer, const struct kernel_param *kp)
> >  {
> >  	strcpy(buffer, map_get_key(map_ac_online, ac_online, "unknown"));
> > +	strcat(buffer, "\n");
> >  	return strlen(buffer);
> >  }

All of these would be better as sprintf(buffer, "%s\n", <whatever>)
so the output is scanned just once instead of scanned three times.


