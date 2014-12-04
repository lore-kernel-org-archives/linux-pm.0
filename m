From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH V2 06/26] thermal: cpu_cooling: fix doc comment over
 struct cpufreq_cooling_device
Date: Thu, 4 Dec 2014 10:32:14 +0000
Message-ID: <20141204103213.GB22781@e104805>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
 <65fe28eb30ff75ec96c29f85c0822eecf23879bf.1417664938.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39631 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbaLDKcT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 05:32:19 -0500
In-Reply-To: <65fe28eb30ff75ec96c29f85c0822eecf23879bf.1417664938.git.viresh.kumar@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "amit.daniel@samsung.com" <amit.daniel@samsung.com>

On Thu, Dec 04, 2014 at 04:11:48AM +0000, Viresh Kumar wrote:
> cooling_cpufreq_lock isn't used to protect this structure and so the comment
> over it is outdated. Fix it.

Instead of deleting this comment, move it to where it belongs.  From
my understanding, the cooling_cpufreq_lock protects the
cpufreq_dev_list.  Can you move the comment there?

Cheers,
Javi

