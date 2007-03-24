From: Oliver Neukum <oliver@neukum.org>
Subject: Re: charging batteries from USB [was: Re: Alternative
	Concept]
Date: Sat, 24 Mar 2007 09:36:24 +0100
Message-ID: <200703240936.25656.oliver@neukum.org>
References: <44ECFF94.3030506@gmail.com>
	<200703201258.03926.david-b@pacbell.net>
	<46047526.5020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46047526.5020707@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

Am Samstag, 24. M=E4rz 2007 01:47 schrieb Dmitry Krivoschekov:
> If I didn't miss something, the primary reason was to allow
> devices to charge batteries from the bus, so, does USB
> specs restrict this somehow? Or, what's wrong with that?

Suspended devices have a very low limit on power consumption.
It's not enough to charge a battery.

	Regards
		Oliver
