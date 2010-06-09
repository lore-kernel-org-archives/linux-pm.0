From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: 2.6.35-rc2-git2: Reported regressions from 2.6.34
Date: Tue, 08 Jun 2010 23:26:09 -0300
Message-ID: <4C0EFBC1.5090401__36067.9118698046$1276050476$gmane$org@redhat.com>
References: <Rlf_Qjov7bG.A.a8F.I8rDMB@chimera>
	<alpine.LFD.2.00.1006081814240.4506@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006081814240.4506@i5.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Venkatesh Pallipadi <venki@google.com>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jens Axboe <jaxboe@fusionio.com>, Linux PM List <linux-pm@lists.linux-foundation.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, Carl Worth <cworth@cworth.org>, =?ISO-8859-15?Q?David_H=E4rdeman?= <david@hardeman.nu>, Network Development <netdev@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Kernel Testers List <kernel-testers@vger.kernel.org>, Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Em 08-06-2010 22:53, Linus Torvalds escreveu:

> =

>> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=3D16037
>> Subject	: NULL Pointer dereference in __ir_input_register/budget_ci_atta=
ch
>> Submitter	: Sean Finney <seanius@debian.org>
>> Date		: 2010-05-23 19:52 (17 days old)
> =

> Perhaps related to commit 13c24497086418010bf4f76378bcae241d7f59cd?
> =

> David H=E4rdeman, Mauro Carvalho Chehab added to cc.

This patch probably solves the issue:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=3D84b14f181a36eea6591779156ef356f8d198bbfd

The patch were already applied upstream. I've already asked the reporter to=
 test it, via BZ.

Cheers,
Mauro
