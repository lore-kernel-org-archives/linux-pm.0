From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] workqueue: define mod_scheduled_delayed_work[_on]()
 helpers
Date: Wed, 27 Feb 2013 07:29:49 -0800
Message-ID: <20130227152949.GD22383@htj.dyndns.org>
References: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
 <20130227151036.GC22383@htj.dyndns.org>
 <CAKohponvsL7BsabqkLS6W4EHx1N7=Ua04JwZksztPqwzW2ze=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:52879 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760001Ab3B0P3y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Feb 2013 10:29:54 -0500
Content-Disposition: inline
In-Reply-To: <CAKohponvsL7BsabqkLS6W4EHx1N7=Ua04JwZksztPqwzW2ze=w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, rickard.andersson@stericsson.com, fabio.baltieri@linaro.org

Hello, Viresh.

On Wed, Feb 27, 2013 at 08:44:52PM +0530, Viresh Kumar wrote:
> To keep things aligned probably i should replace schedule_work() with
> queue_work() and use system_wq there too..

Yeah, that probably is more preferable.  There are codes like the
following in kernel and they always irk me.

	if (custom_wq)
		queue_work();
	else
		schedule_work();

It's just silly.

Thanks.

-- 
tejun
