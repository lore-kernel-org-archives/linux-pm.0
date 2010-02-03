From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
 suspend/resume	if KMS is used
Date: Wed, 3 Feb 2010 15:24:43 +0100
Message-ID: <20100203152443.7ce8b340__5685.67818631909$1265207205$gmane$org@strolchi>
References: <201001240055.59479.rjw@sisk.pl> <201001252254.37635.rjw@sisk.pl>
	<20100126141726.GA1437@ucw.cz> <201001261947.46015.rjw@sisk.pl>
	<20100126145842.GA11295@ucw.cz> <20100128000751.099630ed@strolchi>
	<20100131085419.GI2238@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100131085419.GI2238@elf.ucw.cz>
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
Cc: airlied@linux.ie, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sun, 31 Jan 2010 09:54:19 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Thu 2010-01-28 00:07:51, Stefan Seyfried wrote:
> > Hi,
> > 
> > On Tue, 26 Jan 2010 15:58:43 +0100 Pavel Machek <pavel@ucw.cz> wrote:
> > > We need vt switch when display is controlled by userland app directly
> > > accessing hw. It may or may not be X (svgalib anyone?,
> > > gtk-on-framebuffer? qtopia?).
> > 
> > anything-on-framebuffer should not be different from plain framebuffer
> > console, or am I missing something?
> 
> It is. At least svgalib accesses hw directly. It probably can run even
> on framebuffer.

If it accesses hw directly, it's not really "anything-on-framebuffer"
anymore, is it? The framebuffer device is there to abstract the
hardware.
 
> Well, for now the "shadow buffer" contains only text, not graphics
> images. So you'd need to enlarge it a lot. Doable but more than one liner.

Yes, noticed this today. I was using bootsplash-patched kernels, which
are obviously different in this aspect, so that shifted my view on
reality ;)
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
