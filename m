From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Re: swsusp issues
Date: Sat, 04 Jun 2005 09:25:35 +1000
Message-ID: <1117841135.4766.89.camel@localhost>
References: <1117764111.31082.119.camel@gaston>
	<20050603111541.GC3867@elf.ucw.cz> <1117839029.31082.180.camel@gaston>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36728106580305475=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117839029.31082.180.camel@gaston>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============36728106580305475==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Sat, 2005-06-04 at 08:50, Benjamin Herrenschmidt wrote:
> > PM_DISK_REBOOT is very usefull for testing (and I believe generic; you
> > could do that on ppc too). PM_DISK_SHUTDOWN is usefull for using
> > normal powerdown paths in case something is wrong with disk-specific
> > powerdown. We should move away from it, but please try not to kill it.
> 
> Well, I have a problem with these because they don't call the arch
> prepare/finish callbacks.
> 
> Anyway, I discussed with Patrick yesterday and we came to the conclusion
> that the best is in fact to just kill the current mecanism which was
> done upside down. Kill pm_ops completely and instead of having a slim
> "core" that uses callbacks all over, have the arch contain the main
> state enter function and have the stuff in kernel/power/* be "library"
> functions to be called by the arch code.
> 
> The idea here is then to have the arch provide main.c with an array of
> "name",function pairs (name beeing the name in /sys/power/state and
> function is what to call when the user echo's that name
> to /sys/power/state). The rest would be entirely under arch control, and
> that would remove most of the current cruft.
> 
> To simplify the job for swsusp and avoid the ugly in_suspend thing, we
> should do a slight change of the low level code so that swsusp_suspend()
> returns: 0 -> resume, 1 -> snapshotted, <0 -> error
> 
> We could provide an "example" default implementation that does only
> swsusp that an arch can "drop in" if you want, but archs have to
> implement the various "inline" callbacks anyway (save_processor_state &
> friends).

How could I work with that in an implementation where the vast majority
of the code is arch-independent? I guess I'll have to see what you come
up with.

Regards,

Nigel


--===============36728106580305475==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36728106580305475==--
