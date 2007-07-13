From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Fri, 13 Jul 2007 23:18:47 +0000
Message-ID: <1184368727.1069.71.camel__35820.7823279828$1184340023$gmane$org@caritas-dev.intel.com>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<20070711111350.GI7091@elf.ucw.cz>
	<1184257734.9346.76.camel@caritas-dev.intel.com>
	<20070712085428.GA1866@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070712085428.GA1866@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 2007-07-12 at 10:54 +0200, Pavel Machek wrote:
> > Sorry, I should have re-checked the mail before sending out.
> 
> Were your patches enough to get hibernation working? I got kexec to
> work here, so I guess I'm one step closer...

Yes, it is just the first step. There are still many steps should be
done to get hibernation work.

> ...video does not work in the kexec-ed kernel, unless I boot with
> vga=1.
> 

I will check it.

Best Regards,
Huang Ying
