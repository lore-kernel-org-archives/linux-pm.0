From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: potential pitfall? changing configuration while PC
	in hibernate
Date: Mon, 21 Mar 2005 10:29:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503211027280.1241-100000@ida.rowland.org>
References: <d1lutv$iuj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============23005254342753156=="
In-Reply-To: <d1lutv$iuj$1@sea.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Arioch <the_Arioch-SYPjacQAEmk@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============23005254342753156==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 21 Mar 2005, Arioch wrote:

> AS: where it counts, by hibernate i mean Suspend-to-disk, not 
> suspend-to-RAM.
> 
> I wonder, if hardware configuration asked for changes when resuming from 
> hibernate ?
> 
> I have a notebook with USB1 keyboard-and-hub (Cherry) and an USB2 Flash 
> drive.
> 
> Keyboard reports it can give 100 mA of current per-port.
> USB disk reports it consumes 200 mA.
> 
> So de jure this disk is not to be turned on, or at least Linux is to ask 
> user if he wants to run this device, even he understands it is risky.
> Ok, this question is not for Power-Management forum.
> 
> But i remember a couple of pitfalls i met on Windows and do not want to 
> see them in Linux.
> 
> When i plug this USB dirve into keyboard when Win2003 is running, 
> Windows rejects the device since it requests too much power.
> But if i put Windows to hibernate, then plug the USB Drive and then 
> resume Windows - it forgets to check for power requirements and tunrs 
> device on (which is useful, but which is a bug :-) )
> 
> So i wonder if there are (planned) some measures to test for hardware 
> changes, why PC was hibernated.

This specific case -- plugging in a new USB device while the system is 
asleep -- will be handled correctly.  In fact, it will be handled exactly 
the same as if you had plugged in the device after waking up the system.

Alan Stern


--===============23005254342753156==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============23005254342753156==--
