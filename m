From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: Alternative Concept
Date: Thu, 15 Mar 2007 13:33:53 +0300
Message-ID: <45F92111.2030808@gmail.com>
References: <200703142208.l2EM8uoV007606@olwen.urbana.css.mot.com>
	<200703141623.16643.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703141623.16643.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Wednesday 14 March 2007 3:08 pm, Scott E. Preece wrote:
>> | > =

>> | > But shouldn't it be useful on every platform? ..
>> | =

>> | I couldn't know.  This "alternative concept" hasn't gotten very far
>> | into the hand-waving stage, much less beyond it into proposed interface
>> | or (gasp!) implementations.  Platforms that don't *have* those particu=
lar
>> | interdependencies should not of course incur costs to implement them...
>> ---
>>
>> Well, that's fine if the platform you use is the current design
>> center.
> =

> So you think that platforms which don't have such interdependencies
> should incur costs and complexity to address problems they don't have.
> Why?

they don't. and what is more important they wouldn't.

Our idea is to provide building bricks: a clock provider node, a voltage =

provider node, a domain node, an arc of parent-child type, an arc of domain =

type, etc as well as tools/means (API) to construct an arbitrary graph from =

these nodes and arcs. These are pieces which parameter framework would brin=
g to =

the plate.

Further, an arch/platform system designer reading hw manual defines which n=
odes =

are required for a particular arch/platform and how a graph of nodes and ar=
cs
should look like for the arch/platform. Parameter framework API allows to b=
uild =

an arbitrary graph of nodes and arcs either statically or at runtime.

This way a particular arch/platform graph configuration is the only arch =

dependent thing while the rest is handled in arch independent way.

Am arch/platform designer uses only set of nodes and set of arcs required f=
or =

his particular platform eliminating costs and complexity non-related to the =

specific platform.

Of course, any generalization has size and performance penalties but with t=
he =

proposed approach it's basically narrowed down to size of the structure =

representing a node in the tree and performance of tree traversing. Both le=
ave =

opportunity for optimization without impact on generic ideas, structures an=
d API =

though.

Eugeny
> =

> =

>> For the rest of us, though, all the stuff you're currently =

>> doing for power management is wasted effort and why should we incur
>> costs to work around them? =

> =

> Me personally?  What specifically are you referring to, and
> in what respects would that be "wasted" effort?
> =

> =

>> Today, we just configure it all out and put =

>> in our own stuff. We would prefer to have a mainstream framework that
>> could be used to meet both Intel laptop needs and embedded device needs.=
..
> =

> I don't think I ever said anything against that notion of having PM
> infrastructure capable of handling both PC and embedded configs.  Not
> that I've seen a framework that handles either one well -- yet! -- so
> such notions haven't yet progressed to being testable theories.
> =

> Against the notion of infrastructure (PM or otherwise) that's not
> well designed or defined -- certainly I've argued.  That includes
> much current PM infrastructure, and most recent proposals.
> =

> - Dave
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
> =
