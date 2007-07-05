From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 15:31:36 +0200
Message-ID: <200707051531.37532.rjw__25657.3506434963$1183642481$gmane$org@sisk.pl>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051358.26963.rjw@sisk.pl>
	<E1I6QOA-0000bq-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6QOA-0000bq-00@dorka.pomaz.szeredi.hu>
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

On Thursday, 5 July 2007 14:24, Miklos Szeredi wrote:
> > Don't you think, however, that it can be modified a little to play well,
> > for example, with the freezer?
> 
> I could stick a couple of try_to_freeze()s into fuse, and that would
> make suspend failure less likely.  But making problems less easy to
> reproduce is not a good thing.

So, how about eliminating them?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
