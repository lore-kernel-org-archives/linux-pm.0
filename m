From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Tue, 20 Mar 2007 14:16:06 +0100
Message-ID: <20070320131606.GB4996@elf.ucw.cz>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
	<20070320093105.GD3922@elf.ucw.cz>
	<1174383407.3770.3.camel@johannes.berg>
	<20070320094352.GF3922@elf.ucw.cz>
	<1174385865.3770.20.camel@johannes.berg>
	<20070320102551.GB19283@elf.ucw.cz>
	<1174388812.3770.29.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174388812.3770.29.camel@johannes.berg>
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
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, linux-arm@lists.arm.linux.org.uk, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org, Nicolas Pitre <nico@cam.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Almost all users of pm_ops only support mem sleep, don't check in .valid
> and don't reject any others in .prepare so users can be confused if they
> check /sys/power/state, especially when new states are ever added.
> =

> This patch implements a generic pm_valid_only_mem function that is then
> exported for users as well as using it in almost all pm_ops.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

ACK. (You may want to send it to akpm).
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
