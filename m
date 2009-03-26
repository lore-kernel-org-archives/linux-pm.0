From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Resume after hibernation regression in 2.6.29
Date: Thu, 26 Mar 2009 21:18:40 +0100
Message-ID: <20090326201840.GB29836__44371.6767048047$1238098786$gmane$org@elf.ucw.cz>
References: <200903261920.32173.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200903261920.32173.tvrtko@ursulin.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Cc: linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2009-03-26 19:20:32, Tvrtko A. Ursulin wrote:
> 
> Hi guys,
> I have been running custom compiled 2.6.28.7 in OpenSUSE 11.1 and using 
> hiberation/resume daily as configured by the distro. Yesterday I upgraded to 
> 2.6.29 (make oldconfig from 2.6.28.7, attached) and after resume networking 
> (at least) does not work. Reboot at this point takes very long because of 
> timeouts on CIFS and whatelse.
> 
> Below is how /var/log/messagess looks for one cycle (hibernate-resume-reboot) 
> and I am also attaching kernel config and /var/log/pm-suspend.log.
> 
> You will probably notice evil nvidia.ko in there but don't panic, it all 
> happens without it as well. Tested from runlevel 3 and by running 
> pm-hibernate. After resume from that NIC LEDs were off. I 
> tried /etc/init.d/network restart but that hung so I ^C and tried rmmod 
> forcedeth && modprobe forcedeth && ifup eth0 and after some time network went 
> live again. Haven't had time to test further though, so this is all pretty 
> rough.

Ok, can you try to rmmod forcedeth before hibernation, then insmod it
after resume?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
