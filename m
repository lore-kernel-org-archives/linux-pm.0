From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend and hibernate nomenclature
Date: Sat, 20 May 2006 15:23:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0605201520140.29313-100000@netrider.rowland.org>
References: <20060520172051.GL2946@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73638877785669665=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060520172051.GL2946@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, richard@hughsie.com
List-Id: linux-pm@vger.kernel.org

--===============73638877785669665==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 20 May 2006, Pavel Machek wrote:

> > > > As for downloading, that's why ethernet adapters have wake-on-lan (WOL)
> > > > mechanisms.  Likewise for other wakeup-capable devices, like a keyboard
> > > > or mouse.  Or even 3D engines, DSPs, SPUs, ...
> > > 
> > > ?? WOL is for different functionality, I'm afraid. Or do you know
> > > ethernet hub that automagically wakes machines when data come?
> > 
> > No, that's exactly what WOL is designed for.  A typical scenarios has
> > the adapter waking up when the incoming packet is unicast to the MAC
> > address of that host.  The hub/switch would act normally.
> 
> I do not think WOL wakes that way. IIRC it needs magic ethernet
> packet.

That's right.  I don't remember what the contents need to be, but WOL 
doesn't work with any old ethernet packet.

You can see this by looking closely at what Dave wrote: "... the incoming
packet is unicast to the MAC address of that host."  If the host has been
asleep for some time, its MAC address will have timed out from the
source's ARP cache.  The source will need to broadcast an ARP request
packet before it can unicast anything, and the broadcast won't wake up the 
host.

Alan Stern


--===============73638877785669665==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73638877785669665==--
