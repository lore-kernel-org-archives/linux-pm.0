Return-Path: <SRS0=2C7a=TB=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BECC43219
	for <linux-pm@archiver.kernel.org>; Wed,  1 May 2019 10:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380DB21734
	for <linux-pm@archiver.kernel.org>; Wed,  1 May 2019 10:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfEAKST (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 1 May 2019 06:18:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46775 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAKST (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:18:19 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 515db55704da5067; Wed, 1 May 2019 12:18:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>, Yue Hu <zbestahu@gmail.com>
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: Remove cpufreq_driver check in cpufreq_boost_supported()
Date:   Wed, 01 May 2019 12:18:17 +0200
Message-ID: <2576768.1BJXybHEBs@kreacher>
In-Reply-To: <20190409041759.gyqax5owzhh7owlp@vireshk-i7>
References: <20190409022536.6164-1-zbestahu@gmail.com> <20190409041759.gyqax5owzhh7owlp@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, April 9, 2019 6:17:59 AM CEST Viresh Kumar wrote:
> On 09-04-19, 10:25, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently there are three calling paths for cpufreq_boost_supported() in
> > all as below, we can see the cpufreq_driver null check is needless since
> > it is already checked before.
> > 
> > <path1>
> >   cpufreq_enable_boost_support()
> >     |-> if (!cpufreq_driver)
> >     |-> cpufreq_boost_supported()
> > 
> > <path2>
> >   cpufreq_register_driver()
> >     |-> if (!driver_data ...
> >     |-> cpufreq_driver = driver_data
> >     |-> cpufreq_boost_supported()
> >     |-> remove_boost_sysfs_file()
> >           |-> cpufreq_boost_supported()
> > 
> > <path3>
> >   cpufreq_unregister_driver()
> >     |-> if (!cpufreq_driver ...
> >     |-> remove_boost_sysfs_file()
> >           |-> cpufreq_boost_supported()
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e109227..d9123de 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2426,7 +2426,7 @@ int cpufreq_boost_trigger_state(int state)
> >  
> >  static bool cpufreq_boost_supported(void)
> >  {
> > -	return likely(cpufreq_driver) && cpufreq_driver->set_boost;
> > +	return cpufreq_driver->set_boost;
> >  }
> >  
> >  static int create_boost_sysfs_file(void)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!



