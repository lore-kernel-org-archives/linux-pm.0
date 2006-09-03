From: Pavel Machek <pavel@suse.cz>
Subject: Re: PowerOP, Whatchanged/Issues/TODO 2/2
Date: Sun, 3 Sep 2006 12:44:29 +0000
Message-ID: <20060903124428.GF4884@ucw.cz>
References: <44F9A031.8020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44F9A031.8020203@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> whatchanged:
> - optional sysfs interface is added
> - code is moved under kernel/power
> - Greg's comments on kobject and coding style are addressed
> =

> todo/issues:
> - better implementation for getting registered operating point names
> - move string parsing into powerop generic code

Can we get rid of string parsing altogether? It should be possible to
design better in-kernel interface than char *. Can you just use opaque
structure?

-- =

Thanks for all the (sleeping) penguins.
