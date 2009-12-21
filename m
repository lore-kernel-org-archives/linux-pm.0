From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFT] Input: speed up suspend/shutdown for PS/2 mice
 and keyboards
Date: Mon, 21 Dec 2009 15:29:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912211528550.2643-100000__28868.3650004261$1261427427$gmane$org@iolanthe.rowland.org>
References: <20091221070951.GA4170@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091221070951.GA4170@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 20 Dec 2009, Dmitry Torokhov wrote:

> Hi,
> 
> I am asking everyone to give this patch a try. It is reported to speed
> up suspend process, however there is a risk that there are boxes out
> there that do require full reset and I would prefer to know that sooner
> than later.

It works okay on my machine (Intel ICH4).

Alan Stern
