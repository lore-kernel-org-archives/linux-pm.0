From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.20-rc3: known regressions with patches available (part 1)
Date: Tue, 2 Jan 2007 21:51:38 +0100
Message-ID: <20070102205137.GA11203@kernel.dk>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <20070102192449.GV20714@stusta.de> <20070102192651.GM2483@kernel.dk> <20070102193429.GX20714@stusta.de> <459AC472.4070303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754955AbXABUs5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <459AC472.4070303@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Robert Hancock <hancockr@shaw.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@osdl.org, Jean Delvare <khali@linux-fr.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@in.ibm.com>, Marcel Holtmann <marcel@holtmann.org>, bluez-devel@lists.sourceforge.net, Mark Lord <lkml@rtr.ca>, Laurent Riffard <laurent.riffard@free.fr>, Christoph Hellwig <hch@lst.de>, petero2@telia.com
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 02 2007, Rene Herman wrote:
> Adrian Bunk wrote:
> 
> >On Tue, Jan 02, 2007 at 08:26:52PM +0100, Jens Axboe wrote:
> 
> >>Patch is already merged in -git.
> >
> >Thanks for this information, I missed this (as well as the merged SATA 
> >fix) since it isn't yet at the git mirrors.
> 
> What's "-git" here? I just now pulled
> 
> git://git2.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> and it's not there.
> 
> Otherwise, patch confirmed to work by me as well.

Perhaps not mirrored out yet, I pulled it from master/hera some hours
ago though. The top of Linus' tree is
ec8acb6904fabb8e741f741ec99bb1c18f2b3dee, which is the commit with that
patch.

-- 
Jens Axboe
