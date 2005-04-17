From: Adam Belay <abelay@novell.com>
Subject: Re: [RFC] A New Power Management API
Date: Sun, 17 Apr 2005 16:26:22 -0400
Message-ID: <1113769584.3451.89.camel@localhost.localdomain>
References: <1113533193.3451.40.camel@localhost.localdomain>
	<9268368b0504150616652c268b@mail.gmail.com>
	<200504161013.10135.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============58394032626197112=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504161013.10135.david-b@pacbell.net>
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

--===============58394032626197112==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-04-16 at 10:13 -0700, David Brownell wrote:
> On Friday 15 April 2005 6:16 am, Daniel Petrini wrote:
> > 
> > Suggestion: as discussed in early weeks, why don't adopt names taking into 
> > consideration that Linux can run in systems other than desktops and servers?
> > 
> > #define PM_SYSTEM_STATE_SUSPEND_RAM 0x00000010
> > #define PM_SYSTEM_STATE_SUSPEND_DISK 0x00000020
> 
> The notion of RAM doesn't bother me much, although it may matter
> whether that means "all system RAM is preserved" versus "only a
> small bit of on-chip SDRAM is preserved".
> 
> The notion of DISK bothers me more.  Systems with only FLASH/MTD
> probably aren't more demanding of PM infrastructure, but when
> folk assume that the only non-volatile storage is a disk, it may
> start to seem that way.
> 
> For the moment, maybe using "NONVOLATILE" rather than DISK would
> be good.  Also, somewhat of a nit, those aren't exactly states,
> so maybe take at least the _STATE_ thingie out.
> 
> - Dave

Yeah, I agree.  I've changed this.

Thanks,
Adam



--===============58394032626197112==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============58394032626197112==--
