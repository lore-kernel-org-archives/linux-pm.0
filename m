From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 14:58:01 +0900
Message-ID: <AANLkTilwGOnHtSOBhBQ7tJtXUw8PdzfqnScEow0WDqKk@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503215028.GB18910@srcf.ucam.org>
	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>
	<20100514203202.GA12409@srcf.ucam.org>
	<87aas2azc5.fsf@deeprootsystems.com>
	<20100514231510.GG16989@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100514231510.GG16989@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu, Kevin Hilman <khilman@deeprootsystems.com>, Matthew Garrett <mjg@redhat.com>, Paul Walmsley <paul@pwsan.com>, linux-pm@lists.linux-foundation.org, linux-ke
List-Id: linux-pm@vger.kernel.org

On Sat, May 15, 2010 at 8:15 AM,  <tytso@mit.edu> wrote:
> On Fri, May 14, 2010 at 03:32:58PM -0700, Kevin Hilman wrote:
>> Another likely reason that that there hasn't been an alternate
>> proposal (at least from some of us that are raising concerns) is
>> because we already have a working solution to dynamic, system-wide PM
>> that is 1) already in mainline and 2) shipping on consumer devices
>> with very strict power budgets (as already pointed out in detail by
>> Paul[2].)
>
> The examples cited where the things like the Palm Pre, and the Nokia
> N770/800/810 series. =A0#1, what works on one embedded
> chipset/architecture might not work on another, and #2, the battery
> lifetime on the N770 and N800 (both of which I have) is **appalling**
> **bad**.

Really? My experience is sort of the opposite.

My 3 year old Maemo-based Nokia N800 survived about a week idle. My
half-year old HTC HT-03A with Android 1.6 survives a day or three, but
not much more. Fortunately the japanese cellphone provider Docomo
bundled it with two batteries, haha. =3D)

The Nexus One only came with one battery, but from my perspective it's
as good as N800 or maybe even better.

In the end, I don't think it's a question of Maemo vs Android here or
wakelock vs Runtime PM. I'm sure both would do just fine with enough
optimizations.

/ magnus
