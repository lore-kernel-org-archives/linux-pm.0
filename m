From: "Bob Copeland" <me@bobcopeland.com>
Subject: Re: Suspend to disk broken in latest 2.6.28-rc3
Date: Wed, 12 Nov 2008 17:37:00 -0500
Message-ID: <b6c5339f0811121437v624737abka49b5aefd8f1def4__5145.40115041218$1226529656$gmane$org@mail.gmail.com>
References: <20081109195033.GA1335@mobydick> <20081112184236.GR26778@kernel.dk>
	<200811122237.03882.rjw@sisk.pl>
	<200811121357.02233.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200811121357.02233.jbarnes@virtuousgeek.org>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Jens Axboe <jens.axboe@oracle.com>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 12, 2008 at 4:57 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> On Wednesday, November 12, 2008 1:37 pm Rafael J. Wysocki wrote:
>> On Wednesday, 12 of November 2008, Jens Axboe wrote:
>> > A drm enabled kernel also hangs hard on resume (just see the mouse
>> > pointer) here on the x60. Removing drm makes it work just fine. 2.6.27
>> > works fine as well.
>>
>> Is there Intel graphics in there?
>
> Yeah I think so... I wonder if this is another case where a POST conflicted
> with the kernel's restore and caused X to hang...
>
> Jens, does suspend/resume work if you just do it from the console (echo mem >
> /sys/power/state) with i915 loaded?

Here's a "me too" for resume troubles in 2.6.28, MacBook Core Duo with i915
graphics.  I'm about a week behind in my git tree though.

Probably unrelated, but in testing other stuff I noticed that 2.6.27.3 worked
whereas 2.6.27.4 does not.  Reverting "ACPI Suspend: Enable ACPI during resume
if SCI_EN is not set" makes it work there.  In 2.6.28-rc3, reverting the same
commit met with mixed success:

  * resuming from X got me one successful resume after a long timeout,
    and one resume with mouse-pointer-only
  * resuming from console always worked

With the above mentioned commit, resume never worked.

-- 
Bob Copeland %% www.bobcopeland.com
