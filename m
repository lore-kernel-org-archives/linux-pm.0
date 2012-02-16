From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: Corrupted files after suspend to disk
Date: Thu, 16 Feb 2012 11:52:27 +0100
Message-ID: <CAFLxGvzzHDRma_Y_XEpOD+fY+vonbkoR1mvQp4Vb4c3M6fTsPA@mail.gmail.com>
References: <AANLkTinRC1hXvaXDVV5pOA4YyCdXwAjziZsDzm=LuHqK@mail.gmail.com>
	<AANLkTinewk=mJZifVxEJkCtKfNauOjHnLAqwbGn139C=@mail.gmail.com>
	<AANLkTikui_HQ5JMcMJUqMr9WLyTRNzF-z4G7wAUNPOFy@mail.gmail.com>
	<201103242330.14416.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103242330.14416.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 24, 2011 at 11:30 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, March 24, 2011, richard -rw- weinberger wrote:
>> On Thu, Mar 24, 2011 at 11:16 AM, richard -rw- weinberger
>> <richard.weinberger@gmail.com> wrote:
>> > On Thu, Mar 24, 2011 at 12:00 AM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
>> >> On Wednesday, March 23, 2011, richard -rw- weinberger wrote:
>> >>> On Wed, Mar 23, 2011 at 11:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wr=
ote:
>> >>> > On Wednesday, March 23, 2011, richard -rw- weinberger wrote:
>> >>> >> On Wed, Mar 23, 2011 at 11:11 PM, Rafael J. Wysocki <rjw@sisk.pl>=
 wrote:
>> >>> >> > On Wednesday, March 23, 2011, richard -rw- weinberger wrote:
>> >>> >> >> 2011/3/23 Rafael J. Wysocki <rjw@sisk.pl>:
>> >>> >> >> > On Wednesday, March 23, 2011, richard -rw- weinberger wrote:
>> >>> >> >> >> Hi,
>> >>> >> >> >>
>> >>> >> >> >> I'm facing a very strange problem on my netbook (Lenovo Ide=
apad S10)
>> >>> >> >> >> running Linux 2.6.37.4.
>> >>> >> >> >> After resuming from s2disk some files are corrupted.
>> >>> >> >> >> But when I reboot my netbook everything seems good again.
>> >>> >> >> >>
>> >>> >> >> >> When I saw the problem the first time the ls command segfau=
lted always.
>> >>> >> >> >> I did a reboot and it worked again.
>> >>> >> >> >>
>> >>> >> >> >> A few days later zypper crashed. After a reboot it worked a=
gain.
>> >>> >> >> >> And today ssh crashed. I looked a bit closer and saw it cra=
shed
>> >>> >> >> >> somewhere within libcrypto.
>> >>> >> >> >> So I made copy libcrypto and rebooted.
>> >>> >> >> >> After the reboot ssh worked again but libcrypto and the cop=
y of it hat
>> >>> >> >> >> a different sha1 sum!
>> >>> >> >> >> WTF?!
>> >>> >> >> >>
>> >>> >> >> >> Is this a known issue?
>> >>> >> >> >
>> >>> >> >> > No.
>> >>> >> >> >
>> >>> >> >> >> dmesgs and config are attached.
>> >>> >> >> >>
>> >>> >> >> >> The used distribution is openSUSE 11.4 with suspend-0.80.20=
100129-7.1
>> >>> >> >> >> (default from suse).
>> >>> >> >> >> I'm using ext3 as root filesystem.
>> >>> >> >> >> What else do you need?
>> >>> >> >> >
>> >>> >> >> > Whatever you can do to narrow down the problem. =A0At the mo=
ment I only know
>> >>> >> >> > that it's there.
>> >>> >> >>
>> >>> >> >> I can reproduce the problem now.
>> >>> >> >> After ~20 suspend and resume iterations aide finds corrupted f=
iles in /lib/.
>> >>> >> >> It's always a very basic lib like libcrypto, libglib which is =
used all
>> >>> >> >> the time on my system.
>> >>> >> >
>> >>> >> > Those files are never intentionally modified, right?
>> >>> >> >
>> >>> >> >> Maybe it's an issue like this one?
>> >>> >> >> https://lkml.org/lkml/2010/12/2/339
>> >>> >> >
>> >>> >> > It might have if that patch hadn't been merged before 2.6.37.
>> >>> >> >
>> >>> >> > Is the system 32-bit or 64-bit?
>> >>> >>
>> >>> >> It's a 32-bit system.
>> >>> >> cmp shows that the corrupted files differ in many bytes (not scat=
tered).
>> >>> >> The corrupted bytes are always 0 or 252.
>> >>> >
>> >>> > Do I understand correctly that the files apparently corrupted afte=
r resume
>> >>> > are not corrupted any more when you reboot?
>> >>>
>> >>> Yes.
>> >>> Seems like a cache issue.
>> >>
>> >> There's a couple things you can check before we start asking other pe=
ople for
>> >> help.
>> >>
>> >> First, it would be good to know if things change when you save the im=
age
>> >> into a swap file instead of the swap partition you've been using so f=
ar
>> >> (I believe it's documented quite well how to do that).
>> >>
>> >> Second, please verify if using the built-in save/load hibernate code =
leads
>> >> to the same issue (you can hibernate by doing "echo disk > /sys/power=
/state"
>> >> to verify that).
>> >>
>> >> Of course, please test the above separately. :-)
>> >
>> > Ok, I'll test this when I'm at home.
>> >
>> > BTW: dropping the caches helps, when some files seem corrupted.
>> > Today /usr/bin/okular was broken.
>> > After setting vm.drop_caches=3D1 it worked again.
>> >
>> >> Thanks,
>> >> Rafael
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> >> Please read the FAQ at =A0http://www.tux.org/lkml/
>> >>
>> >
>> > --
>> > Thanks,
>> > //richard
>> >
>>
>> On Linux 2.6.38 I'm unable to reproduce the issue.
>> Only 2.6.37 seems to be affected.
>> So, I'm moving over to 2.6.38. :)
>
> OK, thanks for the report. :-)
>
> Rafael

Bad news:
I saw the issue on 3.x too but thought it's because my IdeaPad s10 is crap.
Now with my shiny new Lenovo x121e I have the same issue! :-(

OpenSUSE 12.1, kernel 3.2.7.
After a few suspend2disk iterations random files are corrupted.
But only cached files. A reboot solves the problem.

-- =

Thanks,
//richard
