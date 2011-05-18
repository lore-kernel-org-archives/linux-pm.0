From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v2 3/3] PM / DEVFREQ: add sysfs interface
	(including user tickling)
Date: Wed, 18 May 2011 09:43:08 +0900
Message-ID: <BANLkTin+sJeg20BXbOfe7TyDhuDWZqqMMQ__48164.2965497032$1305679462$gmane$org@mail.gmail.com>
References: <1305100723-29161-1-git-send-email-myungjoo.ham@samsung.com>
	<20110511225540.GA3492@suse.de>
	<BANLkTik__9G-DuSsT_kAc69d+5g8xcVyFg@mail.gmail.com>
	<201105180041.57723.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105180041.57723.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, May 18, 2011 at 7:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, May 17, 2011, MyungJoo Ham wrote:
>> On Thu, May 12, 2011 at 7:55 AM, Greg KH <gregkh@suse.de> wrote:
>> > On Wed, May 11, 2011 at 04:58:43PM +0900, MyungJoo Ham wrote:
>> >> 1. System-wide sysfs interface
>> >> - tickle_all =A0R: number of tickle_all execution
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 W: tickle all devfreq devices
>> >> - min_interval =A0 =A0 =A0 =A0R: devfreq monitoring base interval in =
ms
>> >> - monitoring =A0R: shows whether devfreq monitoring is active or
>> >> =A0 not.
>> >>
>> >> 2. Device specific sysfs interface
>> >> - tickle =A0 =A0 =A0R: number of tickle execution for the device
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 W: tickle the device
>> >
>> > Any sysfs file change/addition/removal needs to have a
>> > Documentation/ABI/ entry as well. =A0Please add that to this patch ins=
tead
>> > of burying it in the changelog entry, where no one will be able to find
>> > it in the future.
>> >
>> > thanks,
>> >
>> > greg k-h
>> >
>>
>> Sure, I'll add Documentation/ABI/testing/* entries.
>>
>> However, would it be appropriate for "1. System-wide sysfs interface"
>> to be in "sysfs-class-power" and for "2. Device specific sysfs
>> interface" to be in "sysfs-devices-devfreq"?
>>
>> System-wide sysfs interface is in /sys/class/power/devfreq/* and
>
> Hmm. =A0Why not to use /sys/power/ that's already there?

Ah.. that was my mistake. I'd put it at /sys/power/devfreq/*.

Thank you for cleaning that up.

>
>> Device specific sysfs interface is in /sys/...DEVICE.../devfreq/* .
>
> Thanks,
> Rafael
>

Cheers!
- MyungJoo
-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
