From: Brendan Jackman <brendan.jackman-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Tue, 16 Aug 2016 09:34:28 +0100
Message-ID: <57B2D014.8000502@arm.com>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
 <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
 <20160811211023.GC1401@linaro.org>
 <697d8ac2-34ee-db3e-940b-5ce3365c5aa1@arm.com>
 <20160815160857.GE1401@linaro.org>
 <2033f384-7ea3-6713-4def-80bf4251fd67@arm.com>
 <20160815224014.GF1401@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160815224014.GF1401-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Axel Haslam <ahaslam+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, Juri Lelli <Juri.Lelli-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 15/08/16 23:40, Lina Iyer wrote:
> On Mon, Aug 15 2016 at 10:14 -0600, Sudeep Holla wrote:
>>
>>
>> On 15/08/16 17:08, Lina Iyer wrote:
>>> On Fri, Aug 12 2016 at 04:08 -0600, Sudeep Holla wrote:
>>>>
>>>>
>>>> On 11/08/16 22:10, Lina Iyer wrote:
>>>>> On Wed, Aug 10 2016 at 12:09 -0600, Sudeep Holla wrote:
>>>>>>
>>>>
>>>> [...]
>>>>
>>>>>> cluster0
>>>>>>   CLUSTER_RET(Retention)
>>>>>>   CLUSTER_PG(Power Gate)
>>>>>>   core0
>>>>>>       CORE_RET
>>>>>>       CORE_PG
>>>>>>   core1
>>>>>>       CORE_RET
>>>>>>       CORE_PG
>>>>>>
>>>>>> cluster1
>>>>>>   CLUSTER_RET
>>>>>>   CLUSTER_PG
>>>>>>   core0
>>>>>>       CORE_RET
>>>>>>       CORE_PG
>>>>>>   core1
>>>>>>       CORE_RET
>>>>>>       CORE_PG
>>>>>>
>>>>>> Platform Co-ordinate supports the following states and we should be
>>>>>> able to determine that from the binding:
>>>>>>
>>>>>> CORE_RET
>>>>>> CORE_PG
>>>>>> CORE_RET + CLUSTER_RET
>>>>>
>>>>> The problem that we have to sove here is knowing that CORE_RET +
>>>>> CLUSTER_PG (hypothetically) an invalid combination. Kevin and
>>>>> I debated it in the earlier RFC and we dont have a good way to solve
>>>>> this generically for all devices.
>>>>>
>>>>
>>>> Yes, I agree it's complex. But that needs to be solved IMO.
>>>>
>>>> I can think of 2 possible solutions:
>>>>
>>>> 1. Index the states(which people have not liked, but as along as we
>>>>  don't use it in the code as it for any other purpose, it should be
>>>>  fine) and then have each state mentioning what parent state can be
>>>>  entered at this child state(i.e. starting index and all states below
>>>>  it)
>>>>
>>> This is how QCOM solved it downstream.
>>>
>>
>> Yes even ACPI has indices to solve this.
>>
>>>> 2. Something similar to (1) but without index instead phandles.
>>>>
>>>
>>> The problem is when you have non-CPU devices in the device tree and
>>> since they do not have a way to represent states like CPU, we did not
>>> have a clear path to that. Hence we punted that to later. Whatever we
>>> do, we should solve it for a generic PM domain, not just CPU domains.
>>>
>>
>> Yes bindings defined here should be applicable for devices to, but only
>> CPU's will have this hierarchy while the devices need not bother about
>> hierarchy. However the parent power domain can ever the state which is
>> least common denominator of all it's children power domain. That's my
>> understanding. No ?
>>

Are you saying that the parent can enter the shallowest idle state that
all its children are in (I.e if all its children are in "retention" then
it can enter "retention")? I don't know what the reality is on existing
platforms but it doesn't sound like 100% safe assumption to make. Also I
don't think you can necessarily correlate idle states at different
domain levels - i.e. here we've matched up the idea of "retention" at
core level with that of "retention" at cluster level. I may have
misunderstood you there..

> That is correct. But say if all the CPUs choose CORE_RET + CLUSTER_PG,
> which is invalid and the firmware has to ignore it and does CORE_RET +
> CLUSTER_RET instead, then Linux may have an inconsistent view of the
> state selection.
>
Perhaps a better starting point would be to go with the assumption that
a parent PD can only enter any idle state once its children are in their
deepest idle states.

That is, we'd miss out on CORE_RET + CLUSTER_RET but have no invalid ones.

Then a later addition to the bindings as discussed above could enable
the possibility of those combinations to be expressed.
> Thanks,
> Lina
>
>> --
>> Regards,
>> Sudeep
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
