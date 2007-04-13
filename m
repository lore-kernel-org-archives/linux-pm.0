From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 23:00:23 +0200
Message-ID: <20070413210023.GH28264@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176306867.19348.4.camel@johannes.berg>
	<461D494D.3080808@gmail.com>
	<1176367352.5764.2.camel@localhost.localdomain>
	<20070412101653.GB26473@elf.ucw.cz>
	<1176374847.7052.47.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176374847.7052.47.camel@johannes.berg>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Adding platform hook to disable interrupts just because we need one
> > platform device last is not nice, either. (And does decrementer even
> > need to come last?)
> =

> But the hack is classifying the decrementer as a platform device in the
> first place. And then we'd still need to have one platform device and
> one sysdev since we want to wake up the decrementer before enabling
> IRQs

Can decrementer be waked a little later? =


> but set it to a high value before disabling IRQs. Or we'd need some sort
> of special foo device that has hooks both before and after and comes
> last/first, just for one user?

Have two devices, then.

> Besides, we can always rewrite it later when somebody introduces a foo
> device that fits above model. Since this patch essentially changes
> nothing, I'd been hoping to get it into .22 so we can finally start

No. Hacks like this are impossible to get rid of.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
