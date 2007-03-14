From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Wed, 14 Mar 2007 16:23:16 -0700
Message-ID: <200703141623.16643.david-b@pacbell.net>
References: <200703142208.l2EM8uoV007606@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703142208.l2EM8uoV007606@olwen.urbana.css.mot.com>
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

On Wednesday 14 March 2007 3:08 pm, Scott E. Preece wrote:
> | > =

> | > But shouldn't it be useful on every platform? ..
> | =

> | I couldn't know.  This "alternative concept" hasn't gotten very far
> | into the hand-waving stage, much less beyond it into proposed interface
> | or (gasp!) implementations.  Platforms that don't *have* those particul=
ar
> | interdependencies should not of course incur costs to implement them...
> ---
> =

> Well, that's fine if the platform you use is the current design
> center.

So you think that platforms which don't have such interdependencies
should incur costs and complexity to address problems they don't have.
Why?


> For the rest of us, though, all the stuff you're currently =

> doing for power management is wasted effort and why should we incur
> costs to work around them? =


Me personally?  What specifically are you referring to, and
in what respects would that be "wasted" effort?


> Today, we just configure it all out and put =

> in our own stuff. We would prefer to have a mainstream framework that
> could be used to meet both Intel laptop needs and embedded device needs...

I don't think I ever said anything against that notion of having PM
infrastructure capable of handling both PC and embedded configs.  Not
that I've seen a framework that handles either one well -- yet! -- so
such notions haven't yet progressed to being testable theories.

Against the notion of infrastructure (PM or otherwise) that's not
well designed or defined -- certainly I've argued.  That includes
much current PM infrastructure, and most recent proposals.

- Dave
