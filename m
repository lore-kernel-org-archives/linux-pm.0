From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Fri, 9 Sep 2016 15:36:42 +0800
Message-ID: <20160909073642.GA1558@sharon>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
 <20160829134123.GA28806@nazgul.tnic>
 <20160830083505.GG10967@linux-rxt1.site>
 <6348002.9YHCcajBsl@vostro.rjw.lan>
 <20160908211552.GA12651@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34201 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751657AbcIIH21 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Sep 2016 03:28:27 -0400
Content-Disposition: inline
In-Reply-To: <20160908211552.GA12651@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, joeyli <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Lee@nazgul.tnic

Hi Pavel,
On Thu, Sep 08, 2016 at 11:15:52PM +0200, Pavel Machek wrote:
> On Tue 2016-08-30 13:54:44, Rafael J. Wysocki wrote:
> > On Tuesday, August 30, 2016 04:35:05 PM joeyli wrote:
> > > On Mon, Aug 29, 2016 at 03:41:23PM +0200, Borislav Petkov wrote:
> > > > On Mon, Aug 29, 2016 at 09:15:00AM +0200, Pavel Machek wrote:
> > > > > Sounds about as easy as hot unplugging arbitrary memory address. IOW
> > > > > "not easy".
> > > > 
> > > > Regardless, forcibly panicking the system more is still the wrong
> > > > approach IMO.
> > > > 
> > > > Instead, I'd try to issue a big fat warning that BIOS corrupts E820 and
> > > > that the user should disable hibernation on that box and never ever
> > > > enable it again.
> > > > 
> > > > After that, the kernel should *disable* hibernation for the current boot
> > > > so any further hibernation runs don't even happen. Maybe even taint
> > > > itself.
> > > >
> > > 
> > > I support this idea to disable hibernation when kernel detected e820 layout
> > > was changed by BIOS. If system resume luckily then kernel should warn to user
> > > and refuse to hibernate again. User must to know that's better to reboot
> > > system when he saw the warning message after lucky resume.
> > > 
> > > Not just BIOS doesn't fix e820 layout. There have some machines doesn't provide
> > > _S4_ function, so the hibernation fallbacks to "shutdown" mode because "platform"
> > > mode unavailable. In this situation, user is just lucky to run the hibernation.
> > > Kernel should warn to user and disable hibernation when detected e820 layout
> > > changed.
> > 
> > Well, please see my reply to Boris.
> > 
> > Pavel is right that running after detecting an e820 mismatch is generally risky,
> > so why don't we shut down the system (but try to do that cleanly instead of
> > causing it to panic right away) on an e820 mismatch?
> 
> I don't think that's good idea.
> 
> Anything involving userspace is risky at that point, and clean
> shutdown means a _lot_ of userspace.
> 
> We know the filesystems are reasonably clean as we sync-ed
> them; I believe right solution is to panic -- on-disk state is pretty
> good and we don't want to do anything risky.
>
OK, we tried a milder solution that doesn't shutdown the system in the
latest version, which terminates the restore process if a mismatch is found
(hope people would be happy with that one :)
Here's the patch link per yours and Rafael's last comments on the old patch,
and I'm still doing some small adjustment and will send a newer one but it
is approximately similar to the following link:

https://patchwork.kernel.org/patch/9310497/
 
