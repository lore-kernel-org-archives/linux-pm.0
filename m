From: Pavel Machek <pavel@suse.cz>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
	hibernation	patchset against -rc6)
Date: Tue, 18 Mar 2008 23:52:03 +0100
Message-ID: <20080318225201.GA2115@elf.ucw.cz>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue 2008-03-18 10:31:28, Linus Torvalds wrote:
> 
> 
> On Tue, 18 Mar 2008, Pavel Machek wrote:
> >
> > On Tue 2008-03-18 14:06:42, Pavel Machek wrote:
> > > 
> > > Confirmed, suspend slowness is in 2.6.25-rc6, too. It takes 15 seconds
> > > to suspend/resume, while 2.6.24 takes 9. Thinkpad x60.
> > 
> > IIRC 2.6.25-rc5 was "fast".
> 
> Can you bisect it? There's only 343 commits between -rc5 and -rc6,
> so it 

It will take a while. My .git directory is 7G, and I'd like to do a
backup before playing with git.

git gc does not exist here, so I guess I need to update git, too :-(.

> should not take too long to check which commit it is. Even if it should 
> take 9 reboots to bisect it entirely, going just five or six will likely 
> narrow it down sufficiently that we can probably guess fairly well what 
> it's about.

Hmm, it gets weirder. 2.6.25-rc5 was fast, and had small problem with
backlight hotkeys did not work.

2.6.25-rc6 has backlight hotkeys somehow working, but closing/opening lid in X
kills the backlight, making machine unusable.

Hmm...

commit 7c0ea45be4f114d85ee35caeead8e1660699c46f
tree 0822ef23606a733e00bbf75d3e218b1e92abdd78
parent 2f44bbb495dd3e6d0209eff2257438ab9c570e5b
author Zhao Yakui <yakui.zhao@intel.com> Tue, 11 Mar 2008 16:56:47
+0800
committer Len Brown <len.brown@intel.com> Tue, 11 Mar 2008 22:20:19
-0400

    ACPI: Ignore _BQC object when registering backlight device

    According to acpi spec , the objects of  _BCL and _BCM are
required if
    integrated LCD is present and supports brightness level .The _BQC
is
    the optional object. So the _BQC object is ignored when the
backlight device
    is registered in ACPI video driver.

    http://bugzilla.kernel.org/show_bug.cgi?id=10206

    Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
    Signed-off-by: Zhang Rui  <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>


when did this go in? Pretty recently, right? And that means that ACPI
backlight driver is now used on machines where it was not used
before...?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
