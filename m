From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Occasional (too common) suspend problem
Date: Mon, 24 Jan 2011 16:09:17 +0800
Message-ID: <1295856557.1866.802.camel__34467.0319151648$1295856699$gmane$org@rui>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<201101222017.40389.rjw@sisk.pl>
	<AANLkTikSZTZ+mSWcjs2LQGOTbbKY+SAb5YEjP+GDSK0+@mail.gmail.com>
	<201101232229.49494.rjw@sisk.pl>
	<AANLkTimSv5Myv14Kys2OTgm=wH=8DFPFeeUSkEfg-+b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimSv5Myv14Kys2OTgm=wH=8DFPFeeUSkEfg-+b1@mail.gmail.com>
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
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Jesse Barnes <jbarnes@virtuousgeek.org>, Chris Wilson <chris@chris-wilson.co.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2011-01-24 at 15:22 +0800, Linus Torvalds wrote:
> On Mon, Jan 24, 2011 at 7:29 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > There's one more thing that may be related.  Apparently, we've made something
> > recently that's causing lots of problems with boot and poweroff for Asus
> > machines (https://lkml.org/lkml/2011/1/23/54).  The Asus BIOSes evidently
> > don't like something we do, but I have no idea what that may be at this point.
> 
> Yeah, I think there's something there. In fact, I'm getting pretty
> sure of it. Because I have now twice seen the _shutdown_ end up
> halting, and guess what? When I press a key, it then finishes the
> shutdown.
> 
> Sound familiar?
> 
> The last thing printed is the "Disabling non-boot CPU's" thing or
> whatever. I didn't take a picture, and it obviously doesn't get logged
> (since it's after the processes have been killed), but it definitely
> smelled like "Uhhuh, same problem as with suspend".
> 
https://patchwork.kernel.org/patch/500501/
does this patch help?

thanks,
rui

>                    Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
