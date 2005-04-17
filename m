From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] A New Power Management API
Date: Sun, 17 Apr 2005 19:01:48 -0400
Message-ID: <20050417230147.GC7793@neo.rr.com>
References: <1113533193.3451.40.camel@localhost.localdomain>
	<200504161124.05846.david-b@pacbell.net>
	<1113770914.3451.107.camel@localhost.localdomain>
	<200504171529.17711.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============40355675636999289=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504171529.17711.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============40355675636999289==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 17, 2005 at 03:29:17PM -0700, David Brownell wrote:
> On Sunday 17 April 2005 1:48 pm, Adam Belay wrote:

> > 
> > So I think each clock could be a power resource.  It looks like the
> > current code isn't doing much more than turning them on and off. 
> 
> They should clk_use()/clk_unuse(), and automatically handle the
> activation/deactivation of parent clocks.  Some clocks are shared
> between multiple devices ... so "on/off" doesn't suffice, those
> devices' drivers rely on the clock framework to coordinate.  (Or
> were you thinking that on/off would match use/unuse?  There's no
> point to separate enable/disable calls IMO.)

Yes, I was thinking power resources could replace use/unuse.  So each device
could associate a list of required resources by state.  Then, when there
are not any devices in a state that requires a given resource, the resource
could be turned off.

--===============40355675636999289==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============40355675636999289==--
