From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Mon, 21 Mar 2005 21:20:16 +0100
Message-ID: <20050321202016.GI1390@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============095518295118267371=="
In-Reply-To: <Pine.LNX.4.44L0.0503211436020.1241-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
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

--===============095518295118267371==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Messages vs. states:  At the moment the PM core seems to be pretty
> confused over this distinction.  Right in the definition of struct
> dev_pm_info we have:
> 
> 	pm_message_t		power_state;
> 
> Obviously a message isn't the same thing as a state.  This looks like 
> something that will need to be changed in a lot of drivers when we 
> introduce the new notion of a power state.

This is not so obvious to me. Message seems to represent the state
driver is in quite well... Plus we need PMSG_ON for state the device
gets after resume, but that's quite easy...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============095518295118267371==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============095518295118267371==--
