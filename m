From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 07:36:18 +1100
Message-ID: <1111610178.14853.108.camel@desktop.cunningham.myip.net.au>
References: <Pine.LNX.4.44L0.0503221143460.954-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221709080.16154-100000@monsoon.he.net>
	<200503231102.27137.david-b@pacbell.net>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============75901547903934619=="
In-Reply-To: <200503231102.27137.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============75901547903934619==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Thu, 2005-03-24 at 06:02, David Brownell wrote:
> On Tuesday 22 March 2005 5:17 pm, Patrick Mochel wrote:
> > 
> >	 We just need a
> > simple mechanism for parents to monitor the power state of their children.
> > Can't be that hard to come up with something clean.
> 
> Minimally they can walk the list of their children at appropriate moments.
> I think folk have also raised the notion of having a "child state changed"
> call to the parent; it's not clear to me that needs to involve the PM core.

Yes. The children should notify the parent, not the parent poll the
children. Polling is ugly :>

On top of this, the evaluation of the state of the children should be
atomic. Thus, their notifications of idleness might simply atomically
increment/decrement a counter of the number of children busy, for
example.

Regards.

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============75901547903934619==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============75901547903934619==--
