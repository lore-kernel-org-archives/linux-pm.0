From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp issues
Date: Fri, 3 Jun 2005 13:15:41 +0200
Message-ID: <20050603111541.GC3867@elf.ucw.cz>
References: <1117764111.31082.119.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============28418876193148868=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117764111.31082.119.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============28418876193148868==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> So one problem I was having with my new code is that swsusp "hooks" of
> enter_state() early and doesn't go through the "normal" callback
> mecanism, thus wasn't calling any of my new callbacks.
> 
> In addition, it has its own save/restore_processor_state that do not go
> through pm_ops, but instead are arch inlines (and besides, I never found
> any use of those for saving/restoring processor state, though I do use
> them for other means, the semantics are quite crappy here).

Well, i386 definitely uses them for saving some 'less important' cpu
registers.

> This is all fairly inconsistent.
> 
> What about (note: I'm proposing here to do the job, not asking you to do
> it) merging at least disk.c into main.c, that is, having swsusp just use
> the "normal" infrastructure ?

Merging disk.c and main.c is certainly good idea, I never know which
one to look in, anyway.

> suspend_prepare() and suspend_finish() are pretty much equivalent to
> what disk.c does in (un)prepare_processes(), prepare_devices() and
> finish() with the exception of free_some_memory() which is not used in
> suspend to ram, and swsusp does this totally bogus SMP tricks (they
> really can't work properly, you'll deadlock trying to use them,
> really !)

Those smp tricks... see my development tree at
www.kernel.org/...git/pavel/work.git. We actually use cpu hotplug
infrastructure and it should work ok.

> Then, the "main" implementation does ops->enter(). On swsusp, this enter
> sort-of depdends of the "type" of suspend to disk required. Either
> "enter" does all the job (PM_DISK_FIRMWARE) which is then totally
> equivalent to the core code needs, or it's replaced by a blurb that does
> swsusp_suspend, swsusp_write, etc...

PM_DISK_FIRMWARE can be safely removed. See feature-removal*,
DISK_FIRMWARE is S4BIOS.

> Finally, the whole pm_disk_mode is just disgustingly ugly. Especially
> the fact that the user can go muck around and change it. I do not
> support any mode but "PM_DISK_PLATFORM" on ppc and I really think that
> should be the only implementation. That is, it's up to the platform
> provided pm_ops to decide what to  do. Either doing all the work, or
> using swsusp_suspend/swsusp_disk and then restart or shutdown or
> whatever. This is all platform specific. Here, basically, the genric
> code is exposing some x86 crappola.

PM_DISK_REBOOT is very usefull for testing (and I believe generic; you
could do that on ppc too). PM_DISK_SHUTDOWN is usefull for using
normal powerdown paths in case something is wrong with disk-specific
powerdown. We should move away from it, but please try not to kill it.

								Pavel

--===============28418876193148868==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============28418876193148868==--
