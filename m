From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 08:25:22 +1000
Message-ID: <1176503122.5764.109.camel@localhost.localdomain>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>  <200704140009.33298.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704140009.33298.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> Hmm, I missed that. :-(
> =

> I think we need to make things clear: Either we add the additional hooks =
to
> pm_ops in which case they should be taken into account in the (u)swsusp c=
ode
> too, or we don't add them at all.
> =

> Well, there also is one more solution.  Namely, we can add the hooks to p=
m_ops
> and make (u)swsusp use something else instead of pm_ops, but that would r=
equire
> some more consideration.

Well, what would be nice would be if swsusp wasn't just such a gross
contraption completely bypassing the rest of the suspend/resume
framework...

Ben.
