From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOp Design and working patch
Date: Sun, 6 Aug 2006 22:05:20 +0000
Message-ID: <20060806220519.GA4205@ucw.cz>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>
	<20060728233837.GG2140@kroah.com>
	<c6333353f00bb7fd435ef518dc8cee21@mvista.com>
	<20060729004546.GA3917@kroah.com>
	<1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
	<44CBB1E0.3030908@gmail.com>
	<62e4476a851bbed395b509023edc5c5c@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <62e4476a851bbed395b509023edc5c5c@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david singleton <dsingleton@mvista.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > 2) interface (kernel as well as userspace(sysfs)) for the rest of power
> >    parameters except cpu voltage and frequency
> =

> =

> The /sys/power/supported_states file shows the supported operating =

> points
> and their parameters.

We have one-value-per-file rule for sysfs.
-- =

Thanks for all the (sleeping) penguins.
