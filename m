From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 23:48:59 +0100
Message-ID: <20051223224859.GB16104@elf.ucw.cz>
References: <20051223172057.GA15357@elf.ucw.cz>
	<Pine.LNX.4.44L0.0512231619010.28577-100000@netrider.rowland.org>
	<20051223212827.GA17350@kroah.com>
	<1135375796.9616.155.camel@localhost>
	<20051223223142.GA16104@elf.ucw.cz>
	<1135377631.9616.158.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============63435374425364488=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1135377631.9616.158.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============63435374425364488==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On So 24-12-05 08:40:31, Nigel Cunningham wrote:
> On Sat, 2005-12-24 at 08:31, Pavel Machek wrote:

> > > > > > Well, if you can find some elegant solution in the core, I think thats
> > > > > > the best way.
> > > > > > 
> > > > > > You could set system_state to "suspending" or something like that, and
> > > > > > just if() out notifications in that case.
> > > > > 
> > > > > How about simply adding a call to try_to_freeze() somewhere inside 
> > > > > kernel/kmod.c:____call_usermodehelper()?  That ought to do pretty much 
> > > > > what I want, in theory.  The hotplug processes would get frozen before 
> > > > > /sbin/hotplug is exec'ed.
> > > > 
> > > > On modern distros, /sbin/hotplug is set to NULL, so this isn't an issue.
> > > > We use netlink to send the data out, so this might not even be a problem
> > > > anymore...
> > > 
> > > At resume time, prior to copying back the original kernel data, events
> > > can and do occur.
> > > 
> > > FWIW, I've been using "if(freezer_is_on()) return 0" for a while in
> > > call_usermodehelper_keys, to good effect.
> > 
> > Can we have a patch?
> 
> Well the version I'm using depends on my changes to the freezer, so I
> can't give you one straight off, and I'm not likely to get around to it
> today, so I was hoping someone else would run with the concept :)

Ahha, ok. Forget it, then. Or just send a patch without the
refrigerator changes, so Alan knows where to hack. It does not have to
work in order to be useful :-).
							Pavel

-- 
Thanks, Sharp!

--===============63435374425364488==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============63435374425364488==--
