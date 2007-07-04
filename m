From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 13:10:10 +0200
Message-ID: <200707041310.11336.rjw__25961.9483528242$1183547049$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707041233.18199.rjw@sisk.pl>
	<18059.31464.183382.358931@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.31464.183382.358931@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 July 2007 12:48, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> 
> > So, I gather, you're volunteering to handle suspend-related bug reports
> > from the point in which we drop the freezer from the suspend code path?
> 
> Ben and I are happy to handle all the ones for the platform we
> maintain, which currently does suspend without freezing processes. :)

I mean all platforms.  After all, the $subject change won't affect yours.

BTW, does your platform's suspend work on SMP systems?

Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
