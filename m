From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 07:48:45 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503240746290.24692-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231724100.15119-100000@monsoon.he.net>
	<20050324095910.GD1354@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73908464479193325=="
In-Reply-To: <20050324095910.GD1354-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============73908464479193325==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 24 Mar 2005, Pavel Machek wrote:

> Seems to me that suspend-to-RAM and suspend-to-DISK make sense, and
> cover 90% of what people want to do. Add "standby" for "fast
> suspend-to-RAM" and you cover even ARM. I'd say that's good enuogh.

We can treat STR and Standby nearly identically, exceptions being what we
do with the CPU, and what power states the devices enter. But, are there
any others?

What about this "big sleep" and "deep sleep" stuff? What platform were
those for? Is there documentation about them?

Thanks,


	Pat

--===============73908464479193325==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73908464479193325==--
