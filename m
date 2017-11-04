From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH v2 2/2] PM / QoS: Fix device resume latency framework
Date: Sat, 4 Nov 2017 12:58:27 +0100
Message-ID: <CAJZ5v0j+_JSynHx8ajqJ0FqCf8ZijwpU=xTnPtEGiR9Tik9srQ@mail.gmail.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2520927.XkLgALY3I0@aspire.rjw.lan>
 <36826935.bDl2WuZxgq@aspire.rjw.lan> <aea02edb-b112-18db-6de5-f10e9a43846d@intel.com>
 <20171104022806.GA29203@intel.com> <CAJZ5v0ht+sNoOsxutX5gxTsiQd9_ETZBBPN=2BL_SHgwVNSnoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ht+sNoOsxutX5gxTsiQd9_ETZBBPN=2BL_SHgwVNSnoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ramesh Thomas <ramesh.thomas@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Alex Shi <alex.shi@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Nov 4, 2017 at 12:30 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sat, Nov 4, 2017 at 3:28 AM, Ramesh Thomas <ramesh.thomas@intel.com> wrote:
>> On 2017-11-03 at 09:39:08 -0700, Reinette Chatre wrote:
>>> Hi Rafael,
>>>
>>> I started to test this but found myself triggering one of the warnings:
>>>
>>> On 11/3/2017 4:50 AM, Rafael J. Wysocki wrote:
>>> > --- linux-pm.orig/include/linux/pm_qos.h
>>> > +++ linux-pm/include/linux/pm_qos.h
>>> > @@ -28,16 +28,19 @@ enum pm_qos_flags_status {
>>> >     PM_QOS_FLAGS_ALL,
>>> >  };
>>> >
>>> > -#define PM_QOS_DEFAULT_VALUE -1
>>> > +#define PM_QOS_DEFAULT_VALUE       (-1)
>>>
>>> PM_QOS_DEFAULT_VALUE is -1 ...
>>>
>>>
>>> > ===================================================================
>>> > --- linux-pm.orig/drivers/base/power/qos.c
>>> > +++ linux-pm/drivers/base/power/qos.c
>>> > @@ -139,6 +139,9 @@ static int apply_constraint(struct dev_p
>>> >
>>> >     switch(req->type) {
>>> >     case DEV_PM_QOS_RESUME_LATENCY:
>>> > +           if (WARN_ON(value < 0))
>>> > +                   value = 0;
>>> > +
>>>
>>> ... causing me to hit this WARN_ON because apply_constraint() is called by __dev_pm_qos_remove_request() with the value parameter set to PM_QOS_DEFAULT_VALUE.
>>
>> That value does not get used if action is PM_QOS_REMOVE_REQ. May be just pass
>> 0 or PM_QOS_RESUME_LATENCY_DEFAULT_VALUE everywhere apply_constraint is called
>> with PM_QOS_REMOVE_REQ action.
>
> I think it's better to pass the "no constraint" value as that should
> not reorder it to the top of the list.

Actually, no.  The value is ignored if action is PM_QOS_REMOVE_REQ, so
it is better to simply check the action under the WARN_ON() too.

Thanks,
Rafael
