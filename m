From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Thu, 15 Mar 2007 16:07:30 -0700
Message-ID: <200703151607.31269.david-b@pacbell.net>
References: <200703151329.l2FDTh3B000785@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703151329.l2FDTh3B000785@olwen.urbana.css.mot.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org, linux@dominikbrodowski.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Thursday 15 March 2007 6:29 am, Scott E. Preece wrote:

> | > For the rest of us, though, all the stuff you're currently =

> | > doing for power management is wasted effort and why should we incur
> | > costs to work around them? =

> | =

> | Me personally?  What specifically are you referring to, and
> | in what respects would that be "wasted" effort?
> ---
> =

> As noted in previous apology, I was speaking over-broadly. However, as I
> said, we currently configure out cpufreq and ACPI support,

ACPI -- goes without saying, unless you're on x86 or ia64.

cpufreq -- similar, although some non-x86 versions do exist, and seem
to provide limited power savings in a few cases (in conjunction with
voltage scaling, since the cost of N cpu cycles is otherwise constant).


> among other =

> things, so they represent wasted effort from the particular perspective
> of our products. I was speaking rhetorically - just saying that the work
> done on cpufreq and ACPI was "wasted effort" in exactly the same sense
> that work spent on supporting the PM needs of embedded devices would be.

I still don't follow.  I think I'll just count your original response
as one of those "should not have written that" posts most folk suffer
from on occasion.

- Dave


> ---
> | =

> | > Today, we just configure it all out and put =

> | > in our own stuff. We would prefer to have a mainstream framework that
> | > could be used to meet both Intel laptop needs and embedded device nee=
ds...
> | =

> | I don't think I ever said anything against that notion of having PM
> | infrastructure capable of handling both PC and embedded configs.  Not
> | that I've seen a framework that handles either one well -- yet! -- so
> | such notions haven't yet progressed to being testable theories.
> | =

> | Against the notion of infrastructure (PM or otherwise) that's not
> | well designed or defined -- certainly I've argued.  That includes
> | much current PM infrastructure, and most recent proposals.
> ---
> =

> Thanks - I can agree with that!
> =

> scott =

> =

> -- =

> scott preece
> motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

> e-mail:	preece@motorola.com	fax:	+1-217-384-8550
> phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
> =

> =
