From: Kevin Hilman <khilman@ti.com>
Subject: Re: [POWER DOMAIN suspend callbacks] Observation.
Date: Wed, 24 Aug 2011 16:38:01 -0700
Message-ID: <874o167546.fsf__1517.75104827738$1314229191$gmane$org@ti.com>
References: <4E53B6FC.8030507@ti.com> <871uwcjbwi.fsf@ti.com>
	<4E549769.2030800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E549769.2030800@ti.com> (Santosh's message of "Wed, 24 Aug 2011
	11:47:13 +0530")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Govindraj R <govindraj.raja@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Santosh <santosh.shilimkar@ti.com> writes:

> On Tuesday 23 August 2011 10:36 PM, Kevin Hilman wrote:
>> Hi Santosh,
>>
>> Santosh<santosh.shilimkar@ti.com>  writes:
>>
>>> Rafael, Kevin,
>>>
>>> On latest kernel( V3.1-rc1+), the subsystem(driver) suspend
>>> callbacks are not getting called because power domain callbcaks
>>> are populated.
>>>
>>> And as per commit 4d27e9dc{PM: Make power domain callbacks take
>>> precedence over subsystem ones}, it's expected bahavior.
>>
>> Correct.
>>
>>> Who is suppose to call the driver suspend callback?
>>
>> If populated, the PM domain callbacks should call the driver callbacks.
>> If there are no PM domain callbacks, then the subsystem (in this case,
>> the platform_bus) should be calling the driver callbacks.
>>
>>> Some drivers/subsystem would have state machine which needs to
>>> be suspended.
>>>
>>> Is the power domain suspend callback, suppose to take care of
>>> it ? If yes, then that seems to be missing for OMAP.
>>
>> Yup, there's a bug.    They're not missing, just misplaced. ;)
>>
>> When adding the noirq callbacks to ensure devices are idled late in
>> suspend by omap_device, I the patch commited mistakenly uses
>> SET_SYSTEM_SLEEP_PM_OPS(), which sets the "normal" suspend/resume
>> handlers and not the noirq handlers.
>>
>> Can you try the patch below?  I only briefly tested it on omap3/n900 so
>> far.
>>
> The patch works like charm.

Thanks, I'll add a tested-by for you.

Kevin
