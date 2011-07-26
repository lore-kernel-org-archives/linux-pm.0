From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: better oopsing when frozen
Date: Tue, 26 Jul 2011 15:45:02 -0700
Message-ID: <20110726154502.14c7b51b.akpm__24810.0304780111$1311720354$gmane$org@linux-foundation.org>
References: <201107251043.19932.oneukum@suse.de>
	<201107270024.11194.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107270024.11194.rjw@sisk.pl>
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
Cc: Oliver Neukum <oneukum@suse.de>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 27 Jul 2011 00:24:11 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > Hi Rafael,
> > 
> > I had a problem with the kernel stopping the machine forever because I got an
> > oops while tasks were frozen. It seems to me that we should thaw when this
> > happens. How about this approach?
> 
> Well, we do something like this already for the OOM killer (see
> oom_killer_disable() and friends), so I think it would be better to
> simply extend/modify that mechanism instead of adding a new one
> doing almost exactly the same thing.
> 
> I have no complaints about adding thaw_in_oops(), though, so long as
> Andrew thinks it makes sense.

mm...  The patch as proposed is very simple, direct, explicit.  I
suspect that trying to embed this operation within some other one would
end up producing a less clear result.  Sometimes we do exceptional and
weird things, and leaving the code exceptional and weird-looking is
better than hiding it in some framework, if you follow what I mean.

It does need some code comments to explain to people what it's doing
and more importantly why it's doing it.  Also, something which doesn't
break the build when CONFIG_FREEZER=n would be nice.
