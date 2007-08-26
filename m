From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
Date: Mon, 27 Aug 2007 01:21:56 +0200
Message-ID: <6bffcb0e0708261621q25316becqce7b3ae2176f45a8__18448.8332168714$1188170781$gmane$org@mail.gmail.com>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@gmail.com>
Cc: linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>, linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi

[Adding STR wizards to CC]

On 26/08/07, Rog=E9rio Brito <rbrito@gmail.com> wrote:
> Hi.
>
> Unfortunately, it seems that kernels later than 2.6.21 have problems
> letting my powerpc iBook (G3 processor) going to sleep (suspend to
> ram).
>
> The userland that I am using is a Debian testing (lenny) and the
> default kernel that comes with it is 2.6.22, with some patches applied
> and pbbuttonsd (as the daemon for making the machine sleep).
>
> With kernel 2.6.21, from Debian (and other earlier kernels), the
> symptoms that I see when I press the power button is that the machine
> goes to sleep and the led that indicates that the machine is sleeping
> is blinking normally.
>
> If I, on the other hand, use Debian's kernel 2.6.22 or compile my own
> kernel with just the necessary parts for my work (version 2.6.23-rc3
> taken from kernel.org), then I can't make the machine sleep: when I
> press the button, it acts like if I had, in sequence, pressed anything
> to wake it up (say, like pressing shift).
>
> I have already grabbed Linus's git tree and I am willing to do some
> cycles of "git bisect" to discover the point where it stopped working.
>
> I just thought that others may have seen such behaviour before or, if
> not, that being informative about what I see is of use for debugging
> this.
>
> I would also appreciate any guidance on this as I wish kernel 2.6.23
> to be working again on powerpc machines.
>
> Please, if any tests are required, don't hesitate to ask me and I will
> try to whatever is needed to restore the correct behaviour of sleep
> with the Linux kernel.
>
> I have copied mailing lists that I think that are relevant. If they
> aren't, then please let me know. I would also appreciate if I were
> kept on carbon copies as I am only subscribed to debian-powerpc at the
> moment.
>
>
> Regards, Rog=E9rio Brito.
>
> P.S.: It unfortunately doesn't matter if I switch to a console or if I
> am in X when I press the power button with recent kernels.
> -

Regards,
Michal

--=20
LOG
http://www.stardust.webpages.pl/log/
