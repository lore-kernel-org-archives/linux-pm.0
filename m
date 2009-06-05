From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 02/04] Driver Core: Add idle and wakeup
	functions
Date: Fri, 5 Jun 2009 12:26:27 +0900
Message-ID: <aec7e5c30906042026u73f6d03dy9357a1527dabccc4__27578.1871671372$1244172448$gmane$org@mail.gmail.com>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<200905282329.09804.rjw@sisk.pl>
	<aec7e5c30905282210h23f0edc0vad4e29dd52c2e99c@mail.gmail.com>
	<200906031105.21977.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906031105.21977.rjw@sisk.pl>
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
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 3, 2009 at 6:05 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Friday 29 May 2009, Magnus Damm wrote:
>> 2009/5/29 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Wednesday 27 May 2009, Magnus Damm wrote:
>> >> From: Magnus Damm <damm@igel.co.jp>
>> >>
>> >> Add platform_device_idle() and platform_device_wakeup()
>> >> and allow architectures to implement their own versions
>> >> of these if CONFIG_HAVE_PLATFORM_IDLE_WAKEUP is set.
>> >>
>> >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> >> ---
>> >>
>> >> =A0Yes, this needs documentation. See [00/04] for now.
>> >>
>> >> =A0arch/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +++
>> >> =A0include/linux/platform_device.h | =A0 =A08 ++++++++
>> >> =A02 files changed, 11 insertions(+)
>> >>
>> >> --- 0002/arch/Kconfig
>> >> +++ work/arch/Kconfig 2009-05-26 12:31:06.000000000 +0900
>> >> @@ -115,3 +115,6 @@ config HAVE_DEFAULT_NO_SPIN_MUTEXES
>> >>
>> >> =A0config HAVE_PLATFORM_DEVICE_ARCHDATA
>> >> =A0 =A0 =A0 bool
>> >> +
>> >> +config HAVE_PLATFORM_DEVICE_IDLE_WAKEUP
>> >
>> > Again, I'm not sure if the new CONFIG_ option is really necessary.
>>
>> At least it could be combined into a single option for platform device
>> runtime pm. So no need to have separate kconfig options for [02/04]
>> and [03/04].
>>
>> We could also drop the #ifdef stuff and go for weak symbols that can
>> be overriden by architecture code.
>
> The weak symbols don't work really AFAICS. =A0People have been replacing =
them
> with alternative things recently.
>
>> I'm open to suggestions. =3D)
>
> Well, that depends on what exactly you want to achieve. :-)

=3D)

I'd like an architecture independent interface upstream that makes it
possible for device drivers to notify the architecture code that they
are idle() and that need wakeup().

In the long term I hope we can share a great deal of runtime PM code
between architectures, but for now we just need some architecture
specific hooks to get started.

The wakeup()/idle() code in this patch is one way to solve it on a
platform device level. Another more generic way would be to add
->enable() and ->disable() callbacks to struct bus_type and introduce
device_enable() and device_disable() that takes struct device and
invokes the bus callbacks if set.

Any thoughts? Does it make sense?

/ magnus
