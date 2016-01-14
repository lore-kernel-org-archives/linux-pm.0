From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/3] cpuidle,menu: use interactivity_req to disable
 polling
Date: Thu, 14 Jan 2016 10:40:44 +0000
Message-ID: <56977B2C.4070600@arm.com>
References: <1446590059-18897-1-git-send-email-riel@redhat.com>
 <CAPKp9ubg3V0979dGTGi+kjXGiBczCG2+QBGgfrZBKjMgSuhy-A@mail.gmail.com>
 <CAJZ5v0ipLZ3o_f_bZ=ddhvx=_OrGwzZq0bbzo7tSNbu_JDJd1Q@mail.gmail.com>
 <3835535.S7ikxthAoE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45254 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777AbcANKks (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jan 2016 05:40:48 -0500
In-Reply-To: <3835535.S7ikxthAoE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, riel@redhat.com, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, arjan@linux.intel.com, Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>



On 13/01/16 22:07, Rafael J. Wysocki wrote:
> On Wednesday, January 13, 2016 10:58:13 PM Rafael J. Wysocki wrote:

[..]

>
> So I'm wondering if the appended patch helps by any chance?
>

Yes it does fix. As you mentioned earlier, CPUIDLE_DRIVER_STATE_START is
0 on ARM platforms and hence data->last_state_idx ended up as -1.

You can add by Tested-by when you push this change. Thanks for the quick
fix.

-- 
Regards,
Sudeep
