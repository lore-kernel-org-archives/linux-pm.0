From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 07:43:22 -0700
Message-ID: <20100606144322.GC21016__26660.5112854906$1275835476$gmane$org@count0.beaverton.ibm.com>
References: <AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
	<alpine.LFD.2.00.1006050246350.2933@localhost.localdomain>
	<AANLkTikU21xF49Z-_Lnrq7U7buNmqw_gyEEST8LuN24z@mail.gmail.com>
	<alpine.LFD.2.00.1006051736040.2933@localhost.localdomain>
	<AANLkTinD39rI47innPbGz1Gi8PsXV5HqkmaQuJ70oQ63@mail.gmail.com>
	<alpine.LFD.2.00.1006052348200.2933@localhost.localdomain>
	<AANLkTikmWDHYJ8wWF2cZapbkHHjV09R39I37yvQXFmor@mail.gmail.com>
	<alpine.LFD.2.00.1006060148470.2933@localhost.localdomain>
	<AANLkTikdM79nmARagK9gLveMWEiT6rlk44UELes1k8Ch@mail.gmail.com>
	<alpine.LFD.2.00.1006061202351.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1006061202351.2933@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 06, 2010 at 12:36:21PM +0200, Thomas Gleixner wrote:
> On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:

<snip>

> > events like input event go though a single thread in our system
> > process, while other events like network packets (which are also
> > wakeup events) goes directly to the app.

If you want to wake up cgroup-frozen tasks for these fds perhaps your
framework can fcnt(fd, F_SETOWN, <p[g]id>) to send SIGIO to a
userspace-suspend-blocker thread/process/process group. When IO comes in, t=
he
suspend blocker is signalled which then unfreezes the cgroup of the frozen
untrusted task. SIGIO works on pipes, fifos, sockets, ttys, and ptys --
many of which are precisely the kinds of things that would connect [trusted
and untrusted] apps. Notably absent (last I checked): inotify fds, signalfd,
timerfd, eventfd, filesystem fds and likely more.

Incidentally, this is just to show that it's not impossible to implement
"wakeups" for cgroup-frozen tasks in userspace.

Cheers,
	-Matt Helsley
