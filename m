From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
 suspend/resume	if KMS is used
Date: Thu, 28 Jan 2010 00:07:51 +0100
Message-ID: <20100128000751.099630ed__18250.0726580203$1264633749$gmane$org@strolchi>
References: <201001240055.59479.rjw@sisk.pl> <201001252254.37635.rjw@sisk.pl>
	<20100126141726.GA1437@ucw.cz> <201001261947.46015.rjw@sisk.pl>
	<20100126145842.GA11295@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100126145842.GA11295@ucw.cz>
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

Hi,

On Tue, 26 Jan 2010 15:58:43 +0100 Pavel Machek <pavel@ucw.cz> wrote:
> We need vt switch when display is controlled by userland app directly
> accessing hw. It may or may not be X (svgalib anyone?,
> gtk-on-framebuffer? qtopia?).

anything-on-framebuffer should not be different from plain framebuffer
console, or am I missing something?

> Ideally, userspace should explicitely tell us. KD_KERNEL_GRAPHICS
> console mode?
> 
> Plus the switch is needed for any graphics app using fbcon -- I do not
> think we actually save the framebuffer over suspend. (This one should
> probably be fixed).

Framebuffer should be easy to fix - it works pretty well already
because apparently the fbcon code needs to "shadow buffer" all VT
"windows" anyway - so maybe it's just the issue of doing an additional
"redraw()" somewhere appropriate.

The VGA consoles loses their content, because AFAICT they are in the
graphics card memory, which is not saved and restored.

	seife
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
