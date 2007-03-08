From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 0/3] swsusp: Do not use page flags (was:
	Re: Remove page flags for software suspend)
Date: Fri, 9 Mar 2007 00:15:12 +0100
Message-ID: <20070308231512.GB1977@elf.ucw.cz>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<200703041450.02178.rjw@sisk.pl>
	<1173315625.3546.32.camel@johannes.berg>
	<200703082305.43513.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200703082305.43513.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org, Christoph Lameter <clameter@engr.sgi.com>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> +		region =3D kzalloc(sizeof(struct nosave_region), GFP_ATOMIC);
> +		if (!region) {
> +			printk(KERN_WARNING "swsusp: Not enough memory "
> +				"to register a nosave region!\n");
> +			WARN_ON(1);
> +			return;
> +		}

That's a no-no. ATOMIC alocations can fail, and no, WARN_ON is not
enough. It is not a bug, they just fail.
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
