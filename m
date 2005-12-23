From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Re: Hotplug events during sleep transition
Date: Sat, 24 Dec 2005 08:09:56 +1000
Message-ID: <1135375796.9616.155.camel@localhost>
References: <20051223172057.GA15357@elf.ucw.cz>
	<Pine.LNX.4.44L0.0512231619010.28577-100000@netrider.rowland.org>
	<20051223212827.GA17350@kroah.com>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33023608523595627=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051223212827.GA17350@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============33023608523595627==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Sat, 2005-12-24 at 07:28, Greg KH wrote:
> On Fri, Dec 23, 2005 at 04:22:44PM -0500, Alan Stern wrote:
> > On Fri, 23 Dec 2005, Pavel Machek wrote:
> > 
> > > Well, if you can find some elegant solution in the core, I think thats
> > > the best way.
> > > 
> > > You could set system_state to "suspending" or something like that, and
> > > just if() out notifications in that case.
> > 
> > How about simply adding a call to try_to_freeze() somewhere inside 
> > kernel/kmod.c:____call_usermodehelper()?  That ought to do pretty much 
> > what I want, in theory.  The hotplug processes would get frozen before 
> > /sbin/hotplug is exec'ed.
> 
> On modern distros, /sbin/hotplug is set to NULL, so this isn't an issue.
> We use netlink to send the data out, so this might not even be a problem
> anymore...

At resume time, prior to copying back the original kernel data, events
can and do occur.

FWIW, I've been using "if(freezer_is_on()) return 0" for a while in
call_usermodehelper_keys, to good effect.

Regards,

Nigel


--===============33023608523595627==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============33023608523595627==--
