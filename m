From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Tue, 29 Mar 2005 22:52:25 +0200
Message-ID: <20050329205225.GF8125@elf.ucw.cz>
References: <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org>
	<4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org>
	<4243D854.2010506@suse.de>
	<d120d50005032908183b2f622e@mail.gmail.com>
	<20050329181831.GB8125@elf.ucw.cz>
	<d120d50005032911114fd2ea32@mail.gmail.com>
	<20050329192339.GE8125@elf.ucw.cz>
	<d120d50005032912051fee6e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============20810421505097487=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <d120d50005032912051fee6e91-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============20810421505097487==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > Well, there lies a problem - some devices have to do execve because
> > > they need firmware to operate. Also, again, some buses with
> > > hot-pluggable devices will attempt to clean up unsuccessful resume and
> > > this will cause hotplug events. The point is you either resume system
> > > or you don't. We probably need a separate "unfreeze" callback,
> > > although this is kind of messy.
> > 
> > There's a better solution for firmware: You should load your firmware
> > prior to suspend and store it in RAM. Anything else just plain does
> > not work. (Because your wireless firmware might be on NFS mounted over
> > that wireless card).
> > 
> > Hotplug... I guess udev just needs to hold that callbacks before
> > system is fully up... it has to do something similar on regular boot,
> > no?
> 
> Well, I did not really look into udev but hotplug (which can iteract
> with udev) does not keep anything. If it fails its ok - that's why
> there are coldplug scripts that "recover" lost events. But here we
> block trying to start hotplug - we not getting an error - and this is
> bad. Unfortunately I am not familiar with block devices working to say
> why it hangs.
> 
> Should we pull Jens into the discussion?

I don't really want us to try execve during resume... Could we simply
artifically fail that execve with something if (in_suspend()) return
-EINVAL; [except that in_suspend() just is not there, but there were
some proposals to add it].

Or just avoid calling hotplug at all in resume case? And then do
coldplug-like scan when userspace is ready...

But we perhaps should cc linux-pm list.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============20810421505097487==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============20810421505097487==--
