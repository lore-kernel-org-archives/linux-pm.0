From: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Re: swsusp 'disk' fails in bk-current - intel_agp
	at fault?
Date: Fri, 01 Apr 2005 12:33:05 +0200
Message-ID: <424D2361.5000602@suse.de>
References: <20050329181831.GB8125@elf.ucw.cz>
	<20050331221814.GC1802@elf.ucw.cz>
	<1112308137.18871.7.camel@desktop.cunningham.myip.net.au>
	<200504011049.01540.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============71101791938352044=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <200504011049.01540.rjw-KKrjLPT3xs0@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============71101791938352044==
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Rafael J. Wysocki wrote:
> Hi,
>> On Fri, 2005-04-01 at 08:18, Pavel Machek wrote:
>> > I believe we should freeze hotplug before processes.
> 
> I agree.  IMO user space should not be considered as available once we have
> started freezing processes, so hotplug should be disabled before.  By the same
> token, it should only be enabled after the processes have been restarted
> during resume (or after suspend has failed).

it has probably to be enabled before the processes are restarted - they
may rightfully assume that hotplug is working.
-- 
seife
                                 Never trust a computer you can't lift.

--===============71101791938352044==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============71101791938352044==--
