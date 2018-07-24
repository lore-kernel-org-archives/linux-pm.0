From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: linux-next-20180723: battery status funny after bootup
Date: Tue, 24 Jul 2018 11:21:20 +0200
Message-ID: <CAJZ5v0g0b2ucGEn3+hhEgw4FVJP4oV1D+99a3jTNjq4av_qsDg@mail.gmail.com>
References: <20180723214917.GA3733@amd> <CAJZ5v0g=Ey6ZiyjA3NWS_C5zXBUydJNaKOZDbRNFYUGEc8YuaQ@mail.gmail.com>
 <20180724091226.GB22465@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724091226.GB22465@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lucas.magasweran@ieee.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 24, 2018 at 11:12 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2018-07-24 10:27:08, Rafael J. Wysocki wrote:
>> On Mon, Jul 23, 2018 at 11:49 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> >
>> > pavel@amd:~$ cat /proc/acpi/battery/BAT0/state
>> > present:                 yes
>> > capacity state:          ok
>> > charging state:          charged
>> > present rate:            0 mW
>> > remaining capacity:      0 mWh
>> > present voltage:         0 mV
>> > pavel@amd:~$ uname -a
>> > Linux amd 4.18.0-rc6-next-20180723+ #141 SMP Mon Jul 23 22:11:47 CEST
>> > 2018 i686 GNU/Linux
>> >
>> > It will correct itself if I unplug/replug the AC adapter, I
>> > believe. Gnome2 battery monitor also looks confused.
>>
>> There are two battery changes in linux-next now that are not present
>> in the mainline
>>
>> 2a2aad34362b ACPI: battery: remove redundant old_present check on insertion
>> 706ac4aa536f ACPI: battery: use cache_time as cache "enabled"
>>
>> Does reverting any of them help?  Or is the problem present in the
>> mainline too?
>
> Thanks for pointers! Not it mainline, I'd notice that.
>
> I reverted 706ac4aa536f , and on the next boot:
>
> pavel@amd:~$ cat /proc/acpi/battery/BAT0/state
> present:                 yes
> capacity state:          ok
> charging state:          charged
> present rate:            0 mW
> remaining capacity:      37150 mWh
> present voltage:         16400 mV
>
> ..plus icon was ok from the start.

OK, I'll drop 706ac4aa536f then, thanks!
