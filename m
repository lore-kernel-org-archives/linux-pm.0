From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Mon, 25 May 2009 19:27:46 +1000
Message-ID: <1243243666.16743.64.camel__26909.3210380108$1243243638$gmane$org@nigel-laptop>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905082144.57955.bzolnier@gmail.com>
	<1241819971.19600.288.camel@nigel-laptop>
	<200905090105.58243.bzolnier@gmail.com>
	<1241824525.19600.369.camel@nigel-laptop>
	<20090509135820.GF10859@elf.ucw.cz>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090509135820.GF10859@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On Sat, 2009-05-09 at 15:58 +0200, Pavel Machek wrote:
> Hi!
> 
> > > Instead of new features I would rather see more effort being put into making
> > > the _core_ TuxOnIce (I mean patch #8 here) smaller (8 KLOC is still a lot,
> > > just to put things into the right perspective the current in-kernel content
> > > of kernel/power/ is 5.5 KLOC) and with more documentation inside the code.
> > 
> > Yeah, but those 2.5k extra lines get you more reliability and extra
> > functionality. They're not fat.
> 
> If you know about reliability problems in swsusp, please fix them in
> separate patch. Hiding the fixes in 8KLOC patch is not nice.

I'm going to try to. Unfortunately, they'll require what's basically a
group-up redesign of the basic algorithm, because to get maximum
reliability, you need to carefully account for the amount of storage
you're going to need and the amount of memory you have available, and
'prepare' the image prior to doing the atomic copy.

Regards,

Nigel
