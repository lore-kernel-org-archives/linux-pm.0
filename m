From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: [patch] hibernation: utilize ACPI hardware
	signature
Date: Thu, 03 Jan 2008 08:25:41 +1100
Message-ID: <477C0155.70902__48459.9107796841$1199309246$gmane$org@nigel.suspend2.net>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>	<62e5edd40801020208s268aeacbj96481f5a317b8ea7@mail.gmail.com>
	<200801021512.54140.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801021512.54140.rjw@sisk.pl>
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
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, =?ISO-8859-15?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

Rafael J. Wysocki wrote:
> On Wednesday, 2 of January 2008, Erik Andr=E9n wrote:
>> Hi,
>>
>> 2008/1/2, Shaohua Li <shaohua.li@intel.com>:
>>> ACPI defines a hardware signature. BIOS calculates the signature
>>> according to hardware configure, if hardware changes, the signature w=
ill
>>> change, in this case, S4 resume should fail.
>>>
>>> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
>>> ---
>>
>> Would it be possible to extend this mechanism to prevent the following
>> scenario:
>>
>> 1. Linux image A is suspended to disk
>> 2. Linux image B is booted and various changes to the system are done.
>> 3. Linux image B is shut down
>> 4. Linux image A is booted, restoring the suspend to disk image.
>> 5. Chaos is ensured as the file system state is changed in regard to h=
ow
>> linux image A expects it.
>>
>> Correct behaviour would naturally be that image A detects that changes=
 have
>> been made under its feet and proceed to perform a normal boot instead =
of
>> resuming the stored suspend-to-disk image.
>=20
> It should be possible in theory.
>=20
>> Is there another mechanism preventing this?
>=20
> Not at the kernel level, but you can prevent this from happening by run=
ning
> mkswap on all swap spaces that refuse to come up after a fresh boot.

We really should do something about this. It should be possible to
handle this properly if something along the following lines was implement=
ed:

1) Each filesystem implements a function taking a pointer to a struct
block_device and returns a mount count for that filesystem without
making any modifications to the filesystem.
2) Hibernation implementations store the major & minor numbers and mount
counts for each mounted filesystem in the image header when hibernating,
and recheck those values at resume time. If the mount count on any
filesystem has changes, we warn the user, invalidate the image and boot
normally.

Regards,

Nigel
