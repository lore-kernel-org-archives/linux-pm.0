From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Wed, 30 Mar 2005 01:52:13 -0800
Message-ID: <20050330095213.GA12632@kroah.com>
References: <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org>
	<4243D854.2010506@suse.de>
	<d120d50005032908183b2f622e@mail.gmail.com>
	<20050329181831.GB8125@elf.ucw.cz>
	<d120d50005032911114fd2ea32@mail.gmail.com>
	<20050329192339.GE8125@elf.ucw.cz>
	<d120d50005032912051fee6e91@mail.gmail.com>
	<20050329205225.GF8125@elf.ucw.cz>
	<Pine.LNX.4.50.0503291321490.29474-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============068671297222429928=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <Pine.LNX.4.50.0503291321490.29474-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
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
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============068671297222429928==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2005 at 01:23:35PM -0800, Patrick Mochel wrote:
> 
> On Tue, 29 Mar 2005, Pavel Machek wrote:
> 
> > I don't really want us to try execve during resume... Could we simply
> > artifically fail that execve with something if (in_suspend()) return
> > -EINVAL; [except that in_suspend() just is not there, but there were
> > some proposals to add it].
> >
> > Or just avoid calling hotplug at all in resume case? And then do
> > coldplug-like scan when userspace is ready...
> 
> I thought that cold-plugging only worked for devices, not all objects.

We can walk the whole sysfs tree and create "cold" hotplug events.
udevstart does that for devices that udev cares about (as an example.)

> Can we just queue up hotplug events? That way we wouldn't lose any across
> the transition, and could be used to send resume events to userspace for
> various devices that need help..

Ick, I really hate this idea, but there is a patch in the SuSE kernel to
do this at boot time.  Hopefully the author of that patch resubmitts it
again and maybe it will make it eventually into mainline...

thanks,

greg k-h

--===============068671297222429928==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============068671297222429928==--
