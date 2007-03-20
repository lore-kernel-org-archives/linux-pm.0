From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] remove firmware disk mode
Date: Tue, 20 Mar 2007 14:15:02 +0100
Message-ID: <20070320131502.GA4996@elf.ucw.cz>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
	<20070320093105.GD3922@elf.ucw.cz>
	<1174383407.3770.3.camel@johannes.berg>
	<20070320094352.GF3922@elf.ucw.cz>
	<1174385865.3770.20.camel@johannes.berg>
	<20070320102551.GB19283@elf.ucw.cz>
	<1174388573.3770.26.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174388573.3770.26.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch removes the firmware disk suspend mode which is the wrong
> approach, it is supposed to be used for implementing firmware-based disk
> suspend but cannot actually be used for that.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

ACK. (You may want to send it to akpm).
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
