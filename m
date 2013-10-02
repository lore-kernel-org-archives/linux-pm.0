From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: make return type of lock_policy_rwsem_{read|write}()
 as void
Date: Wed, 2 Oct 2013 22:19:18 +0530
Message-ID: <CAKohpok2iwwhZbAZuawW-Ow4ofbGZpUj6Jn7A-F8C42yQ=rA7Q@mail.gmail.com>
References: <075032be4fd288074b8f699d4f4ba0179518df6f.1379344038.git.viresh.kumar@linaro.org>
	<2382588.IckWbq3JRN@vostro.rjw.lan>
	<CAKohpomoqp0dtS+TG-Johsh=o6VefeqByD0bM_DLXg+qYhQ5+g@mail.gmail.com>
	<1472934.KdmdpVCX1h@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1472934.KdmdpVCX1h@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jon Medhurst <tixy@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 2 October 2013 22:08, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, October 02, 2013 02:13:36 PM Viresh Kumar wrote:
>> On 30 September 2013 23:58, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Monday, September 16, 2013 08:40:17 PM Viresh Kumar wrote:
>> >> lock_policy_rwsem_{read|write}() currently has return type of int but it always
>> >> return zero and hence its return type must be void instead. This patch makes its
>> >> return type void and fixes all users of it as well.
>> >>
>> >> Reported-by: Jon Medhurst<tixy@linaro.org>
>> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >
>> > This doesn't apply to bleeding-edge for me any more after I have applied your
>> > series of 44 patches to it.  Care to resend?
>>
>> Done..
>
> Which one is it?
>

 [PATCH RESEND 01/11] cpufreq: make return type of
lock_policy_rwsem_{read|write}() as void
