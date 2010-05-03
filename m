From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Mon, 3 May 2010 15:24:31 -0700
Message-ID: <x2wd6200be21005031524w6c0ef297ka2984fe0740b701b__25878.0041979209$1272925520$gmane$org@mail.gmail.com>
References: <201005032338.26439.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1005031810000.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005031810000.1328-100000@iolanthe.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 3, 2010 at 3:11 PM, Alan Stern <stern@rowland.harvard.edu> wrot=
e:
> On Mon, 3 May 2010, Rafael J. Wysocki wrote:
>
>> The main problem is that the entire suspend subsystem is going to work i=
n a
>> different way when suspend blockers are enforced. =A0Thus IMO it makes s=
ense to
>> provide a switch between the "opportunistic" and "forced" modes, because=
 that
>> clearly indicates to the user (or user space in general) how the whole s=
uspend
>> subsystem actually works at the moment.
>>
>> As long as it's "opportunistic", the system will autosuspend if suspend
>> blockers are not active and the behavior of "state" reflects that. =A0If=
 you want
>> to enforce a transition, switch to "forced" first.
>>
>> That's not at all confusing if you know what you're doing. =A0The defail=
t mode is
>> "forced", so the suspend subsystem works "as usual" by default. =A0You h=
ave to
>> directly switch it to "opportunistic" to change the behavior and once yo=
u've
>> done that, you shouldn't really be surprised that the behavior has chang=
ed.
>> That's what you've requested after all.
>
> How about changing the contents of /sys/power/state depending on the
> current policy? =A0When the policy is "forced" it should look the same as
> it does now. =A0When the policy is "opportunistic" it should contain
> "mem" and "on".

It already does this.

-- =

Arve Hj=F8nnev=E5g
