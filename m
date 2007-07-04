From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 08:41:33 -0400
Message-ID: <20070704124133.GA5836__32928.5566615455$1183552959$gmane$org@thunk.org>
References: <20070703211227.GA28758@srcf.ucam.org>
	<200707041242.59552.rjw@sisk.pl>
	<18059.32111.58643.97174@cargo.ozlabs.ibm.com>
	<200707041325.55779.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707041325.55779.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 04, 2007 at 01:25:55PM +0200, Rafael J. Wysocki wrote:
> > Don't know what exactly?
> 
> How many drivers will be adversely affected by the $subject change.

Ok, so how about a CONFIG option which removes the freezer, so we can
find out experimentally how many people without it?  We can make it be
experimental at first, or (my preference) make it be the default
initially, and if people complain that their laptop's suspend feature
is broken, we can tell them how to turn back on the
CONFIG_FREEZER_DEPRECATED option.

							- Ted
