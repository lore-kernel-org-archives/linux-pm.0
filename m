From: <rasmit.ranjan@wipro.com>
Subject: RE: swsusp1 not working
Date: Mon, 2 Jan 2006 10:03:42 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB2012F5083@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============64340811044516855=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rjw@sisk.pl
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============64340811044516855==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

 
Hi Rafael,
	I tried with resume=/dev/hdb2.
In this case while booting its giving

	swsusp:Suspend partition has wrong signature?

And after suspending using

	echo shutdown > /sys/power/disk
	echo disk > /sys/power/state

It gives kernel panic.
I am not able to get what is happening !!!
Do I need to add anything in my init file( like adding echo >
/proc/suspend2/do_resume in case of suspend2 )? 

-----Original Message-----
From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
Sent: Friday, December 30, 2005 8:13 PM
To: linux-pm@lists.osdl.org
Cc: Rasmit Ranjan (WT01 - Semiconductors & Consumer Electronics)
Subject: Re: [linux-pm] swsusp1 not working

Hi,

On Friday, 30 December 2005 05:27, rasmit.ranjan@wipro.com wrote:
> Hello,
>     i am new to linux power management system. my requirement is to 
> put my system in low power mode.
> so i tried swsusp1 and suspend2. in my system suspend2 works properly.
> but i am getting problem with
> swsusp1.
> i am using linux-2.6.13.3. stpes i followed for swsusp1 are:
>     -- compiled my kernel with software suspend,power management and 
> acpi enabled
>     -- added the following line to my grub.conf as kernel parameter.
>             resume=swap:/dev/hdb2     ( /dev/hdb2 is my swap partition
)

Please try changing it to resume=/dev/hdb2

Greetings,
Rafael


--===============64340811044516855==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============64340811044516855==--
