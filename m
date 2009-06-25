From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V3
Date: Fri, 26 Jun 2009 02:17:28 +0900
Message-ID: <20090625171728.GA25320__26578.4101364718$1245950605$gmane$org@linux-sh.org>
References: <20090610121659.27937.13560.sendpatchset@rx1.opensource.se>
	<200906242050.57312.rjw@sisk.pl>
	<aec7e5c30906241925n3eeaee65of0dcf0286f60366d@mail.gmail.com>
	<200906251634.12222.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906251634.12222.rjw@sisk.pl>
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
Cc: paul@pwsan.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 25, 2009 at 04:34:11PM +0200, Rafael J. Wysocki wrote:
> On Thursday 25 June 2009, Magnus Damm wrote:
> > If possible, I'd like this to be merged as early as possible since a
> > lot of processor specific changes will depend on it. With this
> > included in 2.6.31 I can easily build arch specific code for 2.6.32.
> > Anything I can do to make that happen?
> > 
> > My top priority is Runtime PM for SuperH on top of your code, and I
> > intend to post a prototype for SuperH before the PM Summit. It would
> > be great to minimize the dependencies though, and including this in
> > 2.6.31 would certainly help.
> 
> I'm going to add this patch to my linux-next branch shortly and if your 2.6.32
> development is based on that branch (I'd recommend that anyway), there
> shouldn't be any problems during the 2.6.32 merge window.
> 
Yes, I was already planning on creating a topic branch based off of this
so that we can start getting things ready in the sh tree, so this is not
a problem.. as long as you don't rebase ;-)
