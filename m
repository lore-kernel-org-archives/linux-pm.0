From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] Input: speed up suspend/shutdown for PS/2 mice
	and keyboards
Date: Wed, 23 Dec 2009 21:48:47 +0100
Message-ID: <200912232148.47172.rjw__18247.5471905947$1261601495$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912211528550.2643-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912211528550.2643-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 21 December 2009, Alan Stern wrote:
> On Sun, 20 Dec 2009, Dmitry Torokhov wrote:
> 
> > Hi,
> > 
> > I am asking everyone to give this patch a try. It is reported to speed
> > up suspend process, however there is a risk that there are boxes out
> > there that do require full reset and I would prefer to know that sooner
> > than later.
> 
> It works okay on my machine (Intel ICH4).

Likewise on my Toshiba Portege R500 (ICH7).

[Of course, it also works on my other test boxes, the Wind has ICH7 like the
Toshiba, and the nx6325 has ATI SB400).

Rafael
