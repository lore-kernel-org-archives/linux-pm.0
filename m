From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 10:32:35 -0800
Message-ID: <200503231032.36164.david-b@pacbell.net>
References: <20050321202016.GI1390@elf.ucw.cz>
	<Pine.LNX.4.44L0.0503211613010.2329-100000@ida.rowland.org>
	<20050321222609.GK1390@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============20940708744160896=="
In-Reply-To: <20050321222609.GK1390-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============20940708744160896==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 21 March 2005 2:26 pm, Pavel Machek wrote:
> On Po 21-03-05 16:14:09, Alan Stern wrote:
> > On Mon, 21 Mar 2005, Pavel Machek wrote:
> > 
> > > > 	pm_message_t		power_state;
> > > > 
> > > > Obviously a message isn't the same thing as a state.  This looks like 
> > > > something that will need to be changed in a lot of drivers when we 
> > > > introduce the new notion of a power state.
> > > 
> > > This is not so obvious to me. 

It's a semantics thing, among others.  "System transitioning to
state Z" is a message, as is "system leaving state Z".  Both are
distinct from the "system state Z" being described.

Just like the system power state is distinct from the power state
of each device in the system.


> > > Message seems to represent the state 
> > > driver is in quite well... Plus we need PMSG_ON for state the device
> > > gets after resume, but that's quite easy...
> > 
> > So what value for power_state do you use to tell apart PCI D1 from D2?
> 
> You just ask via pci_choose_state(), and it tells
> you... pci_choose_state() should be deterministic.

Gaack, that again?  No.  Different devices support different
states, so it's got to depend on at least the device hardware
and the target system state.  Not "deterministic" as in the
current version.  I'm going to have to dig up the original
code, it didn't have bugs like that.

Also driver capabilities matter, since they don't all know how
to cope with the partial device reset that may be associated with
transition from D3 (but not D2 or D1) ... but at least in that
case the driver can ensure it doesn't choose PCI_D3 unless it
can actually cope with that result.

- Dave




--===============20940708744160896==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============20940708744160896==--
