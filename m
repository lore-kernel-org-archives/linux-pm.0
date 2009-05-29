From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 02/04] Driver Core: Add idle and wakeup
	functions
Date: Fri, 29 May 2009 14:10:53 +0900
Message-ID: <aec7e5c30905282210h23f0edc0vad4e29dd52c2e99c__1170.92840741879$1243573907$gmane$org@mail.gmail.com>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<20090527100642.29671.52231.sendpatchset@rx1.opensource.se>
	<200905282329.09804.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905282329.09804.rjw@sisk.pl>
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

2009/5/29 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday 27 May 2009, Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> Add platform_device_idle() and platform_device_wakeup()
>> and allow architectures to implement their own versions
>> of these if CONFIG_HAVE_PLATFORM_IDLE_WAKEUP is set.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> ---
>>
>> =A0Yes, this needs documentation. See [00/04] for now.
>>
>> =A0arch/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +++
>> =A0include/linux/platform_device.h | =A0 =A08 ++++++++
>> =A02 files changed, 11 insertions(+)
>>
>> --- 0002/arch/Kconfig
>> +++ work/arch/Kconfig 2009-05-26 12:31:06.000000000 +0900
>> @@ -115,3 +115,6 @@ config HAVE_DEFAULT_NO_SPIN_MUTEXES
>>
>> =A0config HAVE_PLATFORM_DEVICE_ARCHDATA
>> =A0 =A0 =A0 bool
>> +
>> +config HAVE_PLATFORM_DEVICE_IDLE_WAKEUP
>
> Again, I'm not sure if the new CONFIG_ option is really necessary.

At least it could be combined into a single option for platform device
runtime pm. So no need to have separate kconfig options for [02/04]
and [03/04].

We could also drop the #ifdef stuff and go for weak symbols that can
be overriden by architecture code.

I'm open to suggestions. =3D)

/ magnus
