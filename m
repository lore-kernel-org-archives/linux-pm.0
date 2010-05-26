From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 11:40:53 +0200
Message-ID: <20100526114053.440c0559__16807.8556111597$1274866914$gmane$org@schatten.dmk.lab>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005240246.55043.rjw@sisk.pl> <1274863533.5882.4864.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274863533.5882.4864.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010 10:45:33 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, 2010-05-24 at 02:46 +0200, Rafael J. Wysocki wrote:
> > On Saturday 22 May 2010, Arve Hj=F8nnev=E5g wrote:
> > > This patch series adds a suspend-block api that provides the same
> > > functionality as the android wakelock api. This version adds a
> > > delay before suspending again if no suspend blockers were used
> > > during the last suspend attempt.
> > =

> > Patches [1-6/8] applied to suspend-2.6/linux-next
> =

> So you're going to merge this junk?
> =

> =


Yes. By now, everyone reading the posts should know all points.
Raffael obviously was part of this discussion and came to the decision
to merge it. =


My take of the discussion:
_IF_ you want to suspend aggressively, I don't see another
way.

The thing is, this is a paradigm change. Suspend is not anymore
controlled by userspace. In order to let userspace control/work with
this scheme, it needs to know when a suspend will be successfull or
poll:

1. kernel sees suspend may be possible on his side of things

2. kernel sends a message to userspace that i could be possibly
possible to suspend, but it may well be that by the time
userspace suspends it is not possible anymore

3. userspace decides to suspend. =


<- system suspends...  or not ..-> =


4. userspace retries ... retries ... retries ... =


And then you have the whole can of worms and races.



Or you have the suspend-blocker scheme:

1. kernel sees suspend is possible.
2. kernel suspends.
3. bingo.

Cheers,
Flo
