From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH 15/26] cpu_cooling: do error handling at the bottom in
 __cpufreq_cooling_register()
Date: Tue, 2 Dec 2014 15:45:48 +0000
Message-ID: <20141202154547.GC2834@e104805>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <01711a86da59f30b33e1c32aa29cc9b378d0c627.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48382 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbaLBPpx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 10:45:53 -0500
In-Reply-To: <01711a86da59f30b33e1c32aa29cc9b378d0c627.1417167599.git.viresh.kumar@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>

On Fri, Nov 28, 2014 at 09:44:09AM +0000, Viresh Kumar wrote:
> This makes life easy and bug free. And is scalable for future resource
> allocations.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Yay!  We have a similar fix as part of our patches for the power
allocator governor (the only difference is that the instead of calling
the label "remove_idr", we call it "release_idr").  So quite happy to
see this going in.  FWIW,

Acked-by: Javi Merino <javi.merino@arm.com>

