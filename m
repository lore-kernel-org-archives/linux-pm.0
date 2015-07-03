From: "SungEun Kim(cleaneye.kim@lge.com)" <cleaneye.kim@lge.com>
Subject: Re: Re: [PATCH v2] PM / Sleep: Use workqueue for user space wakeup
 sources garbage collector
Date: Fri, 3 Jul 2015 14:03:05 +0900
Message-ID: <55961789.5090709@lge.com>
References: <1435718938-19088-1-git-send-email-cleaneye.kim@lge.com>
 <1435739328-17021-1-git-send-email-cleaneye.kim@lge.com>
 <1544571.4tSqBEqESU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544571.4tSqBEqESU@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2015-07-03 =EC=98=A4=EC=A0=84 9:15, Rafael J. Wysocki wrote:
> On Wednesday, July 01, 2015 05:28:48 PM SungEun Kim wrote:
>> From: "SungEun Kim" <cleaneye.kim@lge.com>
>>
>> The synchronous synchronize_rcu in wakeup_source_remove makes user
> process
>> which writes to /sys/kernel/wake_unlock blocked sometimes.
>>
>> For example, when android eventhub tries to release wakelock,
>> this blocking process can occur, and eventhub can't get input event
>> for a while.
>>
>> Using workqueue instead of direct function call at pm_wake_unlock
>> can prevent this unnecessary delay of an user space process.
>=20
> The idea is defendable, but the patch is too simple.
>=20
> For example, if the garbage collection is in progress, it is not usef=
ul
> to start a new one.
>=20
> Also the incrementation and clearing of wakelocks_gc_count should be =
under
> the lock.

Thank you for your advices.
I will correct and amend my patch and then submit v3 patch.

Thank you.
SungEun Kim

>=20
>=20
> --=20
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
