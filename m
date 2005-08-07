From: Pavel Machek <pavel@suse.cz>
Subject: Re: FYI: device_suspend(...) in kernel_power_off().
Date: Sun, 7 Aug 2005 21:02:23 +0200
Message-ID: <20050807190222.GF1024@openzaurus.ucw.cz>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79524925369827026=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m13bplykt3.fsf_-_@ebiederm.dsl.xmission.com>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Martin =?iso-8859-2?Q?MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>, john@illhostit.com, sjordet@gmail.com, fastboot@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zlatko Calusic <zlatko.calusic@iskon.hr>, Linus Torvalds <torvalds@osdl.org>, =?iso-8859-2?Q?Jos=E9_Luis_Domingo_L=F3pez?= <jdomingo@24x7linux.com>, Pavel Machek <pavel@ucw.cz>, ncunningham@cyclades.com, linux-kernel@24x7linux.com
List-Id: linux-pm@vger.kernel.org

--===============79524925369827026==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> There as been a fair amount of consensus that calling
> device_suspend(...) in the reboot path was inappropriate now, because
> the device suspend code was too immature.   With this latest
> piece of evidence it seems to me that introducing device_suspend(...)
> in kernel_power_off, kernel_halt, kernel_reboot, or kernel_kexec
> can never be appropriate.

Code is not ready now => it can never be fixed? Thats quite a strange
conclusion to make.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============79524925369827026==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79524925369827026==--
