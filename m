From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Mon, 25 May 2009 15:22:26 +0200
Message-ID: <200905251522.26852.oliver__23724.8214114972$1243257939$gmane$org@neukum.org>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<1243243666.16743.64.camel@nigel-laptop>
	<20090525123228.GA13446@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090525123228.GA13446@elf.ucw.cz>
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
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

Am Montag, 25. Mai 2009 14:32:28 schrieb Pavel Machek:
> > I'm going to try to. Unfortunately, they'll require what's basically a
> > group-up redesign of the basic algorithm, because to get maximum
> > reliability, you need to carefully account for the amount of storage
> > you're going to need and the amount of memory you have available, and
> > 'prepare' the image prior to doing the atomic copy.
>
> I don't quite get it; why is that needed?
>
> If there's not enough swap available, swsusp should freeze, realize
> there's no swap, unfreeze and continue. I do not see reliability
> problem there.

The software suspend may be a part of your response to an imminent
power failure (UPS near empty). The number of retries available is possibly
limited.
I'd feel safer if hibernation by default wrote to a dedicated partition,
especially as modern practice is to make swap space smaller than RAM.

	Regards
		Oliver
