From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
 suspend/resume if KMS is used
Date: Sun, 24 Jan 2010 00:18:15 +0000
Message-ID: <20100124001815.48b4eb9c__43157.2472014979$1264292598$gmane$org@lxorguk.ukuu.org.uk>
References: <201001240055.59479.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001240055.59479.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

> I've been testing this patch for over a week and haven't seen a single problem
> related to it during this time.
> 
> Are there any objections to it?

Usual question 8) - explain the locking. What happens if we suspend as
kms is initialising/being removed.

Also what happens if you have KMS and non KMS consoles both active
through the frame buffer off different cards ?
