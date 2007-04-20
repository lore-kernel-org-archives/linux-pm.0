From: Dave Jones <davej@redhat.com>
Subject: Re: [2/2] 2.6.21-rc7: known regressions
Date: Fri, 20 Apr 2007 01:19:08 -0400
Message-ID: <20070420051908.GH20566@redhat.com>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070416003723.GM3691@stusta.de> <4628482B.6040804@goop.org>
	<20070420050344.GG20566@redhat.com> <46284C84.6060301@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46284C84.6060301@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: gregkh@suse.de, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 19, 2007 at 10:15:48PM -0700, Jeremy Fitzhardinge wrote:
 > Dave Jones wrote:
 > > Do you have the backlight code enabled ?
 > > I'm guessing not.
 > >   
 > 
 > Hm, think so.  backlight controls work, via both
 > /proc/acpi/ibm/backlight and /sys/class/backlight/*/brightness.
 > 
 > $ ls -l /sys/class/backlight/
 > total 0
 > drwxr-xr-x 2 root root 0 Apr 19 22:13 acpi_video0
 > drwxr-xr-x 2 root root 0 Apr 19 22:13 acpi_video1
 > drwxr-xr-x 2 root root 0 Apr 19 22:13 ibm

Hmm, given you hit the hpet problems and I didn't I think our X60's
aren't quite so similar.  Mine is the one with the swivelly touchscreen
tablet-pc mode. I understand they made a regular 'laptop' X60 too,
is that the one you have perhaps?

	Dave

-- 
http://www.codemonkey.org.uk
