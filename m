From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Tue, 29 Mar 2005 13:23:35 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503291321490.29474-100000@monsoon.he.net>
References: <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org>
	<4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org>
	<4243D854.2010506@suse.de>
	<d120d50005032908183b2f622e@mail.gmail.com>
	<20050329181831.GB8125@elf.ucw.cz>
	<d120d50005032911114fd2ea32@mail.gmail.com>
	<20050329192339.GE8125@elf.ucw.cz>
	<d120d50005032912051fee6e91@mail.gmail.com>
	<20050329205225.GF8125@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============065187494437830562=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <20050329205225.GF8125-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============065187494437830562==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 29 Mar 2005, Pavel Machek wrote:

> I don't really want us to try execve during resume... Could we simply
> artifically fail that execve with something if (in_suspend()) return
> -EINVAL; [except that in_suspend() just is not there, but there were
> some proposals to add it].
>
> Or just avoid calling hotplug at all in resume case? And then do
> coldplug-like scan when userspace is ready...

I thought that cold-plugging only worked for devices, not all objects.

Can we just queue up hotplug events? That way we wouldn't lose any across
the transition, and could be used to send resume events to userspace for
various devices that need help..


	Pat


--===============065187494437830562==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============065187494437830562==--
