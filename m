From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Thu, 31 Mar 2005 10:02:37 -0500
Message-ID: <d120d50005033107024b4c2f96@mail.gmail.com>
References: <20050329181831.GB8125@elf.ucw.cz>
	<1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	<20050329223519.GI8125@elf.ucw.cz>
	<200503310226.03495.dtor_core@ameritech.net>
	<20050331083909.GA1387@elf.ucw.cz>
Reply-To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <20050331083909.GA1387-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 31 Mar 2005 10:39:10 +0200, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org> wrote:
> >  int swsusp_write(void)
> >  {
> >       int error;
> > -     device_resume();
> >       lock_swapdevices();
> >       error = write_suspend_image();
> >       /* This will unlock ignored swap devices since writing is
> 
> Looks good, except... why move code around? Could you just call
> usermodehelper_disable from swsusp_write?

That's because I don't think that swsusp_write is a proper place for
it ;) It looks like a lean and mean function that does just write and
manipulating usermodehelper state _and_ system (device) state is
wrong. Let it do one thing, don't overload with actions that I think
belong to the upper level. Do you agree?

I think I need to stick in usermodehelper_enable call in case
swsusp_write fails though.

-- 
Dmitry
