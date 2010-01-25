From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
 suspend/resume if KMS is used
Date: Mon, 25 Jan 2010 22:23:00 +0000
Message-ID: <20100125222300.62ddc4d2__4339.61128951541$1264458208$gmane$org@lxorguk.ukuu.org.uk>
References: <201001240055.59479.rjw@sisk.pl> <201001252217.39778.rjw@sisk.pl>
	<20100125212720.7d3af280@lxorguk.ukuu.org.uk>
	<201001252254.37635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001252254.37635.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: airlied@linux.ie, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

> Obviously I'd like to clean it up, though.
> 
> So, what device should handle this in your opinion?

My guess would be the relevant device driver for the hardware layer

So fbcon would probably not switch because it can put video modes back,
KMS obvious likewise. The text console might do something as part of its
suspend/resume path IFF the vt in question is in graphics mode.

Alan
