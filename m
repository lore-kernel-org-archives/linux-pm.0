From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 16:40:12 +0200
Message-ID: <200707041640.12832.rjw__25955.4992699579$1183559602$gmane$org@sisk.pl>
References: <20070703211227.GA28758@srcf.ucam.org>
	<200707041325.55779.rjw@sisk.pl> <20070704124133.GA5836@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070704124133.GA5836@thunk.org>
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
To: Theodore Tso <tytso@mit.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 July 2007 14:41, Theodore Tso wrote:
> On Wed, Jul 04, 2007 at 01:25:55PM +0200, Rafael J. Wysocki wrote:
> > > Don't know what exactly?
> > 
> > How many drivers will be adversely affected by the $subject change.
> 
> Ok, so how about a CONFIG option which removes the freezer, so we can
> find out experimentally how many people without it?  We can make it be
> experimental at first, or (my preference) make it be the default
> initially, and if people complain that their laptop's suspend feature
> is broken, we can tell them how to turn back on the
> CONFIG_FREEZER_DEPRECATED option.

The freezer is generally still necessary for hibernation, so I won't call
it "DEPRECATED'.

Moreover, I'd prefer to make drivers use different callbacks for hibernation
and suspend before we do that.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
