From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Summary of today's IRC discussion
Date: Fri, 18 Mar 2005 13:22:55 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503181312400.16627-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503171331071.855-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79291220561196329=="
In-Reply-To: <Pine.LNX.4.44L0.0503171331071.855-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============79291220561196329==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 17 Mar 2005, Alan Stern wrote:

> Lastly people decided it was a good idea to have a small list of
> targeted systems for PM development.  That way we have a minimum set
> of goals for PM -- it has to work on those platforms -- and something to
> focus on.  Also we'll have an excuse when someone asks "Why doesn't
> this work on platform X?"  Suggested targets included x86 and ppc (both
> workstations and laptops), a couple of embedded systems (OMAP ARM and
> ppc8xx) with maybe a few odd additions such as MIPS.
>
> It was also agreed that we should document what hardware is supported,
> and what states are supported by which drivers.

Just to clarify exactly what I was suggesting..

I was not trying to suggest that we choose a set of target platforms.
Rather, that we simply identify, document, and focus solely on the
platforms and devices that are available to us collectively.

It is impossible and undesirable to everyone to all possess and develop
for the same hardware, so we will by default have a heterogenuous array of
systems. Simply by being a collection of mobile and embedded systems, we
will cover enough of the common cases to benefit most people once the
model is complete.

We can spend eternities trying to factor in every corner case that we can
think of. And, if we do so, we will make the wrong decision. Look at the
platform and system device code in the driver model. Those are the result
of creative thinking about problems that were only be addressed
vicariously. People kept saying we needed to provide for This and That,
without stepping and writing any code. I took several stabs at it, trying
to do what I thought was right. Now, it kinda works, but everyone hates
it. The lesson: design for what you possess; when it doesn't work for
someone, let them work with you to fix it. If they care enough about it,
and you're open-minded enough, it will get adapted quickly.

Besides, I cannot tell you how annoying hearing pathological examples can
be (like properly representing a swap device over NFS over a serial line
that resides on a PCI bus) when they have an infintismally small real
world applicability. :)


	Pat


--===============79291220561196329==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79291220561196329==--
