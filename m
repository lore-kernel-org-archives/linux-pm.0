From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 24 Aug 2006 14:39:54 +0200
Message-ID: <20060824123954.GA5513@elf.ucw.cz>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<b324b5ad0608182310v348f8936j527357e60c3a77bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b324b5ad0608182310v348f8936j527357e60c3a77bb@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!


> >> This adds a whole bunch of new code, and doesn't seem to make any
> >> existing code any simpler (to me at least).  From a cpufreq point of =

> >view,
> >> what does adding this buy us? What problem do we have today that is
> >> being solved by all this?
> =

> Greg and Dave,
> =

>                 there are two competing patch sets for a new power =

>                 management
>        framework.   The patch set I sent out simplifies power management,
>        from both the cpufreq perspective and the embedded world's view of
>        power management.
> =

>                I've renamed my patch oppoint so as not confuse it
>        with the powerop set from Matt Locke (which will probably make
>        it even more confusing).  I've renamed it so it can be seen as an
>        alternative design approach, not just an alternative implementation
>        of the same ideas.  I've also incorporated suggestions from
>        Pavel in cleaning up the original patches.
> =

>                If you'd be willing to take a look at, or try out, the =

>                patches
>        in my patch set you should be able to see how oppoint could simpli=
fy
>        cpufreq code.  The first patch is the oppoint-cpufreq.patch and
>        the second is the oppoint-x86-centrino.patch.
> =

>                Oppoint could replace large pieces of the cpufreq code
>        in the kernel, most notably the policy and governor code, which I
>        believe belongs in user space in the power manager daemon.

I was told (by intel folks) that you can't push governor code into
userspace, because it is latency-critical on new cpus... so I do not
think this is going to simplify cpufreq.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
