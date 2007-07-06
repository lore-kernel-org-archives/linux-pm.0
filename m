From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 09:04:08 +0200
Message-ID: <200707060904.09497.rjw__27234.0738251389$1183705032$gmane$org@sisk.pl>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051048.46202.oliver@neukum.org>
	<1183675095.3388.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
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

On Friday, 6 July 2007 00:38, Benjamin Herrenschmidt wrote:
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

Because it's more difficult? :-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
