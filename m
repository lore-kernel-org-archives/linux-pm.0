From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 18:40:42 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503231838570.15119-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231008340.17099-100000@monsoon.he.net>
	<20050323210204.GE30704@elf.ucw.cz>
	<1111613750.14853.117.camel@desktop.cunningham.myip.net.au>
	<20050323215416.GK30704@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============40035312409947332=="
In-Reply-To: <20050323215416.GK30704-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============40035312409947332==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 23 Mar 2005, Pavel Machek wrote:

> Hi!
>
> > > There are many drivers that do not fit your idea of "driver". Like
> > > mtrrs. Some drivers only ever do work on resume, etc. Forcing driver
> > > to think how to split it into class->stop, bus->save_state and
> > > bus->enter state is bad idea. [Notice that almost no drivers need
> > > ->save_state operation...]
> >
> > I don't think MTRRs should be counted as drivers. Rather, they should be
> > counted as part of the CPU state(s), to be saved and restored when CPU
> > context is saved and restored. Treating them as drivers leads to races
> > :>
>
> Okay, I'll need to make cpu hotplug deal with them. But MTRR are not
> the only strange device. Think timer, for example.

That's a system device (like the current MTRR). In the name of sanity,
please don't make exceptions to the model based on them or platform
devices. Both of those models are FITH and need to be re-done.

Tangentially, if anyone has decent ideas on how to better represent those
types of devices, I'm very intersted in knowing. I'd like to see them
fixed up and cleaned up in the next few months..

Thanks,


	Pat


--===============40035312409947332==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============40035312409947332==--
