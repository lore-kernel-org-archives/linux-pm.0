From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sat, 9 May 2009 21:32:10 +0200
Message-ID: <200905092132.11138.rjw__8708.61396329037$1241897643$gmane$org@sisk.pl>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905090046.21282.rjw@sisk.pl>
	<20090509132711.GD10859@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090509132711.GD10859@elf.ucw.cz>
Content-Disposition: inline
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
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 09 May 2009, Pavel Machek wrote:
> Hi!
> 
> > > And we have different ideas about how things should be done. Userspace
> > > vs kernel space. Providing tuning knobs vs not. And so on.
> > 
> > This isn't _that_ important.  Actually, I'm not against an entirely in-kernel
> > solution, as there are some clear benefits of doing it this way.  We only
> > need to be careful enough not to break the existing setups.
> 
> Would you elaborate?

One benefit is that we need not anything in the initrd for hibernation to work.
Another one is that we can get superior performance, for obvious reasons
(less copying of data, faster I/O).   Yet another is simpler configuration and
no need to maintain a separate set of user space tools.  I probably could
find more.
 
> I would really hate to put progressbar painting into kernel; and if
> that's in userspace, we can do compression/encryption there too as
> well....

That's correct, we can.  But since we have LZO in the kernel now, we can use
it for compression just as well, can't we?

Thanks,
Rafael
