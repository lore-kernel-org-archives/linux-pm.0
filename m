From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Tue, 29 Mar 2005 16:07:01 -0500
Message-ID: <d120d500050329130714e1daaf@mail.gmail.com>
References: <4242CE43.1020806@suse.de> <4243252D.6090206@suse.de>
	<20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de>
	<d120d50005032908183b2f622e@mail.gmail.com>
	<20050329181831.GB8125@elf.ucw.cz>
	<d120d50005032911114fd2ea32@mail.gmail.com>
	<20050329192339.GE8125@elf.ucw.cz>
	<d120d50005032912051fee6e91@mail.gmail.com>
	<20050329205225.GF8125@elf.ucw.cz>
Reply-To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 29 Mar 2005 22:52:25 +0200, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org> wrote:
> I don't really want us to try execve during resume... Could we simply
> artifically fail that execve with something if (in_suspend()) return
> -EINVAL; [except that in_suspend() just is not there, but there were
> some proposals to add it].
> 
> Or just avoid calling hotplug at all in resume case? And then do
> coldplug-like scan when userspace is ready...
> 

I am leaning towards calling disable_usermodehelper (not writtent yet)
after swsusp completes snapshotting memory. We really don't care about
hotplug events in this case and this will allow keeping "normal"
resume in drivers as is. What do you think?

-- 
Dmitry
