From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Wed, 30 Mar 2005 01:05:03 +0200
Message-ID: <200503300105.03861.rjw@sisk.pl>
References: <4243252D.6090206@suse.de>
	<d120d500050329130714e1daaf@mail.gmail.com>
	<20050329211239.GG8125@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0076955716749373959=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <20050329211239.GG8125-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============0076955716749373959==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Tuesday, 29 of March 2005 23:12, Pavel Machek wrote:
> Hi!
> 
> > > I don't really want us to try execve during resume... Could we simply
> > > artifically fail that execve with something if (in_suspend()) return
> > > -EINVAL; [except that in_suspend() just is not there, but there were
> > > some proposals to add it].
> > > 
> > > Or just avoid calling hotplug at all in resume case? And then do
> > > coldplug-like scan when userspace is ready...
> > > 
> > 
> > I am leaning towards calling disable_usermodehelper (not writtent yet)
> > after swsusp completes snapshotting memory. We really don't care about
> > hotplug events in this case and this will allow keeping "normal"
> > resume in drivers as is. What do you think?
> 
> That would certianly do the trick.
> 
> [Or perhaps in_suspend() is slightly nicer solution? People wanted it
> for other stuff (sanity checking, like BUG_ON(in_suspend())), too....]

IMHO, they are not mutually exclusive.    However, by using
disable_usermodehelper we would get rid of the reason (ie hotplug events)
instead of just curing the symptoms (ie execve() during suspend).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


--===============0076955716749373959==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0076955716749373959==--
