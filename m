From: Pavel Machek <pavel@suse.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 24 Aug 2006 09:59:39 +0200
Message-ID: <20060824075939.GF1952@elf.ucw.cz>
References: <c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost>
	<20060817214031.GE6450@ucw.cz> <1155901719.3659.43.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1155901719.3659.43.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Amit Kucheria <amit.kucheria@nokia.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > The userspace interface in Eungeny's patches is for other userspace
> > > programs (policy managers) to activate/deactivate valid operating poi=
nts
> > > in the system dynamically and if necessary, introduce new ones into t=
he
> > > system. It will also allow the operating points to be referenced by n=
ame
> > > instead of the tuple.
> > > =

> > > Then, we will be able to use names like 'video', 'mp3', 'fast',
> > > 'powersave', 'usb' to switch to the relevant operating point based on
> > > configuration of the policy manager.
> > =

> > This seems to be too specific to embedded machine.
> > =

> > If userspace wants to work with usb and play mp3s at the same time,
> > what does it do?
> =

> Switch to 'fast'?
> =

> The operating point for a use-case specifies the _minimum_ required for
> the use-case. You can always go up.

> The system designer is responsible for 'designing' operating points that
> take into account multiple use-cases. Designing here refers to mapping
> use-cases to HW operating points.

Yes, and that's why I argue this is unsuitable for notebook: there are
just too many usecases for a notebook.

> Consider an example system with a main CPU and a DSP. To simplify
> discussion, lets assume 3 levels for CPU and DSP speeds and system
> voltage. Then, here is what an example operating-point to use-case
> mapping table could look like:
> =

> #     CPU speed      DSP speed      Voltage       use-case
> ----------------------------------------------------------
> 1.    high           high           high          fast, video
> 2.    med            high           high          =

> 3.    med            med            med           usb[1]
> 4.    low            med            med           mp3
> 5.    low            low            low           powersave
> =

> [1] USB has voltage constraint (voltage >=3D med)

So... you take three independend parametrs and merge them into one,
named parameter. Bad idea.

What about simply having these parameters:

usb on or off

cpu speed (controlled by cpufreq)

dsp speed (controlled by userspace)

Then you can have infrastructure that is able to compute system
voltage from usb/cpu/dsp speed, and users stll have interface they can
understand.

(How are they supposed to know if video use case is compatible with
usb? They should not have to).

> - Now if we are playing mp3, we switch to OP 4.

Do you expect all mp3 playing applications to play with
/sys/.../powerop-point? How do you tell if mp3's are playing? These
are hard questions for a notebook.

> - Add usb and we switch to OP 3.
> - Now our performance monitor (e.g load avg) indicates that we need more
> CPU processing. So we switch to OP 2.

That's cpufreq job, please

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
