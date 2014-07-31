From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v4 3/5] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
Date: Thu, 31 Jul 2014 16:48:00 -0700
Message-ID: <53DAD5B0.3070500@codeaurora.org>
References: <1406250448-470-1-git-send-email-skannan@codeaurora.org>
 <1406250448-470-4-git-send-email-skannan@codeaurora.org>
 <3141717.0s1tLjazMZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3141717.0s1tLjazMZ@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Srivatsa S . Bhat" <srivatsa@mit.edu>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 07/31/2014 02:56 PM, Rafael J. Wysocki wrote:
> On Thursday, July 24, 2014 06:07:26 PM Saravana Kannan wrote:
>> This patch simplifies a lot of the hotplug/suspend code by not
>> adding/removing/moving the policy/sysfs/kobj during hotplug and just leaves
>> the cpufreq directory and policy in place irrespective of whether the CPUs
>> are ONLINE/OFFLINE.
>
> I'm still quite unsure how this is going to work with the real CPU hot-remove
> that makes the entire sysfs cpu directories go away.  Can you please explain
> that?

Sure. Not a problem. I just wanted to make sure you had a chance to look 
at the code first.

Physical hot-remove triggers a "remove" for all the  registered 
subsys_interfaces for that CPU (after going through a couple of 
functions). So, when that happens, the cpufreq subsys_interface remove 
for that CPU gets called. At that point, I clean up that CPU's SW states 
as if it was never plugged in from the start. If that CPU was the owner 
of the sysfs directory, I move it over to a different CPU.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
