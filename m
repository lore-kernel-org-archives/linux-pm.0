From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: [Bugme-new] [Bug 11717] New: Pressing suspend button
	suspends, but does not wakes up
Date: Sat, 8 Nov 2008 05:50:08 -0200
Message-ID: <20081108075008.GA8177__9877.73363381184$1226130867$gmane$org@ime.usp.br>
References: <20081106194724.GB15366@ime.usp.br>
	<20081107014535.GA19201@ime.usp.br>
	<1226044855.4913f5b7f2f45@webmail.ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1226044855.4913f5b7f2f45@webmail.ime.usp.br>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org, yakui.zhao@intel.com, bugme-daemon@bugzilla.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi once again.

On Nov 07 2008, Rogerio Theodoro de Brito wrote:
> Quoting Rog=E9rio Brito <rbrito@ime.usp.br>:
> > If any further information is needed, please let me know.
> =

> I just discovered that the "suspend button" is overloaded: it is actually =

> a poweroff button, which would explain the behaviour when the kernel is i=
n =

> suspend to RAM.

I think that I have some more information regarding the suspend/hibernate
issue: with Ubuntu's 2.6.27 kernel, I can't hibernate my laptop, but with
vanilla 2.6.28-rc3, I can hibernate (I have not tested it much, but it
seems to work).

Ubuntu's 2.6.27 kernel was hanging when the hibernation phase was
occurring.  It just blinked the HD once and nothing else happened. With
vanilla 2.6.28-rc3, it saves the memory contents to disk and I am able to
resume.

But seeing the behaviour of this in comparison with Windows Vista, two
things still stand out:

1 - pressing the suspend button suspends the machine, but upon a second
    press, the machine still turns itself off and all work is lost. :-(

2 - closing the lid, no matter what I program in GNOME's Power Preferences,
    doesn't even blackens the screen, let alone suspend or hibernate the
    notebook.

Both of the points above work fine under Windows Vista, but I don't even
know how to use Windows correctly and I want to use Free Software.

Again, for those that I just included in the carbon copies now, I have
given extensive information on the bugzilla report, but I can recompile
kernels, get dumps of debugging information, get dumps under Windows (if
that helps and if I am instructed how to do that). You name it. I am really
willing to help as much as possible with all efforts that are possible to
me.


Thanks in advance for any help, Rog=E9rio Brito.

-- =

Rog=E9rio Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
