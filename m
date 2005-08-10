From: Pavel Machek <pavel@ucw.cz>
Subject: Re: FYI: device_suspend(...) in kernel_power_off().
Date: Wed, 10 Aug 2005 15:08:03 +0200
Message-ID: <20050810130803.GA2004@elf.ucw.cz>
References: <42F121CD.5070903@ribosome.natur.cuni.cz>
	<20050803200514.3ddb8195.akpm@osdl.org>
	<20050805140837.GA5556@localhost>
	<42F52AC5.1060109@ribosome.natur.cuni.cz>
	<m1hde2xy74.fsf@ebiederm.dsl.xmission.com>
	<m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com>
	<20050807190222.GF1024@openzaurus.ucw.cz>
	<m1u0i1wmvr.fsf@ebiederm.dsl.xmission.com>
	<20050807211104.GE3100@elf.ucw.cz>
	<m1pssnvx84.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6418427163212479=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m1pssnvx84.fsf@ebiederm.dsl.xmission.com>
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

--===============6418427163212479==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> >> > Code is not ready now => it can never be fixed? Thats quite a strange
> >> > conclusion to make.
> >> 
> >> It seems there is an fundamental incompatibility with ACPI power off.
> >> As best as I can tell the normal case of device_suspend(PMSG_SUSPEND)
> >> works reasonably well in 2.6.x.
> >
> > Powerdown is going to have the same problems as the powerdown at the
> > end of suspend-to-disk. Can you ask people reporting broken shutdown
> > to try suspend-to-disk?
> 
> Everyone I know of who is affected has been copied on this thread.
> However your request is just nonsense.  There is a device_resume in
> the code before we get to the device_shutdown so there should be no
> effect at all.  Are we looking at the same kernel?

Sorry, my fault. kernel/power/disk.c:power_down(): it calls
device_shutdown even in PM_DISK_PLATFORM case. I thought it would do
device_suspend() to enable drivers doing something more clever.

So only missing piece of puzzle seems to be making sure disks are
properly spinned down in device_shutdown... and even that seems to be
there, not sure why it was broken before.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============6418427163212479==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============6418427163212479==--
