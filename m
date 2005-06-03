From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: swsusp issues
Date: Fri, 03 Jun 2005 12:01:51 +1000
Message-ID: <1117764111.31082.119.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48085198293431985=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============48085198293431985==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Pavel !

So one problem I was having with my new code is that swsusp "hooks" of
enter_state() early and doesn't go through the "normal" callback
mecanism, thus wasn't calling any of my new callbacks.

In addition, it has its own save/restore_processor_state that do not go
through pm_ops, but instead are arch inlines (and besides, I never found
any use of those for saving/restoring processor state, though I do use
them for other means, the semantics are quite crappy here).

This is all fairly inconsistent.

What about (note: I'm proposing here to do the job, not asking you to do
it) merging at least disk.c into main.c, that is, having swsusp just use
the "normal" infrastructure ?

suspend_prepare() and suspend_finish() are pretty much equivalent to
what disk.c does in (un)prepare_processes(), prepare_devices() and
finish() with the exception of free_some_memory() which is not used in
suspend to ram, and swsusp does this totally bogus SMP tricks (they
really can't work properly, you'll deadlock trying to use them,
really !)

It would be very easy to consolidate all of that in suspend_prepare() an
suspend_finish() (adding the free_some_memory if state is
PM_SUSPEND_DISK), and those have nice error handling.

Then, the "main" implementation does ops->enter(). On swsusp, this enter
sort-of depdends of the "type" of suspend to disk required. Either
"enter" does all the job (PM_DISK_FIRMWARE) which is then totally
equivalent to the core code needs, or it's replaced by a blurb that does
swsusp_suspend, swsusp_write, etc...

Here, we could do two things... Either add some conditionals to the main
code to reproduce that logic (or rather that illogic), or we could
simply unconditionally call ops->enter() and provide a helper function
that the arch can call that does the swsusp_suspend, swsusp_write,
etc... if that is the arch choice to do.

Finally, the whole pm_disk_mode is just disgustingly ugly. Especially
the fact that the user can go muck around and change it. I do not
support any mode but "PM_DISK_PLATFORM" on ppc and I really think that
should be the only implementation. That is, it's up to the platform
provided pm_ops to decide what to  do. Either doing all the work, or
using swsusp_suspend/swsusp_disk and then restart or shutdown or
whatever. This is all platform specific. Here, basically, the genric
code is exposing some x86 crappola.

Ben.



--===============48085198293431985==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48085198293431985==--
