From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/5] PM / OPP: extend DT binding to specify phandle
 of another node for OPP
Date: Thu, 3 Oct 2013 09:29:23 -0500
Message-ID: <524D7F43.60102@ti.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1380634382-15609-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <524D65A3.5090906@ti.com> <524D6B83.5030308@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <524D6B83.5030308@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 10/03/2013 08:05 AM, Sudeep KarkadaNagesha wrote:
[...]
>> However, could you squash this to patch #2 -> having implementation
>> and binding together is better for git log history.
>>
> Based on some arguments on the other threads[1] on devicetree list, I thought
> having separate patches for binding and driver changes is preferred. Hence the
> split, I am OK either way.
Thanks for pointing the discussion out.

/me might rant about this ;) -> if someone has a strong opinion about
this, they should probably propose a change to submitting patches
guideline.. Grr..

I leave this to Rafael as to how he'd like this to be squashed/split

> 
> Can I add your ACK/Reviewed-by otherwise ?
> 
> Regards,
> Sudeep
> 
> [1] http://www.spinics.net/lists/devicetree/msg04855.html
> 


-- 
Regards,
Nishanth Menon
