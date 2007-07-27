From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [v4l-dvb-maintainer] [2/2] 2.6.23-rc1: known
 regressions with patches v2
Date: Fri, 27 Jul 2007 14:16:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0707271414420.30561@shell4.speakeasy.net>
References: <46AA5A28.3090205@googlemail.com> <46AA5B4A.40500@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46AA5B4A.40500@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Mikael Pettersson <mikpe@it.uu.se>, Peter Zijlstra <peterz@infradead.org>, Thierry MERLE <thierry.merle@free.fr>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, linux-usb-devel@lists.sourceforge.net, Kay Sievers <kay.sievers@vrfy.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Mel Gorman <mel@skynet.ie>, Simon Arlott <simon@fire.lp0.eu>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>, Mauro Carvalho Chehab <mchehab@infradead.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dwaine P. Garden" <dwainegarden@rogers.com>, v4l-dvb-maintainer@linuxtv.org, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foun>
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Jul 2007, Michal Piotrowski wrote:
> Media
>
> Subject         : usbvision: don't return an uninitialized value
> References      : http://lkml.org/lkml/2007/7/23/65
> Last known good : ?
> Submitter       : Adrian Bunk <bunk@stusta.de>
> Caused-By       : ?
> Handled-By      : Adrian Bunk <bunk@stusta.de>
> Patch           : http://lkml.org/lkml/2007/7/23/65
> Status          : patch available

I've made a real fix for this one:

http://lkml.org/lkml/2007/7/23/114
http://linuxtv.org/hg/v4l-dvb/rev/d5c4fffbbad3
