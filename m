From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: Corrupted files after suspend to disk
Date: Wed, 23 Mar 2011 22:49:44 +0100
Message-ID: <AANLkTimSyPiaq14yNP-KPxPcUaCqd4xr1xVNhefdK722__45114.7858672359$1300990999$gmane$org@mail.gmail.com>
References: <AANLkTinRC1hXvaXDVV5pOA4YyCdXwAjziZsDzm=LuHqK@mail.gmail.com>
	<201103232136.19091.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103232136.19091.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2011/3/23 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday, March 23, 2011, richard -rw- weinberger wrote:
>> Hi,
>>
>> I'm facing a very strange problem on my netbook (Lenovo Ideapad S10)
>> running Linux 2.6.37.4.
>> After resuming from s2disk some files are corrupted.
>> But when I reboot my netbook everything seems good again.
>>
>> When I saw the problem the first time the ls command segfaulted always.
>> I did a reboot and it worked again.
>>
>> A few days later zypper crashed. After a reboot it worked again.
>> And today ssh crashed. I looked a bit closer and saw it crashed
>> somewhere within libcrypto.
>> So I made copy libcrypto and rebooted.
>> After the reboot ssh worked again but libcrypto and the copy of it hat
>> a different sha1 sum!
>> WTF?!
>>
>> Is this a known issue?
>
> No.
>
>> dmesgs and config are attached.
>>
>> The used distribution is openSUSE 11.4 with suspend-0.80.20100129-7.1
>> (default from suse).
>> I'm using ext3 as root filesystem.
>> What else do you need?
>
> Whatever you can do to narrow down the problem. =A0At the moment I only k=
now
> that it's there.

I can reproduce the problem now.
After ~20 suspend and resume iterations aide finds corrupted files in /lib/.
It's always a very basic lib like libcrypto, libglib which is used all
the time on my system.

Maybe it's an issue like this one?
https://lkml.org/lkml/2010/12/2/339

> Thanks,
> Rafael
>

-- =

Thanks,
//richard
