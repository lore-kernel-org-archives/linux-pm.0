From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: potential pitfall? changing configuration while PC in
	hibernate
Date: Mon, 21 Mar 2005 10:22:37 -0800
Message-ID: <200503211022.38068.david-b@pacbell.net>
References: <d1lutv$iuj$1@sea.gmane.org> <20050321095229.GA28507@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============017539423788236252=="
In-Reply-To: <20050321095229.GA28507-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: Arioch <the_Arioch-SYPjacQAEmk@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============017539423788236252==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 21 March 2005 1:52 am, Pavel Machek wrote:
> On Po 21-03-05 11:02:04, Arioch wrote:
> > 
> > I wonder, if hardware configuration asked for changes when resuming from 
> > hibernate ?
> 
> Current position is "don't do this". You *will* be able to recover by
> passing noresume, but if you change hw configuration, it may crash&burn.

That may be Pavel's position, but USB-wise we absolutely consider
it a bug if Linux misbehaves in the face of routine actions like
unplugging a device during suspend (or plugging in a new one).
Regardless of "noresume" etc.

I'd say that's true for all hotpluggable busses, in fact, but I
rarely submit patches for non-USB ones like PCMCIA or CardBus.

- Dave



--===============017539423788236252==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============017539423788236252==--
