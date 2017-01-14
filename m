From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: Re: [PATCH v3 6/7] devicetree: power: bq27xxx: add monitored battery documentation
Date: Fri, 13 Jan 2017 22:07:32 -0800
Message-ID: <CAJ_EiSRnU1q8QPKO43hk3ajS=RaAtQ2tVJ-060GcmPoPA6Ranw@mail.gmail.com>
References: <20170111062003.10110-1-matt@ranostay.consulting>
 <20170111062003.10110-7-matt@ranostay.consulting> <20170113172821.noogiax7bqwhkoev@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170113172821.noogiax7bqwhkoev@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 13, 2017 at 9:28 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jan 10, 2017 at 10:20:02PM -0800, Matt Ranostay wrote:
>> Depends-On: http://marc.info/?l=linux-pm&m=148392292830015&w=2
>> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> index b0c95ef63e68..0472a2db0f13 100644
>> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> @@ -28,9 +28,17 @@ Required properties:
>>   * "ti,bq27621" - BQ27621
>>  - reg: integer, i2c address of the device.
>>
>> +Optional properties:
>> +- monitored-battery: phandle of battery information devicetree node
>
> We need a common way to describe charger/monitor to battery connections,
> not yet another way. The battery and power supply related bindings are a
> bit of a mess from what I've looked at.

Sebastian, your thoughts here?

Thanks,

Matt

>
> Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
