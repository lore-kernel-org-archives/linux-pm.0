From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 24 May 2010 20:49:18 +0200
Message-ID: <201005242049.18920.rjw__49374.8280023739$1274727028$gmane$org@sisk.pl>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005240246.55043.rjw@sisk.pl> <20100524043224.GA31700@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100524043224.GA31700@nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: felipe.balbi@nokia.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 24 May 2010, Felipe Balbi wrote:
> On Mon, May 24, 2010 at 02:46:54AM +0200, ext Rafael J. Wysocki wrote:
> >On Saturday 22 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> This patch series adds a suspend-block api that provides the same
> >> functionality as the android wakelock api. This version adds a
> >> delay before suspending again if no suspend blockers were used
> >> during the last suspend attempt.
> >
> >Patches [1-6/8] applied to suspend-2.6/linux-next
> =

> funny thing is that even without sorting out the concerns plenty of =

> developers had on the other thread, this series is still taken. What's =

> the point in dicussing/reviewing the patches then ?

I don't think the concerns you're referring to can be solved out.  Some peo=
ple
just don't like the whole idea and I don't think there's any way we can imp=
rove
the patches to make them happy.  The only "solution" they would be satisfied
with would simply be rejecting the feature altogether, although there are no
practically viable alternatives known to me.

OTOH I do think there are quite a few reasons to take the patchset, so I'm
going to push it to Linus as I told in one of my replies to Kevin.  If Linus
decides not to pull it, so be it.

Thanks,
Rafael
