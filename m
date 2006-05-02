From: Pavel Machek <pavel@suse.cz>
Subject: Re: /sys/power/state contents
Date: Tue, 2 May 2006 13:54:53 +0200
Message-ID: <20060502115453.GB1677@elf.ucw.cz>
References: <1146300258.5019.16.camel@localhost>
	<200605011531.00656.david-b@pacbell.net>
	<1146560856.27351.78.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1146560856.27351.78.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On =DAt 02-05-06 11:07:36, Johannes Berg wrote:
> On Mon, 2006-05-01 at 15:31 -0700, David Brownell wrote:
>=20
> > You mean, exactly like the valid_state() function already does??
>=20
> Which actually opens up another question. Why is the default 1 instead
> of 0? If an arch doesn't have any callbacks, why announce that it can d=
o
> it? It would seem more sensible to me to force an arch that wants to
> support this to also have a valid call in order to announce it. Not tha=
t
> it actually will work, but why even show it?

Historical reasons.
								Pavel

--=20
Thanks for all the (sleeping) penguins.
