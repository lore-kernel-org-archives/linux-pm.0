From: Tony Vroon <tony@linx.net>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff -
	bug?
Date: Thu, 29 Apr 2010 15:38:14 +0100
Message-ID: <4BD999D6.7070808@linx.net>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	<20100419115942.GC5160@tiehlicka.suse.cz>
	<201004191719.53602.rjw@sisk.pl> <201004250435.42779.rjw@sisk.pl>
	<20100426150503.GA4005@tiehlicka.suse.cz>
	<alpine.LFD.2.00.1004261130090.3999@localhost.localdomain>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1004261130090.3999@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Michal Hocko <mhocko@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/04/10 17:22, Len Brown wrote:
> During this period after poweroff and LCD goes out, but before
> lid close, are there any other signs of life?  eg. does caps
> lock button light the caps LED?

The caps lock button does not respond, no.

> How about during this period if you press the power button and
> hold it for 5 seconds, does that cause the HDD parking sound?

Holding down the power button for 5 seconds has no audible or visible
effects, but does indeed properly shut it down. Closing or opening the
lid afterwards does not cause a phantom power-up.
A short push of the power button seems to start the machine up normally
(from a cold boot; just like when the lid is closed/opened after a linux
"shutdown").

> Please send the /proc/acpi/wakeup file before and after
> the regression.

I don't have this file in my /proc filesystem, sorry.

Regards,
- --
Tony Vroon
UNIX systems administrator
London Internet Exchange Ltd, Trinity Court, Trinity Street,
Peterborough, PE1 1DA
Registered in England number 3137929
E-Mail: tony@linx.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkvZmdYACgkQp5vW4rUFj5oUxgCdGPnfQsSE9jhjSzzar/kQbw95
Er4AmgLGStZlrvGZltqsU/REs2srO95A
=6VLH
-----END PGP SIGNATURE-----
