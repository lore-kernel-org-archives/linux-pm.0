From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
 and PowerOP]
Date: Wed, 13 Dec 2006 15:12:07 +0300
Message-ID: <457FEE17.8080806@gmail.com>
References: <20060914101704.GA17820@elf.ucw.cz>	<1158583334.28629.19.camel@localhost>	<20060919182523.GE7099@elf.ucw.cz>
	<200612121200.18513.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200612121200.18513.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, Amit Kucheria <amit.kucheria@nokia.com>
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Tuesday 19 September 2006 11:25 am, Pavel Machek wrote:
>> Could you perhaps provide list of operating points for 770? It would
>> help understanding a bit, I'd say.
> =

> If there was a followup here, I missed it ...
> =

> ISTR that it doesn't use (formal) operating points, and that a lot of the
> basic SOC power savings (vs powering off the display or wifi) come from a
> different kind of mechanism entirely.  Namely, a combination of dynamic
> tick with a modified system idle task, which enters one of the OMAP low
> power modes during those long periods between clock ticks or other irqs.
> =

> That's one of the standard power saving schemes used on OMAP1 platforms
> with Linux.
sample of reasonable operating points for OMAP1 platforms along with approp=
riate =

patches may be found at http://dynamicpower.sourceforge.net/dpm-omap.html

Eugeny
> =

> - Dave
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
> =
