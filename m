From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pm: remove unused asm/suspend.h
Date: Fri, 15 May 2009 01:11:54 +0200
Message-ID: <200905150111.55510.rjw@sisk.pl>
References: <20090512131606.7984.69575.sendpatchset@rx1.opensource.se>
	<aec7e5c30905130304r38796bf4if741f53435bb5cb3@mail.gmail.com>
	<20090514093147.GE6417@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090514093147.GE6417@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 14 May 2009, Pavel Machek wrote:
> On Wed 2009-05-13 19:04:14, Magnus Damm wrote:
> > Hi Pavel,
> > 
> > On Wed, May 13, 2009 at 4:32 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > > On Tue 2009-05-12 22:16:06, Magnus Damm wrote:
> > >>
> > >> From: Magnus Damm <damm@igel.co.jp>
> > >>
> > >> This patch removes unused asm/suspend.h files for
> > >> the following architectures:
> > >>
> > >>  alpha, arm, ia64, m68k, mips, s390, um
> > >>
> > >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > >
> > > Are you sure? arm does support suspend...
> > 
> > Not sure, but these days <asm/suspend.h> is only included from
> > kernel/power/disk.c. And that file is only built if CONFIG_HIBERNATION
> > is set. I've grepped for arch_prepare_suspend and
> > ARCH_HIBERNATION_POSSIBLE but I don't get any matches under
> > arch/arm...
> > 
> > Or am I misunderstanding? =)
> 
> I did rm arch/arm/include/asm/suspend.h and ran test compile on
> zaurus; it seems ok. Because no other architectures are close to
> supporting suspend/hibernation, I think I can
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applied to the suspend tree.

Thanks,
Rafael
