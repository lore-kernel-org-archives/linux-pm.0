From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: comments on irc log
Date: Sat, 19 Mar 2005 10:07:57 +1100
Message-ID: <1111187278.1236.187.camel@gaston>
References: <Pine.LNX.4.44L0.0503181147110.1099-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============56877863105418314=="
In-Reply-To: <Pine.LNX.4.44L0.0503181147110.1099-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
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

--===============56877863105418314==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Usually very fast.  Unfortunately for some kinds of USB host controllers 
> it can be relatively slow, since quiescing the controller has an 
> unavoidable side effect of suspending all devices on the bus.

I wonder if we need to quiesce the controller in fact for FREEZE.
Probably not. Just stop all queue processing and refuse URBs. The hcca
will still get updated, but who cares ? it will end up beeing saved in
an inconsistent state in the suspend image, so what ? On resume, we will
have rebooted, we can "clean it up".

This is sort-of breaking the rule of "no DMA", and thus is not suitable
for kexec (which is ok, kexec currently uses the separate "shutdown"
callback which must switch DMA off), but would fix the problem for
suspend to disk...

Ben.



--===============56877863105418314==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============56877863105418314==--
