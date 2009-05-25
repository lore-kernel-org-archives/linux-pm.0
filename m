From: Chris Howie <cdhowie@gmail.com>
Subject: Re: Boot problems with 2.6.29.1 - cannot smoothly boot
	on battery
Date: Sun, 24 May 2009 21:53:32 -0400
Message-ID: <3d2f29dc0905241853h594aa2a9ta21dee45979c567e__19506.3542029404$1243351591$gmane$org@mail.gmail.com>
References: <3d2f29dc0905180125x5e7ef51dqf10955a3d44336e2@mail.gmail.com>
	<200905242236.22715.rjw@sisk.pl> <4A19BA09.4050502@zytor.com>
	<20090525011819.GA9805@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090525011819.GA9805@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Greg KH <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM List <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sun, May 24, 2009 at 9:18 PM, Shaohua Li <shaohua.li@intel.com> wrote:
> if this is a AMD CPU, please check http://bugzilla.kernel.org/show_bug.cgi?id=13233

Ahh, that sounds like it.  I first noticed the problem in 2.6.28 after
switching from 2.6.26 (but never tried 2.6.27).  So the information
about versions is indeed consistent.  I'm on an amd64 cpu.

Thanks everyone for the suggestions, I will try to take a look within
the next couple of days and report my findings.

-- 
Chris Howie
http://www.chrishowie.com
http://en.wikipedia.org/wiki/User:Crazycomputers
