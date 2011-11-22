From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: 3.2-rc2+: Reported regressions from 3.0 and 3.1
Date: Mon, 21 Nov 2011 23:16:25 -0800
Message-ID: <CALCETrXP63VYU6mvxuUJKq7uJ-a3LG6c4t6asQFGUsJnrP6_ow__21272.4696299576$1322500052$gmane$org@mail.gmail.com>
References: <lx6sezwGldO.A.IhF.UBpWOB@chimera> <201111212249.31196.rjw@sisk.pl>
	<CA+55aFwAELQieN=qR7Gz_MT5rHPp90H10uTMS+DOJjefk7q3ng@mail.gmail.com>
	<CALCETrUpXrsjBLZsZU3u+y7KCDO0LW55QoBQkBqN_BPFZHsrkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrUpXrsjBLZsZU3u+y7KCDO0LW55QoBQkBqN_BPFZHsrkw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2011 at 2:34 PM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
> On Mon, Nov 21, 2011 at 2:11 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Mon, Nov 21, 2011 at 1:49 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>
>>> Subject =A0 =A0: [3.1 REGRESSION] Commit 5cec93c216db77c45f7ce970d46283=
bcb1933884 breaks the Chromium seccomp sandbox
>>> Submitter =A0: Nix <nix@esperi.org.uk>
>>> Date =A0 =A0 =A0 : 2011-11-14 0:40
>>> Message-ID : 8762inleno.fsf@spindle.srvr.nix
>>> References : http://marc.info/?l=3Dlinux-kernel&m=3D132123396226377&w=
=3D2
>>

This is apparently fixed in seccompsandbox.  See:

https://code.google.com/p/seccompsandbox/issues/detail?id=3D17
https://code.google.com/p/seccompsandbox/source/detail?r=3D178

Unless someone objects, I'll consider this to not be a kernel
regression worth fixing.

--Andy
