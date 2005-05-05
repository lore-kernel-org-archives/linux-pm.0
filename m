From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [RFC] Linux Power Management
Date: Thu, 5 May 2005 11:38:30 +0200
Message-ID: <20050505093830.GA3260@elf.ucw.cz>
References: <1115094736.28902.167.camel@localhost.localdomain>
	<20050503214009.GE10404@elf.ucw.cz>
	<20050505041214.GA21223@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37799603746880184=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050505041214.GA21223@neo.rr.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============37799603746880184==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > This API is different from the current ->suspend and ->resume because it
> > > applies to situations outside of system suspend (e.g. runtime power
> > > management) and has an emphasis on specific device power states. 
> > 
> > No. It took 2+ years to add at at least system power states. You want
> > to build on that, not scratch it and start over.
> 
> After giving it some serious thought, I've decided that I agree.  I'm
> reworking my plans to reflect this.
> 
> I was wondering, however, what do you have in mind for adding to pm_message_t?
> Also, are you going to use "PMSG_HALT" and/or "PMSG_REBOOT"?

If I added PMSG_REBOOT, I'd have to modify all the drivers to support
it. Incompatible change, bad.

We already have something close enough, PMSG_FREEZE. That means that
drivers will do right thing by default. If someone really needs to
tell between normal freeze and reboot, we can add a flag; but I'm not
100% convinced it is neccessary.

Same for PMSG_HALT.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============37799603746880184==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37799603746880184==--
