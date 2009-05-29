From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 01/04] Driver Core: Add platform device arch
	data
Date: Fri, 29 May 2009 14:07:35 +0900
Message-ID: <aec7e5c30905282207v5fe17e6aj5a6382aa30d1774f__43902.4083469578$1243573728$gmane$org@mail.gmail.com>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<20090527100633.29671.83531.sendpatchset@rx1.opensource.se>
	<200905282326.57431.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905282326.57431.rjw@sisk.pl>
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
>> Allow architecture specific data in struct platform_device.
>> Platform device data is needed by the runtime pm code. A similar
>> struct already exists for struct device.
>>
>> The architecture specific asm/device.h file needs to provide
>> struct pdev_archdata if CONFIG_HAVE_PLATFORM_DEVICE_DATA is set.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> ---
>>
>> =A0Optionally we can make use of struct device archdata instead,
>> =A0but since the runtime device pm is limited to platform devices
>> =A0it makes sense to make this data platform device specific imo.
>>
>> =A0arch/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +++
>> =A0include/linux/platform_device.h | =A0 =A05 +++++
>> =A02 files changed, 8 insertions(+)
>>
>> --- 0001/arch/Kconfig
>> +++ work/arch/Kconfig 2009-05-15 14:51:35.000000000 +0900
>> @@ -112,3 +112,6 @@ config HAVE_DMA_API_DEBUG
>>
>> =A0config HAVE_DEFAULT_NO_SPIN_MUTEXES
>> =A0 =A0 =A0 bool
>> +
>> +config HAVE_PLATFORM_DEVICE_ARCHDATA
>
> Hmm. =A0Do we really need yet another CONFIG_ option for that?

I don't think we need a total of 3 different config options for the
platform device pm stuff, but I do think it makes sense to handle the
platform archdata separately. Not sure which is the best way though,
the #ifdefery is not very pretty. Maybe the best solution is just to
drop the Kconfig stuff and add empty structures to all architecture
versions of asm/device.h.

Any suggestions?

Thanks!

/ magnus
