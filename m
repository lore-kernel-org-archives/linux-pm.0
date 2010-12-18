From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 18 Dec 2010 18:00:03 +0200
Message-ID: <AANLkTin23vbbA7+UDzh=v060HbkLMrJjB38cs+AWScPJ__36355.8602672585$1292688087$gmane$org@mail.gmail.com>
References: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
	<Pine.LNX.4.44L0.1012110937100.10743-100000@netrider.rowland.org>
	<AANLkTi=32bqipN5U00La-B7JSgTC1bHgMev=xUSF6kRN@mail.gmail.com>
	<201012181607.26628.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012181607.26628.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 18, 2010 at 5:07 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, December 18, 2010, Ohad Ben-Cohen wrote:
>> On Sat, Dec 11, 2010 at 4:50 PM, Alan Stern <stern@rowland.harvard.edu> =
wrote:
>> >> Think of a device which you have no way to reset other than powering
>> >> it down and up again.
>> >>
>> >> If that device is managed by runtime PM, the only way to do that is by
>> >> using put_sync() followed by a get_sync(). Sure, if someone else
>> >> increased the usage_count of that device this won't work, but then of
>> >> course it means that the driver is not using runtime PM correctly.
>> >
>> > Not so. =A0Even if a driver uses runtime PM correctly, there will still
>> > be times when someone else has increased the usage_count. =A0This happ=
ens
>> > during probing and during system resume, for example.
>>
>> I'm aware of these two examples; normally we're good with them since
>> during probing we're not toggling the power, and during suspend/resume
>> the SDIO core is responsible for manipulating the power (and it does
>> so directly). Are there (or do you think there will be) additional
>> examples where this can happen ?
>>
>> But this leads me to a real problem which we have encountered.
>>
>> During system suspend, our driver is asked (by mac80211's suspend
>> handler) to power off its device. When this happens, the driver has no
>> idea that the system is suspending - regular driver code (responsible
>> to remove the wlan interface and stop the device) is being called.
>
> That's where the problem is. =A0If there's a difference, from the driver's
> point of view, between suspend and some other operation, there should be a
> way to tell the driver what case it actually is dealing with.

Yes, the problem will be solved if the driver would bypass the runtime
PM framework on system suspend. mac80211 obviously has this
information, and technically it's very easy to let the driver know
about it.

But the difference between suspend and normal operation is really
artificial: in both cases mac80211 just asks the driver to power its
device down, and the end result is exactly the same (a GPIO line of
the device is de-asserted in our case). The difference between these
two scenarios
exist only because runtime PM is effectively disabled during system
suspend, and therefore the driver has to look for an alternative way
to power down the device.

> BTW, what would you do in that case if the runtime PM of the device were
> disabled by user space by writing "on" to the device's
> /sys/devices/.../power/control file?

That's a good point.

Blocking runtime PM for this device is fatal since this particular
device has functionality tied up with its power control (no other way
to reset it).

It might call for a device-specific dev_pm_info bit flag to prohibit this...

(Or.. not using runtime PM at all for this device. But that would call
for SDIO bus changes, because there is no other way to power off SDIO
devices in the absence of their drivers. Moreover, the device would
not gain from runtime PM's system integration, e.g. powertop
statistics, etc..)
