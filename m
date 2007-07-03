From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 13:55:49 +0200
Message-ID: <200707031355.51028.oliver__2129.51223734326$1183464043$gmane$org@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031307.41366.oliver@neukum.org>
	<1183463053.10386.112.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183463053.10386.112.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mjg59@srcf.ucam.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 3. Juli 2007 schrieb Benjamin Herrenschmidt:
> > Now device drivers have a guaranteed temporal sequence:
> > 
> > last io -> suspend() -> resume() [or disconnect()] -> new io
> 
> No, that's always been bullshit. You can have IOs emitted by kernel
> threads (think knfsd, and that's just one among many others). Beside,

That's why we have the problem of freezing the kernel threads or not.
Short of knfsd very few kernel threads really operate on their own and
those can use the new notifier chain.

> relying on having userland frozen means that your driver will be unable
> to be "live" suspended/resumed for more ambitious dynamic power
> management schemes.

Only if they work without cooperation and idle detection in the drivers.

> So it's always been wrong, imho, to rely on that. I've had powermac STR
> work fine without the freezer for years, and few drivers have been a
> problem, and we just fixed them.

Powermacs are somewhat limited in hardware used with them (OK, powerbook
have PCMCIA, but how often is that used?)

You want to have all that pain for fuse?

	Regards
		Oliver
