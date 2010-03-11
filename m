From: =?ISO-8859-1?Q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Subject: Re: suspend works until core pm_test, but the still fails
Date: Thu, 11 Mar 2010 15:18:10 -0600
Message-ID: <4B995E12.6020104@maroy.hu>
References: <4B973F6B.4000709@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B973F6B.4000709@maroy.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

so, nobody would have any pointers on how to move forward with the issue
below?

=C1kos Mar=F3y wrote:
> Hi,
> =

> I'm still trying to make power management work on my HP Envy 15.
> =

> I'm experimenting with unloading as many modules as possible, testing
> the suspend feature using various levels of /sys/power/pm_test
> =

> I managed to get the number of modules as low as these:
> =

> Module                  Size  Used by
> binfmt_misc             7454  1
> bnep                   11287  2
> btusb                  12729  2
> =

> =

> then I was going through these steps;
> =

> echo freezer > /sys/power/pm_test
> echo mem > /sys/power/state
> echo devices > /sys/power/pm_test
> echo mem > /sys/power/state
> echo platform > /sys/power/pm_test
> echo mem > /sys/power/state
> echo processors > /sys/power/pm_test
> echo mem > /sys/power/state
> echo core > /sys/power/pm_test
> echo mem > /sys/power/state
> =

> and all these worked fine - meaning that I got back to the console
> screen. I also ran dmesg, and didn't see anything suspicious.
> =

> but, when I do:
> =

> echo none > /sys/power/pm_test
> echo mem > /sys/power/state
> =

> =

> the machine will still hang :(
> =

> =

> what am I doing wrong?
> =

> this is all on a 2.6.32.9 kernel
> =

> =

> Akos
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
