From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: CPU local things [was Re: Nested suspends;
	messages vs. states]
Date: Thu, 24 Mar 2005 11:01:53 +0100
Message-ID: <20050324100153.GE1354@elf.ucw.cz>
References: <1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231008340.17099-100000@monsoon.he.net>
	<20050323210204.GE30704@elf.ucw.cz>
	<1111613750.14853.117.camel@desktop.cunningham.myip.net.au>
	<20050323215416.GK30704@elf.ucw.cz>
	<Pine.LNX.4.50.0503231838570.15119-100000@monsoon.he.net>
	<1111634182.3430.1.camel@desktop.cunningham.myip.net.au>
	<Pine.LNX.4.50.0503240017460.15119-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============42129884884726154=="
In-Reply-To: <Pine.LNX.4.50.0503240017460.15119-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============42129884884726154==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Just for clarity's sake, what are you thinking should happen to MTRR
> > support?
> 
> Become more componentized. We need a better way to represent optional
> features of any device, but in particular CPUs. We should never be calling
> it directly; we should be looping over the feature drivers bound to a 'CPU
> Driver' and suspending them.

Actually, no.

mtrr's are cpu local. That means they need to be handled by CPU
hotplug framework. I guess we should just drop them from "normal"
device trees, and create something per-CPU.

Perhaps plain old notification list is enough for this one.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============42129884884726154==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============42129884884726154==--
