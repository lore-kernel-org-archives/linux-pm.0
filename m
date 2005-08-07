From: Pavel Machek <pavel@ucw.cz>
Subject: Re: FYI: device_suspend(...) in kernel_power_off().
Date: Sun, 7 Aug 2005 23:11:04 +0200
Message-ID: <20050807211104.GE3100@elf.ucw.cz>
References: <42E8439E.9030103@ribosome.natur.cuni.cz>
	<20050727193911.2cb4df88.akpm@osdl.org>
	<42F121CD.5070903@ribosome.natur.cuni.cz>
	<20050803200514.3ddb8195.akpm@osdl.org>
	<20050805140837.GA5556@localhost>
	<42F52AC5.1060109@ribosome.natur.cuni.cz>
	<m1hde2xy74.fsf@ebiederm.dsl.xmission.com>
	<m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com>
	<20050807190222.GF1024@openzaurus.ucw.cz>
	<m1u0i1wmvr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============92665871661308641=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m1u0i1wmvr.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Martin =?utf-8?Q?MOKREJ=C5=A0?= <mmokrejs@ribosome.natur.cuni.cz>, john@illhostit.com, sjordet@gmail.com, fastboot@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zlatko Calusic <zlatko.calusic@iskon.hr>, Linus Torvalds <torvalds@osdl.org>, =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= <jdomingo@24x7linux.com>, ncunningham@cyclades.com, linux-kernel@24x7linux.com
List-Id: linux-pm@vger.kernel.org

--===============92665871661308641==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> >> There as been a fair amount of consensus that calling
> >> device_suspend(...) in the reboot path was inappropriate now, because
> >> the device suspend code was too immature.   With this latest
> >> piece of evidence it seems to me that introducing device_suspend(...)
> >> in kernel_power_off, kernel_halt, kernel_reboot, or kernel_kexec
> >> can never be appropriate.
> >
> > Code is not ready now => it can never be fixed? Thats quite a strange
> > conclusion to make.
> 
> It seems there is an fundamental incompatibility with ACPI power off.
> As best as I can tell the normal case of device_suspend(PMSG_SUSPEND)
> works reasonably well in 2.6.x.

Powerdown is going to have the same problems as the powerdown at the
end of suspend-to-disk. Can you ask people reporting broken shutdown
to try suspend-to-disk?

> >From what I can tell there are some fairly fundamental semantic
> differences, on that code path.  The most peculiar problem I tracked
> is someone had a machine that would go into power off state and then
> wake right back up because of the device_suspend(PMSG_SUSPEND)
> change.

So something is wrong with ACPI wakeup GPEs. It would hurt in
suspend-to-disk case, too.

> I won't call it impossible to resolve the problems, but the people

Good.

> So yes without a darn good argument as to why it should work.  I will
> go with the experimental evidence that it fails miserably and
> trivially because of semantic incompatibility and can therefore
> never be fixed.

I do not think any "semantic" issues exist. We need to pass detailed
info down to the drivers that care, and we need to fix all the bugs in
the drivers. That should be pretty much it.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============92665871661308641==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============92665871661308641==--
