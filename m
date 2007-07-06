From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 09:30:20 +0200
Message-ID: <200707060930.21348.oliver__16858.736848417$1183707073$gmane$org@neukum.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051048.46202.oliver@neukum.org>
	<1183675095.3388.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183675095.3388.72.camel@localhost.localdomain>
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
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 6. Juli 2007 schrieb Benjamin Herrenschmidt:
> 
> > There is that.
> > 
> > OK, bite the bullet. Tasks involved in fuse are special. Give them a flag
> > and teach the freezer to put them on ice only after all other task are
> > frozen. In a way they are kernel, there's no use denying that.
> 
> Yet another ugly hack to work around the fact that the freezer cannot
> work reliably ... yuck
> 
> Why not spend that energy fixing drivers to properly block requests
> instead ?

Because we will be unable to escape that job. Let's assume that
we remove the freezer from the STR path. The next complaint would
be that we cannot do STD with fuse. "Then don't do that" would not
be taken kindly as answer.

So we would be under pressure to remove the freezer from STD, too,
or find a way to make the freezer work. If we'd have to make the freezer
work anyway, we can do it right now.

	Regards
		Oliver
