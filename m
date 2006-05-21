From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend and hibernate nomenclature
Date: Sun, 21 May 2006 11:35:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0605211135070.32492-100000@netrider.rowland.org>
References: <20060520205550.GA8490@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77581025893385247=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060520205550.GA8490@elf.ucw.cz>
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

--===============77581025893385247==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 20 May 2006, Pavel Machek wrote:

> Hi!
> 
> > > > > > ?? WOL is for different functionality, I'm afraid. Or do you know
> > > > > > ethernet hub that automagically wakes machines when data come?
> > > > > 
> > > > > No, that's exactly what WOL is designed for.  A typical scenarios has
> > > > > the adapter waking up when the incoming packet is unicast to the MAC
> > > > > address of that host.  The hub/switch would act normally.
> > > > 
> > > > I do not think WOL wakes that way. IIRC it needs magic ethernet
> > > > packet.
> > > 
> > > That's right.  I don't remember what the contents need to be, but WOL 
> > > doesn't work with any old ethernet packet.
> > 
> > You're both wrong.  Notice what "man ethtool" reports:
> 
> Ok, you are right and I was wrong....

Me too.  I guess things have moved forward since the last time I looked at 
this stuff.

Alan Stern


--===============77581025893385247==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77581025893385247==--
