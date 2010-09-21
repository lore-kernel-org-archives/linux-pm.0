From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: 2.6.36-rc4-git5: Reported regressions from 2.6.35
Date: Tue, 21 Sep 2010 00:05:15 -0400
Message-ID: <AANLkTikNm90F6rpi7u=XUOG-Ga6F0+h=bFwkC-sKaO4j__15821.8933306218$1285041989$gmane$org@mail.gmail.com>
References: <1fwtoy8sG5H.A.veG.9D7lMB@chimera>
	<AANLkTinLR0Js0ueVOGEkbs27d4FEH14c=1wuhUqPsiHx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinLR0Js0ueVOGEkbs27d4FEH14c=1wuhUqPsiHx@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: sedat.dilek@gmail.com
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Linux ACPI <linux-acpi@vger.kernel.org>, harn-solo@gmx.de, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 20, 2010 at 3:19 PM, Sedat Dilek <sedat.dilek@googlemail.com> w=
rote:
> Hi Rafael,
>
> can you please add the following, Thanks in advance.
>> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D188=
72
>> Subject =A0 =A0 =A0 =A0 : Radeon KMS r100 and STR problems
>> Submitter =A0 =A0 =A0 : Richard Mittendorfer <delist@gmx.net>
>> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-09-17 18:26 (4 days old)
>> Message-ID =A0 =A0 =A0: <20100917202647.aa4b6300.delist@gmx.net>
>> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D128474802=
809779&w=3D2
>
> On Mon, Sep 20, 2010 at 8:47 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> This message contains a list of some regressions from 2.6.35,
>> for which there are no fixes in the mainline known to the tracking team.
>> If any of them have been fixed already, please let us know.
>>
>> If you know of any other unresolved regressions from 2.6.35, please let =
us
>> know either and we'll add them to the list. =A0Also, please let us know
>> if any of the entries below are invalid.
>>
>> Each entry from the list will be sent additionally in an automatic reply
>> to this message with CCs to the people involved in reporting and handling
>> the issue.
>>
>>
>> Listed regressions statistics:
>>
>> =A0Date =A0 =A0 =A0 =A0 =A0Total =A0Pending =A0Unresolved
>> =A0----------------------------------------
>> =A02010-09-20 =A0 =A0 =A0 38 =A0 =A0 =A0 15 =A0 =A0 =A0 =A0 =A015
>> =A02010-09-12 =A0 =A0 =A0 28 =A0 =A0 =A0 14 =A0 =A0 =A0 =A0 =A013
>> =A02010-08-30 =A0 =A0 =A0 21 =A0 =A0 =A0 16 =A0 =A0 =A0 =A0 =A015
>>
>>
>> Unresolved regressions
>
> Hi Rafael,
>
> can you please add the following Bug, Thanks in advance.
>
> Bug-Entry =A0 =A0 =A0 : https://bugzilla.kernel.org/show_bug.cgi?id=3D161=
40
> Subject =A0 =A0 =A0 =A0 : Suspend To RAM/ Resume broken - Radeon KMS on R=
V250
> Submitter =A0 =A0 =A0 : Michael Long <harn-solo@gmx.de>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-06 09:52
> Message-ID =A0 =A0 =A0: ???
> References =A0 =A0 =A0: ???
>
> What is with "Regression: =A0 =A0 =A0 No" in the BR? Change?

This isn't a regression as according to your bug report, s/r has never
worked on your board with kms.  The kms and ums drm components are
completely different drivers even though they are compiled into the
same binary.

Alex

>
> Regards,
> - Sedat -
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
