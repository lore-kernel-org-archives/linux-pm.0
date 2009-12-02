From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: Re: intermittent suspend problem again
Date: Wed, 2 Dec 2009 13:27:23 +0100
Message-ID: <20091202132723.2499e4aa__38796.5674199679$1259756917$gmane$org@strolchi.home.s3e.de>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200912011328.15551.rjw@sisk.pl>
	<877ht68u4h.fsf@tac.ki.iif.hu> <200912012232.50951.rjw@sisk.pl>
	<87638qw2zy.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87638qw2zy.fsf@tac.ki.iif.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 02 Dec 2009 02:58:41 +0100
Ferenc Wagner <wferi@niif.hu> wrote:

> Btw. s2disk has a strange effect of simulating enters during suspend.
> It looks like this in a terminal:
> 
> $ sudo s2disk

...

> 
> 
> 
> 
> 
> 
> $ 
> $ 
> $ 

...

> $ 
> $ 
> $ 
> $ 
> $ <cursor is here>
> 
> Can you also see this?

That's an old "bug" in X (but fixed for me since quite some time) IIUC:
you type s2disk <enter>, s2disk switches to console 1, while enter is
still pressed.
=> X does not know that enter got "released" and will only notice after
resume finished. The X internal key autorepeat does the rest.

Does not happen for me since at least one year, I'd guess, but I am
always running the latest and greatest bleeding edge of everything ;)

HTH,

	seife
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
