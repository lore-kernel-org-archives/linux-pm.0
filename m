From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [2/2] 2.6.21-rc7: known regressions
Date: Sun, 15 Apr 2007 20:44:12 -0700
Message-ID: <4622F10C.1080203@goop.org>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070416003723.GM3691@stusta.de>
	<20070416005446.GB21217@redhat.com>
	<20070416011636.GO3691@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070416011636.GO3691@stusta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Adrian Bunk wrote:
> I'm not sure why I thought you two ran into the same regression.
>
> So "hpet=3Ddisable" worked for Jeremy but not for you, IOW: you two were =

> running into different regressions?
>
> @Jeremy:
> If this is true, is your HPET related related regression still present =

> in -rc7?

I need to recheck, but when I tried -rc6, I was still having resume
problems but hpet=3Ddisabled didn't help.  So I definitely think there are
multiple bugs with the same symtoms.  I haven't tried -rc7 yet.

    J
