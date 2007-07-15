From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 12:46:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707151240380.25614@asgard.lang.hm>
References: <200707151433.34625.rjw@sisk.pl> <469A8515.3080109@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <469A8515.3080109@gmx.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelius Riemenschneider <c.r1@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, 15 Jul 2007, Cornelius Riemenschneider wrote:

> Hi,
> I think a (10) is needed to be clear:
>
> (10) This depends directly on (9)
> Easy Userinterface for the average user, no one wants to edit several
> files and use a long commandline for a suspend (not all know about
> alias(P)), so keeping the effort to suspend your system low, please.(eg
> for my TuxOnIce i just type hibernate as root/ sudo hibernate as normal
> user and the suspend begin, the rest is automatically done by the
> configuration(for me this is shutting down my wireless interface)
>
> Cornelius Riemenschneider

for both #9 and #10, if there are complex command lines that need to be 
used, they can be put into scripts (including things like 'sudo 
hibernate')

this doesn't prevent people from useing kernel.org kernels, in fact the 
seperate between the main system and what's used for hibernation may make 
it easier to change the main kernel (all that you would need is to enable 
kexec in your main kernel and 'everything else would just work')

now if you need/want to change out your hibernate kernel you will have to 
change the hibernate scripts to tell them to use the new kernel. yes this 
is an extra step, but it can still be simple. for that matter, it may be 
possible for the distros to agree enough to add 'make install_hibernate' 
to the kernel makefiles like they have 'make install' that will just 'do 
the right thing' for each particular distro.

makeing things explicit and flexible may require complex command lines to 
implement, but nothing says that the user (even a moderatly advanced user) 
needs to deal with those command lines directly.

David Lang
