From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sat, 9 May 2009 01:43:10 +0200
Message-ID: <200905090143.10980.rjw__28037.725602235$1241826487$gmane$org@sisk.pl>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905090046.21282.rjw@sisk.pl>
	<1241825408.19600.384.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241825408.19600.384.camel@nigel-laptop>
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
To: nigel@tuxonice.net
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 09 May 2009, Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2009-05-09 at 00:46 +0200, Rafael J. Wysocki wrote:
> > On Friday 08 May 2009, Nigel Cunningham wrote:
> > > On Fri, 2009-05-08 at 16:11 +0200, Rafael J. Wysocki wrote:
> > > > On Friday 08 May 2009, Nigel Cunningham wrote:
> > > > > On Thu, 2009-05-07 at 23:51 +0200, Pavel Machek wrote:
> > > > > > On Thu 2009-05-07 19:42:54, Rafael J. Wysocki wrote:
> > > > > > > On Thursday 07 May 2009, Pavel Machek wrote:
[--snip--]
> > > And the code includes some fundamental differences. I freeze processes
> > > and prepare the whole image before saving anything or doing an atomic
> > > copy whereas you just free memory before doing the atomic copy. You save
> > > everything in one part whereas I save the image in two parts.
> > 
> > IMO the differences are not that fundamental.  The whole problem boils down
> > to using the same data structures for memory management and I think we can
> > reach an agreement here.
> 
> I think we might be able to agree on using the same data structures, but
> I'm not so sure about algorithms - I think you're underestimating the
> differences here.

Well, which algorithms do you have in mind in particular?

Rafael
