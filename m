From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: FYI: device_suspend(...) in kernel_power_off().
Date: Sun, 07 Aug 2005 13:46:48 -0600
Message-ID: <m1u0i1wmvr.fsf@ebiederm.dsl.xmission.com>
References: <dny87s6oe9.fsf@magla.zg.iskon.hr>
	<m1r7dk82a4.fsf@ebiederm.dsl.xmission.com>
	<42E8439E.9030103@ribosome.natur.cuni.cz>
	<20050727193911.2cb4df88.akpm@osdl.org>
	<42F121CD.5070903@ribosome.natur.cuni.cz>
	<20050803200514.3ddb8195.akpm@osdl.org>
	<20050805140837.GA5556@localhost>
	<42F52AC5.1060109@ribosome.natur.cuni.cz>
	<m1hde2xy74.fsf@ebiederm.dsl.xmission.com>
	<m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com>
	<20050807190222.GF1024@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70310184907668494=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050807190222.GF1024@openzaurus.ucw.cz> (Pavel Machek's
	message of "Sun, 7 Aug 2005 21:02:23 +0200")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, =?iso-8859-15?q?Martin_MOKREJ=A6?= <mmokrejs@ribosome.natur.cuni.cz>, john@illhostit.com, sjordet@gmail.com, fastboot@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zlatko Calusic <zlatko.calusic@iskon.hr>, Linus Torvalds <torvalds@osdl.org>, =?iso-8859-1?q?Jos=E9_Luis_Domingo_L=F3pez?= <jdomingo@24x7linux.com>, Pavel Machek <pavel@ucw.cz>, ncunningham@cyclades.com, linux-kernel@24x7linux.com
List-Id: linux-pm@vger.kernel.org

--===============70310184907668494==
Content-Type: text/plain; charset=us-ascii

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> There as been a fair amount of consensus that calling
>> device_suspend(...) in the reboot path was inappropriate now, because
>> the device suspend code was too immature.   With this latest
>> piece of evidence it seems to me that introducing device_suspend(...)
>> in kernel_power_off, kernel_halt, kernel_reboot, or kernel_kexec
>> can never be appropriate.
>
> Code is not ready now => it can never be fixed? Thats quite a strange
> conclusion to make.

It seems there is an fundamental incompatibility with ACPI power off.
As best as I can tell the normal case of device_suspend(PMSG_SUSPEND)
works reasonably well in 2.6.x.

>From what I can tell there are some fairly fundamental semantic
differences, on that code path.  The most peculiar problem I tracked
is someone had a machine that would go into power off state and then
wake right back up because of the device_suspend(PMSG_SUSPEND) change.
If acpi power off doesn't expect the hardware to be suspended I don't
see how you can make device_suspend(PMSG_SUSPEND) a default in 2.6.x.

I won't call it impossible to resolve the problems, but the people
doing it must be extremely sensitive to the subtle semantic
differences that exist and the burden of proof for showing things work
better need to be extremely high.  And the developer who reintroduces
it gets to own all of the reboot/halt/power off problems in the stable
tree when it gets merged.

Pavel the fact that you did not articulate a possibility that your
change could have caused most of the problems that were seen with
it is what scares me the most.  The fairly trivial and obvious
problems were not addressed when the patch was merged much less the
subtle ones.  Your initial patch did not even touch all of the code
paths necessary to achieve what it was trying to do.

So yes without a darn good argument as to why it should work.  I will
go with the experimental evidence that it fails miserably and
trivially because of semantic incompatibility and can therefore
never be fixed.

Eric

--===============70310184907668494==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70310184907668494==--
