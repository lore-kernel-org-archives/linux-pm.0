From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 07:11:02 -0800
Message-ID: <AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2__9716.74594698033$1295709174$gmane$org@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
	<AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com>
	<201101221110.17786.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101221110.17786.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jeff Chua <jeff.chua.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 22, 2011 at 2:10 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> I have a theory, which is that on failing runs your system doesn't even t=
ry
> to enter S3 and it's trying to enter a bogus S1 instead.

Hmm. I can certainly believe in the "BIOS is confused" idea, but I
don't see where that gets us.

> The reason why I think so is that the "Back to C!" message is not present=
 in
> the failing log

It's not present in the good logs either.

> A couple of things may be done to verify this. =A0First, before suspendin=
g for
> the first time after a reboot, you can check if there's "standby" in
> /sys/power/state (it shouldn't be there, because your "good" dmesg says S1
> isn't supported).

No, just "mem".

>=A0Second, after a failing run that was revived by a key press
> you can check if there's S1 instead of S3 in the "ACPI: Preparing to enter
> system sleep state ..." message.

Nope, all log messages say S3.

>=A0Finally, which I suspect is the case, it is
> possible that we don't even try to enter S1, but something confuses the B=
IOS
> which thinks it should go into S1 although it's told to go into S3.

Now this I can believe in.

> Now, if the BIOS is confused, I have no idea what may be the reason, but I
> think it would be good to rule out the change from ioremap() to
> ioremap_cache() in ACPI (as I said before, it's sufficient to modify
> include/linux/acpi_io.h for this purpose so that ioremap() is called by
> acpi_os_ioremap() - unless you have done that already in which case sorry=
 for
> the noise).

Tried it. First boot was fine, second boot had the "press key to make
suspend continue" problem on the first suspend, and then (as
apparently always happens after that half-suspend) locked up
completely on the second.

Oh well.

                   Linus
