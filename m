From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Add some hooks to generic suspend code
Date: Wed, 01 Jun 2005 18:34:17 +1000
Message-ID: <1117614857.19020.32.camel@gaston>
References: <1117524577.5826.35.camel@gaston>
	<20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston>
	<20050531212556.GA14968@elf.ucw.cz> <1117582309.5826.60.camel@gaston>
	<20050601081336.GA6693@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2250275116042062=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050601081336.GA6693@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============2250275116042062==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-06-01 at 10:13 +0200, Pavel Machek wrote:
> Hi!
> 
> > > Why do you need it? Do you initiate suspend without userland asking
> > > you to?
> > 
> > Because there is an existing API, via /dev/apm_bios, and that's all X
> > understands ! And because I've always done that ;)
> 
> Try stopping doing that ;-).

Certainly not short-term. Again, it would be nice to have something
better, but heh, you need to go step by step. I have this big rework
where I re-implement most of the pmac suspend code on top of the generic
code (cleans up a lot of stuff) but I don't want to touch the userland
ABI for now, that would be too much of a chance. And /dev/apm_bios X
notofication stuff seems to actually fix problems for some users.

> [On i386, we do not emulate apm, and it still works. Reason is that we
> switch to other console before suspend, so X has to give up
> framebuffer control, anyway.]

Well, I sort-of work :) I have reported cases of X locking the machine
up under some circumstances. Note that historically, I was not switching
consoles in the pmac PM code, though I'm doing it nowadays.

There are other uses of those "events" in /dev/apm_bios. Some people run
scripts on resume triggered by these for example, etc...

I'd rather not break an existing and relied upon userland interface now,
at least not until we have a well accepted replacement that has been
around for some time.

I do agree however that it may be nice to make the APM emulation code
more generic & shared between architectures. That's something I intend
to look into next. But I would like my current stuff to get in after
2.6.12 is released.

Ben.



--===============2250275116042062==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2250275116042062==--
