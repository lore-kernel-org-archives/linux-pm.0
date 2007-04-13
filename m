From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 00:16:52 +0200
Message-ID: <20070413221652.GR28264@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>
	<200704140009.33298.rjw@sisk.pl>
	<1176502406.7052.134.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176502406.7052.134.camel@johannes.berg>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat 2007-04-14 00:13:26, Johannes Berg wrote:
> On Sat, 2007-04-14 at 00:09 +0200, Rafael J. Wysocki wrote:
> =

> > Hmm, I missed that. :-(
> > =

> > I think we need to make things clear: Either we add the additional hook=
s to
> > pm_ops in which case they should be taken into account in the (u)swsusp=
 code
> > too, or we don't add them at all.
> =

> I can do that. I don't care one bit since I will never use pm_ops for
> suspend to disk anyway.

Please don't do that just yet.

I see ppc as being really special here.

Normally, preparation for s2ram and preparation for snapshot is really
similar, but you have exception to that rule. I do think clean
solution is redesigning plaform/sysdevs to have stable order.

If you added one platform and one sysdev, would that _work_? AFAICT
you say it would and Ben says it would not. (Lets leave uglyness
debate for later).
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
