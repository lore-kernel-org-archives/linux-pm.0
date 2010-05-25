From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 24 May 2010 18:16:15 -0700
Message-ID: <AANLkTilR3CgkLRfxMN_A79kuC_KOgsfW4oNUDPZFlZFW__49452.3047855639$1274750231$gmane$org@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org> <20100524185754.GD1292@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100524185754.GD1292@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Mon, May 24, 2010 at 11:57 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> I agree that the runtime scenario is a far more appealing one from an
>> aesthetic standpoint, but so far we don't have a very compelling
>> argument for dealing with the starting and stopping of userspace. The
>> use-cases that Google have provided are valid and they have an
>> implementation that addresses them, and while we're unable to provide an
>> alternative that provides the same level of functionality I think we're
>> in a poor position to prevent this from going in.
>
> Uhuh?
>
> "We have this ugly code here, but it works and we don't have better
> one, so lets merge it"?
>
> I don't really like this line of reasoning. I would not want to judge
> wakelocks here, but... "it works, merge it" should not be used as
> argument.
>
> And btw I do have wakelock-less implementation of autosleep, that only
> sleeped the machine when nothing was ready to run. It was called
> "sleepy linux". Should I dig it out?
>
> Major difference was that it only sleeped the machine when it was
> absolutely certain machine is idle and no timers are close to firing
> -- needing elimination or at least markup of all short timers. It
> erred on side of not sleeping the machine when it would break
> something.
>

How did you handle external events that occur right after you decided to sl=
eep?

> Still I believe it is better design than wakelocks -- that need
> markup/fixes to all places where machine must not sleep -- effectively
> sleeping the machine too often than fixing stuff with wakelocks all
> over kernel and userspace...

-- =

Arve Hj=F8nnev=E5g
