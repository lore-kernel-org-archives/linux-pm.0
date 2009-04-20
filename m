From: fanderay <fanderay4@googlemail.com>
Subject: Re: Resume after suspend-to-ram broken for Vaio SR19VN
	in 30rc2
Date: Mon, 20 Apr 2009 23:11:15 +0100
Message-ID: <31c940650904201511l45e32bfbn8c30955c7b81962d@mail.gmail.com>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
	<200904202253.54768.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904202253.54768.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 20, 2009 at 9:53 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> I have a Vaio SR19VN (Radeon HD 3400 video) and resume after
>> suspend-to-ram fails with 2.6.30rc2/x86_64. =A0I have been testing with
>> the s2ram tool using the approach described at
>> http://en.opensuse.org/S2ram. =A0None of the s2ram options changes the
>> behavior, which is that the system freezes hard while attempting to
>> resume (screen stays off/black) and must be physically powered down.
>> The caps-lock test fails, which suggests this is more than just a
>> video problem. =A0Suspend/resume actually did work with the stock Debian
>> lenny kernel (2.6.26/amd64). =A0The kernel config is pasted at
>> http://pastebin.com/mb4dd790. =A0Any idea what might be wrong?
>
> Have you tried to suspend after booting with init=3D/bin/bash ?
> You'll need to mount /sys and /proc manually before the suspend for it to=
 work.
>
> Also it might be worth checking if anything changes with the fglrx binary
> driver.

Thanks, Rafael.  Yes, all my tests were run by booting with
init=3D/bin/bash and conducted at the console, so no X.  So it seems
like something quite low-level is broken.

> Thanks,
> Rafael
