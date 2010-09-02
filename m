From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
	resume after abort
Date: Thu, 2 Sep 2010 14:01:32 -0700
Message-ID: <AANLkTim7UM80MrwKoAz3hUFrqL2Fbyw6XS=X89PXRc2Q__22458.7573823102$1283552276$gmane$org@mail.gmail.com>
References: <AANLkTi=s3_kFvRY9Afzku82gUgW7YKYXDBZvTkxQsMP8@mail.gmail.com>
	<Pine.LNX.4.44L0.1009021642320.1311-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009021642320.1311-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 2, 2010 at 1:45 PM, Alan Stern <stern@rowland.harvard.edu> wrot=
e:
> On Thu, 2 Sep 2010, Colin Cross wrote:
>
>> >> I think it would be better to change device_pm_init() and add a
>> >> complete_all().
>> >
>> > I agree.
>> That would work, and was my first solution, but it increases the
>> reliance on the completion variable being left completed between state
>> transitions, which is undocumented and unnecessary. =A0It seems more
>> straightforward to me to only wait on the parent if the parent is
>> suspended.
>
> How about calling complete_all() from within dpm_prepare() as well?
> Then it will get initialized properly at the beginning of every sleep
> transition.
That would work, but I still don't see why it's better.  With either
of your changes, the power.completion variable is storing state, and
not just used for notification.  However, the exact meaning of that
state is unclear, especially during the transition from an aborted
suspend to resume, and the state is duplicating power.status.  Setting
it to complete in dpm_prepare is especially confusing, because at that
point nothing is completed, it hasn't even been started.
