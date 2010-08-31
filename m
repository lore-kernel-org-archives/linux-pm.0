From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Bug 17571 - blk/ata-sff/unknown-boot-option related
	backtrace on resume with TuxOnIce
Date: Tue, 31 Aug 2010 22:11:42 +0200
Message-ID: <201008312211.42578.rjw@sisk.pl>
References: <201008312140.51242.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008312140.51242.Martin@lichtvoll.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: tuxonice-devel@tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 31, 2010, Martin Steigerwald wrote:
> 
> Hi Nigel, hi Raphael, hi Linux-PM team,
> 
> I reported this in this in the mainline kernel bugzilla tough it may well 
> be a TuxOnIce bug for three reasons: 
> 
> 1) The backtrace looks pretty generic, no toi* symbols at least in the 
> last part shown on the screen.
> 
> 2) bugzilla.tuxonice.net timed out. Okay, that not that good reason.
> 
> 3) Raphaels interest in TuxOnIce bugs.
> 
> Linux-PM folks, feel free to ignore this unless Nigel thinks its not a 
> TuxOnIce problem.
> 
> 
> 
> Bug 17571 -  blk/ata-sff/unknown-boot-option related backtrace on resume 
> with TuxOnIce
> 
> I am testing 2.6.35.4 with TuxOnIce 3.2-rc1 on my ThinkPad T23.
> 
> After I few hibernation cycles I now got a backtrace on resume. I tried 
> twice before discarding the image.
> 
> I don't know yet, whether it happens regularily. I am attaching a 
> screenshot of the backtrace.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=17571

I have already replied in there, please let's use the bug entry for furhter
tracking of this issue.

Thanks,
Rafael
