From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Wed, 25 Oct 2006 23:05:05 -0400
Message-ID: <20061026030505.GA18549@dominikbrodowski.de>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<452EC524.5000608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <452EC524.5000608@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Fri, Oct 13, 2006 at 02:43:48AM +0400, Eugeny S. Mints wrote:
> >A) The lowest level: lots of knobs.
> >
> >Somewhere in a "computer system"[2] there are very many "knobs" which may
> >be turned to influence various voltages, clock levels, or operating modes
> >("turbo", "performance" or "powersave", for example).
> >
> >Also, there might be many dependencies on how these "knobs" may be
> >changed.
> >
> >Let's assume the system is in a well-defined, working state right now.
> In terms which we use to describe PowerOP a "kbob" is "power parameter"
> and "operating point" is an entity which corresponds to "well-defined, =

> _working_ [system power] state".
> =

> So, what PowerOP Core does: it just maintains a collection of operating =

> point,
> i.e. collection of known-to-be-working system power states. On many =

> platforms
> (especially embedded) not all combinations of power parameters are valid.=
  =

> Some
> [invalid] combinations of the power parameters may crash or damage the =

> system.

Exactly. And that is what I suggest you may want to do in the level _above_
the knobs. Not all platform need or even want this limitations; some require
it. So let's not force it upon everyone, but let's just use it where it
makes sense?


<operating points table library>
              |
	<knob layer>

> 1) you have a table which tells you that there are some  combinations of =

> power
> parameter values which are
> a) _known-to-be-working_
> and
> b) contains SOME_PLATFORM_POWER_PARAMETER=3Dvalue1.
> Then you chose one of these operating points and switch to it.
> =

> The table creation is simply registration of operating points with POwerO=
P =

> Core.

Sort of.

> Now selection and switch. Obviously the functionality of selection between
> operating points based on some algo (which btw varies even not across =

> platforms
> but even across different profiles of the same platform) has nothing to d=
o =

> with
> the code which actually switches operating points. So having such
> functionalities coupled within the ->set() method is just invalid design =
- =

> they
> have to be separated. That's exactly what PowerOP approach does:

Looking at the code, not really -- there my approach was able to use the
same "separation", or "coupling", which PowerOP uses.


> an upper =

> layer
> can implement selection logic leveraging PowerOP Core interface and then =

> request
> POwerOP Core to switch system to the selected operating point.

That's also possible using my approach.

> 2) table does not exist. There are two options here:
> =

> Either,
> a)an entity which calls ->set() for a particular power parameter IS
> RESPONSIBLE for that resulting combination of power parameter values (onc=
e =

> the
> set has been executed) IS valid one
> =

> OR
> b) the system executes complex logic you described under D) 1) (in fact,
> cpufreq policy notifiers) to get a valid combination of power parameter =

> values
> with a predefined value of a certain power parameter.
> =

> Let me illustrate why 2)a) is just particular case in contrast to POwerOP =

> which
> is general case in this situation.
> =

> i) PowerOP Core provides interface to get/set value of a particular power =

> parameter
> =

> ii)  Let's assume we limit the set of operating points for a platform to =

> one point.  This one operating point is always the current operating poin=
t. =

> All operations occur on the the current operating point.
> =

> iii)in the assumptions above your  ->set() is nothing else than:
> set(param, value)
> {
>  struct powerop_pwr_param p;
> =

>  p.attr =3D param;
>  p.value =3D value;
>  powerop_set_pwr_params(CURRENT_POINT, &p, 1);
>  powerop_set_point(CURRENT_POINT);
> }

Here you turn PowerOP on its head -- you modify one Operating Point runtime?
Isn't that two Operating Points? That sounds strange. Also, it again looks
at it from a top->bottom view, which I dislike...

> That's it. Bottom line is: what you are talking about is NOT an Alternati=
ve
> Concept but a particular case instead. While PowerOP design is generic ca=
se.

As I said -- the differences might be subtle. But they're important. And I
don't care how anything is called -- I care that both the concept and the
code is good.

Thanks,
	Dominik
