From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 09:35:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0608090932460.3785@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<20060808235352.GA4751@elf.ucw.cz>
	<Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
	<20060809073958.GK4886@elf.ucw.cz>
	<Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
	<20060809115843.GB3747@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
In-Reply-To: <20060809115843.GB3747@elf.ucw.cz>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net, ncunningham@linuxmail.org
List-Id: linux-pm@vger.kernel.org


On Wed, 9 Aug 2006, Pavel Machek wrote:

>
> > > How s2ram works would be useful info.
> >
> > No idea.
>
> Well, try it :-). suspend.sf.net.
>

Debian testing has it installed already, so I tried that one.

# s2ram
Machine is unknown.
This machine can be identified by:
    sys_vendor   = "IBM"
    sys_product  = "288679U"
    sys_version  = "ThinkPad G41"
    bios_version = "1XET44WW (1.03 )"
See http://en.opensuse.org/S2ram for details.

If you report a problem, please include the complete output above.



So then I tried s2ram -f

Well it went to sleep fine.  But when I tried to wake it up again, the
screen didn't come back. I'm not sure if the keyboard was working either.
But I could eject the CD and when I put it back in, it seemed to mount it.

Oh well, I'll have to debug that another day ;)

-- Steve
