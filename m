From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: what the patches do Re: [RFC 10/15] PM / Hibernate:
	user, implement user_ops reader
Date: Thu, 25 Mar 2010 22:13:44 +0100
Message-ID: <201003252213.44763.rjw__15202.3809649565$1269551511$gmane$org@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003252129.10224.rjw@sisk.pl> <4BABC926.8060203@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BABC926.8060203@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, jirislaby@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 25 March 2010, Nigel Cunningham wrote:
> Hi.
> 
> On 26/03/10 07:29, Rafael J. Wysocki wrote:
> > On Thursday 25 March 2010, Nigel Cunningham wrote:
> >> Hi.
> >>
> >> On 26/03/10 07:14, Rafael J. Wysocki wrote:
> >>> On Thursday 25 March 2010, Nigel Cunningham wrote:
> >>>> Hi.
> >>>>
> >>>> On 25/03/10 16:30, Pavel Machek wrote:
> >>>> [...]
> >>>>
> >>>>> I have some problems with sws_module_ops interface (handcoded locking
> >>>>> is too ugly to live), but it is better than I expected. But there may
> >>>>> be better solution available, one that does not need two interfaces to
> >>>>> maintain (we can't really get rid of userland interface). What about
> >>>>> this?
> >>>>
> >>>> Just picking up on that bracketed part: Can we flag the userland
> >>>> interface (and uswsusp) as being planned for eventual removal now... or
> >>>> at least agree to work toward that?
> >>>
> >>> No, we can't.
> >>>
> >>>> I'm asking because if we're going to make a go of getting the in-kernel
> >>>> code in much better shape, and we have Rafael, Jiri and I - and you? -
> >>>> all pulling in the same direction to improve it, there's going to come a
> >>>> point (hopefully not too far away) where uswsusp is just making life too
> >>>> difficult, and getting rid of it will be a big help.
> >>>
> >>> We're not dropping user space interfaces used by every distro I know of.
> >>
> >> So what's your long term plan then?
> >
> > First, improve the in-kernel thing, second, switch people to it, _then_ remove
> > the s2disk interface (after we're reasonably sure it's not used by any major
> > distro) and _finally_ simplify things after it's been removed.
> >
> > Does that sound reasonable?
> 
> Well, that's pretty much what I was thinking too - improve then remove. 
> I was just suggesting that we flag now that this is our plan, so it 
> doesn't come as a surprise to anyone later and we can proceed more 
> quickly than might otherwise be the case.

I think it's too early for that at this point.

Rafael
