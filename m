From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: comments on irc log
Date: Sat, 19 Mar 2005 11:33:51 +0100
Message-ID: <20050319103351.GM24449@elf.ucw.cz>
References: <1111195262.25179.201.camel@gaston>
	<Pine.LNX.4.44L0.0503182205040.30560-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============35765088196930606=="
In-Reply-To: <Pine.LNX.4.44L0.0503182205040.30560-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
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

--===============35765088196930606==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This problem would be eliminated if the boot kernel's driver was aware
> that a resume-from-disk was in progress.  I've heard that suspend2 can
> offer such a feature; can it be added to swsusp?  Using a special flags 
> value for the FREEZE would be sufficient.

Flag certainly can be added, but it seems to me solution is to stop
the DMA in this case.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============35765088196930606==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============35765088196930606==--
