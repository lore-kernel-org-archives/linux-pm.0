From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Thu, 31 Mar 2005 08:02:44 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503310801410.15519-100000@monsoon.he.net>
References: <20050329181831.GB8125@elf.ucw.cz>
	<1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	<20050329223519.GI8125@elf.ucw.cz>
	<200503310226.03495.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============93915452635374397=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <200503310226.03495.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============93915452635374397==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 31 Mar 2005, Dmitry Torokhov wrote:

> Ok, what do you think about this one?
>
> ===================================================================
>
> swsusp: disable usermodehelper after generating memory snapshot and
>         before resuming devices, so when device fails to resume we
>         won't try to call hotplug - userspace stopped anyway.

Hm, shouldn't we disable it before we start to freeze processes? We don't
want any more processes trying to start up after we've taken care of
them..

Thanks,


	Pat


--===============93915452635374397==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============93915452635374397==--
