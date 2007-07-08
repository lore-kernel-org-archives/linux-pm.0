From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sun, 8 Jul 2007 20:46:35 +0200
Message-ID: <200707082046.36864.rjw__5051.39936362884$1183920130$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707072218030.10912-100000@netrider.rowland.org>
	<1183869576.3388.250.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183869576.3388.250.camel@localhost.localdomain>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 8 July 2007 06:39, Benjamin Herrenschmidt wrote:
> 
> > In my defense, you should realize that until Rafael's notifier chain
> > was added (just a few weeks ago, still not in mainline I believe) there
> > was no other way to do it.  Plug activity needs to be stopped before
> > the child devices are suspended, and the PM core does not send any
> > notification to drivers at that time.  All it does is activate the 
> > freezer.
> 
> That's true. That was one of the reason I've always wanted the
> pre-suspend and post-resume hooks. (I prefer keeping the ordering there
> too, rather than a notifier, but a notifier is fine I suppose).
> 
> Among the clients we want here the firmware stuff, the allocators,
> etc... to get themselves in conditions that won't deadlock during
> suspend cycle.
> 
> I think that's a much bigger issue overall than freezer vs. no
> freezer :-)

Yes.  The freezer is only one part of the PM infrastructure that we have
currently and that is not very sophisticated, so to speak.

I'm all for changing this infrastructure, but in an organized way (ie. we
discuss what to do next, we do that and then we go to the next step) and in
the order that everyone will be comfortable with.

So, let's finish this thread and start over from discussing what needs to be
done, how (ie. in what order etc.) we are going to do that and who is going to
do what.  Shall we?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
