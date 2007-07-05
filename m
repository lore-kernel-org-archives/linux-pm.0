From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 15:23:43 +0200
Message-ID: <200707051523.44826.rjw__25108.3626681522$1183641435$gmane$org@sisk.pl>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051340.41901.rjw@sisk.pl>
	<E1I6Pud-0000V1-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6Pud-0000V1-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 13:54, Miklos Szeredi wrote:
> > > Limiting what a userspace filesystem can do would defeat the whole
> > > purpose of the bloody thing.  This is not negotiable ;)
> > 
> > Which doesn't change the fact that FUSE _is_ special, because it adds
> > dependencies between processed that were not present before.
> 
> OK, fuse is special.  So is the userspace driver framework (UIO)
> proposed by Greg KH and co.  Now what can be done about these?
> 
>  - making them not-special is not an option due to the established
>    interfaces, which don't allow restartability.
> 
>  - fixing the freezer is pretty much impossible because the
>    dependencies between the tasks cannot be known.
> 
>  - removing the freezer and fixing the drivers seems workable, we
>    already have a prototype in the form of the powermac architecture.
> 
> It seems pretty clear cut.  Whining about how much problems this will
> cause won't get us nearer to a solution.

Yes, that's pretty clear cut, but we should start from fixing the drivers. :-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
