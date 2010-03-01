From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Mon, 1 Mar 2010 21:48:21 +0100
Message-ID: <201003012148.21171.rjw@sisk.pl>
References: <4B86F96A.1010306@maroy.hu> <201002271908.58333.rjw@sisk.pl>
	<4B8B70DD.7000208@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B8B70DD.7000208@maroy.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?iso-8859-1?q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 01 March 2010, =C1kos Mar=F3y wrote:
> Rafael,
> =

> > You can actually do that with the in-kernel hibernate too.
> > =

> > Please read Documentation/power/basic-pm-debugging.txt, there are more
> > hibernate debugging hints in there.
> =

> thanks for the tip. I tried the various levels of hibernation, and the
> freezer mode works, while the devices mode fails the same as the
> 'normal' hibernation.
> =

> as the only point forward in the documentation is to do a binary search
> on the kernel modules by unloading them before the test, I'll have to
> find the time to do this. this is also quite complicated because of how
> modules depend on each other.

Well, you can try to boot the kernel with no_console_suspend and
initcall_debug in the command line, echo 8 to /proc/sys/kernel/printk and
repeat the failing "devices" test.

With a bit of luck, you'll be able to see which driver is failing from the
kernel messages printed to the console.

Rafael
