From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: High power consumption after suspend/resume cycle
Date: Fri, 2 Oct 2009 15:29:24 -0400
Message-ID: <cb0375e10910021229x7924ec56o61627ec0f625a70c__12545.5629583032$1254762755$gmane$org@mail.gmail.com>
References: <cb0375e10910021044n182d696dy8fd566925e46b134@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <cb0375e10910021044n182d696dy8fd566925e46b134@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

[Adding cc's to linux-pm and linux-acpi and ]

On Fri, Oct 2, 2009 at 1:44 PM, Andrew Lutomirski <luto@mit.edu> wrote:
> Hi all-
>
> I'm running a git kernel that's slightly newer than 2.6.32-rc1.
>
> First, thanks for all the great work everywhere on laptop power
> consumption -- on my Lenovo X200s, it looks like Linux is getting
> close to Windows (Windows wins by about 0.7W, except that its power
> usage frequently spikes since Windows apparently still doesn't know
> how to sit still and do nothing, whereas Linux's seems more stable.),
> even running KDE with compositing enabled and
> while connected to wifi, at least after some tweaking.

[fixed irrelevant typo above, too.]

>
> There's a catch, though: after a suspend/resume cycle, power
> consumption goes up by over well over a watt. =A0(On a system that draws
> about 7 watts before suspending, that's a big deal.) =A0I've tried
> turning off X, suspending with 'echo mem > /sys/power/state' to avoid
> any distro scripts running, and manually restoring SATA power saving
> settings, but it still happens. =A0I even tried unbinding e1000e and
> both USB drivers, unloading the i2400 (wimax) driver, iwlagn, and
> iwlcore, and it still happens. =A0This is 100% reproducible, and I'd be
> happy to test things.
>
> This could be a BIOS bug I suppose (although I'm running the latest
> BIOS), but Windows 7 does not have this problem at all.
>
> Any ideas about what to try or what subsystem to blame?
>
> I'm running Fedora 11 if that makes any difference.

This is actually more like 90% reproducible.  I've gotten it to stay
in low power after suspend a couple times with HAL disabled, but I
can't reliably reproduce *that*, either.

>
> Thanks,
> Andy
>
