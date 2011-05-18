From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: pm loss development
Date: Wed, 18 May 2011 23:17:26 +0100
Message-ID: <20110518221726.GC20909__28659.5499179841$1305757101$gmane$org@sirena.org.uk>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<201105180107.58078.rjw@sisk.pl> <20110518031203.GA3640@gvim.org>
	<201105182143.13237.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105182143.13237.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, davinci-linux-open-source@linux.davincidsp.com, Raffaele Recalcati <lamiaposta71@gmail.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 18, 2011 at 09:43:13PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, May 18, 2011, mark gross wrote:

> > I need to get more details on this but I assume its a state where the
> > meta data of the file system is committed to the emmc before lights go
> > off such that when power is reapplied that the damage isn't too big. 

> I don't think you can guarantee that the metadata won't be damaged
> without notifying the filesystem of the event (and making it react
> appropriately).

I guess with a journalling filesystem you'd hope that you can at any
point write out what's in flight and have it be safe; if it's a non
journalling filesystem of course all bets are off.
