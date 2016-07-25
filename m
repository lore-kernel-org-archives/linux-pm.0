From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 05/14] PM / doc: update device documentation for devices
 in IRQ safe PM domains
Date: Mon, 25 Jul 2016 17:21:26 -0600
Message-ID: <20160725232125.GC1369@linaro.org>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
 <1466624209-27432-6-git-send-email-lina.iyer@linaro.org>
 <7htwfd49iz.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7htwfd49iz.fsf@baylibre.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 25 2016 at 16:50 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Update documentation to reflect the changes made to support IRQ safe PM
>> domains.
>>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  Documentation/power/devices.txt | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
>> index 8ba6625..a622136 100644
>> --- a/Documentation/power/devices.txt
>> +++ b/Documentation/power/devices.txt
>> @@ -607,7 +607,17 @@ individually.  Instead, a set of devices sharing a power resource can be put
>>  into a low-power state together at the same time by turning off the shared
>>  power resource.  Of course, they also need to be put into the full-power state
>>  together, by turning the shared power resource on.  A set of devices with this
>> -property is often referred to as a power domain.
>> +property is often referred to as a power domain. A power domain may also be
>> +nested inside another power domain.
>> +
>> +Devices, by default, operate in process context. If a device can operate in
>
>minor nit: By "devices" here, I think you mean the runtime PM callbacks for
>devices?  If so, it should be explicit, otherwise it's not clear what it
>means for devices to operate in process context.
>
You are right. Its runtime PM that is of interest here.

Thanks,
Lina
