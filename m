From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] PM / OPP: discard duplicate OPP additions
Date: Tue, 13 May 2014 11:30:13 +0100
Message-ID: <CAPKp9uZbz3M1Xyu7SnSFEexzUPxPqFTSmd7zmU8jU5-Dwu4gvA@mail.gmail.com>
References: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
	<CAKohpo=6qXer+RRS-F6x=O1VLzbWq+_a-b29MaUzZBvt7XzDwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=6qXer+RRS-F6x=O1VLzbWq+_a-b29MaUzZBvt7XzDwQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "[Chander Kashyap" <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, May 13, 2014 at 9:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 13 May 2014 13:11, [Chander Kashyap <chander.kashyap@linaro.org> wrote:
>
> What happened to your name ? "["
>
>> From: Chander Kashyap <k.chander@samsung.com>
>>
>> It may be possible to unregister and re-register the cpufreq driver.
>> One such example is arm big-little IKS cpufreq driver. While
>> re-registering the driver, same OPPs may get added again.
>>
>> This patch detects the duplicacy and discards them.
>>
>> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
>> Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
>> ---
>>  drivers/base/power/opp.c |   28 +++++++++++++++++++---------
>>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> I wouldn't say that this approach is particularly bad or wrong, but what
> about this instead?
>

Yes I prefer this and this exactly what I had[1] in my OPP DT series which
we could not conclude on the bindings. You also need patch[2] for DT version.

Regards,
Sudeep

[1] http://www.spinics.net/lists/cpufreq/msg07914.html
[2] http://www.spinics.net/lists/cpufreq/msg07916.html
